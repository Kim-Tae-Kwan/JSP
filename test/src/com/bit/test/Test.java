package com.bit.test;

import java.io.*;
import java.util.*;

class Student implements Serializable {
	private static final long serialVersionUID = 1L;
	public static int cnt = 0;
	private final int num;
	private String name;
	private int kor, eng, math;

	public Student(String name) {
		this.name = name;
		num = ++cnt;
	}

	public static void setCnt(int cnt) {
		Student.cnt = cnt;
	}

	public int getNum() {
		return num;
	}

	public String getName() {
		return name;
	}

	public int getKor() {
		return kor;
	}

	public int getEng() {
		return eng;
	}

	public int getMath() {
		return math;
	}

	public void setGrades(int[] grades) {
		this.kor = grades[0];
		this.eng = grades[1];
		this.math = grades[2];
	}

	public double getAvg() {
		return (kor + eng + math) * 100 / 3 / 100.0;
	}

}

public class Test extends Thread {
	static Scanner sc = new Scanner(System.in);
	static HashMap<Integer, Student> studentMap = new HashMap<Integer, Student>();
	static final String SAVE_FILE_NAME = "save.bin";

	@Override
	public void run() {
		while (true) {
			try {
				sleep(20 * 1000); // 20초 대기.
				save();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 파일 데이터베이스에 저장된 데이터를 불러온다.
	 * 
	 * @return Map ( Key : 학번, value : Student)
	 */
	public static void getSaveMap() {
		File file = new File(SAVE_FILE_NAME);
		FileInputStream fis = null;
		BufferedInputStream bis = null;
		ObjectInputStream ois = null;
		try {
			if (!file.exists())
				file.createNewFile();

			fis = new FileInputStream(file);
			bis = new BufferedInputStream(fis);
			ois = new ObjectInputStream(bis);
			
			Student.setCnt(ois.readInt()); 
			studentMap =(HashMap<Integer, Student>) ois.readObject();
			
		} catch (FileNotFoundException e) {
		} catch (EOFException e) {
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ois != null)
					ois.close();
				if (bis != null)
					bis.close();
				if (fis != null)
					fis.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * Map의 모든 데이터를 save.bin에 저장한다.
	 */
	public synchronized static void save() {
		File file = new File(SAVE_FILE_NAME);
		FileOutputStream fos = null;
		BufferedOutputStream bos = null;
		ObjectOutputStream oos = null;
		try {
			fos = new FileOutputStream(file);
			bos = new BufferedOutputStream(fos);
			oos = new ObjectOutputStream(bos);
			
			oos.writeInt(Student.cnt);
			oos.writeObject(studentMap);
			
			oos.close();
			bos.close();
			fos.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (oos != null)
					oos.close();
				if (bos != null)
					bos.close();
				if (fos != null)
					fos.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 각 성적을 순서대로 입력 받는다.
	 * 
	 * @param input - 학번
	 * @return int[] - 각 과목의 점수
	 * 
	 */
	public static int[] getGrades(int input) {
		String[] sub = { "국어", "영어", "수학" };
		int[] grades = new int[sub.length];
		for (int i = 0; i < grades.length; i++) {
			System.out.print(input + "학번 " + sub[i] + " > ");
			try {
				int num = Integer.parseInt(sc.nextLine());
				if (num > 100) {
					System.out.println("점수는 100을 초과할 수 없습니다.\n");
					i--;
					continue;
				}
				grades[i] = num;
			} catch (NumberFormatException e) {
				System.out.println("숫자만 입력하세요.\n");
				i--;
			}
		}
		return grades;
	}

	/**
	 * 학번 입력 받기. 학번의 존재 유무 확인 후 학번을 반환한다.
	 * 
	 * @param option - 0 : 수정, 1 : 삭제, 2 : 검색
	 * @return 유효성 검사를 통과한 학번.(뒤로가기 0 반환)
	 */
	public static int getStudentNumber(int option) {
		int input = 0;
		String[] action = { "수정", "삭제", "검색" };
		while (true) {
			System.out.print(action[option] + "할 학번 (뒤로가기 0)> ");
			try {
				input = Integer.parseInt(sc.nextLine());
				if (input == 0)
					break;
			} catch (Exception e) {
				System.out.println("숫자만 입력하세요.\n");
				continue;
			}

			Student student = studentMap.get(input);
			if (student == null) {
				System.out.println(input + "학번은 존재하지 않습니다.\n");
				continue;
			}
			break;
		}
		return input;
	}

	/**
	 * 학생 정보 얻기.
	 * 
	 * @param key - 학번.
	 * @return 학생 정보를 반환한다. (ex. 학번 이름 국어 영어 수학 평균 -> 1	김태관	50	50	50	50.0)
	 */
	public static String getStudentInfo(int key) {
		Student student = studentMap.get(key);
		return student.getNum() + "\t" + student.getName() + "\t" + student.getKor() + "\t" + student.getEng() + "\t"
				+ student.getMath() + "\t" + student.getAvg();
	}

	/**
	 * @return 경계선 반환. (---------------)
	 */
	public static String getLine() {
		StringBuilder line = new StringBuilder();
		for (int i = 0; i < 46; i++) {
			line.append("-");
		}
		return line.toString();
	}

	public static void main(String[] args) {
		getSaveMap();
		String line = getLine();
		StudentManagerAutoSave thread = new StudentManagerAutoSave();
		thread.setDaemon(true);
		thread.start();

		System.out.println("학생 성적 관리 프로그램 (ver 0.6.0)");

		int input = 0;
		while (true) {
			System.out.print("\n1.입력 2.보기 3.수정 4.삭제 5.검색 0.종료 > ");
			try {
				input = Integer.parseInt(sc.nextLine());
			} catch (NumberFormatException e) {
				System.out.println("메뉴를 보고 다시 입력해주세요.\n");
				continue;
			}

			if (input == 0) {// 0.종료
				save();
				System.out.print("이용해주셔서 감사합니다.");
				break;
			} else if (input == 1) {// 1.입력
				if (Student.cnt == 30) {
					System.out.println("학생 수는 30명을 초과할 수 없습니다.");
					continue;
				}

				System.out.print("이름 > ");
				Student student = new Student(sc.nextLine());

				int[] grades = getGrades(input);

				student.setGrades(grades);
				studentMap.put(student.getNum(), student);
			} else if (input == 2) {// 2.보기
				System.out.println(line);
				System.out.println("학번\t이름\t국어\t영어\t수학\t평균");
				System.out.println(line);
				for (Integer key : studentMap.keySet()) {
					System.out.println(getStudentInfo(key));
				}
				System.out.println(line);
			} else if (input == 3) {// 3.수정
				input = getStudentNumber(0);
				if (input == 0)
					continue;
				int[] grades = getGrades(input);
				studentMap.get(input).setGrades(grades);
				System.out.println(input + "학번 수정 완료.\n");
			} else if (input == 4) {// 4.삭제
				input = getStudentNumber(1);
				if (input == 0)
					continue;
				studentMap.remove(input);
				System.out.println(input + "학번 삭제 완료.\n");
			} else if (input == 5) {// 5. 검색
				input = getStudentNumber(2);
				if (input == 0)
					continue;
				System.out.println(line);
				System.out.println("학번\t이름\t국어\t영어\t수학\t평균");
				System.out.println(line);
				System.out.println(getStudentInfo(input));
				System.out.println(line);

			} else
				System.out.println("메뉴를 보고 다시 입력해주세요.\n");
		}
	}
}


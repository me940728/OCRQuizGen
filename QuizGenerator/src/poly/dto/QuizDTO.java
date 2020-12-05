package poly.dto;

public class QuizDTO {

	private int q_id;
    private int fk_user_no;
    private String q_pic;
    private String q_category;
    private String reg_id;
    private String chg_id;
    private String reg_dt;
    private String chg_dt;
    
    // 임시변수
    private String id;

	public int getQ_id() {
		return q_id;
	}

	public void setQ_id(int q_id) {
		this.q_id = q_id;
	}

	public int getFk_user_no() {
		return fk_user_no;
	}

	public void setFk_user_no(int fk_user_no) {
		this.fk_user_no = fk_user_no;
	}

	public String getQ_pic() {
		return q_pic;
	}

	public void setQ_pic(String q_pic) {
		this.q_pic = q_pic;
	}

	public String getQ_category() {
		return q_category;
	}

	public void setQ_category(String q_category) {
		this.q_category = q_category;
	}

	public String getReg_id() {
		return reg_id;
	}

	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}

	public String getChg_id() {
		return chg_id;
	}

	public void setChg_id(String chg_id) {
		this.chg_id = chg_id;
	}

	public String getReg_dt() {
		return reg_dt;
	}

	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}

	public String getChg_dt() {
		return chg_dt;
	}

	public void setChg_dt(String chg_dt) {
		this.chg_dt = chg_dt;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
    
	
}

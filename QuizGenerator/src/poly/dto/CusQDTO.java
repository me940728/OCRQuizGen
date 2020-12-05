package poly.dto;

public class CusQDTO {
	
	private int fk_user_no;
    private int fk_q_id;
    private int cq_num;
    private String cq_ans;
    private String cq_pic;
    private String reg_id;
    private String chg_id;
    private String reg_dt;
    private String chg_dt;
    
    // 임시 변수
    private String id;

	public int getFk_user_no() {
		return fk_user_no;
	}

	public void setFk_user_no(int fk_user_no) {
		this.fk_user_no = fk_user_no;
	}

	public int getFk_q_id() {
		return fk_q_id;
	}

	public void setFk_q_id(int fk_q_id) {
		this.fk_q_id = fk_q_id;
	}

	public int getCq_num() {
		return cq_num;
	}

	public void setCq_num(int cq_num) {
		this.cq_num = cq_num;
	}

	public String getCq_ans() {
		return cq_ans;
	}

	public void setCq_ans(String cq_ans) {
		this.cq_ans = cq_ans;
	}

	public String getCq_pic() {
		return cq_pic;
	}

	public void setCq_pic(String cq_pic) {
		this.cq_pic = cq_pic;
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

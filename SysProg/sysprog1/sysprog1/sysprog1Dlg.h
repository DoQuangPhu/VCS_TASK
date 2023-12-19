
// sysprog1Dlg.h : header file
//

#pragma once


// Csysprog1Dlg dialog
class Csysprog1Dlg : public CDialogEx
{
// Construction
public:
	Csysprog1Dlg(CWnd* pParent = nullptr);	// standard constructor

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_SYSPROG1_DIALOG };
#endif

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support


// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnEnChangeEdit1();
	afx_msg void OnLvnItemchangedList1(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnLvnItemchangedlistinfo(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnEnChangeEditPath();
	afx_msg void OnLvnItemchangedListInfoPath(NMHDR* pNMHDR, LRESULT* pResult);
	CListCtrl list_ctrl_path;
	CButton btn_search;
	CEdit variable_path;
	afx_msg void OnEnChangePath();
	void ReadPath(CString path);
	afx_msg void OnBnClickedButtonSearch();
};

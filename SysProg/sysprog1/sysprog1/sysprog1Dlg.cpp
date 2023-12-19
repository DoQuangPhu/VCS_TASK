
// sysprog1Dlg.cpp : implementation file
//

#include "pch.h"
#include "framework.h"
#include "sysprog1.h"
#include "sysprog1Dlg.h"
#include "afxdialogex.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CAboutDlg dialog used for App About

class CAboutDlg : public CDialogEx
{
public:
	CAboutDlg();

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_ABOUTBOX };
#endif

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

// Implementation
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialogEx(IDD_ABOUTBOX)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialogEx)
END_MESSAGE_MAP()


// Csysprog1Dlg dialog



Csysprog1Dlg::Csysprog1Dlg(CWnd* pParent /*=nullptr*/)
	: CDialogEx(IDD_SYSPROG1_DIALOG, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void Csysprog1Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);

	DDX_Control(pDX, IDC_LIST_INFO_PATH, list_ctrl_path);
	DDX_Control(pDX, IDC_BUTTON_SEARCH, btn_search);
	DDX_Control(pDX, IDC_EDIT_PATH, variable_path);
}

BEGIN_MESSAGE_MAP(Csysprog1Dlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_EN_CHANGE(IDC_EDIT_PATH, &Csysprog1Dlg::OnEnChangeEditPath)
	ON_NOTIFY(LVN_ITEMCHANGED, IDC_LIST_INFO_PATH, &Csysprog1Dlg::OnLvnItemchangedListInfoPath)
	ON_EN_CHANGE(VARIABLE_PATH, &Csysprog1Dlg::OnEnChangePath)
	ON_BN_CLICKED(IDC_BUTTON_SEARCH, &Csysprog1Dlg::OnBnClickedButtonSearch)
END_MESSAGE_MAP()


// Csysprog1Dlg message handlers

BOOL Csysprog1Dlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != nullptr)
	{
		BOOL bNameValid;
		CString strAboutMenu;
		bNameValid = strAboutMenu.LoadString(IDS_ABOUTBOX);
		ASSERT(bNameValid);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon

	// TODO: Add extra initialization here
	list_ctrl_path.SetExtendedStyle(LVS_EX_FULLROWSELECT | LVS_EX_GRIDLINES);
	list_ctrl_path.InsertColumn(0, _T("file name"), LVCFMT_LEFT, 300);
	list_ctrl_path.InsertColumn(1, _T("file absolutepath"), LVCFMT_LEFT, 300);
	list_ctrl_path.InsertColumn(2, _T("file size"), LVCFMT_LEFT, 100);
	list_ctrl_path.InsertColumn(3, _T("day modified"), LVCFMT_LEFT, 200);


	return TRUE;  // return TRUE  unless you set the focus to a control
}

void Csysprog1Dlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialogEx::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void Csysprog1Dlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

// The system calls this function to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR Csysprog1Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void Csysprog1Dlg::OnEnChangeEdit1()
{
	// TODO:  If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialogEx::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.

	// TODO:  Add your control notification handler code here
}


void Csysprog1Dlg::OnLvnItemchangedList1(NMHDR* pNMHDR, LRESULT* pResult)
{
	LPNMLISTVIEW pNMLV = reinterpret_cast<LPNMLISTVIEW>(pNMHDR);
	// TODO: Add your control notification handler code here
	*pResult = 0;
}


void Csysprog1Dlg::OnLvnItemchangedlistinfo(NMHDR* pNMHDR, LRESULT* pResult)
{
	LPNMLISTVIEW pNMLV = reinterpret_cast<LPNMLISTVIEW>(pNMHDR);
	// TODO: Add your control notification handler code here
	*pResult = 0;
}


void Csysprog1Dlg::OnEnChangeEditPath()
{
	
}


void Csysprog1Dlg::OnLvnItemchangedListInfoPath(NMHDR* pNMHDR, LRESULT* pResult)
{
	LPNMLISTVIEW pNMLV = reinterpret_cast<LPNMLISTVIEW>(pNMHDR);
	// TODO: Add your control notification handler code here
	*pResult = 0;


}


void Csysprog1Dlg::OnEnChangePath()
{
	// TODO:  If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialogEx::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.

	// TODO:  Add your control notification handler code here
}


void Csysprog1Dlg::ReadPath(CString path)
{
	CString searchPath = path + _T("\\*.*");
	CFileFind finder;

	BOOL bWorking = finder.FindFile(searchPath); // Start finding files
	if (!bWorking)
	{
		MessageBox(L"Invalid Path!!!!");
	}
	while (bWorking) {
		bWorking = finder.FindNextFile(); // Find the next file

		if (!finder.IsDots()) {
			CString fileName = finder.GetFileName(); // Get the file or folder name
			CString filePath = finder.GetFilePath(); // Get the file or folder path
			ULONGLONG fileSize = finder.IsDirectory() ? 0 : finder.GetLength(); // Get the file size or set to 0 for folders
			FILETIME lastModified;
			finder.GetLastWriteTime(&lastModified); // Get the last modified time

			// Convert numeric values to strings
			CString strFileSize;
			if (finder.IsDirectory()) {
				strFileSize = _T("Folder"); // Display "Folder" for directories
				CString strLastModified;
				COleDateTime lastModifiedTime(lastModified);
				strLastModified = lastModifiedTime.Format(_T("%Y-%m-%d %H:%M:%S")); // Format last modified time as a string

				// Insert the file or folder information into the list control
				int itemIndex = list_ctrl_path.InsertItem(0, fileName); // Insert file or folder name
				list_ctrl_path.SetItemText(itemIndex, 1, filePath); // Set file or folder path
				list_ctrl_path.SetItemText(itemIndex, 2, strFileSize); // Set file size or "Folder" for directories
				list_ctrl_path.SetItemText(itemIndex, 3, strLastModified); // Set last modified time
				
				CString tmp_path = path + _T("\\") + fileName;
				ReadPath(tmp_path);
			}
			else {
				strFileSize.Format(_T("%I64u"), fileSize); // Format file size as a string
			}

			CString strLastModified;
			COleDateTime lastModifiedTime(lastModified);
			strLastModified = lastModifiedTime.Format(_T("%Y-%m-%d %H:%M:%S")); // Format last modified time as a string

			// Insert the file or folder information into the list control
			int itemIndex = list_ctrl_path.InsertItem(0, fileName); // Insert file or folder name
			list_ctrl_path.SetItemText(itemIndex, 1, filePath); // Set file or folder path
			list_ctrl_path.SetItemText(itemIndex, 2, strFileSize); // Set file size or "Folder" for directories
			list_ctrl_path.SetItemText(itemIndex, 3, strLastModified); // Set last modified time
		}
	}

	finder.Close(); // Close the finder
}




void Csysprog1Dlg::OnBnClickedButtonSearch()
{
	// TODO: Add your control notification handler code here
	list_ctrl_path.DeleteAllItems();
	CString path;
	variable_path.GetWindowTextW(path);
	ReadPath(path);
}

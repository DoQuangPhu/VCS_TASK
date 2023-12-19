
// sysprog1.h : main header file for the PROJECT_NAME application
//

#pragma once

#ifndef __AFXWIN_H__
	#error "include 'pch.h' before including this file for PCH"
#endif

#include "resource.h"		// main symbols


// Csysprog1App:
// See sysprog1.cpp for the implementation of this class
//

class Csysprog1App : public CWinApp
{
public:
	Csysprog1App();

// Overrides
public:
	virtual BOOL InitInstance();

// Implementation

	DECLARE_MESSAGE_MAP()
};

extern Csysprog1App theApp;

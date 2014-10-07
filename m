From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: [PATCH 1/4] Input: pmic8xxx-keypad - remove unused register and bit definitions
Date: Tue,  7 Oct 2014 12:50:45 +0300
Message-ID: <1412675448-11990-2-git-send-email-iivanov@mm-sol.com>
References: <1412675448-11990-1-git-send-email-iivanov@mm-sol.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1412675448-11990-1-git-send-email-iivanov@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

These defines are not used by driver. Remove them.

Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 drivers/input/keyboard/pmic8xxx-keypad.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index 80c6b0e..dd1fc95 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -43,7 +43,6 @@
 
 #define KEYP_CTRL			0x148
 
-#define KEYP_CTRL_EVNTS			BIT(0)
 #define KEYP_CTRL_EVNTS_MASK		0x3
 
 #define KEYP_CTRL_SCAN_COLS_SHIFT	5
@@ -58,21 +57,10 @@
 
 #define KEYP_SCAN			0x149
 
-#define KEYP_SCAN_READ_STATE		BIT(0)
 #define KEYP_SCAN_DBOUNCE_SHIFT		1
 #define KEYP_SCAN_PAUSE_SHIFT		3
 #define KEYP_SCAN_ROW_HOLD_SHIFT	6
 
-#define KEYP_TEST			0x14A
-
-#define KEYP_TEST_CLEAR_RECENT_SCAN	BIT(6)
-#define KEYP_TEST_CLEAR_OLD_SCAN	BIT(5)
-#define KEYP_TEST_READ_RESET		BIT(4)
-#define KEYP_TEST_DTEST_EN		BIT(3)
-#define KEYP_TEST_ABORT_READ		BIT(0)
-
-#define KEYP_TEST_DBG_SELECT_SHIFT	1
-
 /* bits of these registers represent
  * '0' for key press
  * '1' for key release
-- 
1.9.1

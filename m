From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH 0/4] platform/x86: intel-vbtn: Add support for several more switches/buttons
Date: Fri, 3 Nov 2017 20:03:25 +0100
Message-ID: <b8013fda-0f69-41d7-ade3-98ca861dc30d@rwthex-w2-a.rwth-ad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>, Andy Shevchenko <andy@infradead.org>, linux-kernel@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-input@vger.kernel.org

Currently, intel-vbtn only supports the most relevant buttons, although
there are several more events, mostly in use by convertibles.

This series adds support for three more events. One of these events
is a switch (SW_*) event, which is currently not working when using
sparse keymaps. The first patch fixes this combination.

The second patch adds support for the SW_TABLET_MODE switch, which
is used by current convertibles.

The third patch adds support for the KEY_ROTATE_DISPLAY. On the Dell
XPS 12 (9Q33), rotation lock is implemented as a button to toggle
between locked and unlocked state. In locked state, the accelerometer
should be ignored, while in unlocked the screen contents should
autorotate based on the tablet orientation. The same functionality
is likely implemented as a switch (SW_ROTATE_LOCK event) on different
hardware.

The fourth patch adds support for the "Windows logo" button/key found on
the XPS 12 display (i.e. in tablet mode, it is the only key reachable).
The Lenovo Helix 2 has an equivalent touch button. The event currently
uses KEY_MENU, although a distinct key code may be a better choice.


Stefan Brüns (4):
  Input: sparse-keymap - send sync event for KE_SW/KW_VSW
  platform/x86: intel-vbtn: support SW_TABLET_MODE
  platform/x86: intel-vbtn: support KEY_ROTATE_DISPLAY
  platform/x86: intel-vbtn: support panel front button

 drivers/input/sparse-keymap.c     | 1 +
 drivers/platform/x86/intel-vbtn.c | 6 ++++++
 2 files changed, 7 insertions(+)

-- 
2.14.3

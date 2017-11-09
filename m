From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH v2 0/5] platform/x86: intel-vbtn: Add support for several more switches/buttons
Date: Thu, 9 Nov 2017 23:44:31 +0100
Message-ID: <e8cfd35b-5678-4374-aea0-22adec33551c@rwthex-w2-a.rwth-ad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out-2.itc.rwth-aachen.de ([134.130.5.47]:28857 "EHLO
        mail-out-2.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751709AbdKIWoz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Nov 2017 17:44:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: linux-input@vger.kernel.org, =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>, Andy Shevchenko <andy@infradead.org>, linux-kernel@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Darren Hart <dvhart@infradead.org>

Currently, intel-vbtn only supports the most relevant buttons, although
there are several more events, mostly in use by convertibles.

(Original first patch omitted from series, as already applied upstream.)

The first patch adds support for the SW_TABLET_MODE switch, which
is used by current convertibles.

The second patch adds support for distinct press/release events in the
intel-vbtn driver. This is required for the KEY_LEFTMETA modifier
("Windows logo") key, added later.

The third patch introduces a new keycode, KEY_ROTATE_LOCK_TOGGLE, which
should be used by devices which use a button for rotation lock instead
of a switch (SW_ROTATE_LOCK).

The fourth patch adds support for the KEY_ROTATE_LOCK_TOGGLE. On the Dell
XPS 12 (9Q33), rotation lock is implemented as a button to toggle
between locked and unlocked state. In locked state, the accelerometer
should be ignored, while in unlocked state the screen contents should
autorotate based on the tablet orientation.

The fifth patch adds support for the "Windows logo" button/key found on the
XPS 12 display front. The Lenovo Helix 2 has an equivalent touch button.

Changes in v2:
- Correct whitespace in key_entry struct
- New patch, add support for seperate key up/down in intel-vbtn
- New patch, add support for KEY_ROTATE_LOCK_TOGGLE
- Emit KEY_ROTATE_LOCK_TOGGLE instead of KEY_ROTATE_DISPLAY
- Use separate up/down events
- Emit KEY_LEFTMETA instead of KEY_MENU

Stefan Brüns (5):
  platform/x86: intel-vbtn: support SW_TABLET_MODE
  platform/x86: intel-vbtn: Support separate press/release events
  Input: add KEY_ROTATE_LOCK_TOGGLE
  platform/x86: intel-vbtn: support KEY_ROTATE_LOCK_TOGGLE
  platform/x86: intel-vbtn: support panel front button

 drivers/platform/x86/intel-vbtn.c      | 23 +++++++++++++++++++++--
 include/uapi/linux/input-event-codes.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.15.0


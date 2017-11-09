From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH v2 1/5] platform/x86: intel-vbtn: support SW_TABLET_MODE
Date: Thu, 9 Nov 2017 23:44:32 +0100
Message-ID: <fb108f3b-7774-4caa-a5fb-daa50399163a@rwthex-w2-a.rwth-ad.de>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: linux-input@vger.kernel.org, =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>, AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Event code 0xcc is emitted by several convertibles (Dell XPS 12 9Q33 BIOS
A8, Dell XPS 13 2in1 9365, HP Spectre x360, Lenovo Thinkpad Helix) when
entering tablet mode, and 0xcd on return to laptop mode.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

---

Changes in v2:
- Correct whitespace in key_entry struct

The changes where tested on an XPS 12 with BIOS version A8 (2015-03-03).
An earlier BIOS version (A2, ~2013) did not report event, at least
not using the INT33D6 plattform device.

There are other convertible laptops apparenly using the same event
codes:
https://wiki.gentoo.org/wiki/HP_Spectre_x360_(2015)
https://bugs.launchpad.net/ubuntu/+source/unity8/+bug/1678200
https://forums.opensuse.org/showthread.php/526850-Touchpad-and-trackpoint-no-longer-working-after-reattaching-convertible-keyboard

---
 drivers/platform/x86/intel-vbtn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index 58c5ff36523a..ae55be91a64b 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -42,6 +42,8 @@ static const struct key_entry intel_vbtn_keymap[] = {
 	{ KE_IGNORE, 0xC5, { KEY_VOLUMEUP } },		/* volume-up key release */
 	{ KE_KEY, 0xC6, { KEY_VOLUMEDOWN } },		/* volume-down key press */
 	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release */
+	{ KE_SW,     0xCC, { .sw = { SW_TABLET_MODE, 1 } } },	/* Tablet */
+	{ KE_SW,     0xCD, { .sw = { SW_TABLET_MODE, 0 } } },	/* Laptop */
 	{ KE_END },
 };
 
-- 
2.15.0

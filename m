From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH v2 4/5] platform/x86: intel-vbtn: support KEY_ROTATE_LOCK_TOGGLE
Date: Thu, 9 Nov 2017 23:44:35 +0100
Message-ID: <1a034599-ff6c-4a42-8252-4f6007894f4a@rwthex-w2-a.rwth-ad.de>
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

The Rotate Lock button event is emitted on the XPS 12 (BIOS A8, but not
on BIOS A2).

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---

Changes in v2:
- Emit KEY_ROTATE_LOCK_TOGGLE instead of KEY_ROTATE_DISPLAY
- Use separate up/down events

 drivers/platform/x86/intel-vbtn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index e3f6375af85c..a484bcc6393b 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -42,6 +42,8 @@ static const struct key_entry intel_vbtn_keymap[] = {
 	{ KE_IGNORE, 0xC5, { KEY_VOLUMEUP } },		/* volume-up key release */
 	{ KE_KEY, 0xC6, { KEY_VOLUMEDOWN } },		/* volume-down key press */
 	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release */
+	{ KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key press */
+	{ KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key release */
 	{ KE_SW,     0xCC, { .sw = { SW_TABLET_MODE, 1 } } },	/* Tablet */
 	{ KE_SW,     0xCD, { .sw = { SW_TABLET_MODE, 0 } } },	/* Laptop */
 	{ KE_END },
-- 
2.15.0

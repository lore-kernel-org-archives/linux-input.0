From: "Stefan Lippers-Hollmann" <s.L-H@gmx.de>
Subject: [PATCH 2/3] wistron_btns: mark the Medion MD96500 keymap as tested
Date: Tue, 13 Aug 2013 00:53:53 +0200
Message-ID: <201308130053.59956.s.L-H@gmx.de>
References: <201308130050.52800.s.L-H@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201308130050.52800.s.L-H@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Miloslav Trmac <mitr@volny.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

DMI: MEDIONPC WIM 2040/WIM 2040, BIOS R01-A0O    11/04/2005
wistron_btns: BIOS signature found at c00f6b00, entry point 000FDD50
input: Wistron laptop buttons as /devices/platform/wistron-bios/input/input5

Signed-off-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
---
 drivers/input/misc/wistron_btns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -562,7 +562,7 @@ static struct key_entry keymap_wistron_m
 	{ KE_KEY, 0x36, {KEY_WWW} },
 	{ KE_WIFI, 0x30 },
 	{ KE_BLUETOOTH, 0x44 },
-	{ KE_END, FE_UNTESTED }
+	{ KE_END, 0 }
 };
 
 static struct key_entry keymap_wistron_generic[] __initdata = {

From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH 6/33] drivers/char: Make static
Date: Tue, 09 Dec 2008 18:12:36 +0100
Message-ID: <493EA704.5070007@gmail.com>
References: <493EA286.7080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:3300 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbYLIRMi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Dec 2008 12:12:38 -0500
Received: by ey-out-2122.google.com with SMTP id 6so15793eyi.37
        for <linux-input@vger.kernel.org>; Tue, 09 Dec 2008 09:12:36 -0800 (PST)
In-Reply-To: <493EA286.7080500@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Sparse asked whether these could be static.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/char/defkeymap.c_shipped |    6 +++---
 drivers/char/keyboard.c          |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/defkeymap.c_shipped b/drivers/char/defkeymap.c_shipped
index d2208df..e930e3b 100644
--- a/drivers/char/defkeymap.c_shipped
+++ b/drivers/char/defkeymap.c_shipped
@@ -43,7 +43,7 @@ u_short shift_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-u_short altgr_map[NR_KEYS] = {
+static u_short altgr_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf040,	0xf200,	0xf024,	0xf200,	0xf200,
 	0xf07b,	0xf05b,	0xf05d,	0xf07d,	0xf05c,	0xf200,	0xf200,	0xf200,
 	0xfb71,	0xfb77,	0xf918,	0xfb72,	0xfb74,	0xfb79,	0xfb75,	0xfb69,
@@ -100,7 +100,7 @@ u_short shift_ctrl_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-u_short alt_map[NR_KEYS] = {
+static u_short alt_map[NR_KEYS] = {
 	0xf200,	0xf81b,	0xf831,	0xf832,	0xf833,	0xf834,	0xf835,	0xf836,
 	0xf837,	0xf838,	0xf839,	0xf830,	0xf82d,	0xf83d,	0xf87f,	0xf809,
 	0xf871,	0xf877,	0xf865,	0xf872,	0xf874,	0xf879,	0xf875,	0xf869,
@@ -119,7 +119,7 @@ u_short alt_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-u_short ctrl_alt_map[NR_KEYS] = {
+static u_short ctrl_alt_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 	0xf811,	0xf817,	0xf805,	0xf812,	0xf814,	0xf819,	0xf815,	0xf809,
diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index de26a97..564f719 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -151,7 +151,7 @@ static struct ledptr {
 /* Simple translation table for the SysRq keys */
 
 #ifdef CONFIG_MAGIC_SYSRQ
-unsigned char kbd_sysrq_xlate[KEY_MAX + 1] =
+static unsigned char kbd_sysrq_xlate[KEY_MAX + 1] =
         "\000\0331234567890-=\177\t"                    /* 0x00 - 0x0f */
         "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
         "dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f */


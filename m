From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 3/3] Input: adp5589-keys: fix event count mask
Date: Tue, 21 Apr 2015 11:21:30 -0300
Message-ID: <1429626090-29022-4-git-send-email-guido@vanguardiasur.com.ar>
References: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:32974 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbbDUOVs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2015 10:21:48 -0400
Received: by qkx62 with SMTP id 62so207839446qkx.0
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2015 07:21:47 -0700 (PDT)
In-Reply-To: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

The event mask was specified as 0xF (4 bits) when in reality is 0x1F (5
bits) in order to be capable of representing all FIFO length values fro=
m
0 to 16.

This caused a problem: when the keypad reported 16 pending events the
driver took it as 0, and did nothing. This in turn caused the keypad to
re-issue the interrupt over and over again.

=46ixes: 9d2e173644bb ('Input: ADP5589 - new driver for I2C Keypad Deco=
der and I/O Expander')
Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
---
 drivers/input/keyboard/adp5589-keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyb=
oard/adp5589-keys.c
index 8709a7f..0419a7a 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -180,7 +180,7 @@
 #define LOGIC2_STAT	(1 << 7)	/* ADP5589 only */
 #define LOGIC1_STAT	(1 << 6)
 #define LOCK_STAT	(1 << 5)	/* ADP5589 only */
-#define KEC		0xF
+#define KEC		0x1F
=20
 /* PIN_CONFIG_D Register */
 #define C4_EXTEND_CFG	(1 << 6)	/* RESET2 */
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 2/3] Input: adp5589-keys: fix pull mask setting
Date: Tue, 21 Apr 2015 11:21:29 -0300
Message-ID: <1429626090-29022-3-git-send-email-guido@vanguardiasur.com.ar>
References: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:32927 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbbDUOVp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2015 10:21:45 -0400
Received: by qkx62 with SMTP id 62so207838298qkx.0
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2015 07:21:44 -0700 (PDT)
In-Reply-To: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

The pull mask is created by looping each row (column) and building an
8-bit integer with the configuration. It is written byte-by-byte, when
we reach the end of the rows (columns) or we're at the 3rd line (which
finishes the first byte, since each pin is 2bits on the mask).

However, this only works if we have at most 8 pins (2 bytes), which is
not the case for the ADP5589. So, write the byte at each boundary (ever=
y
4 rows/columns).

=46ixes: 9d2e173644bb ('Input: ADP5589 - new driver for I2C Keypad Deco=
der and I/O Expander')
Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
---
 drivers/input/keyboard/adp5589-keys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyb=
oard/adp5589-keys.c
index 19edd2d..8709a7f 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -729,7 +729,7 @@ static int adp5589_setup(struct adp5589_kpad *kpad)
=20
 		pull_mask |=3D val << (2 * (i & 0x3));
=20
-		if (i =3D=3D 3 || i =3D=3D kpad->var->max_row_num) {
+		if (i % 4 =3D=3D 3 || i =3D=3D kpad->var->max_row_num) {
 			ret |=3D adp5589_write(client, reg(ADP5585_RPULL_CONFIG_A)
 					     + (i >> 2), pull_mask);
 			pull_mask =3D 0;
@@ -749,7 +749,7 @@ static int adp5589_setup(struct adp5589_kpad *kpad)
=20
 		pull_mask |=3D val << (2 * (i & 0x3));
=20
-		if (i =3D=3D 3 || i =3D=3D kpad->var->max_col_num) {
+		if (i % 4 =3D=3D 3 || i =3D=3D kpad->var->max_col_num) {
 			ret |=3D adp5589_write(client,
 					     reg(ADP5585_RPULL_CONFIG_C) +
 					     (i >> 2), pull_mask);
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

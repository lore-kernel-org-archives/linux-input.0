From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH 1/2] input: keyboard: imx: no need to control interrupt status
 in event check
Date: Fri, 29 Mar 2019 07:00:43 +0000
Message-ID: <1553842562-8481-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

There is no need to enable release interrupt and disable depress
interrupt in event check, as a timer is setup for checking these
events rather than interrupts.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/keyboard/imx_keypad.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/i=
mx_keypad.c
index 539cb67..7e32c36 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -276,11 +276,6 @@ static void imx_keypad_check_for_events(struct timer_l=
ist *t)
 		reg_val =3D readw(keypad->mmio_base + KPSR);
 		reg_val |=3D KBD_STAT_KPKR | KBD_STAT_KRSS;
 		writew(reg_val, keypad->mmio_base + KPSR);
-
-		reg_val =3D readw(keypad->mmio_base + KPSR);
-		reg_val |=3D KBD_STAT_KRIE;
-		reg_val &=3D ~KBD_STAT_KDIE;
-		writew(reg_val, keypad->mmio_base + KPSR);
 	}
 }
=20
--=20
2.7.4

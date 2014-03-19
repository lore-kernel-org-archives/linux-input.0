From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv4 4/5] Input: edt-ft5x06: Ignore touchdown events
Date: Wed, 19 Mar 2014 14:09:22 +0100
Message-ID: <1395234563-11034-5-git-send-email-LW@KARO-electronics.de>
References: <1395234563-11034-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395234563-11034-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fugang Duan <B38611@freescale.com>, Grant Likely <grant.likely@linaro.org>, Henrik Rydberg <rydberg@euromail.se>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jg1.han@samsung.com>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Rob Landley <rob@landley.net>, Sachin Kamat <sachin.kamat@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-input@vger.kernel.org

The chip may report invalid coordinates on touchdown events, so don't
report the initial touchdown event.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/input/touchscreen/edt-ft5x06.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/tou=
chscreen/edt-ft5x06.c
index 27dccfc..af736e4 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -175,6 +175,10 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void=
 *dev_id)
 		if (type =3D=3D TOUCH_EVENT_RESERVED)
 			continue;
=20
+		/* ignore TOUCH_DOWN events, might have bogus coordinates */
+		if (type =3D=3D TOUCH_EVENT_DOWN)
+			continue;
+
 		x =3D ((buf[0] << 8) | buf[1]) & 0x0fff;
 		y =3D ((buf[2] << 8) | buf[3]) & 0x0fff;
 		id =3D (buf[2] >> 4) & 0x0f;
--=20
1.7.10.4

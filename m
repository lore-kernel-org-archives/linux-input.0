From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 3/3] input: rotary-encoder: Support 'steps-per-period' DT property
Date: Fri,  9 Oct 2015 10:46:56 -0300
Message-ID: <1444398416-3073-4-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1444398416-3073-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35207 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbbJINvQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2015 09:51:16 -0400
Received: by qgt47 with SMTP id 47so68840456qgt.2
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2015 06:51:15 -0700 (PDT)
In-Reply-To: <1444398416-3073-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <zonque@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, mark.rutland@arm.com, robh+dt@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, ariel@vanguardiasur.com.ar, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

As per the recent devicetree binding changes, this commit adds the
support for the new 'steps-per-period' property.

Legacy properties to specify the rotary behavior, are now deprecated
and instead the new 'steps-per-period' is supported. The default behavi=
or
is retained.

This allows to support rotary-encoder devices with detents wich are cap=
able
of producing a stable event on each step.

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/input/misc/rotary_encoder.c | 87 +++++++++++++++++++++++++++++=
++++++--
 include/linux/rotary_encoder.h      |  2 +-
 2 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/r=
otary_encoder.c
index 15a4cc670a3f..e021615dd3c0 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -142,6 +142,55 @@ static irqreturn_t rotary_encoder_half_period_irq(=
int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
=20
+static irqreturn_t rotary_encoder_quarter_period_irq(int irq, void *de=
v_id)
+{
+	struct rotary_encoder *encoder =3D dev_id;
+	unsigned char sum;
+	int state;
+
+	state =3D rotary_encoder_get_state(encoder->pdata);
+
+	/*
+	 * We encode the previous and the current state using a byte.
+	 * The previous state in the MSB nibble, the current state in the LSB
+	 * nibble. Then use a table to decide the direction of the turn.
+	 */
+	sum =3D (encoder->last_stable << 4) + state;
+	switch (sum) {
+	case 0x31:
+	case 0x10:
+	case 0x02:
+	case 0x23:
+		encoder->dir =3D 0; /* clockwise */
+		break;
+
+	case 0x13:
+	case 0x01:
+	case 0x20:
+	case 0x32:
+		encoder->dir =3D 1; /* counter-clockwise */
+		break;
+
+	default:
+		/*
+		 * Ignore all other values. This covers the case when the
+		 * state didn't change (a spurious interrupt) and the
+		 * cases where the state changed by two steps, making it
+		 * impossible to tell the direction.
+		 *
+		 * In either case, don't report any event and save the
+		 * state for later.
+		 */
+		goto out;
+	}
+
+	rotary_encoder_report_event(encoder);
+
+out:
+	encoder->last_stable =3D state;
+	return IRQ_HANDLED;
+}
+
 #ifdef CONFIG_OF
 static const struct of_device_id rotary_encoder_of_match[] =3D {
 	{ .compatible =3D "rotary-encoder", },
@@ -176,7 +225,26 @@ static struct rotary_encoder_platform_data *rotary=
_encoder_parse_dt(struct devic
=20
 	pdata->relative_axis =3D of_property_read_bool(np, "rotary-encoder,re=
lative-axis");
 	pdata->rollover =3D of_property_read_bool(np, "rotary-encoder,rollove=
r");
-	pdata->half_period =3D of_property_read_bool(np, "rotary-encoder,half=
-period");
+
+	if (!of_get_property(np, "rotary-encoder,steps-per-period", NULL)) {
+		/*
+		 * Fallback to a one step per period behavior if the
+		 * 'steps-per-period' is not set.
+		 */
+		pdata->steps_per_period =3D 1;
+	} else {
+		of_property_read_u32(np, "rotary-encoder,steps-per-period",
+				     &pdata->steps_per_period);
+	}
+
+	/*
+	 * The 'half-period' property has been deprecated, you must use
+	 * 'steps-per-period' and set an appropriate value.
+	 */
+	if (of_get_property(np, "rotary-encoder,half-period", NULL)) {
+		pr_warn(FW_WARN "\"rotary-encoder,half-period\" is deprecated\n");
+		pdata->steps_per_period =3D 2;
+	}
=20
 	return pdata;
 }
@@ -247,12 +315,23 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 	encoder->irq_a =3D gpio_to_irq(pdata->gpio_a);
 	encoder->irq_b =3D gpio_to_irq(pdata->gpio_b);
=20
-	/* request the IRQs */
-	if (pdata->half_period) {
+	switch (pdata->steps_per_period) {
+	case 4:
+		handler =3D &rotary_encoder_quarter_period_irq;
+		encoder->last_stable =3D rotary_encoder_get_state(pdata);
+		break;
+	case 2:
 		handler =3D &rotary_encoder_half_period_irq;
 		encoder->last_stable =3D rotary_encoder_get_state(pdata);
-	} else {
+		break;
+	case 1:
 		handler =3D &rotary_encoder_irq;
+		break;
+	default:
+		dev_err(dev, "'%d' is not a valid steps-per-period value\n",
+			pdata->steps_per_period);
+		err =3D -EINVAL;
+		goto exit_free_gpio_b;
 	}
=20
 	err =3D request_irq(encoder->irq_a, handler,
diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_enco=
der.h
index 3f594dce5716..0bebba31908c 100644
--- a/include/linux/rotary_encoder.h
+++ b/include/linux/rotary_encoder.h
@@ -10,7 +10,7 @@ struct rotary_encoder_platform_data {
 	unsigned int inverted_b;
 	bool relative_axis;
 	bool rollover;
-	bool half_period;
+	unsigned int steps_per_period;
 };
=20
 #endif /* __ROTARY_ENCODER_H__ */
--=20
2.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

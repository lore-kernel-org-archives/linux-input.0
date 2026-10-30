Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343185;
	b=fehgz6N694WnXdIllL+IHq9y6V6DqHUIsnjNEcTxX0WB9b6at4WUBYFlI11iYtCkoaNQ
	 DtAL5cLQgDOw1vHFobutyb6c941lcQ1Rg9dv5DRoGUZ1XdtdZoH5yyjCDoYCryC3T1Nmh
	 EOa7Y1zEHneX1uCDdoNadOrn6vRMi4dB2YqNRZIEaUSd/EJXLlBgqzatckhUc61GHSAfq
	 8N77kzhOKIDcnheL4QMvd/v4KLL+j8+woqYTqaL8imovades6rVmyaSlouu7YSfcj2Om8
	 5JYRauTyvbrGazR9lpEcW1thYhm80sNCChdWzVMRKdMrqGWntKHZyUCoyfOAqikqGEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mHd/Wr3BFH8QFtsPeQilYKemQuojRmVOWieDBcVZcE8=;
	b=Uf4RnS2cmjzLNvrDbhRZfl8zn/RZ/oxOIuOXkCHDaZZGXw3T666+vvMmI3vqkH7mlSQl
	 fcllT8HFrOMZl4Ijw+k3rQfa0p2xISjHjSQP0uCf96S5oMe0dU2+gYV4AQOVYbKsdjbVf
	 6qqM84LUvZ5+jo/mFAKIRwrwJtzbr0l1NURC4Kyd0Z7wKbtWIN6FbKUjt6mxVjUciHqjg
	 b8axS7gSfipyGvkf3/g6CPant3/oog0M2/s3WD/HSYre2DnsK5XOaB+sLyHj8MErfibnY
	 u6qVuDdUBhg+PfQOLbrKnSKYe7rSn5W7xdDSrOmfCMFcGRp/jS4RThVNwI7KZLJy5Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdpl67dy;
	arc=none smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1642606A31C
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 06:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1642606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdpl67dy
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ab3dd9670bso3384591fa.1
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793343183; x=1793947983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mHd/Wr3BFH8QFtsPeQilYKemQuojRmVOWieDBcVZcE8=;
        b=xdpl67dytbzMhwH9NnISgP/uV0Va+7GyDNmwYitnPCe2BhCjJEKXtlRAKoMOz7UHFR
         /Qp6x4Me19L8pWxdmBI2b9QxV3B9PI/nErpop+eWH6daruywM6L+rvEPGwHKG4L3wCAS
         lW9cG1otCGa80KoEkGixrGB+ifgPMMqEKh3/FYkn882gTMusaUuaLqHtDdAlOraswWTm
         tpoO6IXhdt4p2oXD85N/VZc8oigg4EHL6n8giXu2kUGzyETIIKjt+ttjNwoLxUoL5V8m
         ZX0zxT343tc4MOhFnYaWfZ2FtPS5RLSPKqPtLzWTpZKBZ6F3CmNK9joD5uiqhabumGEw
         ++gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793343183; x=1793947983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mHd/Wr3BFH8QFtsPeQilYKemQuojRmVOWieDBcVZcE8=;
        b=BzcVka8hggCFay28orwMdQno0VDUavJ9FJ0MOv53uZDH2/agF+tSq2YuUTu994vAj9
         YaZX5miT7VDFByZn7w7gqIIpI7TarATO2qoHnQHW+BmEglY94Oac1bJGO0cRr5/JIGMM
         wKyXw4FRPD08rt956nDlZTQy6wx72FQhExAxNzSz1YNqu+28vg+xhlXXktXwMli2BhDw
         F2lZzrIoccihhd3ObiRIveOhYxVjSLhb8QMsJyZRk4/NGhNlhy93Q1YoK9sorPpIolHe
         2CRpesTzXcfAAhUCHUM48LG2sHzLh8IdLa++eZzO3qmj7SLljPdsYMbmmk/Z7UiqgkXf
         2MOQ==
X-Gm-Message-State: AFq9FYKWkYAnz27yy37I+vIWOiicENqdilMQV9FHXhGSQ8YKdyXmRsX7
	CYWsfjmSmNw2/GLxb50ITaq+AoANTkMGVhMrenMOQfVY8llW3kdqwb6g
X-Gm-Gg: AYBFou2uIiH3psIQQOlnmEnPH/zlEcKEWX0dAg88+612UTJPiOIf+t4GSoJDhk1uvi2
	+GIEXgI+j0e1Kj+cjqAyf4J8Zxb9Pvr1XEZl/go3RH5KNspshcYUnC2/Q8tN5PHmS4lQXQIPGp4
	Fndz+1gARlzY5CBnbQ+Ly27Oi3XohT5wERJ4tbzUruuu65Qa+MgwyRZShSybK0K69E9aQHfCEkm
	ALa26a7+utMUaqOQsqKIkwr3i3MnPYJ7RARtzzqWUfMXkXglsB4cw+z7npqDo/0aW2s16C5PgyO
	d4FomhnbA5/qIlLGfcz6nGG7AVdM5yPmb7GxwdkxezoQK3RcED4OgOClLYzzEc4lpPDMrrn3rtr
	Xgui3DPlL3vZKQMq0GCEZoA3lpV5kX1qKCrxkLUQtxP3Gg80DGnZgUVoTVEKah+m7f4aioQwQMj
	xNiKn3JeV3LS8F+CRalJqTaQXoMKA08tdrczLb9yysJW0rMCRYlkzoWws5NjdooP/m7oXVZAJvN
	4A40sVDlR2zor9jqrceKbXKpRbwfHcgSHNscGivYupfQheziCnte4Au+Nl4anwie+E0SxYVTzoe
	UcL5VX4dm3g0Z0/raCSw9nDKK/NGq9TuShtp4T8GiYkf1P/Qax2Mbs/hhT31isKFane/bnD+
X-Received: by 2002:a05:651c:1474:b0:3a5:8d4d:470d with SMTP id 38308e7fff4ca-3acb7a8a4a3mr2928791fa.18.1793343182840;
        Thu, 29 Oct 2026 23:53:02 -0700 (PDT)
Received: from ahmad-HP-ZBook-17-G3 ([5.212.7.215])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acbbee00a0sm1451851fa.19.2026.10.29.23.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 23:53:01 -0700 (PDT)
From: ahmad baghereslami <ahmad.b1995@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ahmad baghereslami <ahmad.b1995@gmail.com>
Subject: [PATCH] Input: synaptics - support the touchpad LED on RMI function $30
Date: Fri, 30 Oct 2026 10:22:40 +0330
Message-ID: <20261030065240.1706377-1-ahmad.b1995@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some HP laptops have an LED in the top left corner of the Synaptics
touchpad that HP's Windows driver lights while the touchpad is disabled
(double tap on that corner). On the HP ZBook 17 G3 (SYN3040, TM2706-002)
the LED is not driven through the PS/2 deluxe LED command: the Windows
driver (SynTP.sys 19.0.19.68) switches the touchpad to RMI register
access over PS/2 with mode byte 0x7f, looks up function $30 (GPIO/LED)
in the page description table and sets the LED bit in its control
register:

  register write:  SetScale 2:1, SetRate <reg>, SetRate <value>
  register read:   SetScale 2:1, SetRate <reg>, GetInfo (first byte)

For touchpads in a new rmi_led_pnp_ids list, look up the F30 LED this
way when the touchpad is set up and register a
synaptics::touchpad_disabled LED class device. Setting it deactivates
the touchpad, writes the F30 registers and restores the mode byte, which
leaves RMI access. The LED is restored after reconnect.

On this touchpad F30 is on page 1 with control base 0x55 and four
GPIO/LED pins; the LED is bit 3 of control register 0x59 and its
brightness register is 0x5f.

Tested on an HP ZBook 17 G3 with Ubuntu's 7.0.0 kernel: the LED follows
writes to its brightness file, the touchpad and the pointing stick keep
working, and a userspace helper that turns the touchpad off on a double
tap in the corner keeps the LED in step with GNOME's touchpad setting.

Reading HP's Windows driver (Ghidra) and writing this patch were done
with the help of an AI coding assistant (Claude); I tested the LED and
the touchpad on the machine.

Signed-off-by: ahmad baghereslami <ahmad.b1995@gmail.com>
---
 drivers/input/mouse/synaptics.c | 241 ++++++++++++++++++++++++++++++++
 drivers/input/mouse/synaptics.h |  13 ++
 2 files changed, 254 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index b007e642e..bf1c6c738 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -589,6 +589,236 @@ static int synaptics_set_advanced_gesture_mode(struct psmouse *psmouse)
 	return 0;
 }
 
+/*
+ * Some HP touchpads have an LED in the top left corner that HP's Windows
+ * driver lights while the touchpad is disabled. It is wired to RMI function
+ * $30 (GPIO/LED), which these touchpads also expose over PS/2: mode byte 0x7f
+ * switches them to RMI register access, where SetScale 2:1 followed by two
+ * SetRate commands writes a register, and SetScale 2:1, SetRate and GetInfo
+ * read one. Setting the normal mode byte again leaves RMI access.
+ */
+static const char * const rmi_led_pnp_ids[] = {
+	"SYN3040", /* HP ZBook 17 G3 */
+	NULL
+};
+
+#define SYN_RMI_MODE			0x7f
+#define SYN_RMI_PAGE_SELECT		0xff
+#define SYN_RMI_PDT_START		0xee
+#define SYN_RMI_PDT_END			0x0b
+#define SYN_RMI_PDT_ENTRY_SIZE		6
+#define SYN_RMI_NUM_PAGES		4
+#define SYN_RMI_F30			0x30
+#define SYN_RMI_F30_HAS_LED		BIT(2)
+#define SYN_RMI_F30_HAS_GPIO		BIT(3)
+#define SYN_RMI_LED_BRIGHTNESS		0x0b	/* as set by HP's Windows driver */
+
+static int synaptics_rmi_write(struct psmouse *psmouse, u8 reg, u8 val)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	int error;
+
+	error = ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE21);
+	if (error)
+		return error;
+
+	error = ps2_command(ps2dev, &reg, PSMOUSE_CMD_SETRATE);
+	if (error)
+		return error;
+
+	return ps2_command(ps2dev, &val, PSMOUSE_CMD_SETRATE);
+}
+
+static int synaptics_rmi_read(struct psmouse *psmouse, u8 reg, u8 *val)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	u8 param[3];
+	int error;
+
+	error = ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE21);
+	if (error)
+		return error;
+
+	error = ps2_command(ps2dev, &reg, PSMOUSE_CMD_SETRATE);
+	if (error)
+		return error;
+
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO);
+	if (error)
+		return error;
+
+	*val = param[0];
+	return 0;
+}
+
+/* Finds the LED of RMI function $30. Leaves the touchpad in RMI mode. */
+static int synaptics_rmi_led_probe(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	u8 fn, query, ctrl, caps, count, gpios;
+	unsigned int page, zeros, i;
+	int addr, error;
+
+	error = synaptics_mode_cmd(psmouse, SYN_RMI_MODE);
+	if (error)
+		return error;
+
+	for (page = 0; page < SYN_RMI_NUM_PAGES; page++) {
+		error = synaptics_rmi_write(psmouse, SYN_RMI_PAGE_SELECT, page);
+		if (error)
+			return error;
+
+		for (addr = SYN_RMI_PDT_START; addr >= SYN_RMI_PDT_END;
+		     addr -= SYN_RMI_PDT_ENTRY_SIZE) {
+			error = synaptics_rmi_read(psmouse, addr, &fn);
+			if (error)
+				return error;
+			if (!fn)
+				break;
+			if (fn != SYN_RMI_F30)
+				continue;
+
+			error = synaptics_rmi_read(psmouse, addr - 5, &query);
+			if (!error)
+				error = synaptics_rmi_read(psmouse, addr - 3, &ctrl);
+			if (!error)
+				error = synaptics_rmi_read(psmouse, query, &caps);
+			if (!error)
+				error = synaptics_rmi_read(psmouse, query + 1, &count);
+			if (error)
+				return error;
+
+			if (!(caps & SYN_RMI_F30_HAS_LED))
+				return -ENODEV;
+
+			priv->rmi_led_page = page;
+			if (!(caps & SYN_RMI_F30_HAS_GPIO)) {
+				priv->rmi_led_mask = BIT(0);
+				priv->rmi_led_ctrl = ctrl + 1;
+				priv->rmi_led_brightness = ctrl + 4;
+				return 0;
+			}
+
+			/* GPIO/LED select: the LED is the first set bit */
+			error = synaptics_rmi_read(psmouse, ctrl, &gpios);
+			if (error)
+				return error;
+
+			priv->rmi_led_mask = 0;
+			for (i = 0, zeros = 0; i < min(count, 8); i++) {
+				if (!(gpios & BIT(i)))
+					zeros++;
+				else if (!priv->rmi_led_mask)
+					priv->rmi_led_mask = BIT(i);
+			}
+			if (!priv->rmi_led_mask)
+				return -ENODEV;
+
+			priv->rmi_led_ctrl = ctrl + 4;
+			priv->rmi_led_brightness = ctrl + 7 + zeros;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+/* Sets the LED. Leaves the touchpad in RMI mode. */
+static int __synaptics_rmi_led_set(struct psmouse *psmouse, bool on)
+{
+	struct synaptics_data *priv = psmouse->private;
+	u8 val;
+	int error;
+
+	error = synaptics_mode_cmd(psmouse, SYN_RMI_MODE);
+	if (error)
+		return error;
+
+	error = synaptics_rmi_write(psmouse, SYN_RMI_PAGE_SELECT, priv->rmi_led_page);
+	if (error)
+		return error;
+
+	if (on) {
+		error = synaptics_rmi_write(psmouse, priv->rmi_led_brightness,
+					    SYN_RMI_LED_BRIGHTNESS);
+		if (error)
+			return error;
+	}
+
+	error = synaptics_rmi_read(psmouse, priv->rmi_led_ctrl, &val);
+	if (error)
+		return error;
+
+	val = on ? val | priv->rmi_led_mask : val & ~priv->rmi_led_mask;
+	return synaptics_rmi_write(psmouse, priv->rmi_led_ctrl, val);
+}
+
+static int synaptics_set_mode(struct psmouse *psmouse);
+
+static int synaptics_rmi_led_set(struct led_classdev *led,
+				 enum led_brightness value)
+{
+	struct synaptics_data *priv = container_of(led, struct synaptics_data, rmi_led);
+	struct psmouse *psmouse = priv->psmouse;
+	int error, ret;
+
+	guard(mutex)(&priv->rmi_led_lock);
+
+	if (psmouse->state != PSMOUSE_ACTIVATED)
+		return -EBUSY;
+
+	error = psmouse_deactivate(psmouse);
+	if (error)
+		return error;
+
+	ret = __synaptics_rmi_led_set(psmouse, value != LED_OFF);
+
+	/* Setting the mode byte again leaves RMI access */
+	error = synaptics_set_mode(psmouse);
+	if (!ret)
+		ret = error;
+
+	error = psmouse_activate(psmouse);
+	return ret ?: error;
+}
+
+static void synaptics_rmi_led_init(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+
+	if (!IS_REACHABLE(CONFIG_LEDS_CLASS) ||
+	    !psmouse_matches_pnp_id(psmouse, rmi_led_pnp_ids))
+		return;
+
+	if (synaptics_rmi_led_probe(psmouse))
+		return;
+
+	psmouse_info(psmouse, "touchpad LED on RMI F30 (page %u, ctrl %#x, mask %#x)\n",
+		     priv->rmi_led_page, priv->rmi_led_ctrl, priv->rmi_led_mask);
+	__synaptics_rmi_led_set(psmouse, false);
+	priv->has_rmi_led = true;
+}
+
+static void synaptics_rmi_led_register(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	int error;
+
+	if (!priv->has_rmi_led)
+		return;
+
+	mutex_init(&priv->rmi_led_lock);
+	priv->psmouse = psmouse;
+	priv->rmi_led.name = "synaptics::touchpad_disabled";
+	priv->rmi_led.max_brightness = 1;
+	priv->rmi_led.brightness_set_blocking = synaptics_rmi_led_set;
+	error = led_classdev_register(&psmouse->ps2dev.serio->dev, &priv->rmi_led);
+	if (error) {
+		psmouse_warn(psmouse, "failed to register touchpad LED: %d\n", error);
+		priv->has_rmi_led = false;
+	}
+}
+
 static int synaptics_set_mode(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
@@ -1444,6 +1674,9 @@ static void synaptics_disconnect(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
 
+	if (priv->has_rmi_led)
+		led_classdev_unregister(&priv->rmi_led);
+
 	/*
 	 * We might have left a breadcrumb when trying to
 	 * set up SMbus companion.
@@ -1496,6 +1729,10 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 		return error;
 	}
 
+	/* The reset turned the LED off; the mode byte below leaves RMI access. */
+	if (priv->has_rmi_led && priv->rmi_led.brightness)
+		__synaptics_rmi_led_set(psmouse, true);
+
 	error = synaptics_set_mode(psmouse);
 	if (error) {
 		psmouse_err(psmouse, "Unable to initialize device.\n");
@@ -1616,6 +1853,8 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 	 */
 	priv->is_forcepad = psmouse_matches_pnp_id(psmouse, forcepad_pnp_ids);
 
+	synaptics_rmi_led_init(psmouse);
+
 	err = synaptics_set_mode(psmouse);
 	if (err) {
 		psmouse_err(psmouse, "Unable to initialize device.\n");
@@ -1693,6 +1932,8 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 		}
 	}
 
+	synaptics_rmi_led_register(psmouse);
+
 	return 0;
 
  init_fail:
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 3853165b6..1d36a207e 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -6,6 +6,9 @@
 #ifndef _SYNAPTICS_H
 #define _SYNAPTICS_H
 
+#include <linux/leds.h>
+#include <linux/mutex.h>
+
 /* synaptics queries */
 #define SYN_QUE_IDENTIFY		0x00
 #define SYN_QUE_MODES			0x01
@@ -202,6 +205,16 @@ struct synaptics_data {
 	bool					press;
 	bool					report_press;
 	bool					is_forcepad;
+
+	/* Touchpad LED on RMI function $30, reached over PS/2 */
+	struct psmouse				*psmouse;
+	struct led_classdev			rmi_led;
+	struct mutex				rmi_led_lock;
+	bool					has_rmi_led;
+	u8					rmi_led_page;
+	u8					rmi_led_ctrl;
+	u8					rmi_led_mask;
+	u8					rmi_led_brightness;
 };
 
 void synaptics_module_init(void);
-- 
2.53.0


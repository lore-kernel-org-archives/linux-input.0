Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959069;
	b=Yo1H+spDKW5tng7vhDKaancfMrtDTjOgCbV8TjzCyRxz44pK4i3O7sW4BNiYoWmYb8i5
	 mVbNodUtw2xBVVMZ79zrRuYGWs1PpERYpnR7zQuLnJLYWWVVAQx/V1jZ5o7ZZnUCMsmOk
	 GOI7YDyw7kVANLJhMyCTbvGkr2+5wdNsvPISWjJl7sntb9Vi6KUoVHpdZoCueJgaElhXc
	 Y2eNSPlHlWmBfhiX5aWosXgCbmQBfxoyo1fVBgte3YkwBGwuhzCJVx3M+9cHCxrC8WzXC
	 4M+Kpz2iLf9KsCiz9l70Y4DphYNz7OakQz2/slj1ihkzfncy684NmglxKxc6fdqpmkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A/eSH5p57mG74lmqugdknWlw8ZRhrWb7R8CRiW0eBZo=;
	b=p1E9+t/EIzz1YKl/xSiWtha6ghXRDTIfUKD9so8CH9w3jWeXS4pLGpCkh2RWrisZP7Iy
	 HUgZ247PeKrBivDW9WZWTFyU5pWBVjt55IITq8jGoIre/lYblnD0/hwvQbG44hzH3Rqu8
	 +UqofAbBh48xkPy9FFbqAgm4e4Qh6KXWve3EX4Zj/QMuiP/fltka0MXNVx8Jn90Wz3ajM
	 8DlJB7Hvk46D7UIp8scPV29afc1ZSDteQAQJk2lwpkwgnPIDEZy0B2tCWu3OrW9RXNazt
	 8MRk6hXxQZqU3u4f6f7TUTKOlS9vgdsb25vJVuZcAtuZhKJcgxkgINLiPKK7YugsVuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DouVJGNC;
	arc=none smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9B1606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 09:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B9B1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DouVJGNC
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5ba3fba0080so342499e87.1
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 01:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793959066; x=1794563866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/eSH5p57mG74lmqugdknWlw8ZRhrWb7R8CRiW0eBZo=;
        b=DouVJGNCnZ8mLIJpy0xXOyy+odv0D/7Xj54tUSGfAvAoc5fCEYBAn7qeh5j5/X0YM2
         SZQrsb4ol+j8eZ+F0z+IqEv/XFiyq6urFXnvgDrobRlNIQzsLUicCBj/cz37D58CLAaz
         ebfg7uWASGIUb/oBp2OgZE5rFDBc94aL1mXMHUJPj89BV/Xn+jTXg8dN7Y32P+UKeMAz
         Bb6f2XqjB+bVv+k5RkFx6qIEk74Wh1wLw/HahJMOffX6LWk6xFH6KxQkHjyaPitAHYDE
         Sg6U/VS+eBZnDhYm+CszHC2PMiL3vhPaRCqwJfaHQIY8Tl8Mpyd4arnMkTzI9UwfDxGJ
         RlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793959066; x=1794563866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/eSH5p57mG74lmqugdknWlw8ZRhrWb7R8CRiW0eBZo=;
        b=Hpkh0vGK2EXGpENCnXnzEAUO6YCTkO1vWlzFfSoSwdWQM4ozEgz4xrV8c+yWzIGeNd
         eLZTVC/YN3BuotrV+QkloEhSCki0FVeUI0HG5yYTg7pyvomT8zKTHoOGCzjoOQPP+QWk
         M2AjdmzZq9c36ZSDdEQeM5QPa47JsFLD6HJJPdQewbxXDfTwQhVakJ++xjlqdbRTqvtO
         4r2xS81Wc7qIxNpWOwPdzR0muJxlz6acUgup393ye3/6vn3IqQPMKdlC79aqZ9swzS/4
         X0CtHzP/V3qOrTSz73sKhd3qgdWznNNXbetqvGQucg48zyFuPef+rh4GVZ+AgWcXZZSh
         8Lpg==
X-Gm-Message-State: APuU4Z/XKbAo+KOt5j00wGvgFDHRKCOtMNZ+vvoz04i/UP6RBHESJVQ0
	DatdVlf/ij7PVcMP1vPbJyLcMizOw0vPWofNF5BOLmn2wC4fBZ9zkx+EQUhxx9vmjQ2pu59+
X-Gm-Gg: AYBFou32OJ3Dz2CStz6n++00ldtdTg1EHVHMeoutHIN1o0M7ocFNMmdFa+loHPJKYtF
	hmwVcrkDKjD8/0BHo19NmEbRDo1dyGmzzU7pyQnN5bR8ZCrwx42q5VSxfPW3NttBVSqodPOW8M/
	Aloa4WWA35RcFgIBXEq+QbFL36FYFTtBL7AIE7ROr7gJmEqzU3PO0+atN/C8lZMxWO3lMyAO1BV
	S1GM9Z8vfscI4h3kAF/ByAKioVYEi10fSwXlHEaKYDeN2pQ5LN/PWAAf0Gan2kt34sa2UwEBqkm
	/L2mjQcwXK54AqTrxllgLzRLeLtB+X5l/7zi+rcBf75z3cVS4gr8jYlu/2QQELUF5mmRShMkTfz
	72DjgRO01hHDTvVeN8cqkYNh5pp7x398cIdFm+qHiqdgWjc4R9Rfap38jk07NfdqH4YyFS68Qks
	TgTgmmG9Rks+ksr06OQIXkVxmczEjw+PnsWrRHIbb6iL78cnDxvQ/7g6Dca4KfXZ+hXkYavIejd
	b8ZRkzJqRX2VwnLysa2UzzRg5Fan8c/ksC3YjfTBEEnARv48FDI1p09WEl4+oLBYqj3rnO20wyI
	z5iYDRta0/qWK9Pir74CzPoJkw4QOetDVv1aT1TebzAsvA4+vRBRrTyL61XrkSunBrsJXe/riFA
	=
X-Received: by 2002:a05:6512:2252:b0:5bf:e540:8606 with SMTP id 2adb3069b0e04-5c003aeacb8mr605722e87.59.1793959066166;
        Fri, 06 Nov 2026 01:57:46 -0800 (PST)
Received: from ahmad-HP-ZBook-17-G3 ([91.133.224.19])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c003069675sm293680e87.43.2026.11.06.01.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:57:44 -0800 (PST)
From: ahmad baghereslami <ahmad.b1995@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ahmad baghereslami <ahmad.b1995@gmail.com>
Subject: [PATCH v2] Input: synaptics - support the touchpad LED on RMI function $30
Date: Fri,  6 Nov 2026 13:26:58 +0330
Message-ID: <20261106095658.44166-1-ahmad.b1995@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030070821.1716595-1-ahmad.b1995@gmail.com>
References: <20261030070821.1716595-1-ahmad.b1995@gmail.com>
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
synaptics::touchpad_disabled LED class device. Setting it queues a work
item that, with psmouse_mutex held like the protected psmouse
attributes, deactivates the touchpad, writes the F30 registers and
restores the mode byte, which leaves RMI access. synaptics_disconnect()
cancels the work with psmouse_mutex held, so the work only tries to take
the mutex and retries later when it is busy. psmouse_mutex is no longer
static so that synaptics.c can take it. The LED is restored after
reconnect.

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

Notes:
    v2:
    - Fix the link failure reported by the kernel test robot when
      CONFIG_LEDS_CLASS is not reachable: the register and unregister calls
      are now behind IS_REACHABLE(CONFIG_LEDS_CLASS).
    - Set the LED from a work item that holds psmouse_mutex instead of a
      private mutex, so it cannot interleave with reconnect, resync or
      attribute writes (sashiko review). The work uses mutex_trylock() and
      retries, because synaptics_disconnect() cancels it with psmouse_mutex
      held. If you would rather have this done another way, for example a
      helper in psmouse-base.c instead of exporting psmouse_mutex to the
      protocol code, I am happy to change it.
    - Restore the mode with synaptics_mode_cmd(psmouse, priv->mode) instead of
      synaptics_set_mode(), so SYN_BIT_FOUR_BYTE_CLIENT survives (sashiko).
    - Set LED_RETAIN_AT_SHUTDOWN: synaptics_disconnect() resets the touchpad,
      which turns the LED off, so unregistering no longer calls into the
      driver with the touchpad in command mode (sashiko).
    - Mask the F30 GPIO/LED count with 0x1f and give up on more than eight
      pins (sashiko). The brightness register offset still counts every
      GPIO pin, not only those below the LED: the brightness registers come
      after one register per GPIO pin, which is how HP's driver computes it
      and what this touchpad needs (three GPIO pins, brightness at 0x5f).
    v1: https://lore.kernel.org/all/20261030070821.1716595-1-ahmad.b1995@gmail.com/

 drivers/input/mouse/psmouse-base.c |   2 +-
 drivers/input/mouse/psmouse.h      |   3 +
 drivers/input/mouse/synaptics.c    | 282 +++++++++++++++++++++++++++++
 drivers/input/mouse/synaptics.h    |  13 ++
 4 files changed, 299 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 231646882..020821be1 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -111,7 +111,7 @@ ATTRIBUTE_GROUPS(psmouse_dev);
  * rarely more than one PS/2 mouse connected and since semaphore
  * is taken in "slow" paths it is not worth it.
  */
-static DEFINE_MUTEX(psmouse_mutex);
+DEFINE_MUTEX(psmouse_mutex);
 
 struct psmouse *psmouse_from_serio(struct serio *serio)
 {
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 90ed8cd15..77c137a57 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -136,6 +136,9 @@ int psmouse_reset(struct psmouse *psmouse);
 void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state);
 void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution);
 psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse);
+/* Serializes connecting, reconnecting and reconfiguring PS/2 mice */
+extern struct mutex psmouse_mutex;
+
 int psmouse_activate(struct psmouse *psmouse);
 int psmouse_deactivate(struct psmouse *psmouse);
 bool psmouse_matches_pnp_id(struct psmouse *psmouse, const char * const ids[]);
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index b007e642e..4186e4f53 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -589,6 +589,278 @@ static int synaptics_set_advanced_gesture_mode(struct psmouse *psmouse)
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
+#define SYN_RMI_F30_COUNT		GENMASK(4, 0)
+#define SYN_RMI_LED_BRIGHTNESS		0x0b	/* as set by HP's Windows driver */
+#define SYN_RMI_LED_RETRY_MS		50
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
+			count &= SYN_RMI_F30_COUNT;
+			if (!(caps & SYN_RMI_F30_HAS_LED) || count > 8)
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
+			/*
+			 * GPIO/LED select: the LED is the first set bit. The
+			 * brightness registers follow one register for each
+			 * pin used as a GPIO, so count all of those.
+			 */
+			error = synaptics_rmi_read(psmouse, ctrl, &gpios);
+			if (error)
+				return error;
+
+			priv->rmi_led_mask = 0;
+			for (i = 0, zeros = 0; i < count; i++) {
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
+/*
+ * Runs with psmouse_mutex held, like the protected psmouse attributes, so
+ * that it does not race with reconnect, resync or attribute changes.
+ * synaptics_disconnect() cancels it with psmouse_mutex held, so it must not
+ * wait for the mutex: when it is busy, try again a little later.
+ */
+static void synaptics_rmi_led_work(struct work_struct *work)
+{
+	struct synaptics_data *priv = container_of(to_delayed_work(work),
+						   struct synaptics_data,
+						   rmi_led_work);
+	struct psmouse *psmouse = priv->psmouse;
+	int error;
+
+	if (!mutex_trylock(&psmouse_mutex)) {
+		schedule_delayed_work(&priv->rmi_led_work,
+				      msecs_to_jiffies(SYN_RMI_LED_RETRY_MS));
+		return;
+	}
+
+	if (psmouse->state == PSMOUSE_RESYNCING) {
+		schedule_delayed_work(&priv->rmi_led_work,
+				      msecs_to_jiffies(SYN_RMI_LED_RETRY_MS));
+	} else if (psmouse->state == PSMOUSE_ACTIVATED) {
+		/* Otherwise the LED is restored on reconnect */
+		psmouse_deactivate(psmouse);
+
+		error = __synaptics_rmi_led_set(psmouse,
+						priv->rmi_led.brightness != LED_OFF);
+		if (error)
+			psmouse_warn(psmouse,
+				     "failed to set touchpad LED: %d\n", error);
+
+		/* Setting the mode byte again leaves RMI access */
+		if (synaptics_mode_cmd(psmouse, priv->mode))
+			psmouse_warn(psmouse, "failed to restore mode\n");
+
+		psmouse_activate(psmouse);
+	}
+
+	mutex_unlock(&psmouse_mutex);
+}
+
+static void synaptics_rmi_led_set(struct led_classdev *led,
+				  enum led_brightness value)
+{
+	struct synaptics_data *priv = container_of(led, struct synaptics_data, rmi_led);
+
+	mod_delayed_work(system_wq, &priv->rmi_led_work, 0);
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
+	if (!IS_REACHABLE(CONFIG_LEDS_CLASS) || !priv->has_rmi_led)
+		return;
+
+	priv->psmouse = psmouse;
+	INIT_DELAYED_WORK(&priv->rmi_led_work, synaptics_rmi_led_work);
+	priv->rmi_led.name = "synaptics::touchpad_disabled";
+	priv->rmi_led.max_brightness = 1;
+	priv->rmi_led.brightness_set = synaptics_rmi_led_set;
+	/* synaptics_disconnect() resets the touchpad, which turns the LED off */
+	priv->rmi_led.flags = LED_RETAIN_AT_SHUTDOWN;
+	error = led_classdev_register(&psmouse->ps2dev.serio->dev, &priv->rmi_led);
+	if (error) {
+		psmouse_warn(psmouse, "failed to register touchpad LED: %d\n", error);
+		priv->has_rmi_led = false;
+	}
+}
+
+static void synaptics_rmi_led_unregister(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+
+	if (!IS_REACHABLE(CONFIG_LEDS_CLASS) || !priv->has_rmi_led)
+		return;
+
+	led_classdev_unregister(&priv->rmi_led);
+	cancel_delayed_work_sync(&priv->rmi_led_work);
+}
+
 static int synaptics_set_mode(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
@@ -1444,6 +1716,8 @@ static void synaptics_disconnect(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
 
+	synaptics_rmi_led_unregister(psmouse);
+
 	/*
 	 * We might have left a breadcrumb when trying to
 	 * set up SMbus companion.
@@ -1496,6 +1770,10 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 		return error;
 	}
 
+	/* The reset turned the LED off; the mode byte below leaves RMI access. */
+	if (priv->has_rmi_led && priv->rmi_led.brightness)
+		__synaptics_rmi_led_set(psmouse, true);
+
 	error = synaptics_set_mode(psmouse);
 	if (error) {
 		psmouse_err(psmouse, "Unable to initialize device.\n");
@@ -1616,6 +1894,8 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 	 */
 	priv->is_forcepad = psmouse_matches_pnp_id(psmouse, forcepad_pnp_ids);
 
+	synaptics_rmi_led_init(psmouse);
+
 	err = synaptics_set_mode(psmouse);
 	if (err) {
 		psmouse_err(psmouse, "Unable to initialize device.\n");
@@ -1693,6 +1973,8 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 		}
 	}
 
+	synaptics_rmi_led_register(psmouse);
+
 	return 0;
 
  init_fail:
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 3853165b6..b792ac98a 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -6,6 +6,9 @@
 #ifndef _SYNAPTICS_H
 #define _SYNAPTICS_H
 
+#include <linux/leds.h>
+#include <linux/workqueue.h>
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
+	struct delayed_work			rmi_led_work;
+	bool					has_rmi_led;
+	u8					rmi_led_page;
+	u8					rmi_led_ctrl;
+	u8					rmi_led_mask;
+	u8					rmi_led_brightness;
 };
 
 void synaptics_module_init(void);

base-commit: 97a889cad5dd8ff83f40514f2d67c565c0dc54b1
-- 
2.53.0


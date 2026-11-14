Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794647314;
	b=27eCbjDDteo12APRJ3PolDm9/sOfREjWZwH/OdaAHe2c404fevfVROVBDKRn5E+mEa7S
	 Gmu64PTGrHCaC6qHdnTg3YM6f1Xggyf2HssWpnft0ko3i8xvYzBc8gcRnB9qG4HrsPcPX
	 drocQ6lTSfyh3JN2//HJ8eJVoNJFxvi5i2cJPocGz/lsNo2+JRLMTdSB6FPAvaNK0rLMA
	 yNFNjBa3Lgq/zAmhdGCe1P2wcgcwXCwAWGY0AoFTzGiaNf+rN+sVLR/xTbcZD6ZMdaB0a
	 FDO2aSikYKuI3fDUKegBiWrzDebuwr4uxrpBelwFcQ9H8Wz4YMHMMEcM5O5EkB5/m3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794647314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nlKNDal0Mtua8Q981+K4LEkQyRBRppvuvQjoiI3lXQ8=;
	b=FqhEX4wfNgRcBVLJIsM9X8VMQNMH4mbiJm9cuTqoTdNcZOPRQN7YAMmM7vGvqbh10bHq
	 coa9iiKm900rWBPlmiV1vADkjaU+bDePdqg+udHA9r2MzhbSFHIiScBeh20Ab3AE2xNdZ
	 EV0jx045WQu7dn+EAeA0uBMf7mq0OyX+TV55x8t//kKXDYe2hIDXTLY0hh5fAY0OV3q9p
	 rRuaMEaALTY8lvwOob5SDnfjxZ7d/zMl7hU3IAc1cVboZkgjoyklo4At2OLP4khJ9bGz0
	 YUnk5udnR/2R2gHXvheJ+/uXx6mb11BClPv/stalEqeZHcQt8DSagC+Si6W7GFbsxCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D2JERnP2;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92E606A331
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 09:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D92E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D2JERnP2
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be3cff0f6cso1436174e87.0
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 01:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794647312; x=1795252112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nlKNDal0Mtua8Q981+K4LEkQyRBRppvuvQjoiI3lXQ8=;
        b=D2JERnP2tyw/Dd1hoyjAVhzYA36q895l1M0rwgX5w9lzLUkLU0VtJKdkwpUWri+vBp
         UQpz3dlIkBvQksVIi0IR28GZ+pm6tfsmw1k2SN2jFV8Lu0Mmc+aRWCcRbE2Yntqc45PR
         ncf2iETned6RBwTA5rpIgdFVld5VRR8PnsArR/lQGNH+KsxGwhCH6IGlIR2YOOu8yMxI
         QxbKMkoqB2LhoDwchKqtKAHIyIMCXljttzJD4nx26aD8GkFqiqJKj5BswczfQw9BWbn0
         xfFpu0SMeutERFys9eKcJdv9/wutWk0BbIF2JmMmYYD5coRHJQ0X4I61IoDcIjCk4awV
         NuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794647312; x=1795252112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nlKNDal0Mtua8Q981+K4LEkQyRBRppvuvQjoiI3lXQ8=;
        b=0x+ZEAGPLZy9LO23y/8PBFz1pR9oUJ2iiI3Ww8yguClkxBrd0mjOPgXOWU9eGpZJeg
         SL0q+pzekuQ0Ye0ZfCCR4E31kipzz5zlrtxeW1d6c+MlV8YYJzOowkmKei2tdykzM9ff
         w0H99YOzd76qr+k86v+pwQUdG042Ur5AUBBPNkbaQ0Jx/2J/s3HPVozOA3pzKMIiTKyj
         AHpxIj6UypRnLyu9ZYeRlrJ0yXbl7md+ySLayaHGQggscTdXvsXPadL+nr2QwweOubW2
         MmV3c+dipmfEF1O9khTOmWAJrI4Ml1V4sT0ZQgjXh9KpkFyLdw0yGTPKtZSZ93IPbXiH
         7Q2w==
X-Gm-Message-State: APuU4Z+qmYdT4E88cn/UD+xFyOr8ur378787sIdww1HSblK/sw9A9ipT
	nLCy0dH4P+qjec+OUZhNfGjOMJt3oMcwFOu7gxKHf8rSdzWutGoszyV4paXXik/xozVFkA==
X-Gm-Gg: AYBFou2RR+hQQ+B668dBTZ7XzP/Uof7S0SQOhJsEdSHNixlAl6bSoW+SuGlAbw5JSru
	8AGZpZyo8gcEnGvKh3GaT2rrY4RV8kHa+rMICjaij5R781WI+XUiIWEoNctlCKJJ8F2j172QzVA
	wRbmYz1ndQAzeWqIPdDFGRnnjRSsmlMnQasaxjWU+5F890dOVCzxb9MNAzLCpActeVvFc3ZvRJq
	M2SVHxSKgrdzVGiNjHbvQoqjuI0TkjjsrP1nj/V5UgC9vMIQAcP3gazGU8ZsUz0v1EyvFs7dBeZ
	id6AHYJqbRxuE0p5gf7rpQhipXJPlBTdkZbk2SGTwI48Z3F32S+qDjIOowErQenqqVL/PaADdYA
	HwK/LgcBDQbdr0ojNXfBRmrMvXrc1xfB/UFqM97s8rwH2Mkumdke2yvvIfB7v97yOXeN3O8SjMu
	mKqZ0OZPVCpddfhWriqWAnQ8LvkgW4W0otY/mTD9Bt78L1PUmrNF7KwzM7MmjrzDkgyeG5zSBT7
	yhBpdss183v+VesYI3Su8zQfRLQvNLyFT/emoqZEUOcSLqck0/K0HDDclay5JZshrC9etgEhspu
	f17UbqOnlp5ep66r97nMrv9HS7wRv4e3qP4+pDxYPf2lKBnn1MFJ+d+GT/B9bUUNcp+ZSm6xwXo
	IPy6GHtJG/6mXha5IiWBh
X-Received: by 2002:a05:6512:3f18:b0:5be:3c86:f24a with SMTP id 2adb3069b0e04-5c170a07d80mr1948122e87.53.1794647311327;
        Sat, 14 Nov 2026 01:08:31 -0800 (PST)
Received: from ahmad-HP-ZBook-17-G3 ([37.63.208.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c171360498sm1529589e87.81.2026.11.14.01.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 01:08:30 -0800 (PST)
From: ahmad baghereslami <ahmad.b1995@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ahmad baghereslami <ahmad.b1995@gmail.com>
Subject: [PATCH v3] Input: synaptics - support the touchpad LED on RMI function $30
Date: Sat, 14 Nov 2026 12:38:08 +0330
Message-ID: <20261114090808.2572722-1-ahmad.b1995@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106095658.44166-1-ahmad.b1995@gmail.com>
References: <20261106095658.44166-1-ahmad.b1995@gmail.com>
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
reconnect and turned off when the driver disconnects.

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
    v3:
    - Turn the LED off in synaptics_disconnect(): mode byte 0 from
      synaptics_reset() leaves RMI access but does not clear the F30 LED
      register, so v2 left the LED lit after unbind or a protocol switch
      (sashiko).
    - Keep the requested state in its own field, set from the brightness_set
      callback, instead of reading led_cdev->brightness, which the LED core
      does not update when it stops software blinking (sashiko).
    - Use system_percpu_wq instead of system_wq (sashiko).
    - Return 0 explicitly at the end of the RMI helpers (sashiko).
    v2: https://lore.kernel.org/all/20261106095658.44166-1-ahmad.b1995@gmail.com/
    
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
 drivers/input/mouse/synaptics.c    | 298 +++++++++++++++++++++++++++++
 drivers/input/mouse/synaptics.h    |  14 ++
 4 files changed, 316 insertions(+), 1 deletion(-)

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
index b007e642e..ce51fd8a2 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -589,6 +589,294 @@ static int synaptics_set_advanced_gesture_mode(struct psmouse *psmouse)
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
+	error = ps2_command(ps2dev, &val, PSMOUSE_CMD_SETRATE);
+	if (error)
+		return error;
+
+	return 0;
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
+	error = synaptics_rmi_write(psmouse, priv->rmi_led_ctrl, val);
+	if (error)
+		return error;
+
+	return 0;
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
+						READ_ONCE(priv->rmi_led_on));
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
+	WRITE_ONCE(priv->rmi_led_on, value != LED_OFF);
+	mod_delayed_work(system_percpu_wq, &priv->rmi_led_work, 0);
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
+	/* synaptics_rmi_led_unregister() turns the LED off itself */
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
+
+	/*
+	 * The touchpad is in command mode here. Mode byte 0, which
+	 * synaptics_reset() sets next, leaves RMI access but keeps the LED lit.
+	 */
+	if (priv->rmi_led_on)
+		__synaptics_rmi_led_set(psmouse, false);
+}
+
 static int synaptics_set_mode(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
@@ -1444,6 +1732,8 @@ static void synaptics_disconnect(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
 
+	synaptics_rmi_led_unregister(psmouse);
+
 	/*
 	 * We might have left a breadcrumb when trying to
 	 * set up SMbus companion.
@@ -1496,6 +1786,10 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 		return error;
 	}
 
+	/* The reset turned the LED off; the mode byte below leaves RMI access. */
+	if (priv->has_rmi_led && READ_ONCE(priv->rmi_led_on))
+		__synaptics_rmi_led_set(psmouse, true);
+
 	error = synaptics_set_mode(psmouse);
 	if (error) {
 		psmouse_err(psmouse, "Unable to initialize device.\n");
@@ -1616,6 +1910,8 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 	 */
 	priv->is_forcepad = psmouse_matches_pnp_id(psmouse, forcepad_pnp_ids);
 
+	synaptics_rmi_led_init(psmouse);
+
 	err = synaptics_set_mode(psmouse);
 	if (err) {
 		psmouse_err(psmouse, "Unable to initialize device.\n");
@@ -1693,6 +1989,8 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 		}
 	}
 
+	synaptics_rmi_led_register(psmouse);
+
 	return 0;
 
  init_fail:
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 3853165b6..fb337be9e 100644
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
@@ -202,6 +205,17 @@ struct synaptics_data {
 	bool					press;
 	bool					report_press;
 	bool					is_forcepad;
+
+	/* Touchpad LED on RMI function $30, reached over PS/2 */
+	struct psmouse				*psmouse;
+	struct led_classdev			rmi_led;
+	struct delayed_work			rmi_led_work;
+	bool					has_rmi_led;
+	bool					rmi_led_on;
+	u8					rmi_led_page;
+	u8					rmi_led_ctrl;
+	u8					rmi_led_mask;
+	u8					rmi_led_brightness;
 };
 
 void synaptics_module_init(void);

base-commit: 97a889cad5dd8ff83f40514f2d67c565c0dc54b1
-- 
2.53.0


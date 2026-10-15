Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09FF31B101
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028029; cv=none; b=M/C7C2ou7Of2yV3u9VCt4VP48GB1gQqz7tdWVkydVzCXO//ZVeGrKhPmju+KosuqeEfgH7l1GBr68j59+uEh5I2LPUfj7wD6KJuUYauuF3d/3em6bUDY6WWhKi3QQezlVcSGd5+mJo/phTkC3JzxmCxdCgyaVKsAc1CaIyUzARE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028029; c=relaxed/simple;
	bh=QjuTZ8BY3jSQtaj/+uZlNIYsACk3NrKTMY9pmgjw+fk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=lQszcEta6sbVF+qpbn3qTvv5Vy2/WU292T/khXIGKnyy8tFdxi4lzExGNB9Ac93qdKw99Odd4Z9bOIapOFAGiWHPdZxt9YZGJCkHjPKTtocGUDanRmjIluZxQhgTj+ZNH7v3kA2MKp4lvsN+HjSE0DJy2gcDcqWTypeonEDHqto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iY4MxJO2; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY4MxJO2"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-144f79153f5so1044387c88.0
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 18:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028027; x=1792632827; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P3A85n49ZvBdAIlkr9UzU20XswPVap5evBDCbmAFGIU=;
        b=iY4MxJO2xRV50/+lImp0sdro9UmFjA4CrI0NLyWyW+m3E6yLAPIOwE585BCR3nEj3q
         nKMGkzkyR5fw9ZHEqZfgPvZrilX5JjC1IX8S4CuaaM4bx3M5E2sMgNtpaq3+aw6ynu1S
         pmUFgNsSOYplVkGWJcaRXsHgS6rJRLJ79quT3Z3VN2X2f1+h6vdtUryXG6KLzwoo8g1J
         8xG2JhKcB3QQ429g4L2iRBdZhNAs9UOL7qFkfcqd25/xX0okAhyu0SZjibKlyQ0oo2Ax
         qfuaVUyDb0vFb9clIuedpm5vtCUz5K525q8BX185edsG+8JkB+vha/RPqxbMKe0gQkOU
         UIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028027; x=1792632827;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P3A85n49ZvBdAIlkr9UzU20XswPVap5evBDCbmAFGIU=;
        b=u9ZAWNFGMyKS5AgZOxfm4jyVSWJHxNQQYa/KtcyxUBcIzCzd2DBMFP27zn8sMh9Fgl
         xi+Z2Zl2b5JYj92SrfLQFDx/4HhXpot9E9MD5kRZOZp/Nav7Anfe7LcMMIVkcwTP1+pH
         7CvNGVEk1fT7sRrkFcXkC7XMHGH7PDuV5mEGkUO+WLqSHrbSrM4d0jwBCFZ8uE5cjeDs
         lkzxnb/sgkCJlcaH+rtyTrWtDN//6EcChHDfvfuEWHbfexug0fbi0EuYQbLrufslafSY
         LzQ2nlZEdq+67f+E+LQ0T0Ot97wumnuB+IytrzqABcIz+PZFSNigZoIz6ibzhYsNhcfQ
         k8/w==
X-Forwarded-Encrypted: i=1; AKwUvBwQTdQkP7yLqmBHeOxqfWoZSOpKnOJ5pYpE09x4KyRRoVEeTQslVK+i1Nh18NNMBabBXot2wf7ljf+xyQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIiqaMxSqLSr9W8UyrmKRX60LeYESR/JDLLcGQImoEtysPGNLnX
	RPsChYA/vgyn8ekoMPA3KPy4AyVFU9gJefdTjZk+FdlUSJOCVwqF3UqU
X-Gm-Gg: AYBFou27dmi057MuWCsKIzkVFQR62E5A9yFg+ygC7BEd/CXoNphrGob0XaHAZFbdOsr
	iERqxvGJGGx8psVYGOKIa3S6VDEuKZSmranGfD0Zvpot0qdyL6Xl3mbZ8oQ/pFCcoDzijf5yKj0
	1MPEmkhUPKZM5eYOx/d3nYLQt6w7CSts46G9z39m7KXpgYq344xlpWihzaKeSkxCDosv0GLIwSx
	n9sZAe3vli5JnXWHKvYCSm9/Jr2NLoH/pawSDi5uEN0/TAJMCnaYd6jbfejsc8Ob1A72f+461wm
	I2U4c1t0tMjVLRWBWEPqlbeCLgj37jzgX5XrJrdayUX0ZXFAePhqIMebhqbuJTubyB/mXl8v7bt
	M09uAvIG36AcfHrujN+3IuGPEC8aWVQNWF2tHokCjLJ6zzgFpzkqL/eBOD/3RXMuGLM+Sf7jBJF
	Wzlk+xPF3sHbASr0uk0vB4hrN/Ne1ihIIK+8oWYy3afkaWGREhE6SOYQo4q6dOwGf54ndagPgJO
	keZS9M3FCGy0hdUsJHAfwtYtpn9w1fwsmGJqg==
X-Received: by 2002:a05:7022:b048:20b0:158:b944:b15 with SMTP id a92af1059eb24-16a5ec48b20mr24858590c88.22.1792028026492;
        Wed, 14 Oct 2026 18:33:46 -0700 (PDT)
Received: from localhost ([2a00:79e0:2ebe:8:821:261c:74c2:4177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a4429603sm48146848c88.17.2026.10.14.18.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:33:45 -0700 (PDT)
Date: Wed, 14 Oct 2026 18:33:44 -0700
Message-ID: <4c7d0796862cb8258ec5357efb10db99@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Ion Agorria <ion@agorria.com>,
	=?utf-8?b?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 4/7] input: keyboard: Add driver for ASUS Transformer dock multimedia keys
In-Reply-To: <20261013173504.451391-5-clamor95@gmail.com>
References: <20261013173504.451391-1-clamor95@gmail.com> <20261013173504.451391-5-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Svyatoslav,

On Tue, Oct 13, 2026 at 08:35:00PM +0300, Svyatoslav Ryhel wrote:
> Add support for multimedia top button row of ASUS Transformer's Mobile
> Dock keyboard. Driver is made that function keys (F1-F12) are used by
> default which suits average Linux use better and with pressing
> ScreenLock + AltGr function keys layout is switched to multimedia keys.
> Only Dock keyboard input events are tracked for AltGr pressing.

I still think registering a global input_handler just to observe Right Alt
state on the dock keyboard is heavier than necessary, and because the
handler is a passive observer rather than a filter, pressing AltGr+ScreenLock
or AltGr+F1..F12 still leaks the KEY_RIGHTALT press and release events from
atkbd to userspace alongside the mode switch or media key event.

Since asus-transformer-ec-kbc already inspects and remaps 0xe0-prefixed
scancodes on the keyboard port before passing them to serio, we can track
and delay AltGr (0xe0 0x11) there when the extension keys driver is active,
and coordinate with asus-transformer-ec-keys via struct asusec_core:

- When AltGr is pressed on the dock keyboard, asus-transformer-ec-kbc
  delays emitting the 0xe0 0x11 make sequence and sets
  ec->right_alt_pressed.
- If an extension key is pressed while right_alt_pressed is set,
  asus-transformer-ec-keys sets ec->special_combo_triggered (either
  toggling special_key_mode on ScreenLock or reporting the shifted key for
  other top-row keys), and asus-transformer-ec-kbc suppresses both the
  delayed AltGr make and the subsequent AltGr break (0xe0 0xf0 0x11).
- If any regular key make event arrives on the primary keyboard port first,
  or if AltGr is released without triggering an extension key combo,
  asus-transformer-ec-kbc flushes the delayed 0xe0 0x11 make sequence
  before forwarding the event.

This avoids registering an input_handler altogether and drops about 100
lines of boilerplate from asus-transformer-ec-keys.c.

What do you think about folding the change below into patches 2, 3, and 4?

(Also, a minor typo in patch 3/7 in drivers/input/serio/Kconfig:
"Asus Transformed's Mobile Dock" -> "Asus Transformer's Mobile Dock".)

diff --git a/drivers/input/keyboard/asus-transformer-ec-keys.c b/drivers/input/keyboard/asus-transformer-ec-keys.c
index 8e83b27ce60e..ec72c38d7653 100644
--- a/drivers/input/keyboard/asus-transformer-ec-keys.c
+++ b/drivers/input/keyboard/asus-transformer-ec-keys.c
@@ -7,7 +7,6 @@
 #include <linux/mfd/asus-transformer-ec.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 
 #define ASUSEC_EXT_KEY_CODES		0x20
 
@@ -15,74 +14,8 @@ struct asus_ec_keys_data {
 	struct notifier_block nb;
 	struct asusec_core *ec;
 	struct input_dev *xidev;
-	struct input_handler input_handler;
-	unsigned short keymap[ASUSEC_EXT_KEY_CODES * 2];
-	const char *kbc_phys;
-	bool special_key_pressed;
 	bool special_key_mode;
-};
-
-static void asus_ec_input_event(struct input_handle *handle,
-				unsigned int event_type,
-				unsigned int event_code, int value)
-{
-	struct asus_ec_keys_data *priv = handle->handler->private;
-
-	/* Store special key state */
-	if (event_type == EV_KEY && event_code == KEY_RIGHTALT)
-		WRITE_ONCE(priv->special_key_pressed, !!value);
-}
-
-static int asus_ec_input_connect(struct input_handler *handler,
-				 struct input_dev *dev,
-				 const struct input_device_id *id)
-{
-	struct asus_ec_keys_data *priv = handler->private;
-	struct input_handle *handle;
-	int error;
-
-	if (!dev->phys || !strstr(dev->phys, priv->kbc_phys))
-		return -ENODEV;
-
-	handle = kzalloc_obj(*handle);
-	if (!handle)
-		return -ENOMEM;
-
-	handle->dev = dev;
-	handle->handler = handler;
-	handle->name = handler->name;
-
-	error = input_register_handle(handle);
-	if (error)
-		goto err_free_handle;
-
-	error = input_open_device(handle);
-	if (error)
-		goto err_unregister_handle;
-
-	return 0;
-
- err_unregister_handle:
-	input_unregister_handle(handle);
- err_free_handle:
-	kfree(handle);
-
-	return error;
-}
-
-static void asus_ec_input_disconnect(struct input_handle *handle)
-{
-	input_close_device(handle);
-	input_unregister_handle(handle);
-	kfree(handle);
-}
-
-static const struct input_device_id asus_ec_input_ids[] = {
-	{
-		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
-		.evbit = { BIT_MASK(EV_KEY) },
-	},
-	{ }
+	unsigned short keymap[ASUSEC_EXT_KEY_CODES * 2];
 };
 
 static const unsigned short asus_ec_dock_ext_keys[] = {
@@ -138,17 +71,21 @@ static int asus_ec_keys_process_key(struct input_dev *dev, u8 code)
 	if (code == 0)
 		return NOTIFY_DONE;
 
-	/* Flip special key mode state when pressing SCREEN LOCK + R ALT */
-	if (READ_ONCE(priv->special_key_pressed) && code == 1) {
-		priv->special_key_mode = !priv->special_key_mode;
-		return NOTIFY_DONE;
+	if (priv->ec->right_alt_pressed) {
+		priv->ec->special_combo_triggered = true;
+
+		/* Flip special key mode state when pressing SCREEN LOCK + R ALT */
+		if (code == 1) {
+			priv->special_key_mode = !priv->special_key_mode;
+			return NOTIFY_OK;
+		}
 	}
 
 	/*
 	 * Relocate code to second "page" if pressed state XOR's mode state
 	 * This way special key will invert the current mode
 	 */
-	if (priv->special_key_mode ^ READ_ONCE(priv->special_key_pressed))
+	if (priv->special_key_mode ^ priv->ec->right_alt_pressed)
 		code += ASUSEC_EXT_KEY_CODES;
 
 	if (code < dev->keycodemax) {
@@ -207,37 +144,6 @@ static void asus_ec_keys_setup_keymap(struct asus_ec_keys_data *priv)
 	}
 }
 
-static int asus_ec_keys_register_handler(struct device *dev,
-					 struct asus_ec_keys_data *priv)
-{
-	struct i2c_client *parent = to_i2c_client(dev->parent);
-	int error;
-
-	priv->input_handler.event = asus_ec_input_event;
-	priv->input_handler.connect = asus_ec_input_connect;
-	priv->input_handler.disconnect = asus_ec_input_disconnect;
-	priv->input_handler.id_table = asus_ec_input_ids;
-	priv->input_handler.passive_observer = true;
-	priv->input_handler.private = priv;
-	priv->input_handler.name = devm_kasprintf(dev, GFP_KERNEL,
-						  "%s-media-handler",
-						  priv->ec->name);
-	if (!priv->input_handler.name)
-		return -ENOMEM;
-
-	priv->kbc_phys = devm_kasprintf(dev, GFP_KERNEL, "i2c-%u-%04x/serio0",
-					i2c_adapter_id(parent->adapter),
-					parent->addr);
-	if (!priv->kbc_phys)
-		return -ENOMEM;
-
-	error = input_register_handler(&priv->input_handler);
-	if (error)
-		return error;
-
-	return 0;
-}
-
 static int asus_ec_keys_probe(struct platform_device *pdev)
 {
 	struct i2c_client *parent = to_i2c_client(pdev->dev.parent);
@@ -273,17 +179,13 @@ static int asus_ec_keys_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, error,
 				     "failed to register extension keys\n");
 
-	error = asus_ec_keys_register_handler(dev, priv);
-	if (error)
-		return error;
-
 	priv->nb.notifier_call = asus_ec_keys_notify;
 
 	error = blocking_notifier_chain_register(&ec->notify_list, &priv->nb);
-	if (error) {
-		input_unregister_handler(&priv->input_handler);
+	if (error)
 		return error;
-	}
+
+	ec->ext_keys_enabled = true;
 
 	return 0;
 }
@@ -293,8 +195,8 @@ static void asus_ec_keys_remove(struct platform_device *pdev)
 	struct asus_ec_keys_data *priv = platform_get_drvdata(pdev);
 	struct asusec_core *ec = priv->ec;
 
+	ec->ext_keys_enabled = false;
 	blocking_notifier_chain_unregister(&ec->notify_list, &priv->nb);
-	input_unregister_handler(&priv->input_handler);
 }
 
 static struct platform_driver asus_ec_keys_driver = {
diff --git a/drivers/input/serio/asus-transformer-ec-kbc.c b/drivers/input/serio/asus-transformer-ec-kbc.c
index 62ffaf4d4371..0842158f13da 100644
--- a/drivers/input/serio/asus-transformer-ec-kbc.c
+++ b/drivers/input/serio/asus-transformer-ec-kbc.c
@@ -13,8 +13,85 @@ struct asus_ec_kbc_data {
 	struct asusec_core *ec;
 	struct i2c_client *parent;
 	struct serio *sdev[2];
+	bool altgr_delayed;
+	bool altgr_suppressed;
 };
 
+static bool asus_ec_kbc_altgr_active(struct asus_ec_kbc_data *priv)
+{
+	return IS_ENABLED(CONFIG_KEYBOARD_ASUS_TRANSFORMER_EC) &&
+	       (priv->ec->ext_keys_enabled ||
+		priv->altgr_delayed || priv->altgr_suppressed);
+}
+
+static void asus_ec_kbc_reset_altgr(struct asus_ec_kbc_data *priv)
+{
+	if (!IS_ENABLED(CONFIG_KEYBOARD_ASUS_TRANSFORMER_EC))
+		return;
+
+	priv->ec->right_alt_pressed = false;
+	priv->ec->special_combo_triggered = false;
+	priv->altgr_delayed = false;
+	priv->altgr_suppressed = false;
+}
+
+static void asus_ec_kbc_sync_altgr_combo(struct asus_ec_kbc_data *priv)
+{
+	if (priv->ec->special_combo_triggered) {
+		priv->ec->special_combo_triggered = false;
+		if (priv->altgr_delayed) {
+			priv->altgr_delayed = false;
+			priv->altgr_suppressed = true;
+		}
+	}
+}
+
+static void asus_ec_kbc_flush_altgr(struct asus_ec_kbc_data *priv)
+{
+	if (!asus_ec_kbc_altgr_active(priv))
+		return;
+
+	asus_ec_kbc_sync_altgr_combo(priv);
+
+	if (!priv->altgr_delayed)
+		return;
+
+	serio_interrupt(priv->sdev[0], 0xe0, 0);
+	serio_interrupt(priv->sdev[0], 0x11, 0);
+
+	priv->altgr_delayed = false;
+}
+
+static bool asus_ec_kbc_handle_altgr(struct asus_ec_kbc_data *priv, bool is_release)
+{
+	bool suppressed;
+
+	if (!asus_ec_kbc_altgr_active(priv)) {
+		asus_ec_kbc_reset_altgr(priv);
+		return false;
+	}
+
+	asus_ec_kbc_sync_altgr_combo(priv);
+
+	if (!is_release) {
+		if (!priv->ec->right_alt_pressed) {
+			asus_ec_kbc_reset_altgr(priv);
+			priv->ec->right_alt_pressed = true;
+			priv->altgr_delayed = true;
+			return true;
+		}
+
+		return priv->altgr_delayed || priv->altgr_suppressed;
+	}
+
+	suppressed = priv->altgr_suppressed;
+	if (!suppressed)
+		asus_ec_kbc_flush_altgr(priv);
+
+	asus_ec_kbc_reset_altgr(priv);
+	return suppressed;
+}
+
 static int asus_ec_kbc_notify(struct notifier_block *nb,
 			      unsigned long action, void *data_)
 {
@@ -22,14 +99,18 @@ static int asus_ec_kbc_notify(struct notifier_block *nb,
 	unsigned int port_idx, n;
 	u8 *data = data_;
 
-	if (action & (ASUSEC_SMI_MASK | ASUSEC_SCI_MASK))
+	if (action & (ASUSEC_SMI_MASK | ASUSEC_SCI_MASK)) {
+		if (action == ASUSEC_SMI_ACTION(HANDSHAKE) ||
+		    action == ASUSEC_SMI_ACTION(RESET))
+			asus_ec_kbc_reset_altgr(priv);
 		return NOTIFY_DONE;
-	else if (action & ASUSEC_AUX_MASK)
+	} else if (action & ASUSEC_AUX_MASK) {
 		port_idx = 1;
-	else if (action & priv->ec->keyboard_mask)
+	} else if (action & priv->ec->keyboard_mask) {
 		port_idx = 0;
-	else
+	} else {
 		return NOTIFY_DONE;
+	}
 
 	/*
 	 * The data[0] is the number of bytes following the count byte: one
@@ -46,6 +127,7 @@ static int asus_ec_kbc_notify(struct notifier_block *nb,
 	if (port_idx == 0) {
 		/*
 		 * Remap keyboard key codes to match AT layout:
+		 * ALTGR:  RIGHT-ALT  [E0 11] -> delayed / suppressed
 		 * SEARCH: RIGHT-META [E0 27] -> LEFT-ALT   [11]
 		 * MENU:   COMPOSE    [E0 2F] -> RIGHT-META [E0 27]
 		 */
@@ -53,6 +135,10 @@ static int asus_ec_kbc_notify(struct notifier_block *nb,
 			u8 *keycode = &data[n - 1];
 
 			switch (*keycode) {
+			case 0x11:
+				if (asus_ec_kbc_handle_altgr(priv, n == 3))
+					return NOTIFY_OK;
+				break;
 			case 0x27:
 				*keycode = 0x11;
 				++data;
@@ -63,6 +149,15 @@ static int asus_ec_kbc_notify(struct notifier_block *nb,
 				break;
 			}
 		}
+
+		/*
+		 * Only flush delayed AltGr on key make events, ignoring
+		 * key break codes and PS/2 command responses (ACK, BAT, etc.).
+		 */
+		if ((n == 2 && data[0] == 0xe0) ||
+		    (n == 1 && data[0] > 0 && data[0] < 0x84) ||
+		    data[0] == 0xe1)
+			asus_ec_kbc_flush_altgr(priv);
 	}
 
 	while (n--)
diff --git a/include/linux/mfd/asus-transformer-ec.h b/include/linux/mfd/asus-transformer-ec.h
index d09d3b70171e..fda6fb08cc41 100644
--- a/include/linux/mfd/asus-transformer-ec.h
+++ b/include/linux/mfd/asus-transformer-ec.h
@@ -19,6 +19,9 @@ struct i2c_client;
  * @dockram: pointer to Dockram's i2c_client
  * @notify_list: notify list used by cells
  * @keyboard_mask: mask of keyboard packets
+ * @ext_keys_enabled: true if extension keys driver is active
+ * @right_alt_pressed: state of Right Alt (AltGr) key
+ * @special_combo_triggered: true if AltGr + extension key combo was triggered
  */
 struct asusec_core {
 	const char *model;
@@ -26,6 +29,9 @@ struct asusec_core {
 	struct i2c_client *dockram;
 	struct blocking_notifier_head notify_list;
 	u8 keyboard_mask;
+	bool ext_keys_enabled;
+	bool right_alt_pressed;
+	bool special_combo_triggered;
 };
 
 /* interrupt sources */

Thanks.

-- 
Dmitry

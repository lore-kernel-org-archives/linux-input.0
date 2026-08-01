Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6C846A
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785571012; cv=none; b=tjnVFVvlpboAWewKxYmJnYqzzn6d8gfVo2LpZMzGXgWfFIM20jWj4mLMfuj0gcs+CddeClj3J5vDnOEoZES3Bbc9ev0L5F3CYaA8BolXzq7A5Phuwdu0bVhHLapeYOqeQV8C1KNyWPFmbkNBx/V3Zv/Zv7q1JAToQY/kgm7ZuAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785571012; c=relaxed/simple;
	bh=Kt7aw5v1be9+lcNnaGvyQA2wTGV+AOKl2Wj6IFLXFi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcu1BGypRo2KcmBig4VYbaRKuakky3mUH4h0PIWxoigcdWnRXuEEMe0Qu4ZnzTGD9RZvbizIaJC8rcDVk79rH+OsVovBrDnMTH95rFNMJ4sZ9rqdZ5EteQV47CXp5pbfkkphZKjFAqS82V/uqIiZw4S4BlSbroDYqopDks8nmdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrLbi6TG; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrLbi6TG"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-497deab2d66so1380753b6e.0
        for <linux-input@vger.kernel.org>; Sat, 01 Aug 2026 00:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785571010; x=1786175810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/N0Tzrpz6sDPQRaRp7HmPznbO3iM+ppqHQmfBVtWeo4=;
        b=MrLbi6TGFdhkdvF6yhzNRk40/kovsOyADgy1CAUjx2JUQQqw4EwjByZGoSWmBU3QCn
         xXnH1KJ14Sp+KCkZtsz4CbLqPE6d24I1kSgM1YoqY/bem0U3hraxANkboChkl25glT07
         z/z87MVwrTwRLcB99DRNqTZv6w9S0BDSzBqu/Zc/nACUAFZL0n1oI+yQsPpYGmCK5D2T
         ma2KJG3ON6fnzCX76TcQLtihtoBQa6gcgwvkG1X4DGYgbPUHAcXYacEAH1ZT1mz7u9lI
         hqrQtdkNH8gQCEZIiJhVvy0QaJGs+dz7sen64m1vl2rHMdXLr/drZycsMdtV2C7F3dIc
         3/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785571010; x=1786175810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/N0Tzrpz6sDPQRaRp7HmPznbO3iM+ppqHQmfBVtWeo4=;
        b=MAGmqli5iPzw/wR1Boyo0brl2lMSuwfwERyna4klAns+/jCcoCXUTVQjYcHKLq+l6f
         FaOv4hbejJHSdTfwFZ2fReKGMYUrgHe6ulWUPVdT787p07wAQmorRh/qM0Mm6Hl54Fhb
         XPqxz5wN/cCk9udBr6qqOKcPcsJF9jvV8mtjeeWJ2In/6wxs+VgP3NK58qOOMrfxfXuZ
         0Z9JYhzfGCS4CEOEFOfn+cV2fsBgzqi07Y4/rDKXfM+JkrRrwuRSbUpUPBCi6BG2hdf8
         3R0SjInAXr7u7wg6R75EnfOG5AfF6zPLeHQzaPRJ9TxPLsR8M6HnXg2ws3s60+WcbCaP
         +ebw==
X-Forwarded-Encrypted: i=1; AHgh+RoaRFQLL5B4iJTEGocSzMIF37LdazOoIxpB4PMNDBHxwSE4h4nSJhc1kNSv2TjKxGGTi8Ny8c8fesNofQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxopuNWXArx+/wrTqnzpN6Y+6+f2FLt4NIVUvw+2z42/BNaooJ5
	uTRKBmFKHxdctLXlZhHXw4WCHn7h1KCcnxDVb5QQyswxKdb0BmG0uyCS
X-Gm-Gg: AR+sD10gGA5DklXV24Hv8Wj9GXPxGuVwY5HODdsR7FHC25ii+baryLJ33t9exjClh8T
	/05NNBc7cWbhdrV/tSusjNYTUv6s914vM4qhrkSTgsPXuQs5pENQB6rbBGnxVihaStWKUHmEUtW
	TYBQsJzp6QolOacZQ2V66RrhJWbej5aDZJmcnGigkBtH70cmrMENFMXB49lHH8aJVhyUewv/Awu
	iF7M4bLcCCZE5s+LzjNw/dzzwPc9KWNk2Th4C8x26/DEhJ1gt+dxHbtMNVMi6KwTDrYnqWGBI0B
	skiQosQdv8juPbHvV1ZxmEWP0D8243gsu0EmkgVgaDu01CFOvieHcHKCQyVzGH+ZY15ofZmekWb
	Rq6TTUcNDVJQR4RurPtxLjK5M+ikhpSzPCoxzZvMtQbRU+3LgDNGYmo4FBegS+qaNPyOQRke8uw
	SgZ8pYdEMMNEgBRJOkbcyfVUQ5zO6lpfD9JASgHy3AzVLmOQ5ooZsQXjihHaeQGul30kaSNcoVy
	OMdHg==
X-Received: by 2002:a05:6808:1583:b0:492:3ad9:15d9 with SMTP id 5614622812f47-4af5e91f205mr2306521b6e.6.1785571010260;
        Sat, 01 Aug 2026 00:56:50 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([192.3.12.183])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58ce3e8esm2466717b6e.3.2026.08.01.00.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:56:48 -0700 (PDT)
From: Aaron Ma <mapengyu@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...),
	linux-kernel@vger.kernel.org
Cc: Sanjay Govind <sanjay.govind9@gmail.com>,
	Aaron Ma <mapengyu@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Zoltan Illes <zoliviragh@gmail.com>,
	Qbeliw Tanaka <q.tanaka@gmx.com>,
	Elliot Tester <elliotctester@gmail.com>,
	Dmitriy Zharov <contact@zharov.dev>
Subject: [PATCH v2 2/2] Input: xpad - add wired Beitong BTP-KP20D support
Date: Sat,  1 Aug 2026 15:56:23 +0800
Message-ID: <20260801075623.2769601-2-mapengyu@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801075623.2769601-1-mapengyu@gmail.com>
References: <20260801075623.2769601-1-mapengyu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wired BTP-KP20D resets itself when its interrupt-IN pipe is idle
for a few seconds, causing periodic re-enumeration whenever no
userspace client holds the input device open. Add a FLAG_KEEPALIVE
quirk that keeps the input URB running from probe to disconnect,
mirroring the XTYPE_XBOX360W URB lifecycle.

The device also needs the MS OS descriptor query to stay in Xbox 360
mode.

Stop any active output URB on probe failure before freeing its URB and
DMA buffer. LED setup may submit the output URB before input
initialization completes.

Signed-off-by: Aaron Ma <mapengyu@gmail.com>
---
Changes in v2:
- Stop the output URB before freeing it on probe failure.

 drivers/input/joystick/xpad.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 1616047e65f5e..9adc419066353 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -73,6 +73,7 @@
 
 #define FLAG_DELAY_INIT BIT(0)
 #define FLAG_MS_OS_DESC BIT(1)
+#define FLAG_KEEPALIVE  BIT(2)
 
 static bool dpad_to_buttons;
 module_param(dpad_to_buttons, bool, S_IRUGO);
@@ -335,6 +336,7 @@ static const struct xpad_device {
 	{ 0x1ee9, 0x1590, "ZOTAC Gaming Zone", 0, XTYPE_XBOX360 },
 	{ 0x20bc, 0x5134, "BETOP BTP-KP50B Xinput Dongle", 0, XTYPE_XBOX360 },
 	{ 0x20bc, 0x514a, "BETOP BTP-KP50C Xinput Dongle", 0, XTYPE_XBOX360 },
+	{ 0x20bc, 0x5158, "Beitong BTP-KP20D Controller", 0, XTYPE_XBOX360, FLAG_MS_OS_DESC | FLAG_KEEPALIVE },
 	{ 0x20bc, 0x5159, "Beitong BTP-KP20D Controller", 0, XTYPE_XBOX360, FLAG_MS_OS_DESC },
 	{ 0x20d6, 0x2001, "BDA Xbox Series X Wired Controller", 0, XTYPE_XBOXONE },
 	{ 0x20d6, 0x2009, "PowerA Enhanced Wired Controller for Xbox Series X|S", 0, XTYPE_XBOXONE },
@@ -780,6 +782,7 @@ struct usb_xpad {
 	time64_t mode_btn_down_ts;
 	bool delay_init;		/* init packets should be delayed */
 	bool delayed_init_done;
+	bool keepalive;			/* int URB must run from probe to disconnect */
 };
 
 static int xpad_init_input(struct usb_xpad *xpad);
@@ -1971,7 +1974,7 @@ static int xpad_init_input(struct usb_xpad *xpad)
 
 	input_set_drvdata(input_dev, xpad);
 
-	if (xpad->xtype != XTYPE_XBOX360W) {
+	if (xpad->xtype != XTYPE_XBOX360W && !xpad->keepalive) {
 		input_dev->open = xpad_open;
 		input_dev->close = xpad_close;
 	}
@@ -2105,6 +2108,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	xpad->name = xpad_device[i].name;
 	if (xpad_device[i].flags & FLAG_DELAY_INIT)
 		xpad->delay_init = true;
+	if (xpad_device[i].flags & FLAG_KEEPALIVE)
+		xpad->keepalive = true;
 
 	xpad->packet_type = PKT_XB;
 	INIT_WORK(&xpad->work, xpad_presence_work);
@@ -2227,10 +2232,24 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		error = xpad_init_input(xpad);
 		if (error)
 			goto err_deinit_output;
+
+		if (xpad->keepalive) {
+			/*
+			 * The device resets itself when the interrupt-IN pipe
+			 * is idle for a few seconds, so keep the URB running
+			 * from probe until disconnect.
+			 */
+			error = xpad_start_input(xpad);
+			if (error)
+				goto err_deinit_input;
+		}
 	}
 	return 0;
 
+err_deinit_input:
+	xpad_deinit_input(xpad);
 err_deinit_output:
+	xpad_stop_output(xpad);
 	xpad_deinit_output(xpad);
 err_free_in_urb:
 	usb_free_urb(xpad->irq_in);
@@ -2247,6 +2266,8 @@ static void xpad_disconnect(struct usb_interface *intf)
 
 	if (xpad->xtype == XTYPE_XBOX360W)
 		xpad360w_stop_input(xpad);
+	else if (xpad->keepalive)
+		xpad_stop_input(xpad);
 
 	xpad_deinit_input(xpad);
 
@@ -2288,6 +2309,8 @@ static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
 		 */
 		if (auto_poweroff && xpad->pad_present)
 			xpad360w_poweroff_controller(xpad);
+	} else if (xpad->keepalive) {
+		xpad_stop_input(xpad);
 	} else {
 		guard(mutex)(&input->mutex);
 
@@ -2309,6 +2332,9 @@ static int xpad_resume(struct usb_interface *intf)
 	if (xpad->xtype == XTYPE_XBOX360W)
 		return xpad360w_start_input(xpad);
 
+	if (xpad->keepalive)
+		return xpad_start_input(xpad);
+
 	guard(mutex)(&input->mutex);
 
 	if (input_device_enabled(input))
-- 
2.53.0

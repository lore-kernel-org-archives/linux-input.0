Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F353F6B2
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170280; cv=none; b=T4FtgXTpwcwhqZIG01S9pahjSDTLIPU9VugU2py2eK+v5eIBOWlPA4aRCPTOUiZUvtG1eMf9TJWhDPWXWA2aUSAO8GjlW7SDq6zNK7B01byschG5wceR0DqZ0pW1H2YvQCJykMDkdhHDWUtFEJ/HGb9Algc8NdzSD3vu0YLn1ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170280; c=relaxed/simple;
	bh=VgahlXi9xQXwt4JF4mMbufVALOGlgxUt7D/A/d7V4Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMJzclDAZg0esPzBh4JGNhafnJl/qvr0mGhbeOIL/DY7L1m7r6p1QhtP5ko1GN7oei5P9S5aYMwPqRztJ4cjMqFe5pecfXwj0cIoEWtZtnmjt8oje9tTWUfNHeDaVoMZWgEvMWmxnBP3dFRbahZR2Z62FocLPfPomD4TS0AScxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=batON7ge; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="batON7ge"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac749e0719so75691a91.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792170277; x=1792775077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4NgL+ojrdgYlUbFZkcvjKq125dB+9KfHPFlmlvMf/b4=;
        b=batON7geBarKT3rCKiQn235Xk8L7BQPNtxWItSqOwETyyu++CqDs2gbEQc7JzUqkpc
         GhoD7EeSl/1HgbzuBC2BNGXXn0BxTo0htZvNWtTHEnRulX1NDHX5JS+3DswhEtYdVowF
         WtFcDMTv/4qxlpHOUuCkV9CTq7JqsC1pM5WLfVHx4fZJiNCWEl+p4ZgjkDuU0k7917b5
         ZuzvvupvF9+SaU4h1uK3nBQvoM6pcrmFfQl6dQsVn9wZkhtEFtRj7qhika0YiXaHeFrA
         WB8G8qULPCvWNWwM2GeFOi3JYQFscN/BffRqk7VmoF3YDSNyk4086H990xhztm3Mrt5d
         ZIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170277; x=1792775077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4NgL+ojrdgYlUbFZkcvjKq125dB+9KfHPFlmlvMf/b4=;
        b=JIs+e6X3h0zX4+6mR0kbxJQt+TXNXfyMInBx2F27XxHbqAMTFCKKsy/hU9NXIJyqgL
         jmHD/All3JBtFEvkLLpFE+2WwjVvrlS4Ifvf642YHvdcmRL2AHsjm5OqLeIexvKM1fCz
         +Pvf9FDxwmUE7d8EcL3K7BHwRsRXooTuslF6I/HdDQ6x+jLN1FTX4xKj2TqANkxOhGyk
         hZIhCRpVfDLU5FeomHVgdXA+rcm9F5lho3IDtWSSEE7QndamXIq45ZEvBdqYOHsQgwIf
         kZRSd4jwcp4zQh/qT0dMrFjk7UpxoNNPxdaHnPUZRwbwDXu9uHoUSDNjOA5W2jcIxCTU
         swMA==
X-Gm-Message-State: AFq9FYKnkwce2NTPo8h8sKB6HZt2NPPQJkIGD1oz+518O06uE7e6lQ5C
	bm1n4wGPRhAqDIRQZfXfPNtwLZ03Du4JQAQAPWneKObHQUtTvMGlODoQvrkBiiGKWykkXvPC
X-Gm-Gg: AYBFou0K5JZlaG7IiMc22PaF25YiWLmJvxxaxxYCmoCh2VnoljI7dZfrNPxvKem0v0r
	HEcZwK4f9ryl/Ukmzhzw8FId0M+xiIrtB4lKZkKVnyAaQlJOlyFCpyW8KGKJVJ58AvvFczOdhBb
	rxy4eZKYNPmq5VX/YUzzYUAqidQqA4NNhOOGg/b2koGpcmsE2J+KKBFol9BkJBqr/akcm3hWrc4
	jeb8t13IEAK07AZpf7rZYHqUDKEFsaAQUBgYLmXrli/oWNvnno8QlaT1NUCVYS4Ift9i9va/++4
	+PGdkxJ8+DrcMbHyO9mvO5I9AxzQvtfHuSctlNS13yg1rXQVnJ+YiP9NuvviVLYJHLJCWP/Hu+N
	N81kjWxqh+U+UFqwLf3goS0ohtNP2eMqGSCK6H9DBP3J3ZUYdg07RaHMqabL2iYVwZNpZGAw61K
	HDBkI/AlWP2wxRl667zOf+4tpfMI3PBAwrz4diGoiAjgmAqHUzdVMZrdNgGfY8nt4cpN8289Q2J
	e2V4djraFywreI=
X-Received: by 2002:a17:90b:390f:b0:3a4:967c:6947 with SMTP id 98e67ed59e1d1-3aceec24c11mr399807a91.21.1792170276595;
        Fri, 16 Oct 2026 10:04:36 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([223.104.67.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm9928587a91.0.2026.10.16.10.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:04:35 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH 2/5] Input: misc - replace strlcat() with strscpy()
Date: Sat, 17 Oct 2026 01:04:08 +0800
Message-ID: <20261016170411.51025-3-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016170411.51025-1-shlomojune6@gmail.com>
References: <20261016170411.51025-1-shlomojune6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ati_remote2, cm109, ims-pcu, keyspan_remote, powermate and
yealink drivers build the physical path by appending a constant
"/input0" suffix with strlcat() after usb_make_path().

In preparation for removing the deprecated strlcat() API[1],
replace it with strnlen() followed by strscpy() into the remainder
of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
strlcat with better alternatives") did for the usbhid drivers.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/misc/ati_remote2.c    | 4 +++-
 drivers/input/misc/cm109.c          | 4 +++-
 drivers/input/misc/ims-pcu.c        | 8 ++++++--
 drivers/input/misc/keyspan_remote.c | 4 +++-
 drivers/input/misc/powermate.c      | 4 +++-
 drivers/input/misc/yealink.c        | 4 +++-
 6 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index 8db2dca84975c..929163f52177e 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -767,6 +767,7 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 	struct usb_device *udev = interface_to_usbdev(interface);
 	struct usb_host_interface *alt = interface->cur_altsetting;
 	struct ati_remote2 *ar2;
+	size_t len;
 	int r;
 
 	if (alt->desc.bInterfaceNumber)
@@ -823,7 +824,8 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 		goto fail3;
 
 	usb_make_path(udev, ar2->phys, sizeof(ar2->phys));
-	strlcat(ar2->phys, "/input0", sizeof(ar2->phys));
+	len = strnlen(ar2->phys, sizeof(ar2->phys));
+	strscpy(ar2->phys + len, "/input0", sizeof(ar2->phys) - len);
 
 	strlcat(ar2->name, "ATI Remote Wonder II", sizeof(ar2->name));
 
diff --git a/drivers/input/misc/cm109.c b/drivers/input/misc/cm109.c
index 353d3c1d347d5..d3aee3c498702 100644
--- a/drivers/input/misc/cm109.c
+++ b/drivers/input/misc/cm109.c
@@ -685,6 +685,7 @@ static int cm109_usb_probe(struct usb_interface *intf,
 	struct input_dev *input_dev = NULL;
 	int ret, pipe, i;
 	int error = -ENOMEM;
+	size_t len;
 
 	interface = intf->cur_altsetting;
 
@@ -766,7 +767,8 @@ static int cm109_usb_probe(struct usb_interface *intf,
 
 	/* find out the physical bus location */
 	usb_make_path(udev, dev->phys, sizeof(dev->phys));
-	strlcat(dev->phys, "/input0", sizeof(dev->phys));
+	len = strnlen(dev->phys, sizeof(dev->phys));
+	strscpy(dev->phys + len, "/input0", sizeof(dev->phys) - len);
 
 	/* register settings for the input device */
 	input_dev->name = nfo->name;
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index b1a0edcc49b4e..697813fb11da8 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -205,6 +205,7 @@ static int ims_pcu_setup_buttons(struct ims_pcu *pcu,
 	struct input_dev *input;
 	int i;
 	int error;
+	size_t len;
 
 	input = input_allocate_device();
 	if (!input) {
@@ -216,7 +217,8 @@ static int ims_pcu_setup_buttons(struct ims_pcu *pcu,
 		 "IMS PCU#%d Button Interface", pcu->device_no);
 
 	usb_make_path(pcu->udev, buttons->phys, sizeof(buttons->phys));
-	strlcat(buttons->phys, "/input0", sizeof(buttons->phys));
+	len = strnlen(buttons->phys, sizeof(buttons->phys));
+	strscpy(buttons->phys + len, "/input0", sizeof(buttons->phys) - len);
 
 	memcpy(buttons->keymap, keymap, sizeof(*keymap) * keymap_len);
 
@@ -286,6 +288,7 @@ static int ims_pcu_setup_gamepad(struct ims_pcu *pcu)
 	struct ims_pcu_gamepad *gamepad;
 	struct input_dev *input;
 	int error;
+	size_t len;
 
 	gamepad = kzalloc_obj(*gamepad);
 	input = input_allocate_device();
@@ -302,7 +305,8 @@ static int ims_pcu_setup_gamepad(struct ims_pcu *pcu)
 		 "IMS PCU#%d Gamepad Interface", pcu->device_no);
 
 	usb_make_path(pcu->udev, gamepad->phys, sizeof(gamepad->phys));
-	strlcat(gamepad->phys, "/input1", sizeof(gamepad->phys));
+	len = strnlen(gamepad->phys, sizeof(gamepad->phys));
+	strscpy(gamepad->phys + len, "/input1", sizeof(gamepad->phys) - len);
 
 	input->name = gamepad->name;
 	input->phys = gamepad->phys;
diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
index 70cd6586459ef..f0f31f2823d57 100644
--- a/drivers/input/misc/keyspan_remote.c
+++ b/drivers/input/misc/keyspan_remote.c
@@ -430,6 +430,7 @@ static int keyspan_probe(struct usb_interface *interface, const struct usb_devic
 	struct usb_keyspan *remote;
 	struct input_dev *input_dev;
 	int i, error;
+	size_t len;
 
 	error = usb_find_int_in_endpoint(interface->cur_altsetting, &endpoint);
 	if (error)
@@ -482,7 +483,8 @@ static int keyspan_probe(struct usb_interface *interface, const struct usb_devic
 			 le16_to_cpu(udev->descriptor.idProduct));
 
 	usb_make_path(udev, remote->phys, sizeof(remote->phys));
-	strlcat(remote->phys, "/input0", sizeof(remote->phys));
+	len = strnlen(remote->phys, sizeof(remote->phys));
+	strscpy(remote->phys + len, "/input0", sizeof(remote->phys) - len);
 	memcpy(remote->keymap, keyspan_key_table, sizeof(remote->keymap));
 
 	input_dev->name = remote->name;
diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index 754379d2625cf..dbf9f06f3059e 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -299,6 +299,7 @@ static int powermate_probe(struct usb_interface *intf, const struct usb_device_i
 	struct input_dev *input_dev;
 	int pipe, maxp;
 	int error = -ENOMEM;
+	size_t len;
 
 	interface = intf->cur_altsetting;
 	if (interface->desc.bNumEndpoints < 1)
@@ -334,7 +335,8 @@ static int powermate_probe(struct usb_interface *intf, const struct usb_device_i
 	pm->input = input_dev;
 
 	usb_make_path(udev, pm->phys, sizeof(pm->phys));
-	strlcat(pm->phys, "/input0", sizeof(pm->phys));
+	len = strnlen(pm->phys, sizeof(pm->phys));
+	strscpy(pm->phys + len, "/input0", sizeof(pm->phys) - len);
 
 	spin_lock_init(&pm->lock);
 
diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
index 560f895a00cda..1a3bebc8c3513 100644
--- a/drivers/input/misc/yealink.c
+++ b/drivers/input/misc/yealink.c
@@ -812,6 +812,7 @@ static int usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct yealink_dev *yld;
 	struct input_dev *input_dev;
 	int ret, pipe, i;
+	size_t len;
 
 	interface = intf->cur_altsetting;
 
@@ -891,7 +892,8 @@ static int usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	/* find out the physical bus location */
 	usb_make_path(udev, yld->phys, sizeof(yld->phys));
-	strlcat(yld->phys,  "/input0", sizeof(yld->phys));
+	len = strnlen(yld->phys, sizeof(yld->phys));
+	strscpy(yld->phys + len, "/input0", sizeof(yld->phys) - len);
 
 	/* register settings for the input device */
 	input_dev->name = nfo->name;
-- 
2.43.0


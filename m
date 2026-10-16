Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F767541E66
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170284; cv=none; b=g72aKd9qgIFB5r6aLcoIxr0QeY/h1UryMfXC930AU8eWjl8DjbOI3fyCRpA1SEP1KB91xlwcSJ776f0xdy88Jy7wiYyI/XyrkBHoePm/GQL/l8gyT6h2VtNd/7fjrcKLTVCrKKpRSnm06T1fKnDXmbtK0O/E1GhIvc09uzPgyuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170284; c=relaxed/simple;
	bh=uvS/2yZCzMLiXx36NuzhWF/CYeVMFDQgoWSHGRPzXoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VW0M2LbM1xkdvSKH1vmeqHwkZSYQ82urUfmZTlE7HhXlK/jEzy78nP82iacOvZVAaV7ghzIHQEQe98NEl0aZ2bOgIf+WNhIlNsmzFn15SFyh2OOK771z2lc9MAIRDQlzIvDmQERnn60CfLyJIcyAmr1IZ75eUjrUU4jwIvL+Tr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/js0YwB; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/js0YwB"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3ac92391681so64505a91.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792170283; x=1792775083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gC1wV2C1k1gGrEWtewvbb3dn1WTOw2A8wKKqUWsjPzQ=;
        b=A/js0YwBSPU3YF75je0toXJdFgmgEK84LPgMHrkDRZ7uLLTpaiovk7tp1idHWm8KxT
         mD8+AFo3+pqhiHA26Uq8izQ22/h/iujpL1mP7u19ey2kgdbTqkXhGWzV+PPMAhLPvnY7
         nK5llxFKKBo5oLuwIWw8g4xU5b5JglqFI5EgTPTfeazwQj4zR1wO4Y/Y4wsY+mpZp49Z
         zno9qxfzmZnZ8TjiVBUmtsPwyijXHvLSYHbCeP4JpWoURPRIQ43Lt2qmvEGGmUTCu86S
         xre80CeDgYoOqxj8fmj+nQmHS5gleak+kpNDnMIQvW6HzKlahZR/Fj50Kxp9bgjzomUP
         9JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170283; x=1792775083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gC1wV2C1k1gGrEWtewvbb3dn1WTOw2A8wKKqUWsjPzQ=;
        b=bsTEENohMOgKZPRUDl9fToGynZJTxxhA3npBRUlpbxjbRpiyl9QivSfmFyAqtwgK0g
         QONqCJBEX8p3WBtXlGOR5370SlbWmwrHvkqkT4jfxDVPbAktpOPf/0hfS6PJcbJmvhjx
         uMxmseo+hSeRKJ/M+eSbSK3kbvwXuVCbyGl5yUScEst0YfgtFUhrCoG9s7p8Ivi7Cf72
         8rTlYuOM6q1y9WneQvi2fkTcPJSIrG91Jn1ViIefsMDXsqzmN0SafB2VAqFMHsCdyp/2
         b+kGZnvFMSKt7q08OinDXimvSJqaEJGtWfhTNXsDOVbgl1c5QonJ6B8nCnsvN4sgy8rc
         HtYQ==
X-Gm-Message-State: AFq9FYIZT2Hw5xKcjAwOPZpFRb3UZiveNM5LVsaIz28lUc6WZpTytv+h
	/XDEIaJAh9N0Yt+J5I5dXACq5lmO7zTHLljlj6vQlhiunPKlWZH7nRRXOPV70CcAX9SAeqfI
X-Gm-Gg: AYBFou2GaGE20qmWe68AOwywZWSoTDtVcFnqFU/H8Dsg0SwA/toGzmTg90fgy3lvYiW
	arOnwqto1VcqVDKdMdNGuBDhZZcZbWouz0jOcwsX1YdjtP8r37aY8wHYcj1rRwbTnd2m4kaFKhs
	nZIARWECEA8Hr6FjhkHnJ+L9k2xnm55clVmRMloyN7Bon7AXpESb2/CQWu+WjXx8hKl8G/pg+2/
	AhEnDgxQmFQ/weEWplInQxRVdq0mHOaLuZyhEoCG2zW7Yz89JaAMPWnUUAsA3vodu44w48nI5zQ
	wjm9ItchaxyEvCiOdJNTXQR2D19Eppgsn4jHzSCiVe5CmDYHzaNg4qqE2+0hrLRvYoH18Qcxjoi
	5GLnu2FSjmP/DceCc1esfq2aY7vaDYo9fhW6Cgd006cjQta3sELBK+d977mvxnIS7B3jgmwej8Z
	rcT3D0lAeVLOhngimYz8u3oD0CWVf7q9tPRmSGZ19txnrWu7VP98ILK/GtRUImj44oNmaZf6KCK
	2QGrzYaZ+93u1A=
X-Received: by 2002:a17:90b:388c:b0:3ac:8446:c1a5 with SMTP id 98e67ed59e1d1-3acef10d017mr379263a91.48.1792170282321;
        Fri, 16 Oct 2026 10:04:42 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([223.104.67.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm9928587a91.0.2026.10.16.10.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:04:41 -0700 (PDT)
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
Subject: [PATCH 3/5] Input: mouse - replace strlcat() with strscpy()
Date: Sat, 17 Oct 2026 01:04:09 +0800
Message-ID: <20261016170411.51025-4-shlomojune6@gmail.com>
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

The appletouch, bcm5974 and synaptics_usb drivers build the
physical path by appending a constant "/input0" suffix with
strlcat() after usb_make_path().

In preparation for removing the deprecated strlcat() API[1],
replace it with strnlen() followed by strscpy() into the remainder
of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
strlcat with better alternatives") did for the usbhid drivers.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/mouse/appletouch.c    | 4 +++-
 drivers/input/mouse/bcm5974.c       | 4 +++-
 drivers/input/mouse/synaptics_usb.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index eebeb57515e1c..aa43f7ae274ce 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -832,6 +832,7 @@ static int atp_probe(struct usb_interface *iface,
 	struct usb_endpoint_descriptor *ep;
 	int error;
 	const struct atp_info *info = (const struct atp_info *)id->driver_info;
+	size_t len;
 
 	/* set up the endpoint information */
 	/* use only the first interrupt-in endpoint */
@@ -875,7 +876,8 @@ static int atp_probe(struct usb_interface *iface,
 		goto err_free_buffer;
 
 	usb_make_path(udev, dev->phys, sizeof(dev->phys));
-	strlcat(dev->phys, "/input0", sizeof(dev->phys));
+	len = strnlen(dev->phys, sizeof(dev->phys));
+	strscpy(dev->phys + len, "/input0", sizeof(dev->phys) - len);
 
 	input_dev->name = "appletouch";
 	input_dev->phys = dev->phys;
diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index e772bac3b64c0..64e26cca2c2c4 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -928,6 +928,7 @@ static int bcm5974_probe(struct usb_interface *iface,
 	struct bcm5974 *dev;
 	struct input_dev *input_dev;
 	int error = -ENOMEM;
+	size_t len;
 
 	/* find the product index */
 	cfg = bcm5974_get_config(udev);
@@ -990,7 +991,8 @@ static int bcm5974_probe(struct usb_interface *iface,
 
 	/* create bcm5974 device */
 	usb_make_path(udev, dev->phys, sizeof(dev->phys));
-	strlcat(dev->phys, "/input0", sizeof(dev->phys));
+	len = strnlen(dev->phys, sizeof(dev->phys));
+	strscpy(dev->phys + len, "/input0", sizeof(dev->phys) - len);
 
 	input_dev->name = "bcm5974";
 	input_dev->phys = dev->phys;
diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
index 880a0c79148cd..e1a4a9746dbee 100644
--- a/drivers/input/mouse/synaptics_usb.c
+++ b/drivers/input/mouse/synaptics_usb.c
@@ -279,6 +279,7 @@ static int synusb_probe(struct usb_interface *intf,
 	unsigned int intf_num = intf->cur_altsetting->desc.bInterfaceNumber;
 	unsigned int altsetting = min(intf->num_altsetting, 1U);
 	int error;
+	size_t len;
 
 	error = usb_set_interface(udev, intf_num, altsetting);
 	if (error) {
@@ -354,7 +355,8 @@ static int synusb_probe(struct usb_interface *intf,
 		strlcat(synusb->name, " (Stick)", sizeof(synusb->name));
 
 	usb_make_path(udev, synusb->phys, sizeof(synusb->phys));
-	strlcat(synusb->phys, "/input0", sizeof(synusb->phys));
+	len = strnlen(synusb->phys, sizeof(synusb->phys));
+	strscpy(synusb->phys + len, "/input0", sizeof(synusb->phys) - len);
 
 	input_dev->name = synusb->name;
 	input_dev->phys = synusb->phys;
-- 
2.43.0


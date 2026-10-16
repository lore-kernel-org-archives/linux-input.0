Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB89539772
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170296; cv=none; b=qAZLgHdr1Qu8+S3NfSazuJxML8j01e9v0uLVx5AxlesMZ8M0vBtDH6Tnt0DJzrkAn3TuPOOleMcRJiWbpNovPCk+Jy+JCe8SdSZvr0/I1b6pUnptAQtRkG/B/0YGQxLw+f1kHZiRr/ecWIeJxaRTknH2zutkQ2Kl/bXH4hXuyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170296; c=relaxed/simple;
	bh=P0Sg+F0KKBPtMKdv7lWgT3UyF3Ll76cOvOMLZIK6NBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/yWcAdfnr4CAImTWBysLXRZIwMQXCY5CemH24K4kG8Fth3RKEXRmY6FfSJnTaGyucv1mHYvIP2onlcwoTccJARv5tdsJvoJ70hKl3DMbBXovKGt3HsIPk32OkyZX64tN1PBqzBpTw790VxPM99eObCNCTjiSg8rNdr736wMMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+/DsjxN; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+/DsjxN"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3ab3534a186so22311a91.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792170294; x=1792775094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eTK7t+qRWhyCyqZmU5cFtXciAINVp6GCAy+u+kWv2kg=;
        b=j+/DsjxNRn4pSCNitIQqwqo6wCfmoBXav8ejxpJuFxM2XRETwZuuFL86CX/AI+ojyA
         IwBl23VCelSDOOuhGAm528+D/yjCHpKezRyv/oMASUHCiu18+NvZihJd27CsO8MkdK8M
         zq23nS1PdWUljzxjoH4KKbbtOMiQcIH7tgrsO7DTgDaNBHuCOpn/C6Nd90k6eUotAYsJ
         ubJUY44LMaxXs2ZWDR4Ne84VNbSkgadDGghgYhOtntD9jiPioej3pDvZBofA2+QLVdXk
         ChyMdtl7/RdiWIqomOw7qeHZDvWyEVvbjPY/GiObHZfr+eVtm6y8PSzByDyyR4G8WELp
         iZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170294; x=1792775094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eTK7t+qRWhyCyqZmU5cFtXciAINVp6GCAy+u+kWv2kg=;
        b=lDw5E9wqCgDLfwKVuYyksB7wpjVyBAYiL38pF9SDttxPmJ6vDK6WdB7K1X+TnjeGBU
         vxPrdKrttIp+yV67Qmxb5IXXnQ2pM9ev/QfRnRGsGWFBM+Q8UCHucTUq3mxjpyx485TH
         qCNaEV3f7R0i4CJXsvaQOnvDdkUfgg+RMzbAx4GIucKmXv1w4m/QpvnjT5no2Slnc8OD
         1MPasDrsFW6mmPgoO1T+ZuU3ypbrA77FdL6l3IzlouTooaUtptQbFGkXlwBmgz1i0pw/
         13Tt4WqIFGZ2zpCIg6xnm2UjhDjiyf+/v4T/2r032ScMUmYKJZocr5qLllPNcTgk8OSQ
         Q2Ag==
X-Gm-Message-State: AFq9FYLaHcgsAeI4mevm2Njco509nLQTqGoK3Vkelpj3354A9i7q2K1K
	jdLxa7lpGbg0XOiJ+Sad0xbMWg7RH8ThntFve8sr7bIu3abWCjwcLuHMAgLnvTzd
X-Gm-Gg: AYBFou1gkNZ35JbzyCOySoMXaX6KOjHXNyFkyvq98fkC41iD4M8zIeFEKXOtb0Zzuql
	Rtxf+khD3WcthqhaPARKEDD+0OmOuGm8MEvIrrPNvle+jYsEefJxt8VDrKO7+vk4x0vS46QhYQV
	M8xaytiYyNRRUc4ZAMLj6UXV5Y7zk2ye/aXK8uiMqdnZTRBAM2d/JcDIBcT337UQAUVpIP8EZVQ
	AjN8TxYlwO4ZD6Aron0V15XT6IkGMzQpVB1CFzO4Z3+VqnQfwtlHIaAZPOYBcl/R9uGoz1degOu
	cX8IBp/DBlNcDW5bVU4ex221Vl5VZucjc/zvbHylGVLbw01WA/GTOdX0+4TssddquDDoaECAyr4
	Q3H8s5o7lqterGG8i143B8mFEXrauliMubGm7H1N3UHlAWmE9vnaGoENz3dfsyO2AB7h6pnfi5V
	9AU0k9jhZuOlpQPedBxbl6mluZ2Cq+h6JYy6ZWugdWBw+Y8h+lyFgJWELjKFTF9feEmUjxQdJIm
	Yye2PMV0SsJhBU=
X-Received: by 2002:a17:90b:48c5:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3acef4e131cmr275516a91.30.1792170294449;
        Fri, 16 Oct 2026 10:04:54 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([223.104.67.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm9928587a91.0.2026.10.16.10.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:04:53 -0700 (PDT)
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
Subject: [PATCH 5/5] Input: touchscreen - replace strlcat() with strscpy()
Date: Sat, 17 Oct 2026 01:04:11 +0800
Message-ID: <20261016170411.51025-6-shlomojune6@gmail.com>
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

The sur40 and usbtouchscreen drivers build the physical path by
appending a constant "/input0" suffix with strlcat() after
usb_make_path().

In preparation for removing the deprecated strlcat() API[1],
replace it with strnlen() followed by strscpy() into the remainder
of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
strlcat with better alternatives") did for the usbhid drivers.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/touchscreen/sur40.c          | 4 +++-
 drivers/input/touchscreen/usbtouchscreen.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 77ec2c94b91fd..72ec3882e3d40 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -657,6 +657,7 @@ static int sur40_probe(struct usb_interface *interface,
 	struct usb_endpoint_descriptor *endpoint;
 	struct input_dev *input;
 	int error;
+	size_t len;
 
 	/* Check if we really have the right interface. */
 	iface_desc = interface->cur_altsetting;
@@ -691,7 +692,8 @@ static int sur40_probe(struct usb_interface *interface,
 	input->name = DRIVER_LONG;
 	usb_to_input_id(usbdev, &input->id);
 	usb_make_path(usbdev, sur40->phys, sizeof(sur40->phys));
-	strlcat(sur40->phys, "/input0", sizeof(sur40->phys));
+	len = strnlen(sur40->phys, sizeof(sur40->phys));
+	strscpy(sur40->phys + len, "/input0", sizeof(sur40->phys) - len);
 	input->phys = sur40->phys;
 	input->dev.parent = &interface->dev;
 
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 0bbacb517c286..e6f88bd9a3408 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1438,6 +1438,7 @@ static int usbtouch_probe(struct usb_interface *intf,
 	struct usb_device *udev = interface_to_usbdev(intf);
 	const struct usbtouch_device_info *type;
 	int err;
+	size_t len;
 
 	/* some devices are ignored */
 	type = (const struct usbtouch_device_info *)id->driver_info;
@@ -1513,7 +1514,8 @@ static int usbtouch_probe(struct usb_interface *intf,
 			 le16_to_cpu(udev->descriptor.idProduct));
 
 	usb_make_path(udev, usbtouch->phys, sizeof(usbtouch->phys));
-	strlcat(usbtouch->phys, "/input0", sizeof(usbtouch->phys));
+	len = strnlen(usbtouch->phys, sizeof(usbtouch->phys));
+	strscpy(usbtouch->phys + len, "/input0", sizeof(usbtouch->phys) - len);
 
 	input_dev->name = usbtouch->name;
 	input_dev->phys = usbtouch->phys;
-- 
2.43.0


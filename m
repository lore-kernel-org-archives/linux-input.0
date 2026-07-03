Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD12286D56
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093568; cv=none; b=Tyso+DWGvoKmCXzFfhRW9KCHcV5KnYd+CyIvjnmibKuBbolaQDDd1fjDMNfRzekm84WedMukgAIQe2bXZXGiXFUYzZ4K+HSjhNgCLE2UkU2EglrXMGsmtM4vXce7DqnX1lJs7de0C0qspM7W+cor1g+EDTXc3IL0Cqh6R2K0mQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093568; c=relaxed/simple;
	bh=bpDBJApg2sIRD1xZQoJc5hMZ+M4aXNheD81m5KPvtWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIH7kZw2GBk5AjovD4waLV8zwAZN1joJt9YBLLw+hZtomyciO8CPs9zM3s6ZXxPibthwzwOIEY2qmwsWSnF5c7E2IQa9o73BITsqd6yRsFL8akzY6wCW/5iYf55PD/5t+jBxVBFgpGOTcJE4VuFfbxb4L3+ann3jY+m5Ioo+zpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4UN6O0E; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4UN6O0E"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so185575e9.0
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 08:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783093561; x=1783698361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r/Xcb20eXe3Fb4hacmH4fR1R2kfzGBmc8DhY2l8UD4M=;
        b=B4UN6O0E/FMADkq9B6YzaJC7/yIa/yZ44RnPFci5x7w4Lr/Y47ztYGA2Fxn+XcckXG
         2vBPMYthk9jLmot39FUQM/msHgwPBkI8eCvDpSlEN4EvIqSdGUiZUmYPWxBrlY5GA1iR
         f+5oYC80l5GZ4lbklvoXLz1b+sumLKi73F9G8fakLBmw04xjoT9uaZi7Z9pmxCM07c3Q
         gC5lsQ1a51uP2V/9UtEUwGbfOn9SalJol1iKqsXgNKljqUIF1GPdj2D0MdmSClY3H8qC
         Ko3dGRli2FCxxpnlzEMFHpKNIRa8CdPrMG6OaS0uOumzvb5ZzEY27/1sZIBI2y1q3fbl
         oinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093561; x=1783698361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r/Xcb20eXe3Fb4hacmH4fR1R2kfzGBmc8DhY2l8UD4M=;
        b=izYRDYefuUu7hsGyxkxLgm7iX/abf1gXCedMFZE7mRV3PsCffi4q6/irQUOS9YkUWG
         KeFxa7QrOqMDI+zAxyiVcZZ1JkOR5HxUf5ahnZWTxOc5f11N4NfJNXRppRozvtKs1Dmb
         LDVB+iXs6dBp33Q18e9RuQUXb6cSMDGfERTTFXqkb1Xq7Jms1Ierhy+V1QSzExrEO8KH
         VsvBsrXW9zQsGzbKMDWr4ra856wm5HEPy6bISeqS3fkL6EciJEDq2M7G2uQ81RHY6u1b
         wAijufG369ylZbnFvYYxhfsTp8aN5joCUegLyCRRgHJyrFyu8gIOFZDn4PThcF6VkPT8
         Db/w==
X-Forwarded-Encrypted: i=1; AFNElJ8srjlJRNn3SgmtvIhMJ3pvDmUJKKNdxEQmgSUYfmTioNlMrO7Zo7dm4TXapRgOiofn5WWTjGElzcF6kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/HIiWz4bpU3C7X74s/Dr1rgJjfwCuhzwRMDUsLDrF2ICyPgGZ
	XnVsmxQ5ahMpp6vdTsp1bLz+it8m40P/rOQdVrxz/U6CG8Wvd4x1oz2CMzs6VniRsQ==
X-Gm-Gg: AfdE7clsDxFCsdsi2q9ZEKrHl9y8IhVJ9+ikvxycMU9i37cBQOl3OzOcFpTQ9k6Rg8j
	5UKVfShS3okmBTEfs3QrnKDRsD496Fm7p99Q0pzoiK/T+l+hZI7Dt5tgQorRFJVFAb9Yl5ypZiS
	6IZPZ1iDcWVqfiCNnxLBZcDtdqzI5qm8CWBDKyX5CUG5eL9a4Zo3v6MwiBhSj+e9GEyDhLOPjzN
	tVi/akJEp0iyV4ba4L4fwcb1hlCtlQZCw1nRCrVXEpiLgGTDOs5b2uDf3f3PSOEebOyeTWOJqnH
	qiTb2JS5vERy9q+dUQZIURe3wxk8BESQ+UBjPcWgGBkdx9ke1W+L2PqWzRv/8zWBLQ9hyp+iL6j
	eEq/tUONzvkLShknt3KwBqBNUEpu9xQbk2IR3difXVpUy4b8IflxQH4E0Nb1+qttS2MQnJKai1v
	BQ0pIMYYO+1WzI6upGAVFNGkLvyBUASbzebJjr1ul/s2xUku7WBkdS2q2Uss5+kQi8RrDAOQc9D
	lyQqZtwKg==
X-Received: by 2002:a05:600c:1795:b0:493:caa7:4fd2 with SMTP id 5b1f17b1804b1-493d10409a5mr19435e9.6.1783093560547;
        Fri, 03 Jul 2026 08:46:00 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e3e2702sm245351f8f.9.2026.07.03.08.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:45:59 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jul 2026 17:45:54 +0200
Subject: [PATCH v2 3/3] HID: rapoo: fix missing hid_is_usb() check
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-hid-usbcheck-v2-3-c5ed7bc94772@google.com>
References: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
In-Reply-To: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783093554; l=1735;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=bpDBJApg2sIRD1xZQoJc5hMZ+M4aXNheD81m5KPvtWc=;
 b=B0s19zRLEsgsGYSktBtXzkHWMswlMWePnN15OorJ1offp7HG3eYwikDX1/ThZNnRAe5X4QV3Y
 wuAeaAHgsW/DMS/E0g086z4y23Xxu4LX37hk9U1Nc8ProQ7j1KHTpQ6
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

to_usb_interface() can only be used on a hid_device whose parent is really
USB; uhid can create devices that identify as being on BUS_USB, but don't
actually have a USB parent.
Fix the use of to_usb_interface() without a hid_is_usb() check.

Add a dependency on USB_HID for hid_is_usb(), as other HID drivers do; the
alternative would be to provide a simple stub implementation on !USB_HID
builds.

I have verified that it is currently possible to trigger a kernel splat due
to this bug in an ASAN build, and that this commit fixes the issue.

Fixes: b3b1c68fb726 ("HID: rapoo: Add support for side buttons on RAPOO 0x2015 mouse")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/hid/Kconfig     | 1 +
 drivers/hid/hid-rapoo.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f9bcaeb66385..48934c4f3c45 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1048,6 +1048,7 @@ config HID_PXRC
 
 config HID_RAPOO
 	tristate "Rapoo non-fully HID-compliant devices"
+	depends on USB_HID
 	help
 	Support for Rapoo devices that are not fully compliant with the
 	HID standard.
diff --git a/drivers/hid/hid-rapoo.c b/drivers/hid/hid-rapoo.c
index 4c81f3086de4..5c9c396fabf7 100644
--- a/drivers/hid/hid-rapoo.c
+++ b/drivers/hid/hid-rapoo.c
@@ -36,7 +36,7 @@ static int rapoo_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	if (hdev->bus == BUS_USB) {
+	if (hid_is_usb(hdev)) {
 		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 
 		if (intf->cur_altsetting->desc.bInterfaceNumber != 1)

-- 
2.55.0.rc0.799.gd6f94ed593-goog


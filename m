Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585939;
	b=RtN47IaRSl1okwdl6D1kJ8X9V6xTXAjJuUu6HsU1K78Dy/LO0UTVfDi58IWa0U2KecJ1
	 jaGN5cqOD8iFazOMUs+XsdnO4Q952WW1AKaRnFsgjc/TKdwmaBd8mbLd570+IRcG4lI64
	 aD0hR9EOLcJdCf89jOggy3L3dEfC+SxOT8w1AEyT5/A1Fdj72Axirdyvj4hi4F0iep8cI
	 LzNFEAOIx0LAG8cnlCnsc6YDJ3AZDIsvUYwAhrFYUd1vF0RCXz9Kpa5l+u220v+mdlQH6
	 xtEHeODN8o+I1Hr+t8reGZBRdZgY2ZwHYKbNCZqPZNa2SGMbd0SzA9bd+gnlsvB84sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UlfXExQXyhG92dzdrPUvVvWcK6W0MmRTGKrmc+yyUUM=;
	b=YZhj+zzmBXMPxjTcVf41xfEyNXA4VykuJIQru2PY/jWi8F/Ln5I5YhlqTx7v3LdWlyCi
	 LgbewrwboitQjTsbo8MUUhjYwGhD9Qdh84k7vATN2tjdn8zF9j5ccGDy8U04Obn7niFXt
	 rNueOPxf7o6x/xzM/nlMesva9tcF09oFWHEefxe8XWCmdoVSO7/CCDFPfAYWtXOHq2tKh
	 EtPHZjL4Yuy4RThh7HUSfwGvUEsguSGG6yu4Y2+gnVHLbFinJmXG/Y+YGs5W0iNlBd4oM
	 kieZJ7y43GmR8dn+S/rMeUb1f9DPPJ0vgtmrDZJ0te4MkAp9AKAkLz64D4pkhWN394A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aulBXKiD;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7888160A261C
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 12:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7888160A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aulBXKiD
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac63aee1ecso196018a91.0
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585939; x=1793190739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UlfXExQXyhG92dzdrPUvVvWcK6W0MmRTGKrmc+yyUUM=;
        b=aulBXKiD6yr4+Lpo4Q4fQnuP3c62bSp5gu1WaPr9X8F9pBH63WOXP/HmOkj4tA/DwI
         f7c+9Qq6K4JfLf2CYYTlYdL46udovCZHsZWK/oNBh6GLjiX3+rEsqpwMci1cmV5c7Obl
         sImwte7h80qCmdOB7fys3U8uxsuPplW46JMjCp4eu+qEo8+jawjt2Hw9FeABGniYE8jb
         D5+ftqdXwL+dUVqZTyIVXoHUT1S4qYwTtZQN0x23TbxP5hxJ9RgWJXXt540R12rQIK8h
         ZX8ZXNl1Tdw6+kc4Dal9QyGsURqGESjBd2mFgmcBYQE8keRxvJOT6FnKKDAcKZsRsSjv
         4CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585939; x=1793190739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UlfXExQXyhG92dzdrPUvVvWcK6W0MmRTGKrmc+yyUUM=;
        b=FHUa4JAGgJD4ZDIR7w9FMy5aoFrc4e+N9J4gi1zwA0mCBPOZSDkXtQdur3qpyjIFCq
         jt/2Zk/uQTUDuPOioOE33oOqW3Eaby2RB5zVgaIew7YoOvkIQfPzdQoJ0ADhz19+zijf
         O9hjbgnJMuIwZ5wsOdmaWx8l06/mXmPtVC+vzG1LWPAECSL78rpa4NKP5jmkXIWQ04Lh
         k00u61FaHNBetwAq/SyGvvGN03DKf0v86IVsEpdzowmwPGbtMLZFrC1IzWsCv/9/vBQ5
         XONIo5BS3brDSLdZ3gLSUcocewATjR4c9yzMZ7mB7mQFRIPHPWfxhW33odbttgclvGKr
         r4mw==
X-Gm-Message-State: AFq9FYJC4w8jy3lT3rK0KHh4d9uPKw7jPzm3URboV1i7zNDtGd75nu5+
	pSS5RG6VYzqXZcaclCMVpR0BR8Zt6b0jhN/7EVhRx9hOPORzx42eWXoozVeAA3RLcRRLGg==
X-Gm-Gg: AYBFou37nH1modt+TikOAB6hRibm/MxLkFPJ9zMKJLZZMO8KYZRrLJQ2RqiFNsjconS
	KBUJ+sPyFIaKUTiU7JuMy5QZ1t9oax1i3A9avf/R0ALcV/n2EP7tDSzdp7y3/FtlNi4+Np6kR+P
	zx/Q9JCYjhYfKcJdksnyNFeVm1CHK0C26kBdpA64AZVP6H8FI7B1sQoNxtm7fZtB3uEFGGFIPHi
	8spsnG+DxhhegRPNS+kLUhBoJQ4N0aA7Lx9T4KTX3qRvIBsCzFYJZLWWLqi78CaOdvv4+aB5SeD
	+RNnNkPqCCRJPBV2c0qgBKI86fzsUKXuLME+/oVhxEMLTcjDI+WHbRcTKjKeofAymmHuKAp4FSE
	PNL0YEwJcVDVbqk2tNIuSrv1ly28UEfRi+egSoeYvauQuLL8B8dQ0eZ0M7Z9B93xeQs4X34joFG
	oN+nzzhVQ8Ww5r0gTdPh+P78sUWEMJLj6gvvBMi++CVFtsVVFGXtFdpbXJOoMc6LW1VS2Em9L9h
	irTxdURK1e+4ntt26On4ZqoWS/W+/fIBdT/czHBtXHFxK2ZPpISWa5WbLLWmuMLUmLaheUAcA==
X-Received: by 2002:a17:90b:4b03:b0:3ac:80dc:f40c with SMTP id 98e67ed59e1d1-3ad86e9eb76mr1566540a91.14.1792585938937;
        Wed, 21 Oct 2026 05:32:18 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm4229523a91.15.2026.10.21.05.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:32:18 -0700 (PDT)
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
Subject: [PATCH v2 6/6] Input: touchscreen - use usb_make_subpath()
Date: Wed, 21 Oct 2026 20:31:46 +0800
Message-ID: <20261021123146.17202-7-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021123146.17202-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
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

The sur40 and usbtouchscreen drivers build their input device physical
paths by appending "/input0" with strlcat() after usb_make_path().

In preparation for removing the deprecated strlcat() API [1], replace
each pair of calls with usb_make_subpath(). The helper formats the
USB path and the "input0" subpath in one call, avoiding a separate
buffer scan and append operation.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/touchscreen/sur40.c          | 3 +--
 drivers/input/touchscreen/usbtouchscreen.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 77ec2c94b91fd..7702eead123e2 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -690,8 +690,7 @@ static int sur40_probe(struct usb_interface *interface,
 	/* Set up regular input device structure */
 	input->name = DRIVER_LONG;
 	usb_to_input_id(usbdev, &input->id);
-	usb_make_path(usbdev, sur40->phys, sizeof(sur40->phys));
-	strlcat(sur40->phys, "/input0", sizeof(sur40->phys));
+	usb_make_subpath(usbdev, sur40->phys, sizeof(sur40->phys), "input0");
 	input->phys = sur40->phys;
 	input->dev.parent = &interface->dev;
 
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 0bbacb517c286..fd2b896675dee 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1512,8 +1512,7 @@ static int usbtouch_probe(struct usb_interface *intf,
 			 le16_to_cpu(udev->descriptor.idVendor),
 			 le16_to_cpu(udev->descriptor.idProduct));
 
-	usb_make_path(udev, usbtouch->phys, sizeof(usbtouch->phys));
-	strlcat(usbtouch->phys, "/input0", sizeof(usbtouch->phys));
+	usb_make_subpath(udev, usbtouch->phys, sizeof(usbtouch->phys), "input0");
 
 	input_dev->name = usbtouch->name;
 	input_dev->phys = usbtouch->phys;
-- 
2.43.0


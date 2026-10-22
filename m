Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653025;
	b=jXI9su/O+J1madx9GZyp41PrBSSOCS0KeKOjV/1NJhBLnfl+1fsCCrbgvFLHlRWwwhdk
	 GbzhZuY9b+ppDEnNe7wcS7/JJ+vkVJqBJ4RaPvPLgxA5GeIBJX8gRezUaihDGDQcUkp1j
	 rfkSmOzT5JeMLnmkojE04no2bXHesqwbTvX/IM0uSM/fXsThSF1rW9tppDyUL7gJ6th++
	 KV+t3w34ZbHC05s0ZSF/T0nDRt4A56Gh+b2CdUKrmWGrgLYgkytXiOLtzIHBU+0xoMXMw
	 C7kYmi7oji/UOEV5DQC0krE+A+s4C+fABhnyCXi5mhmrKkxq/6tXH2cTYAQjSrykxhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UlfXExQXyhG92dzdrPUvVvWcK6W0MmRTGKrmc+yyUUM=;
	b=fFazTozXvfOqEazPjxgAXkvNY5bAIhJSLvKLrImxY0n7I2Fa5IAS/VJY6ftdt+hJ56uX
	 16Z9fNtxcNLoN8MEL4dxStTzFREun23jZUKOEYkpr0sXLLKeeYr+AmTELSP6uDE2WSViW
	 ydq456b0D0gTdTdxq2O086PsDwdv3kKdbdPxhOQGYNvnMhmUbTBPx3je2xQUpf35NrLrC
	 n5oEP/EFYwrpnyHnbcuHtMqtrRRQQEy99z7YBN83UzJXw+F/rySUdUSVZcAVdP+nXQuZc
	 KTDlNPgE1B0Est9UVUTPfQewhjGUnBw8t9JfwttPSPbN/bZQxsEvQqo9ZtAKFDn35NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qFUMBxMa;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D819606A31B
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 07:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D819606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qFUMBxMa
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e61817b178so5430145ad.1
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653025; x=1793257825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UlfXExQXyhG92dzdrPUvVvWcK6W0MmRTGKrmc+yyUUM=;
        b=qFUMBxMaK6CdgDBTyOpMWCNdcpfDDqGdiQLb/pR1oPQYi6CKaowEzQBpBV0iOSwnVU
         n1Ka8uwLGD93La8MP63IB9EKMndadwJWLM7vk+135dSsI6liSrGFTLi4UEh/YQQ7xHUz
         3L2MDkQdbK//LlcZEuy8jJr3RDvrbPp5fMWbVh6w3HBe5W4Pbq6v2FYBAt4FVakfLI7S
         amDIaOHHbjSRjkCVAnCyms2ivFmTinl7uvmRVWJvej8mlaWm9ZJHDdP+vwW66PKEJpKf
         YE2ngiPpfMh5FrXMlWKX2s23wVNEs1a1hMVnfPih+WL79F4ZIlp4iekknikNaemb6weY
         nLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653025; x=1793257825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UlfXExQXyhG92dzdrPUvVvWcK6W0MmRTGKrmc+yyUUM=;
        b=EsPeq5xGhg6+cmU+obw/ceyOn0B90xqs24JI4lFcIjIWwAX9vnZF/L9FnWzRLHwYH3
         1WIZtq7D3Bvi7lWOaZ65zYP/iqf2DpO2jiySp/v0lwJnYXwsITAtpT/BfCuWqlX1lcSN
         KkkfSdcXOc/7j75cWMpXg7aRalvZ3N/tJH5+Cf009bOkW+Pf7N7Bocf7+ucXHVeYa4Qe
         ZNV0cMKrKY4mvhe3xcYtLTltdeCsMpkO/N4/Wqjry99YlnVqoBcb73Kvq9csUJwPd+VN
         WnEA8jDcpUQY8Ybb9x3QpBJpzPIx2IszhAYsBimv2TDLEibAkKWj7B3UFKfURrZNYU5k
         Tbug==
X-Gm-Message-State: AFq9FYJ0LgsZpwHza1Xqu7Ng6witGyoopIAeqomMD58/ZYasPONQ9p0g
	013S8yX0IPkRUD/YgafAiOIgpPOCHgW7OvVss/v1cz+ocoxxuwQL4ZpQdBa83gZQ/129AA==
X-Gm-Gg: AYBFou2D+AwdLuoGhcU68el5igP1j3Pe6JMYpnL/w8jjJ0nVPZeIEeYcebA2BZjnqox
	PZWH1S9he2iwcXkyRfpfmkp5yUrC38o5SEouEsWw0kBOcrahRiBKLK1Tpw6Wkx6P1d26/ezyTt6
	dAIMqbQbRCMSGsrGQOqR/Cuxztk2X3zio9xpdgkDOkdKbAz7LGKtmBVdY0xhkJ609bD0W+pOeLR
	OeuGTqARe40sM3CpTBjq19bQZJfAo3kH4sxoO+/B4vlGbdxKPffT8KnaID5CetfQQETpjA6VFR9
	Cwrakbs4D/8/84hAgV9ZVuQ8uavAm2oaFuWoLl/JszLnhjJxtGjcExaLkiMCdK4Hk37qklGZsFE
	xW9go9BIIn216ot10pIwpI2Wpf3UmNCcLUj2lq94BTP+hRZtP4t5TUQVjMDiryqL0CAkvzC5FRr
	vUyuzvVC0xzBwbs+R/IE+bvsPoO0D0Il9ehccy/0VKDpqEW/gadgvqXlf6gdlUpE9F74/mHItPM
	olAhbXo2YdsIB7vB5A8STwSaAJ8ZZzkjxVKWvZ973GGzE/+ADRNW5Ne1/XzMP+iA/98k6l3zQ==
X-Received: by 2002:a05:6a00:2e17:b0:89f:4cd9:241a with SMTP id d2e1a72fcca58-8a089d45677mr3426736b3a.41.1792653024539;
        Thu, 22 Oct 2026 00:10:24 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm1706039b3a.12.2026.10.22.00.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:10:22 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Alejandro Colomar <alx+linux-hardening@kernel.org>,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2 RESEND 6/6] Input: touchscreen - use usb_make_subpath()
Date: Thu, 22 Oct 2026 15:09:29 +0800
Message-ID: <20261022070929.20820-7-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022070929.20820-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261022070929.20820-1-shlomojune6@gmail.com>
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653020;
	b=H0WRQO8o5EEYLhJudAtcjufD8tkpxNmf7ujTT5aRXwHJRm8N3y4dzuxsnC/VY5K041MO
	 gvM5zbMtxX0wBhM6MoZqIKZj01Afy9inPSJhqi3HtT4ZAvzz5vv8EZjY5Ik1msXIsnzD6
	 z0M2DqVJjpa9CPulsfEsLKgHOR0+DeRxOGipulwJlLamlDpOMa0hZMx75qgQgisd2AeHS
	 XR3hmqa+5okuEnrcoI0DzSjIKafmHojiolQTyHw9VTiF/fGp7b3kz0kdYyYwymw9Mna7B
	 I9FiNlA+IwXoo8gj/kJq3Zrb95sGL5n+TaMsBxu3sZ5yFD3IrPOxmtC7l35ZqfXWnWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D0jGTVLtzaIFDc7gI7x4v6SVaJxQo+nXgqAY9AHPQIU=;
	b=Zre1foWdzUFZkZnQiL+p5+stVHPBofC/QknzFzAZhNvGxKzKPIlrtN13O9dUtkD3EByy
	 WytrPTDC2Hx8bWNMiGSrzaAQgJHkEW5H7kru4giAxJ97m1NEaSBdhj1lOHwjkvU3urMk0
	 8fnDkLrn/cz7b44p6JjVEtvQW8AyTMgomBEAIkHWB/dJsrqHe4Illipr4xBI7tCD7+k9j
	 VcIYoalnJMvDZvClp1lunC7z61MEj+4qg5zmlcAadRMnucaXBseOhCyVz2teXlprn5bjX
	 //WtVWS2CVTR1kMM5YDxzYOBXPOSpALqW+1tE4s8y1XL53eEkaWf2zsBPufjreCsb1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kiOVV5e6;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10659606A319
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 07:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10659606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kiOVV5e6
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3abe4821449so811458a91.1
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 00:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653018; x=1793257818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D0jGTVLtzaIFDc7gI7x4v6SVaJxQo+nXgqAY9AHPQIU=;
        b=kiOVV5e6J/GurhcFbB5U4EjybcgG1yzCdcXX6qqqH3B8pLf4zT2exbjzkKeu3AkOYG
         8EQtoM6IijOclz7ZN+NIncP26KuaxJ7N+oPIIOX7hBIcv+ggvbWqc0diJmRQwwrOvOkV
         K1nu/SzFLysQ/vNIBbzqL3nJP6HzHiBXc/QTPIMFjM/XRDVc+9uKy4JrWsGJ/VXcAauC
         avfVAKZ3pJKSIk8FLonvgP9p16ZOpzTUbwSWm1ROEhgcbPkvIjW/Yg/jhy9zhVDLSozb
         udFqaQiSg9Q/PTrYCbTI5X34jL4OHBO9pFrN71nfLTVQwHw5oVidgelNT+DgEBwu91YE
         Y5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653018; x=1793257818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D0jGTVLtzaIFDc7gI7x4v6SVaJxQo+nXgqAY9AHPQIU=;
        b=d2r/D6Ct3AmBKAOxkTmTXj8fezlarJmocJLnLxBBHzZoLf/c2QX20PeJnMw0755XWq
         PG/0W6ITtspYGQPsNSos2kWzxdErCvSsJf+ODPCRPIuObGx9b83tcg60luPR1/URy4Qr
         ULtkYWUXKS9WCvHqpIOL5QGL5ZMXJcmtgvU1ZhuHBSFEtwsNuPN2N5DS3qRNqdpHPq+2
         WtZtPW+y09ArjN2kX4O/Z1pDKDPqOCbrRPMmmL3clsHUSPs165V29TG1f1HMSC+V6j8S
         lonu0fEp2j/iMxhMn4YE6J0aAZTXz7kqoqq/Ngh++j3txEuZROv47ELa/HHemy5/EJGF
         Pdag==
X-Gm-Message-State: AFq9FYIMc1NEY7C3WIQfbUGr16hZmIRTviWqAkG9EaFswxiLL4Ug8Ch4
	WzyMtnbkNMhTvKaXyKL8TzOOCeSTifCNf6Uw7bLHOj/gK9uccxuMqig4pubppX4A1ER0WQ==
X-Gm-Gg: AYBFou33Tqk/QuS5ociT393R65v+XKMoXIqBnbNOIeCz6ZJ3U9ywtC3ZwWitXd+Rt7+
	mXnVqwm/jLrD/tk6HlRzT16Z2J6SMb+Zb4k6DVdUHYhw7nMV22AnGDid6XD2ZWsw2AaOmUNzdlA
	27X15dqP+QN1cBiqGVyi80k8+/ir5j74qPFwzF3cp0+wEXYUX9/UCUGz9oNeKNdUipTAFGIV1E/
	2j2kql8y/e+wsqgjIm1znR8mpY9swoRv/L09v+AziM8bTt6IG0PX5Ki9unXk/H4/fi8BsesyvvZ
	PMsNK7mJHkXGBrWzjAGkfuUXtIuH3pzuav0Ew9i3ESppkL62Tveiar3xI/cdd/bVtZ/38epMJ9e
	BX93fS4xl56mnTZW08LEM22KbKcmeIyWE6gw0m3GccOPUHmHMfGOM0rfYkiVneVUKDDTEaIqqhq
	DmaPzi4F9JskclpJpFNtBdvAB5XrJgI+K7AHOMzMS+6jHp1NxZI3ZmzsouRAqw+IxgWAJB6AavQ
	YLTjdI4XvCN2KmxX+JajhV1n4LLa8MZD1L2fuwFkAlftFMZzKoS4JZCyzOXIWyKJVaM926Juw==
X-Received: by 2002:a05:6a21:4ead:b0:3e0:df21:9de5 with SMTP id adf61e73a8af0-3e287dbdaa0mr3277689637.35.1792653018511;
        Thu, 22 Oct 2026 00:10:18 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm1706039b3a.12.2026.10.22.00.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:10:17 -0700 (PDT)
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
Subject: [PATCH v2 RESEND 5/6] Input: tablet - use usb_make_subpath()
Date: Thu, 22 Oct 2026 15:09:28 +0800
Message-ID: <20261022070929.20820-6-shlomojune6@gmail.com>
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

The acecad, aiptek, hanwang, kbtab and pegasus_notetaker drivers build
their input device physical paths by appending "/input0" with strlcat()
after usb_make_path().

In preparation for removing the deprecated strlcat() API [1], replace
each pair of calls with usb_make_subpath(). The helper formats the USB
path and the "input0" subpath in one call, avoiding a separate buffer
scan and append operation.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/tablet/acecad.c            | 3 +--
 drivers/input/tablet/aiptek.c            | 6 ++----
 drivers/input/tablet/hanwang.c           | 3 +--
 drivers/input/tablet/kbtab.c             | 3 +--
 drivers/input/tablet/pegasus_notetaker.c | 3 +--
 5 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
index ba79dff21aac8..c12b0a0181837 100644
--- a/drivers/input/tablet/acecad.c
+++ b/drivers/input/tablet/acecad.c
@@ -160,8 +160,7 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
 		strlcat(acecad->name, dev->product, sizeof(acecad->name));
 	}
 
-	usb_make_path(dev, acecad->phys, sizeof(acecad->phys));
-	strlcat(acecad->phys, "/input0", sizeof(acecad->phys));
+	usb_make_subpath(dev, acecad->phys, sizeof(acecad->phys), "input0");
 
 	input_dev->name = acecad->name;
 	input_dev->phys = acecad->phys;
diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 0c1acb9e6b437..cc68ee82c12c3 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -1705,10 +1705,8 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	 * & a tablet, and the inputX number actually will tell
 	 * us something...
 	 */
-	usb_make_path(usbdev, aiptek->features.usbPath,
-			sizeof(aiptek->features.usbPath));
-	strlcat(aiptek->features.usbPath, "/input0",
-		sizeof(aiptek->features.usbPath));
+	usb_make_subpath(usbdev, aiptek->features.usbPath,
+			sizeof(aiptek->features.usbPath), "input0");
 
 	/* Set up client data, pointers to open and close routines
 	 * for the input device.
diff --git a/drivers/input/tablet/hanwang.c b/drivers/input/tablet/hanwang.c
index fd5a7e761dcc4..a9521bbc89646 100644
--- a/drivers/input/tablet/hanwang.c
+++ b/drivers/input/tablet/hanwang.c
@@ -350,8 +350,7 @@ static int hanwang_probe(struct usb_interface *intf, const struct usb_device_id
 	hanwang->usbdev = dev;
 	hanwang->dev = input_dev;
 
-	usb_make_path(dev, hanwang->phys, sizeof(hanwang->phys));
-	strlcat(hanwang->phys, "/input0", sizeof(hanwang->phys));
+	usb_make_subpath(dev, hanwang->phys, sizeof(hanwang->phys), "input0");
 
 	strscpy(hanwang->name, hanwang->features->name, sizeof(hanwang->name));
 	input_dev->name = hanwang->name;
diff --git a/drivers/input/tablet/kbtab.c b/drivers/input/tablet/kbtab.c
index 6ce70c8e2d7cc..f777118ed7c8f 100644
--- a/drivers/input/tablet/kbtab.c
+++ b/drivers/input/tablet/kbtab.c
@@ -137,8 +137,7 @@ static int kbtab_probe(struct usb_interface *intf, const struct usb_device_id *i
 	kbtab->intf = intf;
 	kbtab->dev = input_dev;
 
-	usb_make_path(dev, kbtab->phys, sizeof(kbtab->phys));
-	strlcat(kbtab->phys, "/input0", sizeof(kbtab->phys));
+	usb_make_subpath(dev, kbtab->phys, sizeof(kbtab->phys), "input0");
 
 	input_dev->name = "KB Gear Tablet";
 	input_dev->phys = kbtab->phys;
diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 85390ae423076..28fbae98f7399 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -354,8 +354,7 @@ static int pegasus_probe(struct usb_interface *intf,
 			 le16_to_cpu(dev->descriptor.idVendor),
 			 le16_to_cpu(dev->descriptor.idProduct));
 
-	usb_make_path(dev, pegasus->phys, sizeof(pegasus->phys));
-	strlcat(pegasus->phys, "/input0", sizeof(pegasus->phys));
+	usb_make_subpath(dev, pegasus->phys, sizeof(pegasus->phys), "input0");
 
 	INIT_WORK(&pegasus->init, pegasus_init);
 
-- 
2.43.0


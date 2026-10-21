Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585923;
	b=C/ZDIHKI9cskaiMak83LCXlzjXucx00sNK0/A1dK6v8hLlpLW8gzlq49FmUEFMYbhI6N
	 WsJuThcyfXJisVa2i5zNv5Wjt33lnJaI20LbN+cW913C0I5r4iAb8ynol5BOM2wf8non1
	 cnkZSk1gNFLoks/gnO8ghZhLOBbRVJkSR64512rDEicyX600ckBcnUp1UsMbCOUIQcTsG
	 m2/Itzf7da5CflpYgOesYu7RryQ7FeSwE59idrI5nlgG275tcjzz+zOsJPuJqCZMtREzk
	 kLrySIaffvHpBJQywWRPsYMoVwQ5CdqLK6NSZQwFCX1XN2xT5wVh7ucdP5x30TYXS8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sPba+bVamvzTWQLnLCNMaFu8OZtPQlAUYLXZMzIXg3E=;
	b=qypBWeu9Kx1WWpzYzKiwQgq33jVDlS8XIF/3AbuKJFSoffYlO4GN6P3EpruLY96iu9iR
	 CLC9kxhRZ76X0D/cUrrgU8PgR4DteaKlr0jb4X/gnS8d1AixdPE1TWNDTcV7D2dS7iz6m
	 GlpRFR/MGoJ3Ew6kiAjVRuw73DFUmr7fNd0mrjS7LAitEjPyxzVEyR4JXTWso2ngz5G0l
	 BxjnlI7y0XEq7clj0cjjasyXHI5/PptTFkTFbZLzfATHkKbV88iXfZPV5pRWv3RouzJ/K
	 La+keSBifNjvBMHSEddxH2EpZrW252DPuGtcst3iH4JNQegL+I3Etjy+FCGzWA9VkLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pyKK+ubN;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727A60A2614
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 12:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9727A60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pyKK+ubN
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac63aee1ecso195946a91.0
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585922; x=1793190722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPba+bVamvzTWQLnLCNMaFu8OZtPQlAUYLXZMzIXg3E=;
        b=pyKK+ubNg2ugvEiozcnh0bkIjd7S64/hpGWpkYQm1AAeaOxNzuSx/aQ3gWBSrfKJ7T
         EWkXp/iFEiDA//sZrdJBHS9mssG66AQbKTkDlJnXepPEbSGHX7hm8gJMbnJdAhflq7Bt
         lMcqeE4aA3lvQf5W49uv8lNZ5SrH+lE+GWjr1jLwih+H6J3MSLWmh0eIsYnpbOHtGjpF
         3un1ctZsA0M9chdX6rO3o/dC/1Pmj0E2TVBFHvhH237+1JNCZj8Quj3lcZ/m+r+Fe9lw
         FKJTAWR0j+NIw/ztyfwqpfQA1OdPRtE5W17l6PSn7Wj/EJVpp36ybi9r8s8hQVxXjf6w
         ZypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585922; x=1793190722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sPba+bVamvzTWQLnLCNMaFu8OZtPQlAUYLXZMzIXg3E=;
        b=TebcthzR9F+DtP112z5KJvURjwr2dp9y6hryXEafGR2JiMkeFzxHE482tU6v/PH+E/
         WPcljjf5SY+UkZZ8V1zfIj24EMHr+Kq/1SBJXJF57gYWXi5bfaW9Spjq7+8i2Y/UiPJn
         61YmGvzkxlBIS+EwlGLAvTDaIcVmIpg3e/2F/29A/ELHcWXGYoYMkajqkW11C4B+4/Xs
         LQyj0pmR2usATPQxJeTC6WUMSHY3oCJOi9AWV+ATRgLjnHE9KoEYohUXYnlDzOGylCC6
         Zex+e63cdDoI+WVx0zIC0EhXh4tEj+aswhQaREuEUB+4NC/24s/Kyta3jKRqEmY2o9a9
         CTLA==
X-Gm-Message-State: AFq9FYL/AMgma7L4nkWJxLqAtn+g2ckIn+E0KqtGZ3vwSUFFDFuEb8sZ
	XMJG/IUWTGx2lmOgdtfb3dHR+HGizKXxqwEVvSfpGMA+rDdBcoONjUICX6lyDYkL
X-Gm-Gg: AYBFou0DMGG8LrxjzXmwYeZCGjuWoula+6vygP5UivqPDOz5nd1/it8zNieYqjm4vT9
	f4OpeHmt2ih/XHzF5hxhz+JHPwrYQ5U7wVV5+OZ2zN4ihSA5UiOngWzbiJTZR1HYmwundDm9EB9
	4mY4QEk9uWihHtc5ey2RnOFHL+xm5hkLO57eTf02lMeKiFZB3HzALTsy1T+dPnv1bMbRk7d7lE7
	/UpJo/r7oQ4bCeBEfbbKJ2sGcmd0JAihY+7R32p+6lFXZiZH3/ntqJ21aBNfqLHGIhFZ3wcbjHN
	xDXKkDgcmzKIOfxTMHqRGb0tMYJPHuGt0a+LRRe1wiynTZsm22GVFl52gsAaaRTG8PAjzgiNbWu
	D0Z06Mkxv2qljsoDd1r3PfFTxIJahuA+ezkuQc5g6Ic15IyHcy49ZMvjJBrgCqXKKY3QiETHyiX
	9a6vnnLVJeMUP0bHccV8b7DzHHxEpsV1jSdtKURFMAmPk5lxZSfuj66RztjisrOskSlZEp3kRO4
	BBBS9qlwvLCG2YtMyFFhR1T4nlxPHmrbYlAdwfjlN9vRawLdGFnxSo1AUIC3qmzdTBo7ywhtg==
X-Received: by 2002:a17:90b:5547:b0:3ac:80dc:f40b with SMTP id 98e67ed59e1d1-3ad86ed848fmr1597600a91.33.1792585921869;
        Wed, 21 Oct 2026 05:32:01 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm4229523a91.15.2026.10.21.05.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:32:01 -0700 (PDT)
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
Subject: [PATCH v2 2/6] Input: joystick - use usb_make_subpath()
Date: Wed, 21 Oct 2026 20:31:42 +0800
Message-ID: <20261021123146.17202-3-shlomojune6@gmail.com>
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

The pxrc and xpad drivers build their input device physical paths
by appending "/input0" with strlcat() after usb_make_path().

In preparation for removing the deprecated strlcat() API [1],
replace each pair of calls with usb_make_subpath(). The helper
formats the USB path and the "input0" subpath in one call,
avoiding a separate buffer scan and append operation.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/joystick/pxrc.c | 3 +--
 drivers/input/joystick/xpad.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 52d9eab667b7a..1a11e73d7cd04 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -169,8 +169,7 @@ static int pxrc_probe(struct usb_interface *intf,
 
 	pxrc->input->name = "PXRC Flight Controller Adapter";
 
-	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
-	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
+	usb_make_subpath(udev, pxrc->phys, sizeof(pxrc->phys), "input0");
 	pxrc->input->phys = pxrc->phys;
 
 	usb_to_input_id(udev, &pxrc->input->id);
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834e..0f7ca5adaeee7 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -2059,8 +2059,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	if (!xpad)
 		return -ENOMEM;
 
-	usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
-	strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
+	usb_make_subpath(udev, xpad->phys, sizeof(xpad->phys), "input0");
 
 	xpad->idata = usb_alloc_coherent(udev, XPAD_PKT_LEN,
 					 GFP_KERNEL, &xpad->idata_dma);
-- 
2.43.0


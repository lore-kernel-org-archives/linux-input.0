Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652994;
	b=hAPspQTvjjeKkOGvLFkgyH2Z0Uepb+5VW6oiWSFPbqMWtbqOwPfMSvUTN4xNnnmtD3en
	 b1ZqVCVj4OWvQhgjThH95YNHDMbbBwmvmc/eYBwN+npGdtTRIYnMgDVKos1q28ZMcjlyR
	 BC+JbZ035NbEosv0SnNyytStQmSvU2590kQx6sxl2yNzkxXwIvRuNcBIE30Nk1khJMkL2
	 A2omfW73HxRB2kjEaSlKWvRzXS0XjXfyKBvS7aXfE8aPer1t0ectj1wGGUgpMAfF45Xt0
	 ixluK50lHtKtQhZir1ejie+SfEgfW2hKW0nIYQXuVpyJblLxBwWpv20DMFyXfFumI/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sPba+bVamvzTWQLnLCNMaFu8OZtPQlAUYLXZMzIXg3E=;
	b=nQ2E1F3nNqBuUyHcuTrefUloruJrsVVo5gzAjuOiMzGsI+0qNtvEnCFvAs2n5dBuvBhX
	 tmQUhfqghNdXKXPRQQuTU7qXf2p+OhzAlJhTa1Wh+OJ/CFz6V0trHjMseQ+Qdvq1WsBvY
	 obt4EsWXEYt1v9lKH9pxmOfdvBEAdNMs+nslgm/vDMRbNNEy2WrvBHRnB8rRPh61zD4Kb
	 OQyp1c3KTXidYENyzcm/WW9qP08DtjLjdnRFOdPvD8ov8CD5bNJHIAIJUpbztBu6JD+Mn
	 jCQ7dyVSWjmIil14HQKE5+rhPTDqgAKLnTT0m1TZFzETq37hyrLRvNC8j9GNHnDDnpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LfFqZKDm;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B00606A31B
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 07:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8B00606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LfFqZKDm
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e651c30dcbso5603335ad.0
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 00:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652993; x=1793257793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPba+bVamvzTWQLnLCNMaFu8OZtPQlAUYLXZMzIXg3E=;
        b=LfFqZKDmN3IkEYK+7q2FvrK/3CegeBNZEJauHae1T8IS20pFOVebUIFqmutLg9n92W
         6qIlk2b16QL71UYza628/9ngC8xGLUa3KuyE2zYLj7R9ElYEebezhI7etJy8oAC2OknG
         QWS5/c5kCqR8NHnjHOaqEftbICkjVWxRYobYX8x+ii8E5kCKB/XyPDR6m4Y+dkxLgFtP
         EomvUv/odZgt3vI+zqsfY06aAhHoqLSD9KctJZAJo37BlTylH9FRRABfEc6PLQvWKO5m
         CgU05NpshSmjPywVDRXteb4OCbazQhxcfvWTa9LowpzM+IkoMyHu+LtKQZTC94Y7VH3j
         jmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652993; x=1793257793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sPba+bVamvzTWQLnLCNMaFu8OZtPQlAUYLXZMzIXg3E=;
        b=HkeqKrKd8tzy/d1qQ6j6HXnzkOi7oi8D2D+d3WgC9jTyttwOewWntfUkfSMyt/yfuh
         N4GZwLhDllIHR2rYXNsWCaBtCsmpiv+DBKPkbqvEcDELFv53TJRBGQBKripKJ6j8twPT
         /ddpnlq19RfTKwCSjvac0OZyIxsRJvUsQH0OnhZceNVsHVib3evG2eYFmV9a26imuCXK
         jeGeUb4OXIM1pa7SGAKHygw4Uxg6EPhRK4J0zJ4WLUZwwW8CmCh7rUdAorRHAU4xY466
         jcpzi0cnmIaf50dssWOMhsZPNxxYG7MjzWPnJ6fq/uQVOHdbTJ4Wokwi8GZzEwBkAeUt
         asBA==
X-Gm-Message-State: AFq9FYKiQ34nfxYulVCcUVxf1j6dH9626SjVhDtoF1umFvmb6OwcZRsU
	uCseDbui0OKrbBLCGS19LpRAj9741G2nXhQTfj+fDaRb1fZk9fQxvg/AGQHu5PjVydAi5w==
X-Gm-Gg: AYBFou1Q814PwuCctIhJqvtf6p6bX08HCOQJ0+/coxcn6ACAf7aSVaL/iflXeGNdRCs
	uz05vIM9G98EWMqD/U7ykJ/5uSadQ29SQDwhd7+JBC3awvW4B3i6M0v2QaJLhlUukAXhB8CySmP
	i4yydpcfYj4pIhyBGNLbhAxLhrj6LZqhS3ooKr09DB6vMOQ3l47fS1j/Wz8/QZLiNCKwqP6PQ9D
	CInE44NJ+nMHHC+Qk9cf0cilybcTZ5NVj0Bwkd/o14+sM9IvUmJU0ht5+0w6DD9CjvM0II023/b
	N0/Hx0XbFF8OimRXSeHMWksfSESPJP8zJ2HMI5mmkTzc+wJYcRl51fv+Ap8kufxM89ho9VImKIf
	qKuDb2r2qCNhCWTTYlSuXKE0uE1AgvDz+znSWzUvGlBPMACtKdk5aTCfG7wBdIJO4GervYr2ANn
	AIBmb+8A71Utv0agnWWzgME+WOH6T4tVDKrcaH0+1SBuYZXgNCrxlk1sNBbyzwNJhXlR7OqvfQn
	LRy0lHNe9P0FJ3qH+eUPhpmgb0Chryhn97qBsJO+rD+NAjPZHAr+JsnQ5KqZ9uON/NlWbwONg==
X-Received: by 2002:a05:6a00:420b:b0:899:3439:c8d5 with SMTP id d2e1a72fcca58-8a089cefce2mr3629799b3a.14.1792652993119;
        Thu, 22 Oct 2026 00:09:53 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm1706039b3a.12.2026.10.22.00.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:09:52 -0700 (PDT)
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
Subject: [PATCH v2 RESEND 2/6] Input: joystick - use usb_make_subpath()
Date: Thu, 22 Oct 2026 15:09:25 +0800
Message-ID: <20261022070929.20820-3-shlomojune6@gmail.com>
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


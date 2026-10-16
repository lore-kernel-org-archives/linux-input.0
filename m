Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F1B53D9C0
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170273; cv=none; b=G9KrPKRKGiR4ROqvWcDia5hQzMMEzn7435bRYj5eODXQPgOkN2Xtf7a9jXd/gxYD0WP0hHwmljw2LY0/PCZnljfQULcmX8Z17oxfF2Z6Y1U260lM+A+RMFnVVvu0S2jjU+6GgL01PJyCvvq1nIdYfO4l7PwB43pZBxxoXFQEL80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170273; c=relaxed/simple;
	bh=RfoITBHU/34UblaJczsB41NK5NQZH3g/VaxCKH1Y1A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuFW9XoWGO0NXRWC5ZYZRJoxRmPkVGmti7WLadF8Zbsa1RSJFNQ3fY48t2V9GB8en1EzqzF7/t7O/5deLjq+DzXo7n6F0V3lJ0AIF9CqmMYrox+mlsfuqHzMyaEnViT3nnHM6X5EMd9QMusfR7f/UV8wtfa1AEh8JOZwWzVQ8wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIKFB+8l; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIKFB+8l"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3ab37ea4798so70769a91.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792170271; x=1792775071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLJ8r+Qkw352j8qkFr8FpLRJS070PYdeAw/tFXJw0Kc=;
        b=jIKFB+8l3+DwwqfX3kzjjhpslR2BFg7T4zPTw+L74gl9IP4iXIiqXXrFJzjhVKGusm
         ogf3CdbvLiQLGH+lepLqlWYN4YAAJSucvQnIXQ2BNYfGYXcTrjPp6jjFQSlCQ1a6OIkQ
         +MWv7WpfJwPi/T4LHmgtRhj2+gNvC4zvjSyxEgxH29dKTP/k6vux+cjkVw91qnM/VTBn
         AN8LvFgNJg7HKLGvR8kGMoRBKrJ+VUHsAyVQSWb8QSWkzM+nW88HL9bWFT7bLx8uhVCg
         zVZ9umEJ6b75ldMNEmFzvahf1BnTKgCec/hvcT2kmfW0neJb8qXdyCX5jd4O0RnFGdgD
         2dGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170271; x=1792775071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLJ8r+Qkw352j8qkFr8FpLRJS070PYdeAw/tFXJw0Kc=;
        b=DJI8sWXB0ZgGJdbULmuq8OEISwX9/FWv5h59zDWAk4AaxrZf+ckqi22014lAWJn+Gd
         IrIT3Xg/d4OYmCGVdjZ0dDEFu3C+omlo5Y8bxbhrSEnB0ilkhy1mjgUN4IDQ0dOvshxn
         E7wToPaFgfnSq8CV0xFN+zTc/7cjy4bY3D1IBES/UVcnvqBAHkuwWAPDgdgHGYMjlpt1
         uT9q3KZOpMZUT5O8h2ZVpWNc6F5/tOBwOjfgJ0fKX5PXJfwSlshnoWIjyDUaEgpG5lUr
         IZsVsBkD2pdovWYf8ecMsf6XHf+2+fmFNw/Ixa8xTVYtO78BY9QcuQaFe5QNbv0Auq/H
         /BJg==
X-Gm-Message-State: AFq9FYKaFSZKj5jSbjQUINXlJSL3kja4LRcVLXXrWFEo/W9VCjJR3ycu
	uDZHhnZzP5Qj0pJu/DdzPdW83QOdqh88YFqDGppjWCTagkikwQq2HmUmPQ5nTFxjxT3CLpe6
X-Gm-Gg: AYBFou1/HibhCoUQIJnrBPe37TqhmAScgacuwHQrApXHN3HTbM74pel4G/dEl6n4/+7
	ib3sgjae5bjrHDJp+P0pSmmqZgMOoFg5qHU1FX1nH9ke0oVUjZ7ARU+TDX3XKTpkBfBmlIADxu3
	oADtFOQwHfoZ/C969jwO/In6Wi89TmcHTxblFPrDbACbSXq5eTGuWIutB77F/TyqAdXd772dm25
	GMuqihGtuBYuNrnBdC2uvDAV8XJfRZJG2Qhzgd4IzVApVyOvokwf/cQYz9GDt8dKXBVPNYfoob4
	HEtV4siUkB+iF0i3SuwqCCrL8aAIymUBNiEq3CreHA64OzYuPqvKVrkbIEIMnbXzwnRek95z8Ng
	VgqwglP3b7ugGevWKM3YuzjusopK4Ezpa/uYjlLsDwcA9LhLvCsc0rTXtGwnFtHtKyNK5npvIsm
	Z/ppQywMgMttisn6xwXlZihCr4mslYWmOjXnSiiCcZUobfto7MaoxieopB5bY3QCcpVoHxp0q5w
	5rK0xfLwf/TaRg=
X-Received: by 2002:a17:90b:2cce:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3aceefbf76emr320123a91.11.1792170270459;
        Fri, 16 Oct 2026 10:04:30 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([223.104.67.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm9928587a91.0.2026.10.16.10.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:04:29 -0700 (PDT)
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
Subject: [PATCH 1/5] Input: joystick - replace strlcat() with strscpy()
Date: Sat, 17 Oct 2026 01:04:07 +0800
Message-ID: <20261016170411.51025-2-shlomojune6@gmail.com>
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

The pxrc and xpad drivers build the physical path by appending a
constant "/input0" suffix with strlcat() after usb_make_path().

In preparation for removing the deprecated strlcat() API[1],
replace it with strnlen() followed by strscpy() into the remainder
of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
strlcat with better alternatives") did for the usbhid drivers.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/joystick/pxrc.c | 4 +++-
 drivers/input/joystick/xpad.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 52d9eab667b7a..9abda2394fffb 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -121,6 +121,7 @@ static int pxrc_probe(struct usb_interface *intf,
 	struct pxrc *pxrc;
 	struct usb_endpoint_descriptor *epirq;
 	size_t xfer_size;
+	size_t len;
 	void *xfer_buf;
 	int error;
 
@@ -170,7 +171,8 @@ static int pxrc_probe(struct usb_interface *intf,
 	pxrc->input->name = "PXRC Flight Controller Adapter";
 
 	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
-	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
+	len = strnlen(pxrc->phys, sizeof(pxrc->phys));
+	strscpy(pxrc->phys + len, "/input0", sizeof(pxrc->phys) - len);
 	pxrc->input->phys = pxrc->phys;
 
 	usb_to_input_id(udev, &pxrc->input->id);
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834e..4f2bb9ca74936 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -2045,6 +2045,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	struct usb_xpad *xpad;
 	struct usb_endpoint_descriptor *ep_irq_in, *ep_irq_out;
 	int i, error;
+	size_t len;
 
 	if (intf->cur_altsetting->desc.bNumEndpoints != 2)
 		return -ENODEV;
@@ -2060,7 +2061,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		return -ENOMEM;
 
 	usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
-	strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
+	len = strnlen(xpad->phys, sizeof(xpad->phys));
+	strscpy(xpad->phys + len, "/input0", sizeof(xpad->phys) - len);
 
 	xpad->idata = usb_alloc_coherent(udev, XPAD_PKT_LEN,
 					 GFP_KERNEL, &xpad->idata_dma);
-- 
2.43.0


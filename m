Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653015;
	b=fve03XpdEXMSR0gTj3e5Wc5HIiRS6K5t0SMLUWK3+JBtejQxrKXxN57L3O29Fb2r/os5
	 LsH3iK+3Y1zwYos/5IcwUAIrQWFWrfK04j0XDCfUpbPmSnWvnh2/dGkA+KrqKOcD3MLCD
	 CHeWisJJMivw/+h5TQXBMEKM6j69b77w3XgpUjwxcv3kpMfN5MUIpBBytk1faVodevOQB
	 e6kXM7hjFS3seu7L09kAfc6fFk2l1t3SXoTFmiuDPbPvbkY2nUldTO8DJUVx6mvoXZtAC
	 aMxpg93xwUxdV56LvqbKOcuH/kjfuhpSPxw7Hq6ZIi3C2D2bwDg5YH4uOgIhVtW3quw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nnZ0MwCj80U+rG8upbc3A6/J8KNZsuBJGtpG/de36Io=;
	b=h/vtQPL/U6pN0V8p5ixBiVYEdlW5zeTxgAEWmB5q6SItaD5kU+WYbA+VHCTTE4jsLuUH
	 wZwsFhR1UhqCMZ8/QW5mJBIAp8Eo2MemhmRygO/FDH2+chCTYu99cNfnq84V+wzbAeCf/
	 eCaH73g45Tk2nf74LUJItIcngF5/N/nCeFoO4wao4tMIAC9FfxMLkjgJ1Poei5fonb+UF
	 iZvMwKK9C3L7K83ZWRihYnMXCd4rFMC8+GIyYg9wLqKyS562mKQu1TMEd1ViHxMfVY/LG
	 LZyTtSSp/54BOLzKsCfH8KVW+YLOiZPllPZXoznNsD20puH5Ov6sfNEpN0KR0yUMwUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=elYBUVHv;
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E89606A31B
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 07:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60E89606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=elYBUVHv
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cc7c286026aso544815a12.0
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 00:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653014; x=1793257814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nnZ0MwCj80U+rG8upbc3A6/J8KNZsuBJGtpG/de36Io=;
        b=elYBUVHv1G/+HQcaNkxI5vFRLDZdl4qCwIUkcU/qNwNUpTSV4qXGzPUkwBnSmr4nxd
         wwVezuvR6Ife3TvQzjo+6K7A6wFvxXJCNcmsuuvTJNcBisvkxV+yDcLbpa572clLuVCI
         9fKil/njdza/R6iwWl11nH61WeT5Epgq0Zykr/jDqP5yuVO47whXgjdQwt6gp8OmSs0N
         idqR9tjE6FPUjivxfYkN5TBNgTz/JAp3q7tdvuFrtnQjJEmwxm3md7ag84qYIaP0tcvU
         NZsQ8W481LlK7Rdco81h88o/EYxdK/htfSER/FoyHgzzdJITP+DHQbednvYEQYj1EVzy
         tMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653014; x=1793257814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nnZ0MwCj80U+rG8upbc3A6/J8KNZsuBJGtpG/de36Io=;
        b=cl/uYvPpViffySLsZ1OIqO0NuPDoXOaii/dFN10li/0ge/XoVru78jMvJR+ybIAaX4
         JjQ28uFYdIL9c61w6J5Lw11pGyTEOFOkbA9x/KTN6Dg0au0AFubYcOE8J7KkpJuWcD2Q
         gUfBGYwcWPHl+2wkCaW0qqRZ+P6XIuHvqx6nPzYlFo5cnmMrOGhGclH1k/inxdeA5NX7
         BvoySGQRf4zBozG/Ti0DqXxGlw6R71hbOIdPTeLRg5IIuKQxoB0Wdo0SFQADjaOoYqt/
         HYPcL1nWpxCfkA5qWc3lsjBSbt/auiQdNs6m6+b8VMGGHMlNIXDfFtNcr+nj0RdXnxH0
         gR9g==
X-Gm-Message-State: AFq9FYJX60m9HoOQw7jlCgLNmjCmB5oLSyjd6rdPXvUln5M7x37ocvR9
	3yI67uPTRCw0194whkXEqOu93RWPABYtFQl/DNoz3q/xcfPBdgv+LwVxzH8fa5VcpTdESg==
X-Gm-Gg: AYBFou1ZvPw9mAQCd4Rn0GE6Ikx2eR7/aAa5e/h0pVfluT3nGgmj5fQ7m2D77SW+MRL
	P3uHqafUEkzMeMPkckFfLXsnavct6lXRQgzat8LDX2EhY4Dr9tVcS35Y6/sh6CAM5YPxs++iiLh
	KeFWOvasPaPse6TJPvcRGb8C7nPUihzMzWzQukfRHT4N5sVk34FxXoxPmnB9Cke3LGANHRwRinz
	l5gj9DAD+ndT68UTvkE2RsXIcDvOIOgyg8omYbVQjXKbx/58P1a8wOFeeD1yWDrINxh+j8fEwYf
	dPul8IGJSVwemykK++UvG+X6T+Pw4dqkRmqm24mnkWob453ORvdBh6o8B0ng+QGgc57sy9Ws16+
	t+LvXGjtbFoMl0OeYT+4B+JOvLZTzKhBVoYE0yy27p0PCVuvJJRqRcPYiTuOnKSUhoqezD6/P/h
	u15MnRysq3011QbMC4bx7RMKrCUpAB2j0dsRvepHiLvW0tVahgZVPUcWDf2uyjhlNWiRz/549/T
	7VxcRSmMHDDp6s/yBK0XfcXyIjCyeJF9Z7aFeeh/6E1/39xKbkZyV3Q7gAZ6m/qNuosmYD9sg==
X-Received: by 2002:a05:6a00:3020:b0:882:e3a6:27c9 with SMTP id d2e1a72fcca58-8a089d0f2f8mr3839994b3a.30.1792653013784;
        Thu, 22 Oct 2026 00:10:13 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm1706039b3a.12.2026.10.22.00.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:10:11 -0700 (PDT)
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
Subject: [PATCH v2 RESEND 4/6] Input: mouse - use usb_make_subpath()
Date: Thu, 22 Oct 2026 15:09:27 +0800
Message-ID: <20261022070929.20820-5-shlomojune6@gmail.com>
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

The appletouch, bcm5974 and synaptics_usb drivers build their input
device physical paths by appending "/input0" with strlcat() after
usb_make_path().

In preparation for removing the deprecated strlcat() API [1],
replace each pair of calls with usb_make_subpath(). The
helper formats the USB path and the "input0" subpath in
one call, avoiding a separate buffer scan and append operation.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/mouse/appletouch.c    | 3 +--
 drivers/input/mouse/bcm5974.c       | 3 +--
 drivers/input/mouse/synaptics_usb.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index eebeb57515e1c..b536dfae427de 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -874,8 +874,7 @@ static int atp_probe(struct usb_interface *iface,
 	if (error)
 		goto err_free_buffer;
 
-	usb_make_path(udev, dev->phys, sizeof(dev->phys));
-	strlcat(dev->phys, "/input0", sizeof(dev->phys));
+	usb_make_subpath(udev, dev->phys, sizeof(dev->phys), "input0");
 
 	input_dev->name = "appletouch";
 	input_dev->phys = dev->phys;
diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index e772bac3b64c0..0732bf3a97adc 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -989,8 +989,7 @@ static int bcm5974_probe(struct usb_interface *iface,
 	dev->tp_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
 	/* create bcm5974 device */
-	usb_make_path(udev, dev->phys, sizeof(dev->phys));
-	strlcat(dev->phys, "/input0", sizeof(dev->phys));
+	usb_make_subpath(udev, dev->phys, sizeof(dev->phys), "input0");
 
 	input_dev->name = "bcm5974";
 	input_dev->phys = dev->phys;
diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
index 880a0c79148cd..7da22118ce576 100644
--- a/drivers/input/mouse/synaptics_usb.c
+++ b/drivers/input/mouse/synaptics_usb.c
@@ -353,8 +353,7 @@ static int synusb_probe(struct usb_interface *intf,
 	if (synusb->flags & SYNUSB_STICK)
 		strlcat(synusb->name, " (Stick)", sizeof(synusb->name));
 
-	usb_make_path(udev, synusb->phys, sizeof(synusb->phys));
-	strlcat(synusb->phys, "/input0", sizeof(synusb->phys));
+	usb_make_subpath(udev, synusb->phys, sizeof(synusb->phys), "input0");
 
 	input_dev->name = synusb->name;
 	input_dev->phys = synusb->phys;
-- 
2.43.0


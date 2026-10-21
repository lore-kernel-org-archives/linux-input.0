Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585931;
	b=zSANvPM/0DRzCF9zQdbfX2DhMee9F+ctogB8agAMOFtkFBe6bihjdn+mP213mm2+ek0E
	 M5dX50OWCa6c315bgmGfSwIPBqJjGUKN/dsl4rWGZG4juIw+i70K9xwkAq3377L7WCSg5
	 ZqnTby0rnjthW2JkcABurah2CNOZj7nmwh7ILEbNpu67x5UbFgMm173D4OePmwK0CYKGu
	 ve5pciXaSfQTIpvnVUuJABok67bZdHMjd+DVPxLZHaSKtsOdzBRse9im6zjX4m/JuLTzd
	 zKpsdP4em+SNNPVKpkYlUdJbnbe1w6JUnhVk6+ypXWavuX8HwBjsfE/x63eg9lkdmuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nnZ0MwCj80U+rG8upbc3A6/J8KNZsuBJGtpG/de36Io=;
	b=u/nc+zvmrkHdN4q94h7zwoz7Qw99h0KGGBpFxi2VGVYxbjtoZAd0IZQTg+ocCi0G7smJ
	 Sef20ZqSPT+QZPyuffIW4Sjtmvw/+o696D9z86bnksTAAJ1Vv+xahdfiBlS3KkmU+B4yd
	 O3pviP6R7ZY/xXB83jneC8J+o/RsB322YC6ZlTp2JyoNI04NAxULyinM0oPyy2R3sWrZr
	 jbAnnm3W/gnaRtAfaWYaiZ0/wRyys6UOGni/EDMNUTzVqSe1ifKPnS2vpvj1Dk+4a6+wl
	 77lPabB+NmH68E8FOL1w+OyZ0Yn0rNiSwwXeMo4syMKAp2ZmzEPOoWp8f15VYof1baw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AVWGBqbZ;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CCA60A3817
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 12:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2CCA60A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AVWGBqbZ
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3acc610014eso368600a91.0
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585930; x=1793190730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nnZ0MwCj80U+rG8upbc3A6/J8KNZsuBJGtpG/de36Io=;
        b=AVWGBqbZm8mWQ0SX6qcDJWcEz6XBHV1d9prbvQRJGTmm5yb+X2NvUUJ8goV7+XPFa0
         xmUN0WtDouocr/yQS0X5Z1DQ5CX0AmWrk+5VDSaels87fAdzTJxWuAnC7yjKC68XqVQo
         XKpfLfyfc8ZM3yJhNdIiwdryMn4+kU45oZFOxtrr/KT91sk4CHPMV2FZLbdcDopo1BLb
         7ZGtDTj/6e2cCYEC0avqz/JaV4eOZ6mYoK2yf4KhEi7cNgoRm5JqBzBZVZr9v9/zoyYz
         sDIzTzpbVEW8/oixX/q2mJ/YfB4hms0mFcik/SXYxuik35ud2Go1zvaz2Cj9dO9gs3O+
         ++7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585930; x=1793190730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nnZ0MwCj80U+rG8upbc3A6/J8KNZsuBJGtpG/de36Io=;
        b=hzqOpMtQqLQ1B5yt0b+i1RW8AY7TbWo2YirLzKScq+vbJooNKS+x4hPTgrzRGw1hup
         JtvY0v+6kvO6SDXMKqkGhpsndT3/p6gipptKVPJmCYn99AyNTJ5Ggt/Mi/wPWSoYCEEq
         ENumfNnoZn5Sv1HFMWHLSsRhiQF47z7US3qQz42DA3ouu9mb0gCR5XQ+iiKcq+wKw9sm
         rBBUuI9f3v43EjH9jAmj/g+vXe1OJWbai6TMcHLeQgnggYxjBRhTPlECqHZJeo1Z84su
         W5lNFNWU6Vcy1A4C36IMIcEgKzKKM7/fyio4x5UhcRdKkrv3QNWw5gklClb0HWjnJGC8
         4iDg==
X-Gm-Message-State: AFq9FYL7vnM5Muj+jc8lyvCwTSLE91nAItCPC4NRH+0EepsRRbDXm6UF
	VzU+Oe+5rBBZDdgHkmlytwhb4tz+CEz2I0y+m2VfHD2FrLiBSFNfqkhRbK0z+725g0/UGQ==
X-Gm-Gg: AYBFou1/5qwDaGl8PH+5+SyYCCz3sywaqXD+eOsyBMHv8NqR/GcBr/IsNpz9UGJIoZe
	XLB6qriQ0VbVMj/qQ7Tjbst7E9TU+/DixxWDBcQN2F+eK+HqjVXFvWsIdSMOUUoxWaYTJONmivx
	LOjXCLZ0Sv0QsT831Yddf/qZZMG/mweU5dsd6Yymk5+a/71NsGPixSta2VVixfRnIp8Pd4StRq5
	ZKD5fRl/CmkwN1Ee5fEZYQB63lxwAmXiPttpOySbXA/ixE05ymwUvzDuTwWp4tYmIebY8pyAgk7
	HskQzpdBUX1zrBQBnehDQ4zMfSdL5A/Cs36UeqaYrgmxoODc+H+9umS0jEOzM/qc7yRHch0I2pq
	QJXFa/vgfvlaoCaF+RvaUWWKwsMiDmZA4iFsNQ1gm8wqkouF6peOZw/66MIc+NGAerqQdF39H/q
	jQ2wda4QHizRNtfDQq1Ap0Wcoum7FkBcSdc+pGnKyqWSs2ovlEioeDIKMXJd+ghS4xwV1h8WSv2
	BnUk9QRl539swQuISjWTOqRQUk/FYbyKlJx32hes8HoRYSau4ohD4UXPKlhvPeUtgm2eDJ8tHwY
	/2dYz0P+CKS2rmLNNBM=
X-Received: by 2002:a17:90b:57e8:b0:3ac:dd28:4621 with SMTP id 98e67ed59e1d1-3ad86f57070mr1515425a91.51.1792585929882;
        Wed, 21 Oct 2026 05:32:09 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm4229523a91.15.2026.10.21.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:32:09 -0700 (PDT)
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
Subject: [PATCH v2 4/6] Input: mouse - use usb_make_subpath()
Date: Wed, 21 Oct 2026 20:31:44 +0800
Message-ID: <20261021123146.17202-5-shlomojune6@gmail.com>
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


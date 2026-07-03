Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772E416D02
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091843; cv=none; b=GXyzC9X93EoPRReTkldFLMA1mdY6N3czhCloO5uq3eh+Kq4+cF94JQsXFubRLKrP12fHs92/NFi0wue2JM1pomfa/y0DYidzr2N9sG5g7NcGF8xxpUkCkLvc/7qi5XMRMv4yCW/YQQ7yI3N0gzcoSYKENQhCgVPsYnxJqiZtycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091843; c=relaxed/simple;
	bh=72x0DNJXcD5r3U1QyiCbruH5a/0EpHLWqt+m0uQv8Is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iWdl16th5zW7IgE5KLvZhwBMyb/B1ehtJQeMAmrVhi0NW8+q5drS/Jrp3mpxQ+LPPRH8SveVhx1WvvPZvGxJoZ0rYsobNLmWGb6dm5JxFurs0QsHZYlwg+n3qI2A0aJCTL8+/NVX36f4ye91AKiUJUVu7D+euicJMjrwKftp+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oHpgVRwq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHpgVRwq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b8d99342so186755e9.1
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783091838; x=1783696638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xk5nWQTYsldtMRW9zLzMfODn+++NEGC3EIHM2mCJ+xM=;
        b=oHpgVRwqcmppPi/9q4Sf8t+iqzY4nHInld8yGAl6YWdfg/t1zR6BFOhcvk453Zobqw
         fDJRVFHof8WRP4fz8uuesu3cR/ZZwISH0JFCGI/nig0WIc8+blf0DGhGeVHxE9VrNT94
         ldthpjj8u6n9j3RrrfuBQK64J86zWM6YHEAZhSvUuo4DC4AbZryrZ1ZcDwfVSUhD6g6U
         Mbbm8OskO+Rrj0k48/AInEG5/m1142KEWDQ+/TG7bBFYHtEpCzW+Bw8XqXQ6D1OwMyx1
         tRiY3eZewrhIWdz/7xqN0YAFdBW8R4ZcUSvq4IGCH2jPyg/Vpez8oz3DP7FuasdCjGHh
         Hbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091838; x=1783696638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xk5nWQTYsldtMRW9zLzMfODn+++NEGC3EIHM2mCJ+xM=;
        b=riXDMXx/1UPSp+mB5SJhGdIpe+JjHTOy/8Sb0N+sYGKD2AYKajEuw23nAGIwBaVoKO
         8tq2IRnNqu4gfafHuLDD0BRpsbMqVy7liaVrKw9jtzGVBy3k0pOZJkcTLFI0TbA5bCXT
         98TQDn4lOGkPEAagGi1zzuBrrMBIVGJN7ROAGojy/j49iBooBpYLKtnF+UkNP82kZbWm
         UlftLN0CeZ7TL0d6qKcMi7WwF0X2eZ463jCQsc+7hgZt29o1b+wau29Sjm6Wh2CNtd7W
         1hvEg8BgpG4y1Iquuy/AE4rDKjM7LKUY+dLzdv5O/OFdxxdre0d95FwgJeizYWFwPmYm
         BQoA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZvlpZD1iQdLK09yQNhuwtQUtP2ZcC10ajhBG21+XRZjZf49RFO+IuQtRnHzFy89xgHxDKDOYCEMqzcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcuFsI41yO8DgxKRk4GDeWeSQlRPQToopqsbMWMcpT3xXE0IlA
	0AOfvkLRjdEWjlAP7tAOFwlSm9P2FvTWkjUVJFAavFvIEjohYDYn12HPxMRl8Yct7w==
X-Gm-Gg: AfdE7cnbJzU01beJx0wP5zGReK/fTeUcaLWiTiCr8s0rSY31KhV9O8aFWKc9ZlGLwkQ
	22Zmn727QMrmW6+Co+DzPJiPy6kmvEBPp9He1snRTRI1RCYiwEGvFtz88ohGdVv1lrUcJ/mNTk8
	VczQxo7NkrNYh9PvdNqy+dmQR+odQZNXCuw0w2KBnP4Pvouacqx/scUNpHCSQAmijqOf3A760fG
	OyOqQ6v2onrlslLiZ91rlGuGMOKpOqnJasrXzFm2gV3AURtVm4D349UiAQK3uvGMCrGQgeRHsQn
	urVJ5zunqyUNuzKenCXLC0A5hYMHpqdt5NxYg9g5mpF4GMteVvwkvd8kANGABFtsAF4y8oqKx3r
	6bcRaQuH9WvcD/e6Vm2qxs5cquaHRlaaZG7FJifW17Qqml2V6OwiDTPP+iico7f3oWBEtgVAAsK
	IQ3PdxWNtTPl55mdsrFmj0MPQC4gGG5JvCcGbB7h5ehCHGdiZA/WA726JZA7vrH1JSiv8cTrA=
X-Received: by 2002:a05:600c:791:b0:493:aed4:8d03 with SMTP id 5b1f17b1804b1-493d1047f09mr7765e9.9.1783091837691;
        Fri, 03 Jul 2026 08:17:17 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdb62d3sm65241445e9.8.2026.07.03.08.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:17:17 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jul 2026 17:16:49 +0200
Subject: [PATCH 3/3] HID: rapoo: fix missing hid_is_usb() check
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-hid-usbcheck-v1-3-e80259ff625d@google.com>
References: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
In-Reply-To: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091826; l=1231;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=72x0DNJXcD5r3U1QyiCbruH5a/0EpHLWqt+m0uQv8Is=;
 b=UHqfAqA+nBILdUKR8Wt2ucHWqHmjpSKN5oWTt0sLfntQmW1lZIYCVUCx/OOYF/tNzG7C3W9Gb
 QRbvEydowKWBB+TeEH/mUekflp3F4xHbwtk8G7cLuUT2Z84WAWQn9uA
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

to_usb_interface() can only be used on a hid_device whose parent is really
USB; uhid can create devices that identify as being on BUS_USB, but don't
actually have a USB parent.
Fix the use of to_usb_interface() without a hid_is_usb() check.

I have verified that it is currently possible to trigger a kernel splat due
to this bug in an ASAN build, and that this commit fixes the issue.

Fixes: 00e005c952f7 ("hid-asus: check ROG Ally MCU version and warn")Fixes: b3b1c68fb726 ("HID: rapoo: Add support for side buttons on RAPOO 0x2015 mouse")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/hid/hid-rapoo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


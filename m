Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AAD2D780C
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 04:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785298576; cv=none; b=q/2kBhtu00pUBzyGSnOYUZmHGXEk8aEC3k0AsiWyzJBErtObV5gasm97RzuLbTgdQLnytTd56xybCuSQpYe0S05Sf/y+LMCRyx4VTU4TumEysHBkbLkvJrp/3FJQgCilDEvoSiCLUt95gojxergwAgT7zwoJheZGiyh7HJD9L+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785298576; c=relaxed/simple;
	bh=Kk6/G63HfloepSkAoEAtmJLfAa92k6+6+Z8J6r73Odc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EK4ExM+zGbBX9475Jm9Ws2j3RvUEuqGPofG6voHVRD+y1k9Cexix/SRNgiQpcr8v4h+G8hMx8DAKXL3JXJILbI5bDGmKZATNKPNUXBgsfyQL0DZGiYVGv2k4TEdgIAPIz1GuK/Y2eNhGZyg/OFAEEFXvCMLiK5u6dkCGGbyIwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ9NZaro; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ9NZaro"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6aae5eb0ee0so207701eaf.3
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 21:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785298572; x=1785903372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0t8cRO7mMT55eOJmPNwwx0ZOHU0T9/P4dbtA/tZ//M=;
        b=jQ9NZarogz7GegvaxJjmGcn++tRVLXmdv/endnxImAu94rdjRreL28+9iAtX4uAkXH
         0leWzVaSXFar/PrR0zMm4TBhjKU/jwIZf1SxOpfOefzDlrLC4epKkbWqL6vGqTx+wd5x
         fg79cTb7K1oL9cvy6BdtMxu8mmi9XVTNb1suqMSyj5K6Q0AxgBD2mFSMPNREc0d1I3Uf
         bvuSCpEM+fZKT/gPAthjEL3wRFDTu+xgjMn+h+yO9D4iGe4MdXdWJZ/F0NzTxH4ESz7m
         gpQ7q2Rp7ypD+lnlpoDFKZI46xkPW1YA5VY0tCWuY8RWGwwoS/9eleXl57+MMA2vu37b
         Vthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785298572; x=1785903372;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m0t8cRO7mMT55eOJmPNwwx0ZOHU0T9/P4dbtA/tZ//M=;
        b=nlcijsw+GbeSvoLd6LLIG9idoFDMynvGEGFHuIGy2PsCmle3CbBILLBFlPXb9TXCIZ
         RO0tTdW+sdxhWZqVlqG6XyPW+jjtuMvrF6Scm2/AAFIpcrIKAAG2XzWZ+D/dEAdK8xsl
         nXUVprJZjhOO1yqxhUdFy1W2tKz2z2r+wV+g9Nb0IbTDSb2X+LqK3KYg182V6y3TWguO
         zGbhztBF4uZgiyyUgWb53P6MxQoTWfKQYChrbnZ6ZVUeVgIhq/VihWcp5EAOcG0Ad5GN
         X1M0KMKTadSqLCegTdQjHzQcumZwLfMC2YN1NRqB0EY1SPEvCMEY48ahLMNK9GGQU0fa
         0vuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+L+IvDLyAM3/qFVmBbOJfhUQx76O9VP0mpZKO0O+Pa1FXrPcjQ/6nQ2rGfAjDHZ3MSY1eg6aIPG7K8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyifbPbKh3BkkXCN/0SjgZaDPpqr426gBj0p/PkZkxMzwI/b8a9
	JU6XQWIXNjJa2qJ5V+mqyLAC18K/sI1I7T99RPoqOFVgWOfgW4KmXvIe
X-Gm-Gg: AR+sD13Xvfd2huETCtkpCCewWi1y/rlTxVltlFAspc2fVYjhX727nnE09zBPv0UJ+j3
	ESVb+Xl7ugs2T5Bh/keSAQn0g7m4NeRQXvFWB6j3Kkg9htO68wdG4U5geI6/063yNpCU+J4gUcx
	EXKM/d12bItLoP4QHs9vJ4vTnwQHGychWQff2bMDyjjzjl1kpZ4or6zCINfJ3M9tPYfVhR6Q7cb
	QNOBLSjWHj23S80qV6dzFmVC48Ae/OzZ0MPoseaPtrkc+dpV6eOUQeA0SNZAzpxlcO4HADAcJeg
	zYKW0rRBnLNQe0wt3YmZUrUuAtNFZvt7fvQjo1j6LFPRWoYYrZr0om1wfUG8uyoo+XHqSXRnnbU
	yleeqiuzlgoWHmEwPPZ3eBUdJJDNBaRk8ImkpzCxkMlEhbtVcaDsoCvkwZab8b31VuWMM1HHqtR
	HGPydRDz9Negm6XcjFHiWTAAYHGNJEZ3mvR6oPYPqEyh08vZOiDcxTOgQes8XJ
X-Received: by 2002:a05:6820:4d02:b0:6a1:8192:4d89 with SMTP id 006d021491bc7-6ac969dad73mr2468366eaf.29.1785298572466;
        Tue, 28 Jul 2026 21:16:12 -0700 (PDT)
Received: from desktop ([2806:107e:1a:2f14:d204:ec3e:fc64:563b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aca9a41fddsm340762eaf.8.2026.07.28.21.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 21:16:11 -0700 (PDT)
From: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Alec Hall <signshop.alec@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
Subject: [PATCH] HID: magicmouse: do not keep a stale msc->input if no input is claimed
Date: Tue, 28 Jul 2026 22:15:57 -0600
Message-ID: <20260729041557.1185819-1-pepemontfort@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

magicmouse_input_mapping() caches the first hid_input's input_dev in
msc->input while the report descriptor is parsed, and the rest of the
driver treats a non-NULL msc->input as proof that an input device was
registered.

That does not hold on the hid-input error path. If hidinput_connect()
fails -- for instance because input_register_device() returns an error --
it unwinds through hidinput_disconnect(), which frees every input_dev it
created, including the one cached in msc->input.

The failure does not abort the probe. hid_connect() only skips the claim:

	if ((connect_mask & HID_CONNECT_HIDINPUT) && !hidinput_connect(hdev,
				connect_mask & HID_CONNECT_HIDINPUT_FORCE))
		hdev->claimed |= HID_CLAIMED_INPUT;

and the "device has no listeners" bailout below it does not fire for this
driver, which sets ->raw_event; on the USB Magic Mouse 2 / Magic Trackpad
2 paths hidraw and hiddev are claimed as well. hid_hw_start() therefore
returns 0 and magicmouse_probe() continues with msc->input pointing at
freed memory. Being non-NULL, it passes the "input not registered" check
in probe and the NULL checks in ->raw_event and ->event, so the next
input report dereferences freed memory.

Clear msc->input when the HID core did not claim an input device, so the
existing NULL checks cover this case as well.

Fixes: f1a9a149abc8 ("HID: magicmouse: fix race between input_register() and probe()")
Link: https://lore.kernel.org/linux-input/20260728185542.65F091F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jose Villaseñor Montfort <pepemontfort@gmail.com>
---
Found by the Sashiko AI review of "[PATCH v2] HID: magicmouse: avoid NULL
pointer deref when there is no input device" (Link: above); I verified
the path before writing this. That patch [1] is a sibling fix that adds
the NULL checks in ->raw_event and ->event which this one makes
effective on the error path; it applies independently of this one.

I picked f1a9a149abc8 for the Fixes: tag because that is where probe()
started treating a non-NULL msc->input as proof that an input device was
registered. The dangling pointer itself is older than that; happy to
change the tag if reviewers prefer a different one, or to drop the
stable Cc, given this needs an input_register_device() failure to
trigger.

Also a sibling to "HID: magicmouse: prevent unbounded recursion in
magicmouse_raw_event()" [2], which touches the same driver but a
different function.

[1] https://lore.kernel.org/linux-input/20260728184059.688513-1-pepemontfort@gmail.com/
[2] https://lore.kernel.org/linux-input/20260715053526.574725-1-pepemontfort@gmail.com/

 drivers/hid/hid-magicmouse.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 802a3479e..2f14094a6 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -900,6 +900,16 @@ static int magicmouse_probe(struct hid_device *hdev,
 		return ret;
 	}
 
+	/*
+	 * When hidinput_connect() fails it frees every input device it
+	 * created, but that does not fail hid_hw_start(): the core simply
+	 * does not claim an input. msc->input, cached in ->input_mapping
+	 * while the report descriptor was parsed, would then be a dangling
+	 * pointer that passes every NULL check. Trust the core's claim.
+	 */
+	if (!(hdev->claimed & HID_CLAIMED_INPUT))
+		msc->input = NULL;
+
 	if (is_usb_magicmouse2(id->vendor, id->product) ||
 	    is_usb_magictrackpad2(id->vendor, id->product)) {
 		timer_setup(&msc->battery_timer, magicmouse_battery_timer_tick, 0);

base-commit: b7556c8e713c88596046a906c7c4385218d44736
-- 
2.55.0


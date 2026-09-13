Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787DF3EC82A
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789306857; cv=none; b=WebEU0xGQKBPXOhUCJxBfSMnYsn4GPi6A/+fz4l2SC+N2LvqIKkgXHAuIa67b7GWApuyS60xwXPuS4Y2P8tzIX7Q6hcO35oNPVG9e8RLhkRuK2ZTzQEM6GXI+hxu5ANh64XI+5y0DnkfQQktn8RvSOaP5IQN5NMGOk3t8DjipD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789306857; c=relaxed/simple;
	bh=vUq7OE8glOhov/9NBs9mV+ziOL9KOUWXVhl29wF32kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZz3iSYhlLhckm6p5FUKOfOD2Mk72sYxi+8/ttjoSSzyMBZ7JE/2N4S8Cuyua8/7KvBqfGuHvxFr+NI4graF6boZHWG+9aXZeYAG6rTI0FSK390iX5mAc1MUwx1oWWAThmn+aDt/b09OZI5/+t55skVLIJgJ015CO7yZfAHzzqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sYYdMye6; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYYdMye6"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so898045a12.0
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789306855; x=1789911655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9U8XN+wqeWZ2BOPDqAL3IN95g06CNkRCt1kYaktqWGg=;
        b=sYYdMye6yetjLqtrxHBwrfTskPMmuHpQVzGHUu1uBEWKvrSt/BlQXSB7QFdaMMK4W6
         2GQG8FvgH2FwfOpBfwLhfzJLQ9SSyipGFayJVcmLnLJV+VcetlO/F9MFLH2ZUzwgEtpn
         h2Fem1sOoDjDCVrqFt/s/vmWLtIpbCLo32ZB+ftjIA+/9IuC5Gx2mje5pH5Xpni0DGnH
         aAlNjTG3pu7WCPQEFvrsKds5qgD6+q2QfggpswHaCbX+ADaX8UCh9glptXL9jNw7I1zv
         y0CqEsyoKf4u/h0rIQa4ASPwxg5oOP/a88PjMc/rK0Hh5JzRN91+dhtBZRjK8pypKhXe
         9Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789306855; x=1789911655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9U8XN+wqeWZ2BOPDqAL3IN95g06CNkRCt1kYaktqWGg=;
        b=gTQxpMPGQpMRYcmKJ4q8HWebV8v1nnHqm8SU4U9VGoHnkP42AWi9xSo2p5qzBL9Z9n
         ZULCdKJvR9t2ccObIVS2SlwSGRxgrH602e9Uei3olWW6kB/ObuxKOSajY1ZzI9Kk/Fvn
         ejzL+1LQlwqOxUreX8elBGW+DCK0tFaY4wowI6odAwir1yhVPg2qmTWPDepZIvaoLG6F
         MAIQmEBZIscQEsmMHFgp7BZfb5BPNYCgxjdelnufs/P1SfDhqGU4DZ5mmoGpgcMu+u3B
         38bNt4HOU134+LW9HIXjwcL7otPMwcpACGoG+71lVOkIx0OrpRt3K4GvIwu3ekqPL4jL
         G4Xw==
X-Forwarded-Encrypted: i=1; AKwUvBxF6xRxTL7Mxa6dmLHbUzll5ozqv4L0ks/GkgINpJpze7YMCBsgp6KQsKSdezEam+cPbMMpGrVaTWgpow==@vger.kernel.org
X-Gm-Message-State: AFuF++mzcCxM8K9iaCOpTkpC5F1meJ/sY6mN/jsO59Iz52u6S3FlmY6K
	avI6zY1BkN9nsN5RfCcliKcINgiHNc51byf3b+r5hVpItSDe2eqETdzc
X-Gm-Gg: AYBFou0Tvcrlc37Hc/dn6OG24G3dhgWTacCBsGi4vO5XDuIudAThWgoGClAUlMTnm0a
	uD216ooxPX+zo3RFdCURpm2VmM3OznLnLdDYU5A1pKiomeK3KtGtwanPp9YKJgprN70BrY07L5e
	S7rF4FMUHOuIC+5Dq4GtwipXD+UZnd3L0sXk2Q6qTAVtDftpBFPC+w7mIHIkD9AE/ln0yeZ841j
	YR7MjEbeKKoknntleCyFNMXu7WMxmL1gS6vQvU3Qt9XVQ+iF6fQavG3mw418dkWEhVsbmwKGFgC
	LIAoGeu2awkmS5tysAijxSmGBrZQkOpTHeMA/0420Ql1voy5pxUTf03J8lEFVdrhRtZiZ7XRb3C
	2Iy1Sv1LQ3re+FEWuXzy2cV87nWJ2nAoveWNBDeUHP8V6mhhQ5PBsoYV06w+cxYFNl2QsnQT6K/
	0HQbKF5EUzQa8YW0EFrZwBP2ee0sqAwleYCyQF1CTET2/CQvLitPEQpw==
X-Received: by 2002:a17:90b:1651:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-39d9bbf93c5mr20289197a91.2.1789306854833;
        Sun, 13 Sep 2026 06:40:54 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95752809sm15365323a91.13.2026.09.13.06.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 06:40:54 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: logitech-hidpp: cancel reset_hi_res_work on probe failure
Date: Sun, 13 Sep 2026 21:40:44 +0800
Message-ID: <20260913134044.1562697-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hidpp_probe() initializes reset_hi_res_work before starting the device.
Once device I/O is started, incoming HID++ events may schedule this work.

If a later probe step fails, the error path stops the hardware and
cancels hidpp->work, but leaves reset_hi_res_work pending. Since hidpp
is devm allocated, it may be freed after probe returns while the work
is still queued, potentially resulting in a use-after-free when the
work handler runs.

Cancel reset_hi_res_work in the probe error path, matching the cleanup
performed by hidpp_remove().

This issue was found by manual code inspection.

Fixes: ed80cc4667ac ("HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1504de32b1c8..6a21b281a1df 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4834,6 +4834,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 hid_hw_start_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	cancel_work_sync(&hidpp->work);
+	cancel_work_sync(&hidpp->reset_hi_res_work);
 	mutex_destroy(&hidpp->send_mutex);
 	return ret;
 }
-- 
2.43.0


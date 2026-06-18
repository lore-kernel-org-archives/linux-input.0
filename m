Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBAA78F39
	for <linux-input@vger.kernel.org>; Thu, 18 Jun 2026 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781766402; cv=none; b=VzzA9bjAt0eOJGKXH00uKvjQXt9tTOVxa0I3kZnFTLBFfrX4l6a6Noj6LQEP2hwWTYyQyc1D8AVMjiKvOt2cMcJVf89Lmml/82WKJd9N3TQwUNyHI1//VC9MZL4R0zT/EycdtJZcLRllTVDhWwy7pt/j1Wl7X/4/ZpLpDLRPG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781766402; c=relaxed/simple;
	bh=pOB0N7oC3zaT1BpMk1Zxc2ZumaX/k1RMNsTJW57uJKg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZBBrUxSI1+QWWe7JeYUWCiQVV03HEEqVsfuoQQePO7X6/s0v3njpt4Gv5eTBer0tpQzDYvU1PC/ZlNQ84Sr4osDvgMr6we7T4uZeAbQ+7cLJGP1ISEmHxBZs+AtnAPspIqwzgMxss96jonwy48WVlmfOZGUjjVTeriyWCh41K5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agGtNkpY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agGtNkpY"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c88b7c92577so275387a12.3
        for <linux-input@vger.kernel.org>; Thu, 18 Jun 2026 00:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781766401; x=1782371201; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4w489f812sOCalQuTrE1vmKCysqhU1b+dFQi+eqawKk=;
        b=agGtNkpYqxj+rIjWs4GVlEYzHxYcklwvNsJLaJSHnWms68bzZ6Uubegq/AHYpaKrQS
         9MWfPH+RVMpOcCnOgF2kaqCiIXVl7o83g/BdThYip4kscFFbev4c0WIMBnvljC/bUlCI
         w31hi0q3jkyKtz5QyWelEoNIDR4jsFI5ERfzphnoxeUEymKMxifpvc1msqCd+hfwJOTD
         c8wt0Z9oMse2+BxGZ6b8nfUIHhYxEXPvrAA4iE7nZAowF3Hy/uY3HtL5W3hIYgmOiD3C
         75fll+o2h3nLAz5RnhAoLei1unPXV7Xv48QltcsqI1BLVSaaRdUfGtLPGMJhLcAYvJ58
         kUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781766401; x=1782371201;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w489f812sOCalQuTrE1vmKCysqhU1b+dFQi+eqawKk=;
        b=bN7kp4MjYAwBBUwpnB2+CQjaCA4UEb5BAqKcwbHtGP9LgkmlaxWAbCHSKRlHfxCn2m
         40JPNpcmWhkmQ0sE/GQapihaQzgCyFi8HBLFnssOSzTU7l0WVfojl3ltw7aVUXBJ8Mx2
         1ohlGGzwkRbCrN4mGu+s7g6lUzRflZ5G4mcWTr/cvbbgdLrtFf/Dy8Gbr7wi9b3WaIyz
         EG0uiO8N7Ms9HkQ3iAE8mULtyfDKjkIwYqHlvZPLpXD2MPDvaN1srFnKaB52dseEXMVK
         xD3XoOlhvr2SGm3VJgQ+CJztCuvZGOJtygiDIzKegrIqVGonztEYxZRj7XY6cScHAJLy
         UN6g==
X-Gm-Message-State: AOJu0YxSP68rfkYzUB3Pjo+War0VJv6NCEw4LN1Gm/bGDrzSmNUthFBC
	aU9/eKfHEGxYMzfu+gx/3jE6wdmJ5l3xAncS6pUpXbhec5zMfPPkOznk
X-Gm-Gg: Acq92OHYV/VjuRlvJgLgiV5kSyB4X07OJSFgTdtmNLodGmKPAzaLMC7+o4uXY2GMmZL
	XHuMtREeQ2KqHxEhXnvGedDpfIrilbjIBsFEszV023QlGxGI7/CAQSustYailjwXzQAZKjZVlIL
	7fx83aZtQY3BHFtNDJVzZ/LwInLljzGmHL7j1a2mqUpqUhamG6zxNhhHTXIz2kU79cizaKjgq34
	5kClFib/maNGA93hlBKg2mMwoutus9aYKReM3qAWg62zKFXTgkCiaFCzCZD8L60nmz4kGtnr3uZ
	x59Su1xOYGvzRzRo+boMeSoffyEv2wgOt4yp+szqdmTDvixRYhqKigfDR9a61V6fsUICV2Tqkjq
	teSenwbyuDq4UKMH9IrnIB0ehLnrAePnM3+onPk6QPKz1xY69a6uQEEm2n1Ckz+y1kFA1ApoNV+
	v9zljFmSkrx1HD/zEKdXV12F4jEtNf9aiRLuVKpw==
X-Received: by 2002:a05:6a20:d497:b0:39c:cdb:5d81 with SMTP id adf61e73a8af0-3b8b77ef2f8mr8266487637.32.1781766400332;
        Thu, 18 Jun 2026 00:06:40 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8664586b3csm16018741a12.14.2026.06.18.00.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:06:39 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Hans de Goede <hansg@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH] HID: lg-g15: cancel pending work on remove to fix a use-after-free
Date: Thu, 18 Jun 2026 15:06:35 +0800
Message-ID: <178176639579.3377656.12792307991044339915@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

lg_g15_data is allocated with devm and holds a work item. The report
handlers schedule that work straight from device input.
lg_g15_event() and lg_g15_v2_event() do it on the backlight cycle key,
and lg_g510_leds_event() does it too. The worker dereferences the
lg_g15_data back through container_of.

The driver had no remove callback and never cancelled the work. So if a
report scheduled the work and the keyboard was then unplugged, devres
freed lg_g15_data while the work was still pending or running, and the
worker touched freed memory. This is a use-after-free. It is reachable
as a race on device unplug.

Add a remove callback that cancels the work before devres frees the
state. g15->work is only initialized for the models that schedule it
(G15, G15 v2, G510). The G13 and Z-10 leave it zeroed, so guard the
cancel on g15->work.func to avoid cancelling a work that was never set
up. The g15 NULL test mirrors the one already in lg_g15_raw_event().

Fixes: 97b741aba918 ("HID: lg-g15: Add keyboard and LCD backlight control")
Cc: stable@vger.kernel.org
Suggested-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/hid/hid-lg-g15.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index 1a88bc44ada4..02ef3e2094b4 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -1374,11 +1374,27 @@ static const struct hid_device_id lg_g15_devices[] = {
 };
 MODULE_DEVICE_TABLE(hid, lg_g15_devices);
 
+static void lg_g15_remove(struct hid_device *hdev)
+{
+	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
+
+	/*
+	 * g15->work is only initialized for the models that schedule it
+	 * (G15, G15 v2, G510). The G13 and Z-10 leave it zeroed, so only
+	 * cancel it when it was set up.
+	 */
+	if (g15 && g15->work.func)
+		cancel_work_sync(&g15->work);
+
+	hid_hw_stop(hdev);
+}
+
 static struct hid_driver lg_g15_driver = {
 	.name			= "lg-g15",
 	.id_table		= lg_g15_devices,
 	.raw_event		= lg_g15_raw_event,
 	.probe			= lg_g15_probe,
+	.remove			= lg_g15_remove,
 };
 module_hid_driver(lg_g15_driver);
 
-- 
2.34.1


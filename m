Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25FA38AC8E
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 03:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791516386; cv=none; b=YKTVAbQtfMAA9jwoxIKdGg8gDneTlZbBWDt7RorU6prnUEiJFAhrM1gEQ+nzZRzlCVMztH7nooRnbM6wq1hQ+qQzmcCnDskbMQYEEv+KNUQPzf0uPeOccDiiGUAx6UL7h/3W9N0ssLPXrrkKNx1rXLS+QqdV50BSyUYL16w0JO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791516386; c=relaxed/simple;
	bh=FC0tBf/Bbd0fFv+n0zfKmklZj2q8QedkLNsQoVQYUiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UR9YAUR9gEcoo7qKFGs5NoeZoXVh3n5MXyIsmgz6cxE6oipNR8O/IsatdJre7OzJrhsPpum4KG2CraMgJ7pGO+v/gLG4y/ptqhNNTM1ce/ti/W21fwQnT2k7AmpFj9YiwMkt7k/NcLgf3j4vv/dg2x3KIVoVxi7XXAv/46qHlAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx4x+YMr; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx4x+YMr"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-97622cc1f40so2136932241.3
        for <linux-input@vger.kernel.org>; Thu, 08 Oct 2026 20:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791516375; x=1792121175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0oI5ab0SOpcU2oguj2Mvg/3amVLKLWqr9M0+kJZIag=;
        b=Zx4x+YMrxsZTRjx8vuVtP19LE8VSxgNi6ghVN7P2yxStBZtUJ1W8ZOUJ67kI6Qb0ZA
         /9eamYyyeVusn2BNXogqJZorrT6WkkENW7MR+HzfW+zi0PpYLcLxNixYzoZnGSqAV77Z
         fEaGXxLr+MfefLfyg3Ee3Zqj+qzQ249qe7ZvCB2Pal4hbB/pzin+kKrb3xRFiS0wzg4Y
         Ajp4JF7sXh7WxTfLry7Mgwwy05kQgbYV7eey+jgLmP4vczOBSW6gG8xVHTmwbt+5+swp
         iuKrjraINgRqYW8DConvFIEO3z95ufE0nMJXd+GWTXMek6mOJ/AqWmvFiU3sRxT93p5Z
         8Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791516375; x=1792121175;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b0oI5ab0SOpcU2oguj2Mvg/3amVLKLWqr9M0+kJZIag=;
        b=c8iXSFk4oMY0Pi8ACHPfnZ/sHrMM5SgE77L+bWEVc81cVXbd0bSbwljS8Mx0L8CbT1
         kAcfpFLb1LP6jP9/ebda/7r5BWn0Z1pHJ+jK9x3l52x+hMW1JGsMe2ks4qwu3Zb4FKT2
         lCxxqN1AaxCCJezTbteKYX7R7Sfn9Ie24PjUWcJwOFvz2Q5Jj+km9tsXdIPfk+N1Xz7Z
         1aA7ba1iJIPAxo+kr93hGyc0VrpLUrl8OkR+cX78HFhQ2pXjCYRugtGgUqSn94Vb66yx
         fwLVed3F6aKD8TB3rgdu7BOWFgV/LogN87OBoEYuGzFXUyAQPHMVubZXSXwmGxUnuPFA
         XTHA==
X-Gm-Message-State: AFq9FYKCp/DQ2lhC3mjstRJnp1SVtpwpbfVSPpYldzB/UORtsb3OJkGT
	JTJagtJu8yR/n5WpYRt90kCcYjqMKw85kSK8Y2/be4AtHiqQBV0ih1xh
X-Gm-Gg: AYBFou2cC09DIB66jRAAQpSZ710ZUXLnta2lquwAkPhoB0GLyMwqYx/1GLA2aRv7VKG
	ckiBTsaIqGDiF2AzfBLDic4QHhwKTbz0WkcDo6wtCZ3u1ftrc2LIEggfaMoKiwObDnAncNeaFc2
	JVNnWGMAMOdwDwcnKOQFTp0xp4L4XPUI6Svgj0ztlOHnfVs1fsUv4vKtR/j0Gt90LsBPC+wl34W
	kaU4t14uzq6DnPhcVKvDg8Wo47pyz51FemApJJ8DJWIw6QO0uahBFOS7g8JDotpo+WKESaFMmTg
	5NfpWSNgAG9U6BLnrchwRpSnu/T/wJ2CtMxLlxADdgWsXkWKv2oybmYqGl3c/NVlXhx/zMXeFtL
	QHWpqC5zfWHzaHt0GKR9DkwtgMYW12+bvByP7cTaWDgcC8LksYeWqv+sxcRgh/eHKzUdJXMSdkH
	gP1Ke0NDZLtojsqRmr9d9eKuYtkOCivM+KhDahv613N6XG+7I/O6Rv7IGCPbJjVOE=
X-Received: by 2002:a05:6102:b02:b0:7a5:2792:32d0 with SMTP id ada2fe7eead31-7cb3a067145mr220615137.15.1791516375576;
        Thu, 08 Oct 2026 20:26:15 -0700 (PDT)
Received: from beelink.. ([187.13.210.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb354681e4sm728780137.10.2026.10.08.20.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:26:15 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2] HID: haptic: fix use-after-free of devm haptic data in hid_haptic_destroy()
Date: Fri,  9 Oct 2026 00:26:03 -0300
Message-ID: <20261009032607.3233482-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mt_probe() allocates td->haptic with devm_kzalloc(), tying its
lifetime to the HID device's driver unbind.  hid_haptic_init() then
installs hid_haptic_destroy() as the force-feedback destroy callback,
which dereferences haptic->hdev on its very first line.

When the HID device is removed while a process still holds an evdev
fd, devres frees td->haptic at unbind time, but hid_haptic_destroy()
runs later from input_dev_release() when the last fd closes.  The
callback operates on freed memory.

The existing get_device()/put_device() pair in init/destroy pins the
struct hid_device but does not keep its devres allocations alive,
since devres runs at driver unbind, not at the final device kref put.

Replace devm_kzalloc() with plain kzalloc() for the haptic struct so
it outlives the driver.  Free it at the end of hid_haptic_destroy(),
which already tears down every sub-allocation manually and holds a
device reference that keeps hdev alive until the kfree.  On the
non-haptic path and the pre-hid_hw_start error paths in mt_probe(),
use kfree() instead of devm_kfree().

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: do not free td->haptic on hid_hw_start() failure — if
    hid_haptic_init() ran inside hid_hw_start() and installed the
    FF destroy callback, the internal cleanup already frees the
    struct via hid_haptic_destroy().  Only free it on the error
    paths before hid_hw_start() (found by Sashiko AI review).

 drivers/hid/hid-haptic.c     |  2 ++
 drivers/hid/hid-multitouch.c | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 8760eeb08..6c365dbf0 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -406,6 +406,8 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	haptic->hid_usage_map = NULL;
 
 	module_put(THIS_MODULE);
+
+	kfree(haptic);
 }
 
 int hid_haptic_init(struct hid_device *hdev,
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4e19a0c4d..f4d8d640d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2132,7 +2132,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
 		return -ENOMEM;
 	}
-	td->haptic = devm_kzalloc(&hdev->dev, sizeof(*(td->haptic)), GFP_KERNEL);
+	td->haptic = kzalloc(sizeof(*(td->haptic)), GFP_KERNEL);
 	if (!td->haptic)
 		return -ENOMEM;
 
@@ -2181,12 +2181,14 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_parse(hdev);
 	if (ret != 0)
-		return ret;
+		goto err_free_haptic;
 
 	if (mtclass->name == MT_CLS_APPLE_TOUCHBAR &&
 	    !hid_find_field(hdev, HID_INPUT_REPORT,
-			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX))
-		return -ENODEV;
+			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX)) {
+		ret = -ENODEV;
+		goto err_free_haptic;
+	}
 
 	if (mtclass->quirks & MT_QUIRK_FIX_CONST_CONTACT_ID)
 		mt_fix_const_fields(hdev, HID_DG_CONTACTID);
@@ -2206,9 +2208,13 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_ALL);
 
 	if (!td->is_haptic_touchpad)
-		devm_kfree(&hdev->dev, td->haptic);
+		kfree(td->haptic);
 
 	return 0;
+
+err_free_haptic:
+	kfree(td->haptic);
+	return ret;
 }
 
 static int mt_suspend(struct hid_device *hdev, pm_message_t state)
-- 
2.43.0


Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CEA415B7B
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426404; cv=none; b=ZldQlFsU7c4xbv1pUh17eq7+rP5rRn7taXCOhCXXjqvMEyVxBE8WKWPR9wqjsW4qrhMzeeDZuqINPjTJAOTjylJ+c//iYizkTCm+2BksUlMa2scwFSc3IWJ1iqfnGaX5/5Lr7hVFTEanP5RIos4muohU0HsgpucAkSTLPjFKomk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426404; c=relaxed/simple;
	bh=xIajdwp3UXaS5EFZENA7x4jgBGOmg59ClMsUOv8AQMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrsCm25uyME6rBSnEHf0Rk5h5xN5v/7DdwoN+ILMlIcVfyu2q+Uc7PV4t9SHPM+XNb/3wKpYzPblF+vJov2A+ZLTc3dwOxwEWIVWXtF8umP9aEKnF/ifv0bGWFuLfxlm/czUzpgrlLSQsiACUuHiFWhcekFbzcOf8XLxyJB93N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLCpnCnA; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLCpnCnA"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc149372c14so2544883a12.1
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 15:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426395; x=1790031195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4fkv1qRouOwCooBcv9E2ZIq98f5GRAhZGGtxGx4jV5A=;
        b=FLCpnCnANbRXTJfa/C9vR8x5W6mFDjIU94tHAD1GyfgYxOjHd6QBIW4ZG2y/2AAtYP
         5zqlYNRlv1B/Hj/sk6LPJ40FH46FwKnSO3slCpPIrmJtwptZvpEsDV0u7HQ5ly/nCqOD
         wmRUt380RbdILETUGenksR9kyz+p/hC05AY1Ctfz6deh9F/gC66VLFnfrIKNIeumFsJ3
         3bshzR9yYdtICAuD71AXtYAkfrl39ACGhBvmLCrCp13bmA6gMB7SIkMedejZ3O1i5gzj
         CDb24ZSlQ4i+N3TqFeQD8df2XgxpiV7WYeJMG9LodCSje47ahgK16yNK7ZuPc5FDorqN
         r+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426395; x=1790031195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4fkv1qRouOwCooBcv9E2ZIq98f5GRAhZGGtxGx4jV5A=;
        b=0UEdKBbOrY+UJSxxhJlkV87A9av9OXxyQKnxqAzVs+7yAAG1gbXc2B2Nmi+SnbB5P+
         Gd7CBxSsLVuaBVyppGWN3DHytK4rC9tbXbxkpF2Gt1H4VeT3YDwn8b8PYbrUi/0rwt8C
         1DQIjVKjhG06cFFjRcuIIQ0Nl73Wzj1/+WMo13AF2SWTjFlGNYA0dCe1wDjRpQVIDqFA
         hcjjrE9nuz4YnRxddksso9MPylSvegIa1lPEJ/pMTykr7raxBPtOxRur68joXg6ObZb0
         HK186tnXgiukMfTRkOTKVfExWEOslsjR8V7UN8D9UQewW9T85X4oJChoVUb/ow+EUnZH
         UETw==
X-Forwarded-Encrypted: i=1; AKwUvBxrTS6i8fpFG/Hx3ylc6e2UQrFIJDZTB9/vBKB4X/tvZnho7dUz3ERzMgqCtVNFmobhlrYkU/c3f/ZQxA==@vger.kernel.org
X-Gm-Message-State: AFuF++lPpJj5fBZCzDQ9EvXxece/oZHIdXK9/4JzZnaepQhELYqDSSXm
	xQKAEi3jHvnV61geElTHFFRWun+LtZaRz+uVzb1NHeIN25Fur7XDoWi2
X-Gm-Gg: AYBFou13m349ggeBU5OC9I6TkyDFMUe9CRBzaO3xUq1UGg62W7PuDmd1tdYbDbJ2JKS
	idfefggIZlqV/T96Ada1kfPfEg+o5TILM0heR4iiGjBVPEyC8I06UPcdES1P0XyrcBsPcnD5aGC
	T+epV5ZBiQ0mD5xkvRy0J68c3Fq/Mvxsmw07bTQMrJI76nlQXj8xJA569x5WLr9LQbuAbqdxbWU
	+AiBEDf+LB84CrakbONrrH+kw4zsLQkNyIgWoPDb4q7ATTyJq8/yelYOHSz6MWjZw9pZHjxgqMO
	tL8+PQpVbPEAUjK1bXck+9eBGnYRnss3z+fNFO74Sw5Zx63YmYfcvqpzCJO+cNg3x2tY/E91kYX
	RHuFIjfpOyLi1nLJ2qUDqo3huYTQxJg84jRIh76vl+U0mrfz/lO/jcp9RO8BIyHAQEZ+wUJuv/w
	h1AN6wpMyJO06qYo9l8IJadVogbRiUWsx1AiTHX9WwScOWuUeeNijRxbIk5Gnv3AgQDwZu/chiS
	+cK2KMddYf5UGdMqNLlJRCA1M2xSnBVLonnUhu73HdMIsS9dEzC
X-Received: by 2002:a05:6a20:3951:b0:3d3:af85:eb98 with SMTP id adf61e73a8af0-3db40694c9fmr9691158637.26.1789426395459;
        Mon, 14 Sep 2026 15:53:15 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:15 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH 07/10] HID: hid-lenovo-go-s: Move attribute init to after device query
Date: Mon, 14 Sep 2026 15:53:00 -0700
Message-ID: <20260914225303.868569-8-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914225303.868569-1-derekjohn.clark@gmail.com>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently this driver registers attributes before the MCU is ready to
accept commands. This can lead to attribute access that blocks the MCU
in some rare cases.

Move attribute construction to gos_cfg_setup, after the device has been
queried. Gate creation to drvdata.gp_registered and
drvdata.rgb_registered so a resume before setup has run doesn't prevent
attribute creation or attempt to re-register the same attributes.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 68 +++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 6d98fff6d987..f1a0bcfcdb71 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1452,6 +1452,7 @@ static struct led_classdev_mc gos_cdev_rgb = {
 
 static void cfg_setup(struct work_struct *work)
 {
+	bool gp_registered, rgb_registered;
 	int ret;
 
 	/* MCU */
@@ -1497,10 +1498,53 @@ static void cfg_setup(struct work_struct *work)
 		return;
 	}
 
+	/* Pairs with smp_store_release from below */
+	gp_registered = smp_load_acquire(&drvdata.gp_registered);
+	if (gp_registered)
+		goto try_rgb;
+
+	ret = sysfs_create_groups(&drvdata.hdev->dev.kobj, top_level_attr_groups);
+	if (ret) {
+		dev_err(&drvdata.hdev->dev,
+			"Failed to create gamepad configuration attributes: %i\n", ret);
+		goto try_rgb;
+	}
+
 	/* Pairs with smp_load_acquire in attribute show/store functions */
 	smp_store_release(&drvdata.gp_registered, true);
+	gp_registered = true;
+
+try_rgb:
+	/* Pairs with smp_store_release from below */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (rgb_registered)
+		goto update_kobjects;
+
+	ret = devm_led_classdev_multicolor_register(&drvdata.hdev->dev, &gos_cdev_rgb);
+	if (ret) {
+		dev_err(&drvdata.hdev->dev,
+			"Failed to create RGB device: %i\n", ret);
+		goto update_kobjects;
+	}
+
+	ret = devm_device_add_group(gos_cdev_rgb.led_cdev.dev, &rgb_attr_group);
+	if (ret) {
+		dev_err(&drvdata.hdev->dev,
+			"Failed to create RGB configuration attributes: %i\n", ret);
+		goto update_kobjects;
+	}
+
+	drvdata.led_cdev = &gos_cdev_rgb.led_cdev;
+
 	/* Pairs with smp_load_acquire in attribute show/store functions */
 	smp_store_release(&drvdata.rgb_registered, true);
+	rgb_registered = true;
+
+update_kobjects:
+	if (gp_registered)
+		kobject_uevent(&drvdata.hdev->dev.kobj, KOBJ_CHANGE);
+	if (rgb_registered)
+		kobject_uevent(&drvdata.led_cdev->dev->kobj, KOBJ_CHANGE);
 }
 
 static int hid_gos_cfg_probe(struct hid_device *hdev,
@@ -1510,30 +1554,8 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
 
 	hid_set_drvdata(hdev, &drvdata);
 	drvdata.hdev = hdev;
-	mutex_init(&drvdata.cfg_mutex);
-
-	ret = sysfs_create_groups(&hdev->dev.kobj, top_level_attr_groups);
-	if (ret) {
-		dev_err_probe(&hdev->dev, ret,
-			      "Failed to create gamepad configuration attributes\n");
-		return ret;
-	}
-
-	ret = devm_led_classdev_multicolor_register(&hdev->dev, &gos_cdev_rgb);
-	if (ret) {
-		dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
-		return ret;
-	}
-
-	ret = devm_device_add_group(gos_cdev_rgb.led_cdev.dev, &rgb_attr_group);
-	if (ret) {
-		dev_err_probe(&hdev->dev, ret,
-			      "Failed to create RGB configuration attributes\n");
-		return ret;
-	}
-
-	drvdata.led_cdev = &gos_cdev_rgb.led_cdev;
 
+	mutex_init(&drvdata.cfg_mutex);
 	init_completion(&drvdata.send_cmd_complete);
 
 	/* Executing calls prior to returning from probe will lock the MCU. Schedule
-- 
2.55.0


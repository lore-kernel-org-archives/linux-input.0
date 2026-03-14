Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7026ED4F
	for <linux-input@vger.kernel.org>; Sat, 14 Mar 2026 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773450341; cv=none; b=Hs8+oVwE42e6F78Gdr/hu68Dar8dPtPJXHwQJvQqbc4U2ezZadEzPzG7GJIzqHybEUSPbfW8KGUIvIMxgBhQBGiciycj5pmUcXi5efujeR3ZclqK4a5P4dpahsyPiC2G4UnKGnHZafUh83MJQwnrE1Tez/x0gSvn22V5KxoG3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773450341; c=relaxed/simple;
	bh=U5owSX045Ib0ahybg1me7g+qoWpff+IWRo4y6Hv88vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ih+1LtbJ1rqcO122sEZO23DneRmrpc9pmm5oppD2Bn4fKMsFGxGvAIzkGm8Q4ZOuhpxLA9HWVZ/VTDcWWS4seWDXwCxpYSESUH7IRpZT1TGHIjCPfOkdrk6jNt8CXrSTm1rb2TYTlm4KK1NWreBDThxzhzF+g/9mOiOqnU6UHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+TlrZy+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+TlrZy+"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439cb5af25bso3000731f8f.1
        for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 18:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773450339; x=1774055139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fflG4TjEG/VcWRgaf7Cfa5vhuhGA88Qlq712W7KoR88=;
        b=P+TlrZy+GLDArdUWYw92xXv3myzp/rURD+mL+itUpk9CCqzuXf2ISlB2imV6dXtm2a
         7Tu1/XEAc0u8q6lW7o2eG1guSRYr7CP9bRdd8nESt9UCkurRJydap2oo70gahrhUi81o
         kziP7eSUYBwsaUHPrABFBuvRAWw2YJOvn3aUn4yNWuj6DhQ3xTFz/8J+OUK3Fftzm+iS
         GuWp0naKpydF/rFJLnflbNmoEC3aY+0UCU5HGlrVwcbVTFNUpJF30t/FbJyS5K/jWDOW
         lxyvo6ZkxPqWAp5znnN0N3sq2s8GBaUyC0z92ryWaBRbsqurVAt9QSe0EtTLzcxtb3zn
         zA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773450339; x=1774055139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fflG4TjEG/VcWRgaf7Cfa5vhuhGA88Qlq712W7KoR88=;
        b=jeWrTw770QnkKjvMbZkqz/zX7x4kv+VhqSrXhDNIHTICKOQTtm45w41R+iXzejITyK
         LiXUw9rlQhUKOVrtKA1JpUF9Wx5ZFHxwqW/iSBGLtfmhD3PWUV8lHKbQM9vWu3qxwaw6
         GsT98v+iJF86TYeOpGljF9xIvZIrBkSfRyUFMJjKShlZ8AfI2CC+4QvlLawexPJgw9NO
         0r6radU7yHFE+FipWBFgTevwu4U+PH43NEb7oKFK91Xoa2vdwiD8Hjr/sG47VVtaFaVe
         ucJXPYZ2N7+XrZmRbOIXnOqpDAI9rolc1YZGedPVvJHawFkpGNtN0E9rS4VGOM80DeJ4
         KuQg==
X-Gm-Message-State: AOJu0YxtzULIGmxh1FgkIs2xgnNBwy0fUldB0WYM8okP2pSXvIwXw6+B
	gJd/u4aRpSxrB7MxUTS1TzdDXeTg0RTCWI4U4dCv4Bgk21W3/mwNCgD4TN9HTD5QnS8f
X-Gm-Gg: ATEYQzxXPi+ZqbNtFO+DJSBSmw9Og8SDxT3LMvL2faQ3bYaIyDxWA06VExugXyY5zSc
	p5VTSc63EF9eJkM1oMOj1DAlrK5sTiwi628hmIZssoWPWy9WHAAKRw5cNx5B1B9P9nbratNbH20
	WBhXpuU/BKyhlYM9taAxCFnNEW04Y/kL5/vZ/R8QGHo7ADegXs4o3m3uwT/LZOLBXHsy0RK1cVx
	u0QYldJj4s/KAVN5IMHESbvRiRYae+jibs8u32xDLz9KHXpXU11uTlwqI8kn2LV/tTq/Ya7/YzP
	9SXIpaGNmofpl69xcEBSsYuYDOtV+NfVRcfOHWs7I/eHJ7ocqGnRn3yrHxIO66AeAJNlrx2u1Dg
	mnimD89WA+w3MGtUVQQSvjnRiHVfbJ1eJR4vE/OEo8xMkye14Gt4C8QtZcVIeNND97SXnf33Na7
	eaMvv+I+o0Dj+/SPqGFzOTKVh7vYmKJqbEDv4D+w27ts8ckiboARud09rK68E58t8S5jpZowglX
	zwFIzxMjTlqLjdSMD9iiqfdbo12/IQ52SxXc/u69oyCN54rY7hjiiYx1iHoC0Bz44UG5STYbDhn
	xX3P6sEUwHXFVvo=
X-Received: by 2002:a5d:5849:0:b0:439:ca1f:3929 with SMTP id ffacd0b85a97d-43a04dc0e02mr9324311f8f.48.1773450338480;
        Fri, 13 Mar 2026 18:05:38 -0700 (PDT)
Received: from sissix.lzampier.com (92.40.172.137.threembb.co.uk. [92.40.172.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a03cfd18fsm13059963f8f.36.2026.03.13.18.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:05:37 -0700 (PDT)
From: Lucas Zampieri <lcasmz54@gmail.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lcasmz54@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v7 1/3] HID: input: Convert battery code to devm_*
Date: Sat, 14 Mar 2026 01:05:28 +0000
Message-ID: <20260314010533.110278-2-lcasmz54@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314010533.110278-1-lcasmz54@gmail.com>
References: <20260314010533.110278-1-lcasmz54@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the HID battery code to use devm_* managed resource APIs for
the power_supply_desc allocation, battery name string, and power supply
registration.

The error path uses devm_kfree() to clean up allocated memory if
devm_power_supply_register() fails, preventing memory waste on repeated
setup attempts. The hidinput_cleanup_battery() function is removed as
devm handles cleanup automatically.

Signed-off-by: Lucas Zampieri <lcasmz54@gmail.com>
---
 drivers/hid/hid-input.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 395138372..7e0f971ef 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -526,13 +526,13 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (quirks & HID_BATTERY_QUIRK_IGNORE)
 		return 0;
 
-	psy_desc = kzalloc_obj(*psy_desc);
+	psy_desc = devm_kzalloc(&dev->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
 		return -ENOMEM;
 
-	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery",
-				   strlen(dev->uniq) ?
-					dev->uniq : dev_name(&dev->dev));
+	psy_desc->name = devm_kasprintf(&dev->dev, GFP_KERNEL, "hid-%s-battery",
+					strlen(dev->uniq) ?
+						dev->uniq : dev_name(&dev->dev));
 	if (!psy_desc->name) {
 		error = -ENOMEM;
 		goto err_free_mem;
@@ -574,7 +574,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 
 	dev->battery_present = (quirks & HID_BATTERY_QUIRK_DYNAMIC) ? false : true;
 
-	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
+	dev->battery = devm_power_supply_register(&dev->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(dev->battery)) {
 		error = PTR_ERR(dev->battery);
 		hid_warn(dev, "can't register power supply: %d\n", error);
@@ -585,27 +585,13 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	return 0;
 
 err_free_name:
-	kfree(psy_desc->name);
+	devm_kfree(&dev->dev, psy_desc->name);
 err_free_mem:
-	kfree(psy_desc);
+	devm_kfree(&dev->dev, psy_desc);
 	dev->battery = NULL;
 	return error;
 }
 
-static void hidinput_cleanup_battery(struct hid_device *dev)
-{
-	const struct power_supply_desc *psy_desc;
-
-	if (!dev->battery)
-		return;
-
-	psy_desc = dev->battery->desc;
-	power_supply_unregister(dev->battery);
-	kfree(psy_desc->name);
-	kfree(psy_desc);
-	dev->battery = NULL;
-}
-
 static bool hidinput_update_battery_charge_status(struct hid_device *dev,
 						  unsigned int usage, int value)
 {
@@ -660,10 +646,6 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	return 0;
 }
 
-static void hidinput_cleanup_battery(struct hid_device *dev)
-{
-}
-
 static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
 				    int value)
 {
@@ -2393,8 +2375,6 @@ void hidinput_disconnect(struct hid_device *hid)
 {
 	struct hid_input *hidinput, *next;
 
-	hidinput_cleanup_battery(hid);
-
 	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
 		list_del(&hidinput->list);
 		if (hidinput->registered)
-- 
2.53.0


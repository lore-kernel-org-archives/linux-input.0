Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8163E958C
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127791; cv=none; b=p6NhhHTMmq5W8wt4V2oXnFQO2d2QJvnJAbFZOhF2MA4k/V6byFoweoDaSoY346gtsopPZbpIdMdMK4iOy1W8TI22QiiFuXq2iVg756RVWf2f+2kJbP+3aD7IfSgc8RFCDpCRlpAI5koJaOwBj0NUGm5EKrXGde7uKoF4cYJPWtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127791; c=relaxed/simple;
	bh=FqJg3tER+3ZakLbAqodEwX5qMpqX5ohA1t7cv/evT/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXjpEUdubGm53cXX//u6TaGwkdJsUxruZsJ/64mVjd84MOsSRcaOikhsGYK/29Ah/yRDJmDgdhpZgihvuab1dPQCjf/ZIMhstaMyHzkQfoiMOl3LNuepuNAAvutLdBK6j1X4KE6ETrtNm+dru1Mf3yJZ+ewEiUm5ENrgtPaOK58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke85yFH0; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke85yFH0"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so8959726eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773127789; x=1773732589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfIfejfLL8bAkAX0LN1/a1iIMrdC2id01EppEdgKGLI=;
        b=ke85yFH0OglxdcpWrXuZso0k+xZp+5KO3yAfeNuPzEzGmhyD/rECSg6uJ2jXstAnc8
         f+hEDxHbKyvz7es7Ct1P9d8r2A8Ht4wQ7bTIyWGwoGU8+/y5KT4HvoENd2AtpNxMc8tE
         n23gMWIeHV+f4CXpIpa8VNr/KI2MJ01LSnrwAIwUk19JCn26lFU40F4+Ms1rbdBDGGOS
         VhqiTs0UitWevlNtJJX1xFQSRp8Zx/QWxU9E6N1w7qGisoGruxIS3+gmoaueqbZCN2EK
         9qvm1yFa5yPX5n1lUKGvPIEa/WAWt28vtbdr1w3Xj7qDHBH6/I7puE/EvN/puo5wvgR3
         qnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773127789; x=1773732589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rfIfejfLL8bAkAX0LN1/a1iIMrdC2id01EppEdgKGLI=;
        b=idgu18VPt054G43XI+glT2qq5RFLxfyVdeZar9rq2Lsh011v3C7yKh5KtqQvkpI8yz
         txakPkWVjuwrxglnd/B8ORe4aP3HfaPdlGceG5xTnOv8rCMqoNei22WJqnYv2mfCu23D
         CW08+TUj9YEnK5rvR/wPYCBpVSNUmHCNwau0KjVVRkQTZnvIPPpALnMyXeMQC+yiHY1n
         26ZKlfiW9mdOMrSdQoBAjZ64S1UtJwSNv/xy3ABjvZgfqu7IB8e21Xwj4bYCTmZoQwjd
         PZ+cwIy0AHimg/fCOHsqYZje53OPzjbjGBxjfell1KjBw4CX5Nd3LL1Bk+D8Y+2L3r7B
         gqcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHmxyUUguq85IpxoWeSRPr3tMm6lax+ZkoToSioEDtPPfPov2fJ4W1cShQw3mb4AQGc9VmCkhBfGoRHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOAZR5YgZIyVHjD2JGDK32NU3YoYcUAIL4QFRM5lo539VZ6kft
	5w4Pc8STmxUomcsbAxzCMK26q5h8ul23gYkJcxqsvTFz3xwHdU8EvwH9
X-Gm-Gg: ATEYQzxPruyoPLLnts3jecFwmL2DUvri0jBExJenUUv9mGkyyrxVGwhj7PtlI0ihtJ2
	IxY8HDvpFKi8F6IPmRJLxy0eE8RGP1esXBJIjvD2m1Bs5+fj2oZv41S1bHqAPImtmvAlfVH5bQ1
	dbuNDYTvIxptCfEkXipfUTex87tccDHV4orLBRzi4/LSsBpccs/BpbqdP4RpGjIAAlqL1yZYURr
	JLwTvSlzeLITUrD4ffJWetxO09HX529ae75+5g32VY1WVo0FHuQlzuxV4qgAjh8FsWhOEEfPn+U
	fZCCYfWdACDR7YuWsDHVbFhifPwzx1CK5lKfnbiWhnzCq66cjT1UO7anMeNca2FPjSfwN5KwZR0
	WTmaRFKyyRX9G9gnSMXf+4M/kI3RMjdFJamz94Lxx8EvSWJmRmQMRgiEuAJViM0+1KM64yKuPsL
	bILpxGbfcZ4xj1rI1yS6cyK1TPxpuaR3L6NUojFNSsoOh0o35z75CUUQwc3nhQuREFUP3PbRE1M
	/9s
X-Received: by 2002:a05:7300:3724:b0:2be:27db:b16 with SMTP id 5a478bee46e88-2be4deaedb6mr6266093eec.15.1773127789119;
        Tue, 10 Mar 2026 00:29:49 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be81209142sm721925eec.12.2026.03.10.00.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:29:48 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Richard Hughes <hughsient@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/19] HID: Include firmware version in the uevent
Date: Tue, 10 Mar 2026 07:29:27 +0000
Message-ID: <20260310072937.3295875-10-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
References: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Userspace software fwupd probes some HID devices when the daemon starts
up to determine the current firmware version in order to be able to offer
updated firmware if the manufacturer has made it available.

In order to do this fwupd will detach the existing kernel driver if one
is present, send a HID command and then reattach the kernel driver.

This can be problematic if the user is using the HID device at the time
that fwupd probes the hardware and can cause a few frames of input to be
dropped.  In some cases HID drivers already have a command to look up the
firmware version, and so if that is exported to userspace fwupd can
discover it and avoid needing to detach the kernel driver until it's time
to update the device.

Introduce a new member in the struct hid_device for the version and export
a new uevent variable HID_FIRMWARE_VERSION that will display the version
that HID drivers obtained.

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Richard Hughes <hughsient@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hid/hid-core.c | 5 +++++
 include/linux/hid.h    | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a5b3a8ca2fcb..524f2b9ed512 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2887,6 +2887,11 @@ static int hid_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	if (add_uevent_var(env, "MODALIAS=hid:b%04Xg%04Xv%08Xp%08X",
 			   hdev->bus, hdev->group, hdev->vendor, hdev->product))
 		return -ENOMEM;
+	if (hdev->firmware_version) {
+		if (add_uevent_var(env, "HID_FIRMWARE_VERSION=0x%04llX",
+				   hdev->firmware_version))
+			return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/include/linux/hid.h b/include/linux/hid.h
index dce862cafbbd..ce728c8d5bdc 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -698,6 +698,7 @@ struct hid_device {
 	char name[128];							/* Device name */
 	char phys[64];							/* Device physical location */
 	char uniq[64];							/* Device unique identifier (serial #) */
+	u64 firmware_version;						/* Firmware version */
 
 	void *driver_data;
 
-- 
2.53.0


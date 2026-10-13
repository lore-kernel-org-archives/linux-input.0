Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30BC52189F
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904547; cv=none; b=YFI0ZUcuQoJb7i0l/ZmAIqmSFlr1in19sEE7Ro166zY2GtX6+KrSBnTYiVRvEKwdHyV17kTvtu1OFASrk9y0hLG6vRaxekLbBOC/orQYvsca0qKvSbZt6kAGSDJ93Cnf3/nItBACE1Gv8LImPSmp9fkAhui9Hw2iClBi5Zg7dDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904547; c=relaxed/simple;
	bh=4oUcfn/aG/2LlccdeXopD+FbwSKNU7W6lskF/8Ob8uY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Suur5JCvLU3InOCEfrGwyQvVSgeswbuaQUZ7bnLYi4COb4DDYIcXV6kbmvXQNYOt3aFDSgKGzOzP8dEwnSJOow8F3wUd+N9c/VNICAu8zp4LioemjFq7ifkfFeYEtVk0dZxgBapSG0XRFmSPQUnehvSGHW946anzWnJWF+8wa5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=Gi193gQM; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="Gi193gQM"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30b6dad2382so7112916eec.0
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791904545; x=1792509345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YzTa31p3mVN/sH8ialORwNcbJ7+oKPie6pSClyvLsIA=;
        b=Gi193gQMliDZwYnnckZGPQepqq/6mTtLmHehvxcuqmUwtbZncJAx00gZIHuEL/q/8+
         MDkvwmdMAyMmMvh/KFI4GJzN9iSyOOXOsJYj0fYbsfaDBN73jIXNqz2U2N+/hW32Zf58
         hYKVoogrEyB/t1KdjLJ06e83kRGaoHwy2C4rLyG0ndgHfU9FNtSGShOI+/GTufyMDI1A
         RH4R9sdwhbUlaibW7jdKFwWjzqRImhtY9ZWCzGh3sHa+fT+T1bu0/aBHCxRU3NN1Fv7+
         C8jzLl46o65mhKdXC+VwT09TvPhL0cmKyzZ4gU/dB301hebxSFOiFdMy1GzKCTtFbyc5
         En1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904545; x=1792509345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YzTa31p3mVN/sH8ialORwNcbJ7+oKPie6pSClyvLsIA=;
        b=0yD2hUDh46/JorgDkDU6iMDXn5ZKD6AyjQ/Ak9edxSKOFC4qJl327tfGeeXHzjswJ9
         Rhx09mHqlvfvM8qPdnYVMEMfNv0dRIP1BGmZdWPaBo8FwLHB+bxYXCF4nHfubgc4CCT4
         FxRkUjSFrQjnWBvS3AjK+swQ4EiFgBRqvRoXNoTzUMMOsDMU2D6NRXOgnUY5UDeoS+Gx
         NL1XaTohQfUfs9hu0lvz15D2HKhP6Ex/ar6OhagJauimBgpk9sTEiICHfpWt8SAiYiOX
         PMyA14o69ZvvcPQPaopXWiE1lsILaK21Y3Wwp6Am0abJbPukC2twyWfw1YsNoXMyg8Xs
         NCkA==
X-Gm-Message-State: AFq9FYJntFh++bbDWPkisssUtPe+6uZrpuBN5PtFtFW7ZVoYUr4MzTf6
	N0CAbsIDrDJxMsEVyC0BmXPwlGkz3RBIXopKZeSc3qnUY8fhBn8/+dT5N9jUWZRCbhw=
X-Gm-Gg: AYBFou0i7d5F2YmUbhDZeZvZk2vBOu/u8ezroLux2Ph1/vhlWItAx1HFjI4H7c5dDCX
	4CJ+NzMekpI8mpmi+P0h1GbYN9GcTl7XAornkuIH4b6eHsuZMfZyKNQkloz4b4iBmXOyeSMFHoY
	cd6J+rFC/HhO9TNQZVQ3MQGtCfPS8XWfzQdDyc7Uvhk0KgQVjko7at0cFngMGLRQesdndvdRSS5
	HurmQALmDBIpV3fcMyNqhAFTBOFu3V+LUBcegyhKkeFjcRILOecg1Gul3UiCfPvPWyT/p0Yanoo
	rro4BViudAV9Xe/We/64v7d/wD16QLaluJz+t56AwNTXW9fc01sykP6xbLBhv/CNinPCt2xA8i9
	C2dHSGYLK7TOVb/1mhLeuR34NCKh5qGWCrevmIeJShnmlVCkYazgX/Ad9TF7c/ETwNMwgbS13lv
	NiK3DLB6GaM6mtDzFS2is/Yg+R/78qWSayjFx4wg+7BODokfth35D6nYQNxwkRaQpfM04hNmEWC
	MVcINxcIGiH6fk=
X-Received: by 2002:a05:693c:895a:10b0:351:1e72:7470 with SMTP id 5a478bee46e88-3537e04414emr18187121eec.13.1791904544676;
        Tue, 13 Oct 2026 08:15:44 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:49b8:4c98:b3d1:72aa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-358de54fe47sm30691751eec.31.2026.10.13.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:15:43 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Tue, 13 Oct 2026 16:15:23 +0100
Subject: [PATCH 2/4] Input: misc: use named initializers for acpi_device_id
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-acpi-input-v1-2-53ad09ba82b7@thegoodpenguin.co.uk>
References: <20261013-acpi-input-v1-0-53ad09ba82b7@thegoodpenguin.co.uk>
In-Reply-To: <20261013-acpi-input-v1-0-53ad09ba82b7@thegoodpenguin.co.uk>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Nick Dyer <nick@shmanahar.org>, Hans de Goede <hansg@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791904532; l=2702;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=4oUcfn/aG/2LlccdeXopD+FbwSKNU7W6lskF/8Ob8uY=;
 b=Os3WfFvBA/IGfHGvBo8P3yLDwk4fQu1+7P1UF52NZo5URi93Zzs6fHaSN1TE3h7WSbX2hxsK7
 h4dIysiLhVCBQYdMK4hWkNpieqUR9Lrjflv8qN83NRWPV99bwlmvJcC
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Unify the list terminator to have a single space between the brackets and
no trailing comma.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/input/misc/atlas_btns.c       |  4 ++--
 drivers/input/misc/drv260x.c          |  2 +-
 drivers/input/misc/soc_button_array.c | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
index 5805a1a3bb05..e77e53ee9d41 100644
--- a/drivers/input/misc/atlas_btns.c
+++ b/drivers/input/misc/atlas_btns.c
@@ -128,8 +128,8 @@ static void atlas_acpi_button_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id atlas_device_ids[] = {
-	{ "ASIM0000" },
-	{ "" }
+	{ .id = "ASIM0000" },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, atlas_device_ids);
 
diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 6c5c4c53753b..8a3d74d65d63 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -640,7 +640,7 @@ MODULE_DEVICE_TABLE(i2c, drv260x_id);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id drv260x_acpi_match[] = {
-	{ "DRV2604" },
+	{ .id = "DRV2604" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, drv260x_acpi_match);
diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 064243677fcf..dbf86ea778e6 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -603,14 +603,14 @@ static const struct soc_device_data soc_device_MSHW0040 = {
 };
 
 static const struct acpi_device_id soc_button_acpi_match[] = {
-	{ "PNP0C40", (unsigned long)&soc_device_PNP0C40 },
-	{ "INT33D3", (unsigned long)&soc_device_INT33D3 },
-	{ "ID9001", (unsigned long)&soc_device_INT33D3 },
-	{ "ACPI0011", 0 },
+	{ .id = "PNP0C40", .driver_data = (unsigned long)&soc_device_PNP0C40 },
+	{ .id = "INT33D3", .driver_data = (unsigned long)&soc_device_INT33D3 },
+	{ .id = "ID9001", .driver_data = (unsigned long)&soc_device_INT33D3 },
+	{ .id = "ACPI0011" },
 
 	/* Microsoft Surface Devices (3th, 5th and 6th generation) */
-	{ "MSHW0028", (unsigned long)&soc_device_MSHW0028 },
-	{ "MSHW0040", (unsigned long)&soc_device_MSHW0040 },
+	{ .id = "MSHW0028", .driver_data = (unsigned long)&soc_device_MSHW0028 },
+	{ .id = "MSHW0040", .driver_data = (unsigned long)&soc_device_MSHW0040 },
 
 	{ }
 };

-- 
2.53.0


Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE6A525A62
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859158; cv=none; b=GXh8HqcH7ZHuX03iTV2iqaSEXW0PJhXxAYi4pz0g4QF01lrCCXa+7ZxqOJI9IfeNQPJ+j7/Yu6ZcaqapDCj6ADFWm2ygffGhP2uMwvQzpow4NMlNiokn/7V/JMb7ax2bjKhgNsPYzSI98MTm6IUxOV3RIuCN9wh4oSBuVQqk8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859158; c=relaxed/simple;
	bh=wzHJ5AZLh1S4sbm7NQXwPNEFKn8BKSSciphvCkw+aLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMZ5mjYEmeGCNrUtGyPMrQN+h4hDUIhVqPFyVmxcmwEvEYMLw1ScHxuqNexnX0nt7FRhEmIptodw71+i4IFsyPeHGw3Ua3c5dQGzHUF38NE+0+OlrjgXO07N2xjO2O85d+dwc8UTbfefQREXtihYhNpJ2P4jIE0CqRDEeO5/6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=qmOcj4U0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="qmOcj4U0"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso3327854a12.1
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 02:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1788859156; x=1789463956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xSKG1D/i01HPr9XPX9unVriFqaH3a/5SqIW/cS7CsCY=;
        b=qmOcj4U0E6t5KqQ54AVBQUIKw1Xol4uBK0s/EXumSP5B9ETmZgbj4x6bLZhSvTqjcF
         2xLbplzVLO+HD0jG2Qpgc2wnaKlZEbRiKIZS8b42sddQVfAVIAxuX944S9kDbNBvfE3w
         yAm9X92+g6bexLWuglytjxE6Sk1Loal7RlpJYAbRIYbsP9f1IxGQZHz6pqPlIhtPZ28t
         KUlzQ7gjwZF6zqokfSL+Yd5aDOK2dLurK3eFWA81FFd8T3eGrtcsi8TyemCeDsQqTAb4
         UChozgxP0jvVypUYzmUMSgFfKT85gXk+dhiC+j1TxzxLFUi0JY4zzvjD0eRbaRHFm1tR
         ywJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859156; x=1789463956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xSKG1D/i01HPr9XPX9unVriFqaH3a/5SqIW/cS7CsCY=;
        b=ahiYjC7sVeeujchI/qYXiehLsFU5bSr+df14cdTxFixY/kAWjmxpa6hryBVOU2sAQF
         YStDnVt5Iyzox9L9Q4Hug8xBaClZsrDVW6ZwQPRvti9y3U/pdGwOWxM7dA+9icFUWO0x
         2u+us+SDG8X26jHxfLLuucAodbaOHmXhh1a6cLiLVMNC+r9CQXOGeI+258q/uDRY8JcV
         6xaAbUxPZdD/MMfWquYKQgH6p9Vs5M8wkF9nMBBhFkCRSZg2CBXIJwoPTxWhCIHLAzn2
         R/G/UQ5JMVatAGd72eJkOrHPx2cP+drxmeHTbe09xYhgd96pscKjJp3H72V7o0oNt26/
         b5nw==
X-Gm-Message-State: AFuF++loDX/vnpQJz0Ek+M0HEhCt3TrjKEg2oBKRCtL64FdSgJc7FptQ
	4pnO3ygKezVlKeXu3am52T7uEjISb0KTYSDH4OLzAdpiZHkH0PuDDEji4z0isPowLrita7wUoeL
	tdJyy
X-Gm-Gg: AYBFou1TvadoYCncOOLtYbi9aRYHdpeJb93/5LjdIBmCxpHyS3dr6CaNVuMclZkMPLY
	SAqWGL1NfAVyA+zRS2moir3xlbuEOfZga07BTXKXwzHGP9wyXdFL8P81SqtWz4o9LN11Hg5exbf
	dqYHX5fbF80UHUp1b2OV+M/+2VFY1Gzhnm8HiCr95bFBx+jeriL7k04irPfCnTXtyjBeIfTh8I8
	isDHysufystDe6tpMgxS1u4OfZIPf+lis9sl4W6I28o69ELVCKxrhG5qKUiZxY+T3PZ2edllx7n
	0YEYsBWQdQaISA7ttGb/JbKYBlCg2ls3ebEDnfw9uWxpXiQqZKrg5keDNLWhsJ2dYbgbm/GbyB0
	UxwyNS3+JDCANqB9nhhYGkFMQOhNZwDvRUrLrtaotkBjhO3dvtCnvrCxteAToGwPnK8E/iRcuQJ
	aAH2MI/20hsA6WUyJRBhLBoBrnm7aR+f9bIAefpDVPU6sZC+Qv2PgAfkZ6+SALntJRUmdaGeUju
	E3/rQ==
X-Received: by 2002:a17:90b:3804:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-39b25f4397emr42321906a91.0.1788859155665;
        Tue, 08 Sep 2026 02:19:15 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:75be:f01c:dde1:cb38])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm32015722c88.14.2026.09.08.02.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:19:15 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Tue, 08 Sep 2026 10:19:04 +0100
Subject: [PATCH 2/3] HID: i2c-hid: use named initializers for
 acpi_device_id
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-acpi-hid-v1-2-08df24c4b139@thegoodpenguin.co.uk>
References: <20260908-acpi-hid-v1-0-08df24c4b139@thegoodpenguin.co.uk>
In-Reply-To: <20260908-acpi-hid-v1-0-08df24c4b139@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788859148; l=1319;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=wzHJ5AZLh1S4sbm7NQXwPNEFKn8BKSSciphvCkw+aLw=;
 b=uf+1mk4iLkcE9iwyWW0QFbX+TS2t6INT8BNRYRowZ2wjB0Qy+vICZc3tGfqptCelVoc1op7Qu
 +JpstvANQhjBdDUDg4O8bmwkOnBbsfZyd1GPeWVbke2xBQanHvE7EBK
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a named initializer for the acpi_device_id fields which makes the code
more readable and consistent with how lists are initialized in the rest of
the kernel code base.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/i2c-hid/i2c-hid-acpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index 13f977d6aab6..9371db200fc4 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -39,12 +39,12 @@ static const struct acpi_device_id i2c_hid_acpi_blacklist[] = {
 	 * The CHPN0001 ACPI device, which is used to describe the Chipone
 	 * ICN8505 controller, has a _CID of PNP0C50 but is not HID compatible.
 	 */
-	{ "CHPN0001" },
+	{ .id = "CHPN0001" },
 	/*
 	 * The IDEA5002 ACPI device causes high interrupt usage and spurious
 	 * wakeups from suspend.
 	 */
-	{ "IDEA5002" },
+	{ .id = "IDEA5002" },
 	{ }
 };
 
@@ -93,8 +93,8 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
 }
 
 static const struct acpi_device_id i2c_hid_acpi_match[] = {
-	{ "ACPI0C50" },
-	{ "PNP0C50" },
+	{ .id = "ACPI0C50" },
+	{ .id = "PNP0C50" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, i2c_hid_acpi_match);

-- 
2.43.0


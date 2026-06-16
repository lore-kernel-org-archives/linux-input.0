Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A76D42883B
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605598; cv=none; b=oWAWwjGFWwc2CwRBfwy0i+V0kNe+uLhD8l/KHuM55mNDXFp9kukrlHwCnxO/h+yi5Ua/owWdcb30emkMaCFMn/L4sIgxY9NMtxjkpnatBQovwFQ++xsFtDgzS0jAnrCTv8gZbq8e5S6+ebdkd1M59aNCozV3vqBxx9aIsKf+Stw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605598; c=relaxed/simple;
	bh=YatbobhKKz4ZXJqLFkZi6B5c6FYlSQIo4E6cJZYKIBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nh9lBeI9DaVQgxfrZjCmzEPpQn+9DJcErfNXlhj/exw6AhK7ZQJR/RxEy90WlqEjzKnLHdsIx8FEHRUuA0TXKpyru/TGQCoEEEw1ay/z3B5Ex7O9FaMBu//Yf/aDVo+rq1pnUgpC8aiwwMFlers6AZYtVzKdeQsSRY+A6xrhvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b60qy7oB; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b60qy7oB"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so2784161a91.1
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 03:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605596; x=1782210396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=563kewyp78EbqXlKbSAb9Qtc/HGBLkQqxRNmW+0iFYY=;
        b=b60qy7oBt0fqNFTRdu3cMWqfrqgpkvc6hQip2zMfbFgqElbwAgfF/LzQgjrrmyWsOk
         sowKrDiCteTMLS73BIxkJM59EqYEl9tvWRcf/G/NrtyKRs4SnSRdG8WBg8GRigimGoka
         azA2eYXzvzWkiUERhkOzZeSUMWiCMiFwWuAeZO1bVNxZ8abF7kkxgCnWYNyxu2TnmRu6
         qxh8NOdGi0ceXELEjlg7aTA1JyBA+r8PdcysE570Lvj0qQjLG68gKlU3IzvJ5g5ztpqA
         cZjk+Aq06MYtxg0/QFD8dsNMGnDpduAWJo4cijfMtjolENautgbLwO1YujSS9a57DGH6
         amoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605596; x=1782210396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=563kewyp78EbqXlKbSAb9Qtc/HGBLkQqxRNmW+0iFYY=;
        b=hQlMHfR3D1nN7nXziOFLhsU7l1/97j+6jbiocZQwg0+l0JIj0FyBCf8mQksdRy+P3E
         84nPlc8AZZ6KGNGPINkCFuYa9bALhEbXrx2M7WZ4luZ3rQmBAZ2Wj8fx9vc5LkEIL6K2
         c7wDpdcdirIBHxoNY5M87XwfIR0pkJ0d1OrnqoIck2zCRrgqDxfK7gDkUPie+jLMcH6J
         mwhhTiC+N2xRgTBoDz+340KEi8xduSJumCvJqDADK5ramH9er4Wm4oW3oAmqJJgtZXhn
         0pfzhNUHhM7ygVe3PzaV92uPXDl3f8/rYWtPxAZIGs6ZfXx/baz18BrLznLqQmjHOEl+
         V/9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/nzkU6WKd+cXBHKeNOD0mahG8LZXW4dPn3ajACY4MNct8csA+tZ/aQOaS8PB+F9rNnsKLrO70bU2Vipg==@vger.kernel.org
X-Gm-Message-State: AOJu0YznRuRtW1QsFdmQv0f5pPDEaf0JmhyiG9pGnmVD+gdLZDHOS06P
	PEZWSH4J8Hqdk7PArKMTDHAvF7CJzleoOn/lCwN1vHTR8zXo377ugFXO
X-Gm-Gg: Acq92OFBx+GwxBlAGCBtKdD7rGVTqZFJutJpGViIKnW+hW7AHg9n/LfzluuJBTXAaC6
	rUdbdKy4zj7o9jp/Jzx7F6s3GS77J7Z8KVtwk6X41w3pxrDKCvYer5GNnorRNF80PKqzXl7fv0y
	LcmylGRE0A9/oq30nroLoXyEMcOoWhqPBJZCVz0S19cWcTqk105/M7wttj4JiWwxcUJAWGfPk0V
	VJuSANrt3EGJ4Ot0RBf2vCTXn4dMAx90tMKJNKb/V6eTuOBcq9Pkz6BTqLCafEyqvyao/5g0AYD
	EDcT/i2In3iVBsYcw5Ysdg/AVuxQj5l7FCSLYopqdRBMGmeULSR3NbfLRli6WPdiDNAOjf/lOCT
	vkaVrBkoJzDy8PVWZMayV1I+bSu9B09W3QKH4tSetRyV3VeQxsItMDFQuUQWAdW8EaIp6l4SHLV
	WMLdriLhkfw6QD62scrA/GW0/VqGHNyi4AsmagVOhsnVlKwQoV
X-Received: by 2002:a17:90b:258d:b0:369:7421:b36f with SMTP id 98e67ed59e1d1-37c52916561mr2911272a91.21.1781605596401;
        Tue, 16 Jun 2026 03:26:36 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:26:36 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:06 +0530
Subject: [PATCH 01/11] iio: hid-sensors: add missing blank line after
 declarations
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-1-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Add a blank line after variable declarations to improve
readability and align with kernel coding style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
changes in v4:
- Rectify commit message with input from David
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 417c4ab8c1b2..c8ccf96f3d03 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -314,7 +314,9 @@ static int __maybe_unused hid_sensor_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	schedule_work(&attrb->work);
+
 	return 0;
 }
 
@@ -322,6 +324,7 @@ static int __maybe_unused hid_sensor_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	return _hid_sensor_power_state(attrb, true);
 }
 

-- 
2.34.1


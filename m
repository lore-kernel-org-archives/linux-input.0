Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858B4749F3
	for <linux-input@vger.kernel.org>; Thu,  8 Oct 2026 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452862; cv=none; b=mcOLbD+MzkavvM6SQQcQRwrJm5jzQVo1qrEFuaGK0OelV0sQvL7E3DcYeeayXMzzf+Z414BnRQcdu/TQUjSlFZ+xB/lJm/cr7ufVQWViCtXvmsw9e+XK0AZ7HWqpNE7DB2qmDzwTzxf8CP6QqfDB8b68Amg5AdBxNspXd9nbCCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452862; c=relaxed/simple;
	bh=de1VYtZxZuYBiolieKv4Kyss3CVyEfpOMQRSIaZrmXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5/0lPO9hcomZgcnp7EAqJPXpRei2uRfcuYsDfFcz4v4asIBTYVjuGuaI7YStkEX/a9zQAGcWABzzPWTsFBo8qKWDUX6psyv3aEAhhHbNuaIDwxsNMkB2QCz3HpPzepPipjDIY0XtWGaxjBAH4/fsFPSeqXxOwzhLF4Wv9fYuxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVl9lkXs; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVl9lkXs"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3515f9a5d25so4083798eec.0
        for <linux-input@vger.kernel.org>; Thu, 08 Oct 2026 02:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791452861; x=1792057661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P9ZyEwHBBKMRO++jPxVaJMCJG2/++7HjKeORRjTAHvM=;
        b=fVl9lkXsR+sFByD03Xpd8u3QlGcLSuvokB0qNKZ94ag1rvcL4P0Lo+rAjqKQjaPLrm
         lNdOtS6id1shetC/QG/PMJEWv0XYYG35Sio1w4jOfnADKqN/45o/Ql421Bw0HiFQXcnj
         AyPQJ436UAXVGC99G+BJgp5CTuWDkoZFgl93j/Gc8XpGf/F3tXtJ2NqTS+NJ9TXStZJF
         4pfwG17iZt7fbQb9agYxnp+ZPUZftV936BMLuRP1SjuUBLASU0788irNW0lNmnEoRhuV
         Wqto2x16Q9zCoE9kOBCQw/3P6o9seza+FD83wUt+aS5JF0JkK8+mdAVmwy2TXv3EE+hq
         +01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452861; x=1792057661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P9ZyEwHBBKMRO++jPxVaJMCJG2/++7HjKeORRjTAHvM=;
        b=uWiaASNJIJXTMR2c65Ul1XjTN8bfsoICjVN6Zx0lL3SE3ojONn5AMc7jsoaa1eztCS
         WCm+NXUPm30wN8FreU09BXl2tkitX+J/ymudTXPFPcBoTHT7oYqjKbAv7xYUoVjDLf7g
         2G9/buE6edC2q8yyOqTGSpWv/ZRMRf26a27Cx1E9FNaWhm0nWOI+QpZWavAJdfKQcsOe
         5pww/QZiz/8bA0K5FvrIZ9giAQLSShD6IO/+wNbvVIRuiMO9zpE9MK/h3OS0zwk4E92+
         OWFq2NAGvcrb7Y9nsaqe2db1h13wjleFef1jTlkZT2E9/WRKdhPpkaseutK7s+cwtBfH
         Vc2w==
X-Gm-Message-State: AFuF++mvs57xZEnHoAdfMDnyAvq3uc4+BniihkBXF9pQlznu1sD4ahnu
	O6ZSUgs+hvC5wGMddAmvVogHfJZx1IexF9jai385QW2vl0G7MZ5o+SHGLCkGxpiEZ3waPw==
X-Gm-Gg: AYBFou1cRjWiw7hML278cf42V64Yc2CkyUUzMzqO00A0qIHSzu1iCLKXmGNUWH3ESlK
	chOt7LP4x8I95Vvbe8kQ52ijNRQonP4lUzFo22HX8kXwuQA33ALYKRrowvsFVGw/PqlXumeusjd
	yB0nff8ew+Olm0zThRpf2CoOBOYBxFZ0u6ldVFWiXv4R1oOMCyQw8bvnDmyW8rBpaGjQj5GMaDR
	Dmz/n9rWPQSEw2WIY9IBl6akNlvip4TA6lCLho/qpD9x2inF2KUfyKDbQkftNnqVVNOpjJB3LmF
	lBpEJSUcJDypJ9WtI8/OpakiclQv+6gn+OmuX1V2IJO9qfRwEXYCannFdbENidzYmfxvmbbQnAd
	0zkoih5LZ2DT/3wKgk6u+LFnst8OknbOpBeUJS+ZIXenbXTfQjvR+n0avy3jBRNke4sF73ByXSK
	ELcGkR3cDK9G6ykNTw0uXrdOnapKRBhB6YiLbssB+IcfpRNQKiX37OViPeUZZLnW5w9j6G6piKa
	YA+kv8sO0c+V+koXYQLoVJTLPxscB//tqX2SvTZ45d14Zktr+pzJjxn/JcqQpg=
X-Received: by 2002:a05:693c:820b:b0:342:547:cc49 with SMTP id 5a478bee46e88-3515de373e4mr6689477eec.25.1791452860606;
        Thu, 08 Oct 2026 02:47:40 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3002:e11e:c053:ebcb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aeb5c00sm14994424eec.8.2026.10.08.02.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:47:39 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Support Opensource <support.opensource@diasemi.com>,
	Roy Im <roy.im.opensource@diasemi.com>,
	Dan Murphy <dmurphy@ti.com>,
	Yegor Yefremov <yegorslists@googlemail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Input: da7280 - fix input device parent assignment
Date: Thu,  8 Oct 2026 02:47:31 -0700
Message-ID: <20261008094736.918137-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assigning the I2C bus controller (client->dev.parent) instead of the
I2C client (&client->dev) as the parent device after
devm_input_allocate_device() causes input_register_device() to attach
the devm unregistration action to the parent controller device rather
than the client device. This leaves the input device registered on
driver unbind, leading to use-after-free.

devm_input_allocate_device() already sets input_dev->dev.parent to
&client->dev. Drop the redundant and erroneous assignment.

Fixes: cd3f609823a5 ("Input: new da7280 haptic driver")
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/da7280.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
index 77fcf868dca2..e607836efb50 100644
--- a/drivers/input/misc/da7280.c
+++ b/drivers/input/misc/da7280.c
@@ -1218,7 +1218,6 @@ static int da7280_probe(struct i2c_client *client)
 	}
 
 	input_dev->name = "da7280-haptic";
-	input_dev->dev.parent = client->dev.parent;
 	input_dev->open = da7280_haptic_open;
 	input_dev->close = da7280_haptic_close;
 	input_set_drvdata(input_dev, haptics);
-- 
2.56.0.385.gd3acb90ef8-goog


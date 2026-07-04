Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C6390C84
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144696; cv=none; b=tWsk/eV+mvekCBBf/tShW6cmdVjuq5gTRvEHpzyGmJIknwK63QbWUGlzXLhFzlIsEB7cH45r4iu9bd2tNu8ROVnUPKG3gie/sbfkk2K/xrYGH7cVehDA9iZTHPCIHWO36BFK2mrLhmybL3rXOoBqANFGh6OJd3iXX2+3JqjsxlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144696; c=relaxed/simple;
	bh=bQtYsjtXaJYuyI8vpIX4gaXFUZwfy4lDJF5ogpSBWxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2aNSWIBxkxWjaK73evE5d3nWEzxyNYL0U+cfNi5CA4amDIpzRBkgdZTxPkAJe6lRFV7dEd4NpUb56GFq3GZZ9urPAdGzBq4O4AcCCsD0VJCEjRSSXGHmGZSDDuQ2wb5wqt99eRB70kxrTNteM4qQsxKGb49SDqFcr5pL1630pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB7JhYxw; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB7JhYxw"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso1190266a91.2
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144694; x=1783749494; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/05hwWd8d+nbJ2K7TsHjukJa8IrGxWrR/Hgx1jL48II=;
        b=hB7JhYxwCHtpikzY9KCdpHdTubKwpV4jpbIL/ldK9W/jyT2bi2NDfjj3MZekpTZX0k
         3FX/pxC92b5TLUR5ZqY/pZqQHzEVC0WINyY4QYl157EdcNTUL05UOJyzr5jpsX96mqhE
         kQEJNi2TuK0RUQJJuIQ4gu5+P0AQg259eu8sQRX4rBtooUeUYtit0gRkEVgjDlnKeFAG
         Ei1s1z392nR9uHQoVjpPXUCkPv++4Eqi4MVSub1qdFQdQ2z0OZ4yIleAwea9iaG9C6xW
         Pi9uhVKUeavbiw0/lD9LY/1F76yHkASE/VZhSbJWGgq697mVgh05vujCmODVFb0HzLWA
         LCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144694; x=1783749494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/05hwWd8d+nbJ2K7TsHjukJa8IrGxWrR/Hgx1jL48II=;
        b=NwexFf5bePlvE4x5rVKWXioEMMpT9UQjR+pkfk7EEHJ0LY2dBRhMviPln5Ut5TCusk
         hpxvP5GV1WrIF1Jm6ufyFBaWmu4vaaS6V8j9jZ+6kZVwrv0iL3FMbFRWWJlrpx+NfgLc
         LD1/TPD0utSBXM+erQ72fkQbBO9meFKO3tcT5UJhFb5wRgF7SKXQSPYrg1jQUg6mwDnJ
         JGP5kOCc8kgkflZ3hJCZlT4e4AfIJc6XRCIHfH7MSItRVMggyFF3RWCKU4I8b1n1HVxi
         V+z8WAvjwP9mzWW+MGQQBpYh/NoPR5jChYiEgGkO/AO+ou50X7GS8JxonSyzyCjxJr9N
         mWlQ==
X-Forwarded-Encrypted: i=1; AHgh+RrtgmxzUnHyYLCG4wY1AZPLim/o1hFH22XAYTBwjgu7gY4iieEr0SJUsgoPnpHnEh3Yzlnnb/La6m43uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyDBjQN5v4CwODLuA49MJ4Yi6Kq2tUlpTCVCoU7APBSp+0OLmC
	gXtzpq6uTmBWxZVaQTbullnc/1Tt6NtReLCXUNMnNN8A3JRO7O9KxKQr
X-Gm-Gg: AfdE7cmAt/to+xZ9psjDGBcz6rBMnIOwKspkGbsXgT4ohhhUX8gioqs/HNLrLlYubPj
	nWIkwFGrQyj3d9odBiGIOV3vDhbdZyVwE97nkd5w6OifCeG/OatL1d3tv1fqfVvuo+Q07Mb6/Ic
	WcJi6fj4+qI+qZBX/23lvaSMFoPV1XzWG9AHBo/8JL8WLcAnTpIhdT/umJpwkFY/u/FxfXdIunv
	2ZNOzcBi3cN4I/ICvbVAh5p74VL+bMj/zBt6LugF8nHwcyWP/xqU8lLkyA8Z4kTamG5pD+1XTd7
	cwWMfSTEGEgs0jAHVhETO0AmlSqfaEu0/yClhJtDU0R2C9rhNzPFCF2yeWZ4393xiunqmu4n6zz
	Dpyh97//i9IR2a89BrIeIwIpO1mi+N42GLevADHchE+E11s642PF1x7binGIcw1DZAZQg5Wu/vs
	5hAqZRqVxGmy5ZH+2TMq3fNlCfyf4ZjBgLu8LEr5jRyqC/obTCkMv+2lYgIHqsx3aKpeOGU6s5b
	oA=
X-Received: by 2002:a17:90b:57c8:b0:382:1cf1:a0a6 with SMTP id 98e67ed59e1d1-3829f5eadf7mr2306393a91.24.1783144694449;
        Fri, 03 Jul 2026 22:58:14 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:13 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:48 -0700
Subject: [PATCH 25/26] Input: maplecontrol - fix style issues
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-25-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

Fix coding style and formatting issues reported by checkpatch.pl and
switch to using BIT(). When reporting D-PAD events avoid conditionals.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/maplecontrol.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 3ef6652d40cb..457a73d91239 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -35,22 +35,22 @@ static void dc_pad_callback(struct mapleq *mq)
 	buttons = ~le16_to_cpup((__le16 *)(res + 8));
 
 	input_report_abs(dev, ABS_HAT0Y,
-		(buttons & 0x0010 ? -1 : 0) + (buttons & 0x0020 ? 1 : 0));
+			 !!(buttons & BIT(5)) - !!(buttons & BIT(4)));
 	input_report_abs(dev, ABS_HAT0X,
-		(buttons & 0x0040 ? -1 : 0) + (buttons & 0x0080 ? 1 : 0));
+			 !!(buttons & BIT(7)) - !!(buttons & BIT(6)));
 	input_report_abs(dev, ABS_HAT1Y,
-		(buttons & 0x1000 ? -1 : 0) + (buttons & 0x2000 ? 1 : 0));
+			 !!(buttons & BIT(13)) - !!(buttons & BIT(12)));
 	input_report_abs(dev, ABS_HAT1X,
-		(buttons & 0x4000 ? -1 : 0) + (buttons & 0x8000 ? 1 : 0));
+			 !!(buttons & BIT(15)) - !!(buttons & BIT(14)));
 
-	input_report_key(dev, BTN_C,      buttons & 0x0001);
-	input_report_key(dev, BTN_B,      buttons & 0x0002);
-	input_report_key(dev, BTN_A,      buttons & 0x0004);
-	input_report_key(dev, BTN_START,  buttons & 0x0008);
-	input_report_key(dev, BTN_Z,      buttons & 0x0100);
-	input_report_key(dev, BTN_Y,      buttons & 0x0200);
-	input_report_key(dev, BTN_X,      buttons & 0x0400);
-	input_report_key(dev, BTN_SELECT, buttons & 0x0800);
+	input_report_key(dev, BTN_C,      buttons & BIT(0));
+	input_report_key(dev, BTN_B,      buttons & BIT(1));
+	input_report_key(dev, BTN_A,      buttons & BIT(2));
+	input_report_key(dev, BTN_START,  buttons & BIT(3));
+	input_report_key(dev, BTN_Z,      buttons & BIT(8));
+	input_report_key(dev, BTN_Y,      buttons & BIT(9));
+	input_report_key(dev, BTN_X,      buttons & BIT(10));
+	input_report_key(dev, BTN_SELECT, buttons & BIT(11));
 
 	input_report_abs(dev, ABS_GAS,    res[10]);
 	input_report_abs(dev, ABS_BRAKE,  res[11]);
@@ -138,7 +138,6 @@ static int probe_maple_controller(struct maple_device *mdev)
 		return error;
 
 	return 0;
-
 }
 
 static struct maple_driver dc_pad_driver = {

-- 
2.55.0.rc0.799.gd6f94ed593-goog


Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FA138B7DC
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144675; cv=none; b=tK3FkKvZQ1YthcqHzWHeI7DiIXKYzeQttnNy040yyF6aboMH0ivr41H1caIuvcAIYn36d7E8Hb1FbmYeo0z/sMDr/JlpTtLoYENTIA48AIp5rywEOQJi60f46ITwk/3HMM6rwEV3exISQP2LyYv9kyybfVMNJHlaKWwYis+3v8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144675; c=relaxed/simple;
	bh=YIF7ar5wz8/hkgAvDMQQcbu0A00u2r8cdOkNUyS5mpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kNqPM+PDA7P2as/hkeajiq8NhkF60lL+GNBgGsyBehQ0brRSCzkIGtuUpbeJHAb8kIW1r7cYyQ2bqG59Z+cKgSQ2z2bUMjK2QA/eMEut9HZmeLpfDm5Y2Mg4wOtIT4KeemZ/ACSuaazmxVVTR468Wphe9E+TLTwe79KAHGTQeb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oaoZaSd1; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaoZaSd1"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so614645a12.3
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144669; x=1783749469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHrM5LSEGqI4QhlJVp2LQ5Kcemj6Dk254XODTohARZs=;
        b=oaoZaSd1Bb3yqAeqhQtGSi8gC0MSLZMzPh9985YnfBFEG6Y7lxWSQ5iTf159eU3kIY
         HqqC1DEau8++AuiygO+J88zeVIdxCwA9Ka06GqQPX/5rco8t40eeUmizmNRPoyDukZFf
         SBzrgXijPvxjr654gBYWOa083qGcWmyqC//HjEHBbpuSagi/uGRviLaJEqgriXu6qoM9
         lZIR1xBo0GSPAsL2SX2hOCl0oCkmRhi4saKdpjx1ApZyc1ECQaQYPGQA1g1fU77RwlDr
         zJY4J6Xk3H8BC0TDmtgZEz8XZd9+dUqvvoNlbyNPcv7dBME08pIUK6J3tCULTHjxajId
         ot5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144669; x=1783749469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lHrM5LSEGqI4QhlJVp2LQ5Kcemj6Dk254XODTohARZs=;
        b=oYf5SwTIFAAp8f72UoSmmWYZ4vkoIfw55QlF0Yg+JXYJ/FSfNe6yWLxQyUdS8/T3sF
         VWgzT1Kc4pk0+TMZS+16EfEEFYTm0jUztw5u/UiGFwGQsd4c7vNu0NUkc/UlJ11jLeSR
         V7e1IbM4sbtGTbnN6G7Kk+iVBjuRsMiYIm9tpMP/jCGJVw/OfUaJ9cBWps/OCe0G8bin
         lNK5pDCXhQV15bSKirln4+VfMs90Wcd9nhYGWtLXOmqu91vRnctLAL4aQTP7UYxEH1Kz
         0AAj0ZF9g3rtv80OAF6qyJ9FJyq9+9UIoXbpN5VLZuj2WIV0RYwplva8cc7FEx9xt7Yp
         3paw==
X-Forwarded-Encrypted: i=1; AFNElJ8kRNCibUw4MMzDmo6trgqsnwFvK+OiCVqEisS4wrhT5eoWJeMNB9SVPeDo/NDrrCsrL1fASP9DkvzEaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGC9OH8Ai+KtmYQdk2GfMB+e3ZB6lRfJVbOQeJTUuCJHX1EIb
	tFPaQ0bw8gXPFUHOb5wE7vqjYsBy0XRMEC3ik304XGyFeGy/Cfh8a6od
X-Gm-Gg: AfdE7cm0vDvgmwB4WUEI1Fm4m7q3QvHEsPNA3TdJk4tt9F6MtNda2ZEAtydkgvidA7Z
	gWI1J3M26+W8hVDzbIojjSLRBxKcOiuupcMLdwIZFWJIDmSi+XPEks7ZiuypmA7xzzIGdW1YFjF
	Nz1rY8d0rnYEFOoP+thsdM/2KwrxPIUlLrmQZiE44gOkRptUOC+39HzTG1QJPWgn6Gl6N8VO2wA
	BS6cV1WMZhXx4M+pQoh4LL9a2CfzPx2jgto4Dy+AIN7Ez7T7fOLT2yFqYBv6iMmUkijNzD6dSHU
	VVd+RJmwxA+v52lhfYJY+5JY26wLzRqZ2Msi5vz8JHkJjWPxW1VNeR37hYiH4DhPnYpyKlLNvou
	rNuYSOmRo2pv4seQLj5gZGcokDfW4+/MsLxP7YQ7Z+Jq6plStY3aJm2eHfhe0MTaRe4AAQhKMtG
	2yNi5BDxIRLSwWQaGKzKdEY/sxrC/yyS6UYnuqUN0I+7oIT72TTxa5Ap96kvnlWaoMT+vzKecoZ
	nb2wYyumkVmeg==
X-Received: by 2002:a05:6a20:d70f:b0:3bf:b4ed:5579 with SMTP id adf61e73a8af0-3c03e4f1acdmr2369689637.59.1783144669308;
        Fri, 03 Jul 2026 22:57:49 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:48 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:33 -0700
Subject: [PATCH 10/26] Input: maplecontrol - remove redundant drvdata
 resetting
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-10-41e424964da5@gmail.com>
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

The driver core automatically resets driver data to NULL on probe
failures and device removal, so we can remove it from the driver.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/maplecontrol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 9d623c9e8f22..79cec89ad52a 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -146,7 +146,6 @@ static int probe_maple_controller(struct device *dev)
 fail:
 	input_free_device(idev);
 	kfree(pad);
-	maple_set_drvdata(mdev, NULL);
 	return error;
 }
 
@@ -156,7 +155,6 @@ static int remove_maple_controller(struct device *dev)
 	struct dc_pad *pad = maple_get_drvdata(mdev);
 
 	input_unregister_device(pad->dev);
-	maple_set_drvdata(mdev, NULL);
 	kfree(pad);
 
 	return 0;

-- 
2.55.0.rc0.799.gd6f94ed593-goog


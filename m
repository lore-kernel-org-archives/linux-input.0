Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0A038B7DC
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144665; cv=none; b=q126+hNyfvzxpLbBIVKqxdQleLSY3hTwpkMIQUX3+G81IEhxkhw+sDpY3uidkjOdnHJTGHc5BxVymhPE+k5VtJaqVUutm6PCSyrCdhvIoZ452iPkK62eJrUgAGSJged0mLeTpdG6SXyfHVyw149dD44wOptgVCt7dz8WWkhdmhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144665; c=relaxed/simple;
	bh=odbDvJx6lsIoH8Kr5k7TX6xmqMEZUVoCppIYKyNTnYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7aqfjMl4Kh9he1p42yN8BSpOOBnpJshH2p1cRiy9n5BcXmUeztqiaszbZykLnd0aDSFJbOEZK3cbP2X/+kF5mFqzN7JE0fAeIi0oJ4uhGDLjS/NblK4CH2icwDTLA9+Hq5ORzoHvmT3PGpnI3sCMV7yP5zeH6ofbUl/GUqOxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et3pdl8F; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et3pdl8F"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b9d265355so910391a91.2
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144663; x=1783749463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0JiJbOxq7Ya2dq8srztzHeLNjlbnlC1+4jsRTTFCbAA=;
        b=et3pdl8FnliwRsd9H5b8KUqlW8YtibE0phCQxmZ5RzXTLhQminCltWm7WJ8RYYh20U
         abhE4eLeeQV60Zdooa5TRMPIU6QJ6JQDP7d6J2VTGAbNjW7I/0qPihmoaBwOlTUEYqoN
         F+tGASKXO7AQJy7rb9oZtpWnUcD/2YEFqvKH/ThY3EiNdQG3kn8EyaC6gqYaIHl33Ky3
         B8kwOOMx5lpGcvCzODIc/PUkTVW3jNth0M0WZXjouBJ7apTPiy1aajYGujSv2brxqDR6
         /di0VNkj4ov9CRBurOPE5PFNmDoil4m4Y2F062gPU+0DlDsufJY+56haLN6Nn1zne2aw
         XexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144663; x=1783749463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0JiJbOxq7Ya2dq8srztzHeLNjlbnlC1+4jsRTTFCbAA=;
        b=Z9CeyMHBVMJaLV/VHEpc22e8EGHREi2ObbgZqLF7rcK0FZYQ9pQL8+YRlPj4uGDYSn
         A1jttkDKGPK99Xm/Zmi328ijSHISsspMnviridoLrrfo+SJzR7X7O/TiCoRSj1ytQC7S
         NmPPNEzXXmDOYo96fDMBxr+z3/wNHXu239rgjaabm+O2vGOwnHtgXfbSZhCE0Zp2fvId
         +gS8Kv1nvzBGr3MFqJ75cMbuWf4z+dtnJILcQvFjB16cCo5Sx3mj7AN2At8TL7dHlhEz
         3TBe9i5tEX3POn+zYAZIK85uAA0SXcTGsAWRBnaZ+YmUfmamCXm7otbzYv2YzmWr8Syk
         o+Ag==
X-Forwarded-Encrypted: i=1; AHgh+Ro4JCHxigy2eyWVdX4aJa0gawSF2CRvOg423+kFMW4b+LWIog/iLWz9+/bpqElnpTLmPIcBsR2sKmimNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYAa9tCgwhh+ZMT7hWXrME1azbGEbJyZUf1KZNvEkGQuQuh8wO
	Cuaj0ANqOsDN08Px0wLapp6S1IA9Ol0Zf5SSZ9/GOHAC0wyY0OYUFhwi
X-Gm-Gg: AfdE7ck9ucTOrcsj1uv4JNN6YbrIdK9wH/EdWFk17h4M3J0k2EfAv9FhLmxhrjcEuVm
	uYUmw9NK4nmR/aeEizuz1555TPVkoY9kO6Jcg2kuY8i37ssKpJQku38kq0gR2u1y99xsUVGCJlg
	P7zP603vjt52nzgf3GSHKRQNNaxnOenYq837pDZ9Fd4G7jseIjOc+gbf0sK+WCPru2EGLMyM9vj
	p/5yMaDx9C3A2DLrDFMnP8aBXC0ItwTqg2xB0tODj9eqcgoQwz8woinJT0PmrR1fYpvS5BbvSw1
	iDxBzD1KU3BvinA6bUzuxl88DVkCbdmdh0bf0lG95A3ZyhLlVqD++/q4DT/ZAAN3R6YBNdQPnEH
	KpkYzv3b4ak8EHNZddxXWlFR7S+7RpagmIMUGz069P1iVhUnyPalFPY68lzh9Pq2FTHwEsh31IT
	23rTb+efvJw47dZ14es2GTXmmcGHhNdQUg3mOIWBemUaqO38Rebw9Vmv/Jj6tJnMyKAuTaBZBHr
	0w=
X-Received: by 2002:a17:90b:510b:b0:37f:c28a:de61 with SMTP id 98e67ed59e1d1-3829eb1e24emr2191947a91.17.1783144662715;
        Fri, 03 Jul 2026 22:57:42 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:42 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:29 -0700
Subject: [PATCH 06/26] Input: maplecontrol - simplify maple_device
 retrieval in open/close
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-6-41e424964da5@gmail.com>
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

Instead of passing the dc_pad structure via platform_data to the
input device to retrieve the maple_device in open/close, store the
maple_device pointer in the input device's private data (drvdata)
and use input_get_drvdata() to retrieve it.

This allows us to remove the platform_data assignment in probe.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/maplecontrol.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index c66b2614e298..9d623c9e8f22 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -62,19 +62,19 @@ static void dc_pad_callback(struct mapleq *mq)
 
 static int dc_pad_open(struct input_dev *dev)
 {
-	struct dc_pad *pad = dev_get_platdata(&dev->dev);
+	struct maple_device *mdev = input_get_drvdata(dev);
 
-	maple_getcond_callback(pad->mdev, dc_pad_callback, HZ/20,
-		MAPLE_FUNC_CONTROLLER);
+	maple_getcond_callback(mdev, dc_pad_callback, HZ / 20,
+			       MAPLE_FUNC_CONTROLLER);
 
 	return 0;
 }
 
 static void dc_pad_close(struct input_dev *dev)
 {
-	struct dc_pad *pad = dev_get_platdata(&dev->dev);
+	struct maple_device *mdev = input_get_drvdata(dev);
 
-	maple_getcond_callback(pad->mdev, NULL, 0, MAPLE_FUNC_CONTROLLER);
+	maple_getcond_callback(mdev, NULL, 0, MAPLE_FUNC_CONTROLLER);
 }
 
 /* allow the controller to be used */
@@ -112,6 +112,7 @@ static int probe_maple_controller(struct device *dev)
 	pad->mdev = mdev;
 
 	maple_set_drvdata(mdev, pad);
+	input_set_drvdata(idev, mdev);
 
 	idev->open = dc_pad_open;
 	idev->close = dc_pad_close;
@@ -130,7 +131,6 @@ static int probe_maple_controller(struct device *dev)
 	if (idev->keybit[BIT_WORD(BTN_JOYSTICK)])
 		idev->evbit[0] |= BIT_MASK(EV_KEY);
 
-	idev->dev.platform_data = pad;
 	idev->dev.parent = &mdev->dev;
 	idev->name = mdev->product_name;
 	idev->id.bustype = BUS_HOST;

-- 
2.55.0.rc0.799.gd6f94ed593-goog


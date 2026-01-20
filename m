Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5609744B66B
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932890; cv=none; b=BYxY4FRmPIXmx8ct+iI+g+U2hbZ10S59CLvD2bPQuHT2TkBx+F+xsxjwqxBwZcDm/c0J8Wb1q7eLdnN/mwxcr8KFI8plXWzofZ6AFcyAqMUCYHzodWVlPu8XJFwrLVQrTtJb9k6jFMfeJo0LF/TEXXpXrKsnSoDMDebdof7Ehuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932890; c=relaxed/simple;
	bh=IiEQ7uyRwvRu42axOI4+B00IxhwGOcQ6YipycnmidPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=meA/9gpP/p+zRiFfQwWSSV3A9xCMZx0t35pTz7qry6hrHClENcPT80XBSHJq/C+LfLVk0+rlr7pMr0jDU0PNv0f1qW8K2Y+DuM9xkkoeODyqKIqzxsYHuBY7rDDN/Cpbs8vb8IEgfZwHeTv1/hQ46zPfRSDKABmOVZ6o3HOaqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyswR/Un; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyswR/Un"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6f5a9cecaso2018921eec.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 10:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768932888; x=1769537688; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvPakcMBCnGLAUdWuDHMxHBoJI9VRoMFoW9RlnxrcUg=;
        b=SyswR/UnYnXScE7O1ntH28uV7gaBWtOg/C9JRQLgWjoYblKTgO3TwgmKUIxLeQ4s2Z
         HbCWTYGgJGF09dqEyQ9jdQn69ViuShrcXbCFCTzEg28b61My7cOyB+2j4Gs2CI4kPrPT
         AM5/kRxdXcSzo+b8gcAw04PQ9bGq91PLTEcJaKa313H6n6z57HIIrPIYur9wSvM7hPHV
         Qace0wuYeHNKj5G1aONEFzBSk/uw7SPhjdFcVtkGROEhgJ9RFqMJAwHgBcAYKbqbdeWy
         xsKVnj7C4kDIqBkVPi6QicNoJVWyePry7RP/lr57boUvPSNtKhuUGhEuiFjOgBu50p9s
         FkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932888; x=1769537688;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvPakcMBCnGLAUdWuDHMxHBoJI9VRoMFoW9RlnxrcUg=;
        b=wMXlYaoifOAFWGXx8AEITueUged1IagEGPFfMl0qpH5FZSMBwwr1z/290WT0TOy45V
         uZ2u2D+iWv479DNGYB7B6D9pgj10aoUAwkJ1kCO3GPPv9iVTdU+wU+X1X8IXTPhxfVtM
         baa9odv76DTY09pivbjf/EFqyp46Jod7z1IkkxBgutvxHrSp/C0fHjUEVwhWQio0RL1M
         53jhSoKSTjwq7v5V/I9p/We9t3oPWAcnbXUy/B8DIHBeq9rO9FapzURGzcHjKB1a3eFw
         uilwLt6jykzIJ3NRve9TFaCaS+lsU7PeSb9UOYyljIsz37K1qa5MA6kMCQnTBW3GwmC6
         bKow==
X-Gm-Message-State: AOJu0YwatBb1cKtNMo4MJ3+VCgT20EYVAu1LHCcxUVPbiVr/k8+/P2Ps
	OBZGIydGXNAhYMZtzxPUwmCzErFx/CFZC+omy0VHsqUop1pyKioIGALcPatmpQ==
X-Gm-Gg: AZuq6aIasesII4OnhnUs3KS4HojYXX8aKFncwc5UyCTsipGWzmK4K+kyDv9GlIjTU+f
	Zteh/inHmE60ymOY56igSVJYswLAxrM640s8M26go737TDIVBcLbRBQo7gxUhNezhi/vATKh7AZ
	lxZoN8n5DG885vLs8CK8A/Qpt93fEZFSgKpLZvj8cm1ABP46yerzYqtVsoHWDMoC6GLKPP4OZ6E
	wX00Nt+XPxF9dmV2wcLkLaSBCz+l6jH/8K1N3252zWQvrwXEOzgobXNhQePCtipjwF50GsyUWLz
	5eiP5cSX/Up6/FNegFgOhAX8aVwyNxphXT0oy035Q8rRUTvR1nS49lzIuHdxxuObWdBox6cxoWi
	Zw2ypNPZuybP8mJrBqF32aey82mLU7EBE2oWnxQ4mMEVg2NoiptrtVTAupG6YRxX1LwkAoEGRbK
	LBNce+m3/dOIw+LfY5+/mHGhzmdBZl3sMuhZp/HAop8+OIwHxvbdaR
X-Received: by 2002:a05:7300:fb94:b0:2ae:614a:3307 with SMTP id 5a478bee46e88-2b6fd7eee95mr1986031eec.42.1768932888046;
        Tue, 20 Jan 2026 10:14:48 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d631:e554:f0bd:4106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7102fd2efsm10035eec.12.2026.01.20.10.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:14:47 -0800 (PST)
Date: Tue, 20 Jan 2026 10:14:45 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Haowen Tu <tuhaowen@uniontech.com>
Subject: [PATCH] Input: appletouch - fix potential race between resume and
 open
Message-ID: <uuwucixxc2ckd6ul6yv5mdvkc3twytg4tg5a5vhfqg6m2qcodc@klaco6axglbm>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Take the input device's mutex in atp_resume() and atp_recover() to make
sure they are not racing with open and close methods, and use
input_device_enabled() helper to see if communication with the device
needs to be restarted after resume.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/appletouch.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index e669f86f1882..3ce63fb35992 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -200,7 +200,6 @@ struct atp {
 	u8			*data;		/* transferred data */
 	struct input_dev	*input;		/* input dev */
 	const struct atp_info	*info;		/* touchpad model */
-	bool			open;
 	bool			valid;		/* are the samples valid? */
 	bool			size_detect_done;
 	bool			overflow_warned;
@@ -800,7 +799,6 @@ static int atp_open(struct input_dev *input)
 	if (usb_submit_urb(dev->urb, GFP_KERNEL))
 		return -EIO;
 
-	dev->open = true;
 	return 0;
 }
 
@@ -810,7 +808,6 @@ static void atp_close(struct input_dev *input)
 
 	usb_kill_urb(dev->urb);
 	cancel_work_sync(&dev->work);
-	dev->open = false;
 }
 
 static int atp_handle_geyser(struct atp *dev)
@@ -963,7 +960,8 @@ static int atp_recover(struct atp *dev)
 	if (error)
 		return error;
 
-	if (dev->open && usb_submit_urb(dev->urb, GFP_KERNEL))
+	guard(mutex)(&dev->input->mutex);
+	if (input_device_enabled(dev->input) && usb_submit_urb(dev->urb, GFP_KERNEL))
 		return -EIO;
 
 	return 0;
@@ -981,7 +979,8 @@ static int atp_resume(struct usb_interface *iface)
 {
 	struct atp *dev = usb_get_intfdata(iface);
 
-	if (dev->open && usb_submit_urb(dev->urb, GFP_KERNEL))
+	guard(mutex)(&dev->input->mutex);
+	if (input_device_enabled(dev->input) && usb_submit_urb(dev->urb, GFP_KERNEL))
 		return -EIO;
 
 	return 0;
-- 
2.52.0.457.g6b5491de43-goog


-- 
Dmitry

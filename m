Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C923EA8A
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 05:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775625393; cv=none; b=GyYv7W1T3yPHHTcM8iofW6WUxPv9id3uBLF1gY8KpLgxmioMuAqj/gQbgLUOHNmHK/SnDA8hnfJGN5jTJiKz6trooACxqKo1Ey7UJWss5ne9KKhX3DSLoPeoT6i318vQ4WuHHVSVowwta8v+q1+6CR5+W2Dxyy9FbwmE0PkctVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775625393; c=relaxed/simple;
	bh=/Edk8lNtgYHzW4kh2l1uclCuMA1blZ7sUmH+m7M5h3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S5MP4H8EaKWGqNWv50npCAaNNEL/IFw+if1ce2Um8OSiX04lLw4wgFF+Bt+SIyJjqY105HGIZdbKaElFs/APPiy7jqpq6BrJIgyRLioMEVK4ITL8WjA8obTVNBN//xEVNqNEpcRGcIrhrsuntIUPRxSmouT9Hpy6a3gxqKVmDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZd1ys0K; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZd1ys0K"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c0433a4b9so2134162c88.1
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2026 22:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775625391; x=1776230191; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJwo+bUkwq4R20/wGCVVzJubVVnKL9F/dxM6esPvz74=;
        b=sZd1ys0KzBmi+G0zUo3R8gJB1gHCa0Yqyqf07+sJ5QlLVylw5Nz/Flb2wC8rDr4G4l
         P0lcaC+3xJEQbrsYlsoQSi4uS4q2PCN2UOp21CJT+K5GtZlEGp002aOzXnRQx1Rqrfaa
         bop5CfrJ5VI2o7KsL7KnVAHMLF7WS5Y+kIz3oRFI+qHTTphQF/dziqZkgc3BZP2p+VR2
         sqyrmkgin20yT4Ymeh0Bg3c1dJ5rKpjLkfECYtoautV5dVEIt9I7qNNulSfEKMpxQdI3
         mdXsaCUFGBtHDF/OJzueLQmovAca2VMpm+QvJRwIwTDzzxWZJ5u4pBfME3r7Wk38B+PV
         kTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775625391; x=1776230191;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJwo+bUkwq4R20/wGCVVzJubVVnKL9F/dxM6esPvz74=;
        b=Issi7SkRkRKPlmaXBqj5elvbTBRkNixS3hTtXhu0wjXnN5TOxdImwbn94SuixgFdOr
         K7ZLd8UZeBr279O6XIJkWdcL+8kCawtlZ21cYcMhn3F9coe4aHOkdYoyVy1729W8RVmU
         3hNtgtyXpo0IC4wE9YveuupSHxQrblByspCbefjwcLj3d6MoQdXHVg5J3gmtpRgtZ2yo
         az/qLHcFdcALYWETBLaMbu1StjYburdPPC8DxFEqNRa01x9QTE5yZ+teKYThDVavuFGL
         0oUC988nNwiObUEzwUjViaKAu6kSS9moL6Kro/qbzyFyuJQrwhTS0dY5/LKeD0a6rcKr
         lRXw==
X-Gm-Message-State: AOJu0YyjtLB9PS52SjDGTFzhYhXu644pWQGDMCbNV1Lad+fP79dP9HGJ
	HVOowFz9ckzdaOMfQqohnLbNkuYKjMoE9JpzFYIwpyUvUqBWuKVzg0JEenyLvA==
X-Gm-Gg: AeBDiesEtlMRjByPLCzCzeqN5CPLDP4o2vIOVTNZW671Iy83qZagEtR8uqq8pgFEG7r
	t3fo5HZ8O38HGsbryu7/+w1U/xyA+VZ3OQJ9tNDICDPUMd2waLE+JdjiO9t8cn2DiQHuC6hW6h6
	RbDrZ8rAZkivSq1GiAWTyimTdpBYEeovda8ctGSAwI3diQ2JJLLApgcJYk3yk0D733iJUPBStBP
	FaVECsghxNga4+deszk+hC4RYr5lMsSSaMqJljf1Q0ztUHyung11bduKE0dNXlKEq3cNk6sH9pU
	xy9NSl/nRjCqhJsG6MEOUjxqeyz6I/2TMfG2P7u2QEa2vhywCJ2xUTkw1AM0T9uUQMSEaeeLSSg
	mX/m0wsx6eYNdFENNzRtAgsvBr2mnavbbL1X8ylWUS7JjnEsT0xN0sFNjNjVXSOd/ueBeyAiVzQ
	kfDLgv1zEE7CkfRCycNlCvEh019TbZ0o33ztUoS+n5jKS7B0knwL0ud2y/WX4LmcCI
X-Received: by 2002:a05:7022:6b85:b0:12b:f899:717f with SMTP id a92af1059eb24-12bfb6fb68bmr10117071c88.9.1775625390816;
        Tue, 07 Apr 2026 22:16:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4faa:4b67:d989:bce2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c0ce7dfe8sm11090749c88.3.2026.04.07.22.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 22:16:30 -0700 (PDT)
Date: Tue, 7 Apr 2026 22:16:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: uinput - take event lock when submitting FF request
 "event"
Message-ID: <adXkf6MWzlB8LA_s@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

To avoid racing with FF playback events and corrupting device's event
queue take event_lock spinlock when calling uinput_dev_event() when
submitting a FF upload or erase "event".

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Mikhail, could you please try this one?

 drivers/input/misc/uinput.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index e24caf6fc8e8..d32fa4b508fc 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -25,8 +25,10 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/lockdep.h>
 #include <linux/miscdevice.h>
 #include <linux/overflow.h>
+#include <linux/spinlock.h>
 #include <linux/input/mt.h>
 #include "../input-compat.h"
 
@@ -76,6 +78,8 @@ static int uinput_dev_event(struct input_dev *dev,
 	struct uinput_device	*udev = input_get_drvdata(dev);
 	struct timespec64	ts;
 
+	lockdep_assert_held(&dev->event_lock);
+
 	ktime_get_ts64(&ts);
 
 	udev->buff[udev->head] = (struct input_event) {
@@ -147,6 +151,7 @@ static void uinput_request_release_slot(struct uinput_device *udev,
 static int uinput_request_send(struct uinput_device *udev,
 			       struct uinput_request *request)
 {
+	unsigned long flags;
 	int retval = 0;
 
 	spin_lock(&udev->state_lock);
@@ -160,7 +165,9 @@ static int uinput_request_send(struct uinput_device *udev,
 	 * Tell our userspace application about this new request
 	 * by queueing an input event.
 	 */
+	spin_lock_irqsave(&udev->dev->event_lock, flags);
 	uinput_dev_event(udev->dev, EV_UINPUT, request->code, request->id);
+	spin_unlock_irqrestore(&udev->dev->event_lock, flags);
 
  out:
 	spin_unlock(&udev->state_lock);
-- 
2.53.0.1213.gd9a14994de-goog


-- 
Dmitry

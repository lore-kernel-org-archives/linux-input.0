Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B63B42C0
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800907; cv=none; b=DfamHpPMIgVpqndbtyjch2M04JF8oYKPIt44UGM6AFN3gpuOPRqNsROaOoew4lqSxH0oyd5W+f/uClvzjfy5O0F9EsNnJDgk72k0R1BwR1meo52RHYxUhTs6DBPsxXvCavdRqLe71ub0SdWavRXy6wqmB0sqM9rBLzj98+tJGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800907; c=relaxed/simple;
	bh=AAFARNeKXceasPZwtKiPmdn3eYRuyGQsWoRLRDxFa+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I30pK/OgRqa3ctkrIkmoVvTVafgMUgUA+xjjq4xf+UqauG4scQtUe1IDpztBLsoyuxUPa1cs4WAIGvJRJYoIVn1zO2iXfyFKPJuzQ/Xz250j8C9CBi/DhXXTv83u8bbKOl7L0UuEXPQPiwl7/Toujph8wUALsSu6BRQfRop2WVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ybal8tbP; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybal8tbP"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so3858717a12.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 16:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785800894; x=1786405694; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koNBidNkBzz3w3S5JKYG4xx62FxheLcPS+8lMG+vrIQ=;
        b=Ybal8tbPdeGnq8gSSDPO9oKSuU3umk3dEGSWKeRK8dj17ozJxOOR+IyOGph+r0dVVt
         hwkNw7mGxi0aES65EELe5h5ohv2T6FGUMnPRboXQE816E9yr+x2sXLSFZ9dZJnlx580m
         lk+Qw+nfAkkX/8WL0R6cP23COwPZSABSjSUQcOI4JIgkiwAPgCXsf/dgYrneDq0W5+YP
         4DRyN3TG0kHWu6OShz30C6xIS1yP/KZ+f1AX6pJYTWNv9YDlDd6se3Tz6l11QrvXZ7B7
         IuuRhIyJtTy6nqk9/QKs/tpqyHWk0lpNzQGyLiDTThG/FCootTprx3TWHyKm0xPOL5XH
         +rtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785800894; x=1786405694;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=koNBidNkBzz3w3S5JKYG4xx62FxheLcPS+8lMG+vrIQ=;
        b=E1eyEQQcQ34y/RLSrjkb9uKad1mfYLMRVGovUHp6UcmiEiX+71zQjSeTi0jPjGSNuS
         OMC8jsOLRRw+4QPwPBbzIOJmPpwoRa0vu0eQzWMcwAn9wX/ZRm2Whg80Jw2nfx0T8GK3
         K7TJ9pQMs2Yi908agHWpSEwKF3btQE2jjlgUJqP7KcjXg+aRw192i2DKBpzTm5NZfWMh
         Qj69cGAu1Z9UQCfvdIzMJfCOjJXFzjHBAVa1TgfkvsSTqibIZnJKApbCFZ/dt7LIeHvn
         3zPIuM7ngpC4AdcpcO17lpwhby6BQwDYPb5bG+feq1hvyR9kyQ2n/c0BGjMUeXbPDdOY
         qeCQ==
X-Gm-Message-State: AOJu0YyT+1vH52udHmWNW6c1jK0pLm6mxQH2Q3/Cl6WxHphNajWLNJI9
	iiChYYgRKHiW44BQdFzZbZTNpEAgTmWzvovGtVITp4PQATpjJ/YyIVu+QrDTsQ==
X-Gm-Gg: AR+sD108RzKLXiuXRxab78xkUnJOf7HdwZmN+2NCwmzXMtlXL2XCpUJaR8fTSqjqpks
	YO77sXwRg1DTZBSJKHdzU0OWd0p6T95D1/lVj+gSpSXIwAk5rVe/FwwN0su7eu34CbX2XynYs8J
	+/qu36OUaFOtq1WM71t9q57Lk8kZuecfE0UfAlA3Ocu1EuvdJNqDIFVXQyEooyHzyIVf633AQ1J
	IBNPRsde7hzVVUzbrOm0ZKJWPJ+hMy/mYE+lxGQWeodbRC0LjdP4AGx0mUxvcPbSpsXqlG6BUaX
	SA5EI0MgnypvzUcSu1YZ9dD6qfl7P+KVjpgujR2d9bZTxl0MoUk9wYoBuogIbtPvUbSeOOH9UD/
	G6Akh4C/+B83i6RVl4zy1xoX8T8/VwqflpbTnt21ri06sMN2LukLx1TXdIXjbpfg4kquaX6HLlN
	lZI5OaxkK4ZPP/fs7Hslhru30f+Aq/cv+zgm8wEH3zGB3bN/xv4zK684A9K6IDjPsp5Al3U4Pi5
	O9WaPWJnsMlpMru7sgZQ9Ga3YHrdQ==
X-Received: by 2002:a05:6a21:1644:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3c92a51df40mr11783580637.7.1785800894664;
        Mon, 03 Aug 2026 16:48:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e70esm69374770eec.29.2026.08.03.16.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 16:48:14 -0700 (PDT)
Date: Mon, 3 Aug 2026 16:48:11 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Input: reject inhibit and uninhibit requests on
 unregistering devices
Message-ID: <anEolqA35rGei9ql@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When an input device is being unregistered via input_unregister_device(),
input_disconnect_device() sets dev->going_away = true under dev->mutex
and releases the mutex.

If a concurrent sysfs write to the inhibited attribute executes
input_inhibit_device() or input_uninhibit_device(), it acquires
dev->mutex. Because neither function checks dev->going_away (unlike
input_open_device()), input_uninhibit_device() proceeds to call
dev->open() and start polling on a device that is in the middle of being
unregistered and torn down.

Fix this by checking dev->going_away in input_inhibit_device() and
input_uninhibit_device() under dev->mutex and returning -ENODEV if the
device is going away.

Fixes: a181616487db ("Input: Add "inhibited" property")
Reported-by: sashiko-bot@kernel.org
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 6 ++++++
 include/linux/input.h | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index cf6fecea79b8..dcb1f72711c3 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1756,6 +1756,9 @@ static int input_inhibit_device(struct input_dev *dev)
 {
 	guard(mutex)(&dev->mutex);
 
+	if (dev->going_away)
+		return -ENODEV;
+
 	if (dev->inhibited)
 		return 0;
 
@@ -1784,6 +1787,9 @@ static int input_uninhibit_device(struct input_dev *dev)
 
 	guard(mutex)(&dev->mutex);
 
+	if (dev->going_away)
+		return -ENODEV;
+
 	if (!dev->inhibited)
 		return 0;
 
diff --git a/include/linux/input.h b/include/linux/input.h
index 76f7aa226202..bb97ebb815bf 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -117,7 +117,8 @@ enum input_clock_type {
  *	user opens device and dev->close() is called when the very
  *	last user closes the device
  * @going_away: marks devices that are in a middle of unregistering and
- *	causes input_open_device*() fail with -ENODEV.
+ *	causes input_open_device() and input_inhibit/uninhibit_device()
+ *	to fail with -ENODEV.
  * @dev: driver model's view of this device
  * @h_list: list of input handles associated with the device. When
  *	accessing the list dev->mutex must be held
-- 
2.55.0.629.g250fe7f194-goog


-- 
Dmitry

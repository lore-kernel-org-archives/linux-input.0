Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525E1F09A5
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785901596; cv=none; b=DgG5emJR89FUnoh7FlCg6FFUGtsGECKNG4orGy+o9GbetnnwP2zCxmbAorMSzSnYoFYyl+HUfrROVXLJDetlRMGa0AQvKD3ZhIhDql/FuC/OwWcySs6rk59CaF/UEAgoIVQurQAbz3YgdTjOs6YWvRVD8qIHj40pfM0VFdRW8a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785901596; c=relaxed/simple;
	bh=V6L1uncpNDG98/tPMbvHYCKcGDxXRUFDU72MczzTRg4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IO/5uKgfiin2Ose//KBH1H6dZD8wvytTA5Yz1RlLVq5WcDkmX9lWLfdgcDxFYJZuKwWwUyOy29XZxkLxDSRHZ9OXwgSqcZ3DWBeAX7Ic6Q9AFGLSwRzIwyUsfDF+sIgPRD056CI361DU9dbdlSOS79U34GSSKXltaEm3TbrEMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDNB3oM3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDNB3oM3"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbb973e6749so562382a12.1
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 20:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785901595; x=1786506395; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HlIEXTNcuCEiC7E3Thba2FVlKyMKDVKx24jQHuFwaPY=;
        b=kDNB3oM39dxTvBKUCXuzLvfWPEK1vcCyjFnOGqDU8ptU0ub0SeNlaLAV+t23vs+h19
         5ASStYpWTMGy4+PYzOh0AYeh69Xg/Ab8Zdm0QRL8FzrTTqxEh5YD5Uzv4C8VsT9NeJsH
         bi5qTW6ZPEp/8ncJ3Lr/95uw4o4+w+cQZ2jmR+A9G+hTpronOq5IwE//CF0hRzRpMCSi
         X6k2MNqCZN4qk9s3FkdoE06VKzmvI6x6tHctpZM/4E+DwKlseQKQvH9MLvZZaTbs7M5s
         GC6BNQE6JUscZ2tBNR430bV5uBifLPYiljZdXZPSCDZeomfE/RoeuCAcsxZMBx8U2AiN
         yqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785901595; x=1786506395;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HlIEXTNcuCEiC7E3Thba2FVlKyMKDVKx24jQHuFwaPY=;
        b=i7Ux3pbLNB+0IHFE5crDQRNWFnFZJzZ2ZA5ODGXTyswTgiPnt2EmL+PSacEZmQA0ep
         UDHMHiVexVedEVG5VUpk2ZyXmxXXTZiZNe+RdpRmLLGckt39AlDWUfgqxsXB/OSwTnVy
         08x6wSibckaMscKCtAPYyqt2rjRlM92dSz8dT3345JuQk5BUuHJLQ8rn4AfWrLZ6/EtF
         PzGqQ1z092DB/ZZ01AasbehPIlPUzksJmf45A2hHzYWntF43q2A5T9DA72lQ02J1FXkm
         V43q78sJSz2njlwshVuTDMALEjBKUjPvfmY5TyI7M6h2y2Md5bRQVSSVlNuXqI1cZfBC
         J2uw==
X-Gm-Message-State: AOJu0Yw0E9KffK/LjuqYt1viwxaGXEUkW0+ZrK8Z7Wla5PgrX/7IioOL
	OdTzogPQ/x8peYYR1tnBRKOrbMJ+lrMBrHdevGHGd8ll/hnArJrOsoLAuPSK8g==
X-Gm-Gg: AR+sD12fGLtd6vnWU+SXlh5mhyEvMbUJAMbFyi1EqE0KdYYEkdTjw8LFF26ja1Lz667
	w5pckmsN/wcvA7qJ5EOYNx1H6i1MIFKtXrf4povPU7qaNorJs22ye69YAyzbaOt0TQd92QDUcIZ
	er9TRY65ik7u6Gzgir1jV3izcvVVUIkWVI0UMbDJYWBUgiyiZJqTqA3XRA3lemV46T9aa1jr2mt
	DE1nOPuJ1a8FORvnziir/f6Ucl61Bdub8zC1EQ1wJIyTI7bPad05BdDy0isOsPcSa3PYx2B4r97
	59ktk5MFgbUX1DBJ1//vTSHJQhdnYYAuWzU8zw8mdR2Dqsr8udSH/xLEdgHYYDOIQ8thbt9gzZC
	TSeNxgc7JonDg5xPIfTpfVwgPXfP+JFuc3MHpfuvta6KJMnUxhw7qCmBAMEIl+y9lzJqLhdnW1L
	nnAPFZQbKZLscOVZKrbBFkwszWz53gCFod9rUwhPZcWBr8yQhHD6G+fNz5Gq8pppkqHFTdTTUFY
	aIq8MLnjjcCwzgouEN3MMYX4rW7Zw==
X-Received: by 2002:a05:6a20:d38f:b0:3c3:935a:af2c with SMTP id adf61e73a8af0-3cb85dcc9abmr4374382637.3.1785901594913;
        Tue, 04 Aug 2026 20:46:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bf3a:ac93:79c4:84fd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca50acddsm8987014c88.3.2026.08.04.20.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:46:34 -0700 (PDT)
Date: Tue, 4 Aug 2026 20:46:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: mms114 - fix touch slot corruption in suspend
Message-ID: <anKxGkyRRu5A92Q_@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In mms114_suspend, the driver synthesizes touch release events for all
slots and calls input_sync before disabling the hardware interrupt via
mms114_stop. Because the threaded interrupt handler runs independently
and does not share a lock with this early part of the suspend path, an
incoming hardware interrupt can fire after input_sync completes but
before disable_irq is invoked.

If a touch event arrives during this window, the interrupt handler
reports the touch slot as active again, overwriting the synthetic
release event right before the system goes to sleep. Upon resume,
lifting the finger does not generate a release interrupt, potentially
leaving userspace with a stuck active touch slot.

Fix this race by calling mms114_stop, which disables the IRQ and
synchronizes with any executing interrupt handler, before synthesizing
the touch release events. Also ensure that we only synthesize touch
release events if the input device is enabled, keeping the entire
suspend sequence protected by input_dev->mutex.

Reported-by: sashiko-bot@kernel.org
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 27911a9f4e9e..734c37579f5a 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -679,6 +679,13 @@ static int mms114_suspend(struct device *dev)
 	struct input_dev *input_dev = data->input_dev;
 	int id;
 
+	guard(mutex)(&input_dev->mutex);
+
+	if (!input_device_enabled(input_dev))
+		return 0;
+
+	mms114_stop(data);
+
 	/* Release all touch */
 	for (id = 0; id < MMS114_MAX_TOUCH; id++) {
 		input_mt_slot(input_dev, id);
@@ -688,11 +695,6 @@ static int mms114_suspend(struct device *dev)
 	input_mt_report_pointer_emulation(input_dev, true);
 	input_sync(input_dev);
 
-	guard(mutex)(&input_dev->mutex);
-
-	if (input_device_enabled(input_dev))
-		mms114_stop(data);
-
 	return 0;
 }
 
-- 
2.55.0.571.g244d577d93-goog


-- 
Dmitry

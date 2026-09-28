Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C844B0E47
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.203
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596011; cv=pass; b=quYlXsyDegkDcXrvXIJN3KKlMsq+7+lMfwvL+5cD7sF89CGIBsRQCQfhd+0nkfD+796zdkMv5LtDwGnBXGFYcllmzAQFax3UW1ynM+YBhme+3gcSyw1y9TOtQG+6aCFsJZbrjXIOItuvwokz/h4/MJe9ITB14nW/fo7GG6bcvHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596011; c=relaxed/simple;
	bh=lBv8IBD6IJb/z9r6xNQnFgugXVsOeX1D0j5YFBOsNP8=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=orhQlUTsM2jymqTIMhffPCM1pa0QcrQbO+mjCb40PDrIV2UUVLCwsVOTDXPs/eOwrKIubiwjevHir6dH8AnNSDFuES1tdaGkbg/PevP9htzVBMaY3AO3pUjtIncQDvWokPCvKaEO9ikALYMbQMJr6/g3OUPedY/qjuWCFJ+YLGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEmd1BhH; arc=pass smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEmd1BhH"
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4e7133c0eeaso247421b6e.1
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 04:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790596008; cv=none;
        d=google.com; s=arc-20260327;
        b=btb5EUS/WfAH5mD8a1RK1uWsn4e2z6Qst6dWbAP5yzapcdBk0d9hT/R2SmEXZrYJPl
         LnBHZqPYGy4sEGMTu6sgNW0Os8uZw2UueDi/0TRwEsrX2bvbCg2G/D9ZMgJ3bSttkPTW
         0heLnnXWZm2BMybxADd/LA+aZnz+FiMe8B784ZgtnU2chAvf/fCsEcWpq2dDgyw1zuxn
         cTjBcx1yUebP8uKM+t6s9oqF5nIDn0vG6wwuqlK+WTWoMC5VqFGsfCEWPfdgoWELeFtV
         kEgcBkxpixIg8npGlM6nqxJUXnQ4/c6SJwQJDaaf5JaZ7cEOQ0WTBL0jayP/bYc/VLdD
         Opjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=8y/14vF+O1HeqA5emJg88NL5DefW60ELONqq7Ew71Mg=;
        fh=3Qel/lUG78A6srYcK2LEt1qyyTG31ZHCFoNA35/cV9Q=;
        b=REtZdIlD25bhBif8R0ntVAOXg6QkKjd5zgq2pFqmp5GABl2cs6MqLaaLzLINT8A07G
         kaQU+vZtg+fDojgVb06VMxzEbYbu0uxSBYaKuMq8WFewxvOYgCugkLUsbPrOOXnGKh9p
         BJlAr4PmQ/op6VmM1JOu/ZUDC5S7m9EM9x14QlRMKMyiTfqQUvttXf1L3q0647Nag9f5
         Aj+zf3b2EKfc7gVbii+IRRpeJd61nFm7ZDpktIW4+TFxkQY3D8BJaFajVPkVSE2ZMeHZ
         64zDWhiAIuMxYeyOkqB0xrnInwerl2eM6im+6OjJVbOAWYxGDjdJ47GVLz5IFLA47dXb
         uwLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790596008; x=1791200808; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8y/14vF+O1HeqA5emJg88NL5DefW60ELONqq7Ew71Mg=;
        b=fEmd1BhHfrHKOPJbcsNae+s3Qjv8xY7/kJNU/qJzo1aycD20k8tDOovLZxcZliA2B3
         1UR6ZsqPZFlNdsH9jf5ZOhVNoTWI2SUDCrF3pjjnbkAuE4NPinNzZKKbWHgb0PTfe7k1
         x0h/3oFwolKtCk/DbFHsHDdMDJag6rR6R43OWTV0+N+2f51mNjp1+h6FgsE2CJg5nIfE
         v5r7RjUdEywqXlDlRGf0jRqlrtX8qt0XwxgfopIsE4xPQQkPsmTIA8DOsSk3DVwEy9en
         Rzjaq96OGEl2HZytM9jKx4JEj6IO1kPI9Igdc4GY1dY48uILGGJIN/ipV5CgSxp/3TSW
         TbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790596008; x=1791200808;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8y/14vF+O1HeqA5emJg88NL5DefW60ELONqq7Ew71Mg=;
        b=nNrL7g5fWL0j238SSuxk0YuZDJugAwy1slBuPJHpUGyVHgKhe2Y3LZfDcXJIhb40i3
         5faIbuHsMvjmRyj/BgVlF8PVRcX2CRTHkCtb1Z1A+6dhkNGhm5RDuQfecTM5osVX8Mgs
         +tzWTe4PmG4N/3MkndKnUmAO+Sh1ev8OM8cbuC+UCR01/XsoMsfh05uUIEYY+mo3N8m8
         WEKU/BAgLUwwM4DBL9Lb15ummJKLPMeb2+ax54zIDMR+OoucF44ZsVFwv9JGPV0+9ico
         u3IDEGohtxPo1q+5BNP7oBZjxI2t/mrT+YHnhT9AcE2GOa5ir3hCSxoe7F2MKqtgUloF
         rt7Q==
X-Gm-Message-State: AFuF++mwxJUa44Ppcgfg31RRBFRgFKxbqT9uFd8Gi2UZQ+MQ9RIIki4q
	Om9cu2TS0oSJWuNNt1boORK9M8Uu/bK2ISnulqJLknn3aK3Y2jFP0AtUuBTi4JkxW/SeoKKozXT
	a9hznQM5vBa2G0ANs9M+ulJvIhicsql0=
X-Gm-Gg: AYBFou3a4DcUYa/352fQEDcngczQNJphE/FEhxGxaCG5LAq/v4Xsl7xL4lrz0BroMR9
	i6UZSW4nwpVMbfKXCfnqLy5uvm/IPZzcej62R5U3QpK9zAFKdk9vfQvZveXWFKAWrgjscXFoQYi
	J9xdpVfrJf6jvey5hlt8P3KS5eIGVjKjYWlxiAMeD+cD8w5pbf+Q7/UGVTcYYmiAjKNyXOP4wni
	Kcj9o4Jkv3LDODtY41JE9H/SbHjtX4S+83cAeQY2yV6IMYgDsto1YEVA+ssx0yOCIYfRwEUk1i6
	CoD3t/PoMMM8PpVqJK8CRi7OIi+lXrhViEJpBVbdqnmfGGRxMHXyoTnUUDTt8BoYw9zWTIcMcOk
	cIxRNBpVtMA==
X-Received: by 2002:a05:6808:bcc:b0:4b3:7da2:f393 with SMTP id
 5614622812f47-4d72c636b6cmr12794285b6e.15.1790596008135; Mon, 28 Sep 2026
 04:46:48 -0700 (PDT)
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:47 +0200
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:47 +0200
From: Aveline Noir <jm5905938@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 13:46:47 +0200
X-Gm-Features: AclHuK8vvWWUjI-1FK5rP_VlhGDEQ4c_Oaxo0Aq7l7qcc2S08USGBF3bm-pvFn0
Message-ID: <CANOyQmEg5abcMc-Xk6=2hQQWu9vq9wevGR3spe352QLyxsZNEw@mail.gmail.com>
Subject: [PATCH 0/2] HID: picolcd: Fix output-request and framebuffer locking
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, bigeasy@linutronix.de, 
	linux-rt-devel@lists.linux.dev, deller@gmx.de, simona@ffwll.ch, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

This series fixes two PicoLCD locking problems. The first moves output
requests into sleepable context and serializes LED state updates. The
second breaks the last-close/deferred-worker lock dependency using a
private framebuffer update mutex.

The first patch was tested separately with the original syzkaller C
reproducer and bounded concurrent sysfs/UHID-destroy workloads on
PREEMPT_RT. The complete series additionally passed repeated framebuffer
open/write/close and persistent-open framebuffer tests. Pre-fix modules
reproduced the respective failures. Physical hardware, prolonged stress
and suspend/resume have not been tested.

Patch 2's Fixes tag identifies the fbdev change that began draining
deferred work from fb_release() while holding info->lock. Patch 1's Fixes
tag was checked against the upstream transport-conversion diff.

Aveline Noir (2):
  HID: picolcd: Move output requests out of spinlocked sections
  HID: picolcd: Avoid framebuffer last-close deadlock

 drivers/hid/hid-picolcd.h           |  4 +++
 drivers/hid/hid-picolcd_backlight.c |  7 ++--
 drivers/hid/hid-picolcd_core.c      | 46 +++++++++++++++---------
 drivers/hid/hid-picolcd_fb.c        | 56 ++++++++++++++++++-----------
 drivers/hid/hid-picolcd_lcd.c       |  7 ++--
 drivers/hid/hid-picolcd_leds.c      | 31 +++++++++-------
 6 files changed, 93 insertions(+), 58 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0

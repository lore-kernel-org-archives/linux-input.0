Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5EA4EC64B
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612152; cv=pass; b=e9e2sSKI9MEUPv8xO1HocEkOH72rwUnxk75iwX1Gg3zUZif8r6tnris+L87yUK4tP84zLU5m94fOdS8H2OlyOqfVtN82ai7lJz1vp1VvpOCwmKhVvNHA+7+4E9hF0YRrIxxih6zCXjYjTO8Ib7iLAXznI2dV5jkJ9QprelhbU+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612152; c=relaxed/simple;
	bh=5zhxTTDmIVJyF7gRnQGI1x1uORVwq6Xhxto6tH0D/wQ=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=HRQsLGZ6RLSk98hBpsuXFzYws4o2OKwbwBHwZa8Upw/JFq9Gv0K8SznKVDH+wgCBEBwYNnw4s2iqjkLB66aQUI77RLR95cjOWHNTlvf33Pc2ro/fkaF/6N5MTTRLWjbcKf6/j5L1Mj7Mqc8Hoh02fVQYeNGxqI520jcfhz73EkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlOhyslV; arc=pass smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlOhyslV"
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-448a12ddfb4so1454874fac.1
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 09:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612145; cv=none;
        d=google.com; s=arc-20260327;
        b=jgjl6Q4lMcFyQi6Dc+aO/bJC+nGGceABgfG8P9cmzOuz5wBXRuIG9znHpc0saDvV3e
         R6iEwa4ZtxCSJ1OnqEmFoBEfmm06TpVXKVv9I20SOBn2qeNIg7MJ8qEN59FkSZIHThWW
         tJLKRWWAb5nvLB8rY1R5TvSEEIE3DN+82llEhKQ4QA0wwBkIJrk0OybrbIPnNxMaOoWP
         eqg+j/KIYIqchc2Yrn8Iua7wUAeT2W6NPW3eT87BUmI0lr6HXAc1RLPGELz1TQTlBt+j
         uhRoSzXNX6yuRhYN8OX5UgHlwjA4bMiFlvoCBiFnsFlGdjZ4S1L5mpSzl/HdKLD+FYYc
         Vbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=0A5INQy7dX8LBqGciPLMu7YdS8AMK7M47XwobBkMymc=;
        fh=0th/NpVackua6Prn8RVP7cwKo5ZLvLdbux0Hk1pcVQ8=;
        b=UjQHDSsNxCwIc80j53c3QYBn0n9c2jGPey2w8Z3QLqOsqfD4lSmidffmwlXsVsc8tc
         P7FAfNXDire75KmefyU9h59EfFSyRnIt+JRdGxolCT3iVLy3rtcpnaoL3lhzHEOsBj1z
         hjLzd1t0AmpIWW92FADZT6LYZtIWkxCewRV+/+jHzixX1V2bTxMX5xqSjhSKvrwUzmDb
         xyX80KP1utu9SLze7egp976Nw0xAlcuWDYnpYJtyTS/kVca4uNILglmMj5HQ8u4jncv+
         2wrldOLPMEwGOpklM7byEA4rYvSJ7kVH9FDTTVlQkZ45XEUD/+74vpyvUim0j8MHAvKX
         7aSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612145; x=1791216945; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0A5INQy7dX8LBqGciPLMu7YdS8AMK7M47XwobBkMymc=;
        b=ZlOhyslVUrlWymcuC/MqPbxr4onRVzChOjkIPIgTGWjevHlLxpftjx9So4kGgay9TJ
         I1e0qyo36WrHA7CrVVzULjLmP41bpz1dbXrPO3oH3v3nCeEwlpJ7ctpgOKwNry3cP4lm
         EucllAX1KO++yYuDTC5kpHW/nv+i5kyZ3ssIavSSPgraGgJeo4XW8jWJULZv46eIRI2P
         c/lAhgZ+rQSD4Pr2aLFtxo+JiIQ5pxA5huBRQLGhn8L3iOOx+1fMpm8aDk7Xj6du4W4G
         c51aMVXxbAszP4ySV1HTYxr2bQhKi3c7KWKZ8oKF5ZPIcL4T9C8fbyWZPwKQKiIW4WBm
         qHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612145; x=1791216945;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0A5INQy7dX8LBqGciPLMu7YdS8AMK7M47XwobBkMymc=;
        b=sciN4Z51bGpXLxxbqEkRJNU5KcVlwxeKkGnHFXfy5Z17Mnv9H1f9g59jQAiE2UOf99
         AHIcEehpeF+u0LK4DyjBLEVrhATQF11oOhRdkl6ZFQAhRwTDOuTJL8I+7/00v/vlX7jJ
         dxc23CQLvL262naEu45O1XssyLudgEMcPuNCbkTO2O51SecOSS7xWgMYwOoosKKtD2B6
         0ZR4bMQlPUFdkRsuc1b1UvCsC5MdD+0vYpJZYQPjDWlssx4NldvKQXpCu9bfEfhUIUC2
         lElNxwAqmc5Se5bOImRdB1NCvLOU/AmCPRxMt+TSC1Un0ff7pj1A0aIpS3pgz6KBzJ9d
         jUeQ==
X-Gm-Message-State: AFuF++ksI26Y9niJOnKBJe5nMSS6hQQJnZJlrm7tQA4nwcAQkGmNaUDI
	E/N9NHRUYE1ezUhjRL1WhZdPGEbjbE+qBChaxQ8kiUFCaGaVbRp2Ttz1VBdnN+0F/ld8P1vTXfn
	gm6Y8ofXpTjV24qpJiJ86Hz/FkhvYj8o=
X-Gm-Gg: AYBFou3vnCI9SUm9dsCrCphBKXg18YlQmcno0Yb1iXx13YYGwnTecCXQSIjyL47aogY
	OLLoIaiHIIAv5dpMMEPdcpKdPzC5oSnHaljOu+fl4bst3hEOc9Btcuo0iK43KyKkBCs915by6JI
	OOm7Onp3urzHyYMqXr7CmOYgGBhQo67AkUM17iYR8EbQGh5daALVvMILfmQl2oWZAERcc5FbXLu
	Dpkf/jsdDdGiTv+wgEipc788TG6pC30RocBiX/1JCd6v71GrMei4m12C9qeL749LH/MDeLRNBep
	AeX/4ZwDgc0TUjNC0hPmEi8nA2EdU9UPbzhf0VClIF3RkcRJ4l8yBmp1oVu7cqI3kakivvYQEsm
	QKrGOs6BQng==
X-Received: by 2002:a05:6808:198e:b0:4d6:90f4:48ba with SMTP id
 5614622812f47-4d72ac45eacmr14395634b6e.44.1790612144676; Mon, 28 Sep 2026
 09:15:44 -0700 (PDT)
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 18:15:44 +0200
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 18:15:44 +0200
From: Aveline Noir <jm5905938@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 18:15:44 +0200
X-Gm-Features: AclHuK9iPdog26wVV94AzoDOB6Ecnbo54mNzfsBz7HWPWdsxEbSKehYuy5Lt6Js
Message-ID: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
Subject: [PATCH v2 0/2] HID: picolcd: Fix output-request and framebuffer locking
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
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

Changes in v2:
- Address Sebastian Andrzej Siewior's feedback: clarify that the issue
  is not specific to PREEMPT_RT and identify picolcd_data::lock as a
  spinlock_t in patch 1. The code changes are identical to v1.

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

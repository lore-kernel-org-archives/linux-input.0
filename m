Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73711501F49
	for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976005; cv=none; b=UuYutzusxv/5ujPbjfeDaB3FKFFK/p8sI3dLWfCYHYiZcjDA1ygR2Xv21eKKSYfv+ZCXHAIZXzv0UrWb2ajK7ShynjHsrVKfVloy53ea3PUYPshTCyIwATTUvp6Qm97P01m/nby6uGUirsZTpteJdCKTUS06x5QeXNGUopaTz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976005; c=relaxed/simple;
	bh=Q4sS6ysJkh6bVqmDm0t8nwutvdPtgGri+t2E+qvwZrQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=NazhhmXaodt6Qh+c1QCYdnb6qa7ffCC8FJAv1rjF4XTBBLY/dB4AKZaMlmKgsgUcAs0gmF2eiIChDDsHGhqvv6lzWYgfVupgLPGpELbPLOMeOmaKZR4kioKlonN7SSn/A/5QSLg5WAGwpli/WgCqt6bOnQKIERZfDtDT3Q8Ekcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnNRWHem; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnNRWHem"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3ab37ea4798so1458454a91.0
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791976000; x=1792580800; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E41qJNRzVmPfHenlZSA2Vl9639pSTN9ZvaDbaLPA2p0=;
        b=lnNRWHemxl4Adum9W7q2lsSnAeuUGVAJM10nga7X5Ny3gjQ5nYA4FjQR4lEDYeTn4J
         QvoncNKcllKwbJkxdqgKQMANLUaCrSAm6NEZZm+LkmNBewYdAEFDkQch9VsAFSLokQuR
         iwEt/R+EF/oE5l14hESfPsB/m/v+x0qIjY62h88Jl58wY5b/nEI8SbiIC/1330VPQmpE
         WGJ8AxCc1Pih9+MHHLsgjSxEdsYwh1t6FGFqDrOim7gYI2kaaW0TFPDc0DiLA+vMkSjb
         MWMDKgIgVPOnAsil1oesXfD2fR/lRxXJvId/UyHS7jwJW5W1gouuRgFpdKef2iL6Unr9
         oeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791976000; x=1792580800;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E41qJNRzVmPfHenlZSA2Vl9639pSTN9ZvaDbaLPA2p0=;
        b=NSSayYNxs8Mh6ufBHzFX+nkGcZ9z9W4uOfty48Kh13aZEHHCpLQ2/IA4Ew7dGF/gVv
         dU82P24wH8IbpUaxrtWfn/uAMC+0BVtLGr9fNPc3ZkxFUJhtc0GqzdjUTl0rYa2NIT8i
         G4nrjeXFqqysxuqd0RK+s9VdkAQNpAzbf74FL2KPkU68G0pDiJrgMGy1OTeMKmNHxDb8
         hWDVfRrCXcU0EK15KxY+DOamoaIuths86CWt96YGY1Lwh70KjN16HOdIQUsX8UtWT5md
         qQSyJmm3hjS03Ja899zmctHRZnpi1J6G8fGJYAWfpMfrrPBeZhksnFioPJOTUqstBQ+I
         7T0w==
X-Forwarded-Encrypted: i=1; AKwUvBxKZ6nxOB26FrmNM4oCNWcSrrwHVHjO1PdjM2kKjzYSVfWXnWj1N0v/GESdQWsZYB88XKyQ33rh5OrgqA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLyICGvwjY+oKAECl2QVf+HrvIZ1UAxoE1oVg12pg2bvgyk6gdZ
	BZKv7NA8ta7BNolFVnNFbMexYqXyga4qBJ96O9HPS0WONAw+gvWFNHL7
X-Gm-Gg: AYBFou1+S3e7bTdSkosA2WCltqFLgLM4qbATP/+kvjQAhIjL4WhCsJJTRjbv66qNRs1
	+Tsl33sGTFTxKzmi02oZxi8oDAGxTOMO0J44R+wT/XYWiKZNbIhyZaHo737VQABHE/XFiJaxKtS
	q7us/QqqvezH9/JYCAg7uzBUF3Y1zDmocjxsoIqrzMjVnwO6HPMHsnVosODMMSf0H7GWPxE1+LZ
	Ka4yCTSBRrBgFQBfS2DVNypiT34BIhmsJwRXIyJiCmJTZr+Np+Eb95U6rnTjVu07xYsMvqKY8g2
	Z0wgg2MLvWGK8vXyvgcPYTiYRNpCRyYQQrG9QN2Q4hkQGai7eDHm4Gl7iXKR45lE+hef6Pg+Slq
	NzW5Pb8XitlqqnDtdIb5AjsNGXLB4dsJFJqYA5lRIySdFqYD+oxfGvhKcsmzocr6FXDXXzcvvYs
	tn+W0BJMqyLe0c8POpYDl8/XTzTC5igq76uRZ8G3mwJY3FSs3FnEU/epJ6zO2QQgOk85Ng1MUac
	hnmjGZKij1cOuONystCLNf3XvSlQTc=
X-Received: by 2002:a17:90b:4a08:b0:3ac:4e91:bff7 with SMTP id 98e67ed59e1d1-3ac4e91c1b6mr2825151a91.48.1791975999552;
        Wed, 14 Oct 2026 04:06:39 -0700 (PDT)
Received: from [172.20.10.4] ([240e:471:300:dde:5eec:32d6:f33:1d4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd5e2b79df5sm5281837a12.19.2026.10.14.04.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/2] HID: picolcd: Fix output-request and
 framebuffer locking
From: Aveline Noir <jm5905938@gmail.com>
To: Aveline Noir <jm5905938@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
 bigeasy@linutronix.de, linux-rt-devel@lists.linux.dev, deller@gmx.de, 
 simona@ffwll.ch, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
References: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
Date: Wed, 14 Oct 2026 19:06:31 +0800
Message-Id: <179197599193.532954.6543599494592547892.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791975994; l=2119;
 i=jm5905938@gmail.com; h=from:subject:message-id;
 bh=Q4sS6ysJkh6bVqmDm0t8nwutvdPtgGri+t2E+qvwZrQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgboJ0y2WZIrQV0H4HJI1WEQ5sxS6pM
 Nc/XEYGLW8ee6wAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJSB+KMp1PvZyKEm4roi9iB1DW2hPjN7sh98ZjltMhWCFYkG+UkBAjTEszr3F5A7A+M39+3Sa31
 Dwagjpf+n0w0=
X-Developer-Key: i=jm5905938@gmail.com; a=openssh;
 fpr=SHA256:oSxqik6Pl1M8EjQW1QXKHoylm1jy0sguOWFFJlA9zf0

Hi Jiri, Benjamin,

Just a quick ping on this v2 series. Have you had a chance to take a look?

Both fixes have been tested with QEMU/UHID, though not on physical hardware. I'd appreciate any feedback and would be happy to make changes or run additional tests if needed.

Thanks,
Aveline

On 2026-09-28 18:15 +0200, Aveline Noir wrote:
> This series fixes two PicoLCD locking problems. The first moves output
> requests into sleepable context and serializes LED state updates. The
> second breaks the last-close/deferred-worker lock dependency using a
> private framebuffer update mutex.
> 
> The first patch was tested separately with the original syzkaller C
> reproducer and bounded concurrent sysfs/UHID-destroy workloads on
> PREEMPT_RT. The complete series additionally passed repeated framebuffer
> open/write/close and persistent-open framebuffer tests. Pre-fix modules
> reproduced the respective failures. Physical hardware, prolonged stress
> and suspend/resume have not been tested.
> 
> Patch 2's Fixes tag identifies the fbdev change that began draining
> deferred work from fb_release() while holding info->lock. Patch 1's Fixes
> tag was checked against the upstream transport-conversion diff.
> 
> Changes in v2:
> - Address Sebastian Andrzej Siewior's feedback: clarify that the issue
>   is not specific to PREEMPT_RT and identify picolcd_data::lock as a
>   spinlock_t in patch 1. The code changes are identical to v1.
> 
> Aveline Noir (2):
>   HID: picolcd: Move output requests out of spinlocked sections
>   HID: picolcd: Avoid framebuffer last-close deadlock
> 
>  drivers/hid/hid-picolcd.h           |  4 +++
>  drivers/hid/hid-picolcd_backlight.c |  7 ++--
>  drivers/hid/hid-picolcd_core.c      | 46 +++++++++++++++---------
>  drivers/hid/hid-picolcd_fb.c        | 56 ++++++++++++++++++-----------
>  drivers/hid/hid-picolcd_lcd.c       |  7 ++--
>  drivers/hid/hid-picolcd_leds.c      | 31 +++++++++-------
>  6 files changed, 93 insertions(+), 58 deletions(-)
> 
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> -- 
> 2.55.0
> 



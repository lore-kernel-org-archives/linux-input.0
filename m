Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9FCF9C0
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786822415; cv=none; b=UIPOO85qx/Shd3eMlHlLwhEn5+AW1feEywQAM8zSvrCUE+h6usuOitafr9/agxuiLl/5r6tIIQ+ZW+BDoSYRFdl/FclNCcEGQP/+oPVA8/3caWvvBgnanyP2YoR/JgEJNaKkUtk/ibb4EPa893GE3B1Sv3bJM6tzGwEGGCpcoiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786822415; c=relaxed/simple;
	bh=o0AnMacdq0bOiSycbXAvI5cFKmtVjcZln/CiGgiarGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnfTHgl+7pYMKSMjk/irQuV7Bg6jIX0aPHnpgzteIfmgJHu133zon3wwOiIELkth+ZEkyHBsDft7P+xoQIr8wFbB+Ylb9GoLdQNSOT2kojL9CPxB9HdHBfskheagqNtd8lAd+2+D1rJ8Ifv/1dfzxsONPWt6QBFFe/z7LVY1stQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bICh8Uxx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bICh8Uxx"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38511175ad3so2015580a91.2
        for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 12:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786822413; x=1787427213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8QfDYn3LXCdJNJnJI4l1itkip6zXqWm+TG5+HQBXhHc=;
        b=bICh8Uxx72Wri6bjC8UIeCcUQbALdfal9F9VxZPLBXhRbDV1EBCnKt0ImQ+NgC5Yxe
         HqqYUjuwTL34xmDt7tdvOahnizEpzON4gSWFJ9mwjUv8bmeQRZz6GNtYh/zphBeGD6dg
         c2khk+wI5un4Pi3gBzdxEuw/namCVr/KvOVrZ6J8E080SaEuCLFPoz7n87zibly+QIZo
         Dqka2nLByaoYwSf3RootJ383A5sYCObh1EJiuQgqw7K8+9StdHDXhJT3lQdl71WNGYjI
         pxOSKneD1U9Oo6geX6iBEF4Y+A+oF/LJXmAn7MwunipyRxbjPhjIMMfNORxG9kYuEAlg
         aS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786822413; x=1787427213;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8QfDYn3LXCdJNJnJI4l1itkip6zXqWm+TG5+HQBXhHc=;
        b=Zi1XGbknWDB4y/PNjA6HyTGUdj3DA4f0qJxdosR3EPnzpJusQY4dRmSwiirtmEN/Uz
         nsF3/jJxDmBis+rYEOvlEajSpeXkrYj4IaOOnC9gdUnHtZaa3oe5lDOFHfuDTXwZZa7r
         jSX3vGeAum77HF+TCPBTM+3wrer4+dCLDx4EiJT893JvckMUdmSE6CK8TTfFt+Gja04L
         UUwxNsqtURqkcOEtKNpxBVhQtRFLGe4zEcW/Q/Esx4LQ7o17fZP+cdNQkTGeNUjBPz9p
         MAvXH7NCGnIarOjnqWrJi+4PoRyBPf3BhKpug3/8Pm1ggd8Qfzdo4ZX9f4FDax9dcvSh
         C3Bg==
X-Forwarded-Encrypted: i=1; AHgh+RrLpsLDC+R2dpalRlMhtHatSVGs8GlBVdfX3k05sCiXMm4MSk7R5DN5cRCp2UWn4Jih5wCb4HXqChebJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmPvY9mjLfjE2Nb1L2hiSqrugk9kJzpE1sUy+ygfdEDF2/MPPN
	a69p1ErqdvQPj2Rl7do/dfsSRnax97QdCkLe1qW99EnSVZxJEwEVcUzz
X-Gm-Gg: AR+sD109pZ8I8VrJzBqx6goyxshSMRXWQsbrtY7RGqjg7WLrqiGq48HegeGkAPJpGlg
	Z1M80BL57Al3vWi4wVw6OqC3kZNGWvqZfWc+NEYz3iJnkFwiPL7HRttM4mcqVHriHitbVul3iUM
	DQlzwKxdZhw599ORJqrpylHz1sOAVnh95XOONBAiQegDPCvH8C5ZQtcSId0s1ZZAf2L3DB/s9uD
	jJUZH/XJ2ykjyEx/n0r/Ld2ZRdwssTKiYofqgO1S5Midk7pwY45gcjTwhLfv0cM+2ADmm4FEWai
	GjgXmyBS517rmYOhdaavRqMspEbACUeA3UCozW9jfKoE828uK4d+DdFF0iUlqbtydbZfbV5SVpS
	SDB+MeLZz6GOPDbVWg5Pu6phE17fwcrPei4lZOTKTpchXxPG4xOVSmAFcuBmR077ltbA8PVha9R
	SGQ6/qTU91AikaPt/+W2cfPxdh9smopuzHGGI4ULBtLqG1g5MpPpGG4H1qnHcTTKqL5GIwO5tUk
	A7CjFswajz2/wphWEtQvzSBjn/Cbw==
X-Received: by 2002:a17:90a:c888:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-3933b7fd2cfmr16437935a91.6.1786822412858;
        Sat, 15 Aug 2026 12:33:32 -0700 (PDT)
Received: from localhost ([2409:40c4:3103:c7f7:a9f:75a8:7ec7:e37b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm29554554c88.6.2026.08.15.12.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 12:33:32 -0700 (PDT)
Date: Sun, 16 Aug 2026 01:03:27 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Adam <testyiprywatnosc@gmail.com>
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [BUG] HID: i2c-hid: ELAN 04F3:30FD touchpad reset race causes
 -EREMOTEIO on HP Pavilion Gaming 15-ec1xxx
Message-ID: <aoC-aI_7Dq_nJTHg@eggarch>
References: <CAEru=6LrMqg93AKrmbTJtvRNPx=arYuhSf4zMw4bK1SjWQQvrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEru=6LrMqg93AKrmbTJtvRNPx=arYuhSf4zMw4bK1SjWQQvrw@mail.gmail.com>

On Mon, Aug 10, 2026 at 07:31:32PM +0200, Adam wrote:
> Hello,
> 
> I'm reporting a reproducible probe failure for an ELAN i2c-hid touchpad
> (ACPI ELAN0718:00, VID:PID 04F3:30FD) on an HP Pavilion Gaming 15-ec1033nw
> (AMD platform, i2c bus under AMDI0010:03). The touchpad fails to
> initialize on nearly every boot on Linux, while the same hardware works
> reliably every time under Windows 11 on the same machine (dual context,
> same BIOS F.35 rev.A).
> 
> Kernel: 7.1.6-arch1-1 (Arch Linux)
> Also reported by other users with the same touchpad ID on different
> kernels/distros (Arch, Ubuntu, Linux Mint) going back to at least 2022:
> - https://bbs.archlinux.org/viewtopic.php?id=277393
> - https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2031061
> - https://forums.linuxmint.com/viewtopic.php?t=329212
> 
> Symptom (default logging):
> 
>   i2c_hid_acpi i2c-ELAN0718:00: failed to fetch HID descriptor: -121
>   i2c_hid_acpi i2c-ELAN0718:00: Failed to fetch the HID Descriptor
>   i2c_hid_acpi i2c-ELAN0718:00: probe with driver i2c_hid_acpi failed with
> error -121
> 
> With dynamic_debug enabled for i2c_hid and i2c_hid_acpi:
> 
>   i2c_hid_start_hwreset
>   i2c_hid_set_power: cmd=05 00 00 08
>   i2c_hid_xfer: cmd=05 00 00 01
>   i2c_hid_finish_hwreset: waiting...
>   i2c_hid_finish_hwreset: finished.
>   asking HID report descriptor
>   i2c_hid_xfer: cmd=02 00
>   reading report descriptor failed
>   can't add hid device: -121
>   probe with driver i2c_hid_acpi failed with error -121

Could you attach full dmesg with debug enabled, of failing boot and
successfull boot? And also acpidump?

Thanks,
Lovekesh

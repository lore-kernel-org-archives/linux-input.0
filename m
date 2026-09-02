Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0138A725
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378993; cv=none; b=aCBo04zMEWR4YcVze1g06fWSs5CYzt4BCLQAxHHuGe2TiZPyHJLU+zJJHJHfF/utw9je13wgENZaHStTYWjZ2NJIUXjuh8tUTCZ3oKelspxN9DrvOiBAksmNjNZzIYAV8FoGPq1Hea8/H0sioVaK8XsS9uCoyv/6mYKed4tchBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378993; c=relaxed/simple;
	bh=n0viXMutNv6qwE2hA6DDzDwUAdN8YPqWWfnCl1u8oPs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m2OWbnqDekbQW8CHVLwP83o8oSmVhN2t0rybLTvKjLtnNPSKTO4OafOVjmdoC5CaoDEQN8+fQflN7NJu+AZSMWChxH3rypPS9BzuNgdOiaf05uC9vB9W3F017euF9xIeJLe8oneUjF+78NDy33yokzA10Ls9/j2YrsOC+X60xtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qweWOypo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qweWOypo"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48433fad54aso1006185f8f.1
        for <linux-input@vger.kernel.org>; Wed, 02 Sep 2026 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788378990; x=1788983790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dQExniahpFLGspEvq9HaNz76Rwz/D2ggJ2M9Cmsyfjs=;
        b=qweWOypogMEiHJMAzEinXyVdmu5vH1a/NCMBdbNHI8wijVAL21ZMeennMn2zruRQY1
         c0x1vqm3TSiU97OYOqV8wc/QFfupxYrYOVCHv8VqSKOZUuK9Mo02/rl6/aITqSPgVote
         MvcFImzMwwjl8TG3eWC9UJ3OAqs/IWr4HuWBJ4kzyZL6IvWCx9uEkf4jNqzskyktTtCB
         toiDpk2vy27yCvQ0JHGLpk6eR+vp7WJwyxPa+WXjD22NuBzM4IxD8qSGt8eHrhxZUcvx
         5ilasRm3HYhCacSv06NVUhofJZm604ZYvDJ2katEgyPOaZj2xeoXwH5OFOBajr10b7Qf
         Yn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378990; x=1788983790;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dQExniahpFLGspEvq9HaNz76Rwz/D2ggJ2M9Cmsyfjs=;
        b=LjDlZnGKuHK4HqUwq5O6fK3W1SnmjpvfeuW6fH5o891F+HliYwypbCGV1itSOgHn+W
         265rjET/0ULsRGQsGdun0PSHm5WT3hczhuJogQPYQpQradNr4OMdejiH9VG5xIA770XK
         AVgBrS3XC6WqyLwbspru/5VKzydAUoWo7XG9vSu/NXAH4PlXAHkUN+vpTAW7aJjpjNyt
         CZU7VFMAYGGSXoA5Tiunw25Ew5NvqmZLUhCUrxF8+mRCG8I7kzMpakLlwEUF4qGuVf+d
         SHO/urFXDG8hq1mS9YXx7vDHrJ8WtGVrl3N80ig7XDFcIZ2LF+NpMwj1pYeph4EmWj/E
         /Y7A==
X-Gm-Message-State: AFuF++mjK7Ev8O5ko7/XlM2PEtXPING6EuIPLM0pjvvt+K2ze8nzai4x
	WRPHdLBGK7VKdpMiU+HAs6bQmnYQMXacneqovwLYvbZFKdJUx2DvEA9kjBhRLPjn
X-Gm-Gg: AYBFou19paXoc0CxwJ78fIJ8fdnNFADbNspS77oZnzMxUFfdFS36ez29c1me76mxwYr
	COPpbdgc7Ci5DhWTMuhiOcnjD40vdtMGKL5vHaIsunTilkMgPJiE6Zbcs3XYD21JYF39sUS8NNt
	p38d5iWbXDwJypAMM68jWtpbe0eSOLwVTmFRQTt99D/0zDIP4E3Ih/ZL/NeQviIFs7Oru2jBdDz
	5+2vyVS4JheQX1XlbqQTggi/FRHpONHwPaLPsZ3fec9u5+hRny2q+bX2pffEvnbKv7t4flGdKNj
	o4x+e/J/RcOxuO4FinOzkYkgOpyCF1MWnu1k3JbFs48a8Ke6rV3SPe/Vtq1aEIN3RTBMT/5+/CM
	X32BJeJQa9edsjEG6KoJG8TxkeO+3AKKDavlPkC96mp9FG8r5sgH9RqEMojZJ8o0A7yQiKV/scb
	Z/pO8CblEjjP7C66tAupxd2eOxv/5+AibrDocUL1suu3pL8rqgjGDWZPvuf4vKNXJ2ShdYA2bAi
	jAFxd124peCxSyRG9FqrhgC2L1Agt1PVOYIkA==
X-Received: by 2002:a5d:5f07:0:b0:485:78f9:63de with SMTP id ffacd0b85a97d-48578f9642amr10715373f8f.0.1788378989849;
        Wed, 02 Sep 2026 12:56:29 -0700 (PDT)
Received: from ?IPV6:2001:9e8:8992:34d7:1685:5d4:7c1a:307d? ([2001:9e8:8992:34d7:1685:5d4:7c1a:307d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed2e9fsm8669822f8f.20.2026.09.02.12.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 12:56:29 -0700 (PDT)
Message-ID: <834ab849-9624-4adb-92d0-796e6f826a7f@gmail.com>
Date: Wed, 2 Sep 2026 21:56:28 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: amd-sfh: 10s resume delay from s2idle due to sensor status
 timeout
From: =?UTF-8?B?UmVnw7Zsw7YgTWFhc3M=?= <regoeloemaass@gmail.com>
To: linux-input@vger.kernel.org
Cc: "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>
References: <6ad35436-63ac-4bc0-8d38-90ffe03b6db9@gmail.com>
Content-Language: en-US, de-DE
In-Reply-To: <6ad35436-63ac-4bc0-8d38-90ffe03b6db9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Update: As I've mentioned before the operating-mode was also affected. 
But the operating-mode (SW_TABLET_MODE) is now working correctly in 
userspace after testing 7.3-rc-1.

But the resume-delay still is present, including the operating-mode 
which comes unavailable after resume.

I'm willing to test new patches if they come available.


On 8/19/26 13:37, Regölö Maass wrote:
> When closing the lid and reopening it again the screen is frozen for 
> around 10s seconds before any keyboard input is recognized.
> That results in every sensor being in a broken state i.e. 
> "monitor-sensor" shows the accelerometer orientation as "bottom-up" 
> and tilt as "undefined" and the ALS shows very low values.
> The broken states of the sensors are: status 0x5 for sid 0x0 
> (accelerometer), status 0x4 for sid 0xf (operating-mode) and status 
> 0x4 for sid 0x16 (ALS).
>
> As on my current system the operating-mode is not recognized in 
> userspace (No SW_TABLET_MODE Event) I can not be sure about it's state.
> This resume bug happens consistently on every try based on my experience.
>
> Here's the filtered dmes output:
> [So, 16. Aug 2026, 13:30:49] PM: suspend entry (s2idle)
> [So, 16. Aug 2026, 13:30:53] amdgpu 0000:03:00.0: dpm has been disabled
> [So, 16. Aug 2026, 13:30:53] amdgpu 0000:03:00.0: SMU is resumed 
> successfully!
> [So, 16. Aug 2026, 13:31:03] pcie_mp2_amd 0000:03:00.7: resume sid 0x0 
> (accelerometer) status 0x5
> [So, 16. Aug 2026, 13:31:03] pcie_mp2_amd 0000:03:00.7: resume sid 0xf 
> (operating-mode) status 0x4
> [So, 16. Aug 2026, 13:31:03] pcie_mp2_amd 0000:03:00.7: resume sid 
> 0x16 (ALS) status 0x4
> [So, 16. Aug 2026, 13:31:03] PM: suspend exit
>
> As the dmesg output shows the resume operations for the sensor are 
> delayed every time by exactly 10 seconds.
>
> I managed to solve the issue about the frozen screen by disabling the 
> amd_sfh driver via "modprobe -r amd_sfh", after which the resume 
> operation was nearly instant and no freezing occurred.
>
> I updated the BIOS version to the latest available version: TN3604YA.306.
>
> Importantly I'm using the "mem_sleep_default=s2idle" flag as a grub 
> argument.
>
> I also opened a bug-report in bugzilla as a reference:
> https://bugzilla.kernel.org/show_bug.cgi?id=221895
>
> Kernel infos: Linux xxx-xxx 7.1.8-arch1-3 #1 SMP PREEMPT_DYNAMIC Tue, 
> 11 Aug 2026 09:16:08 +0000 x86_64 GNU/Linux
> HW: Asus Vivobook S 16 Flip (TN3604YA), AMD Ryzen 5 7530U
>
> Happy to provide more info if needed or test patches.
>

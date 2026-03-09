Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FF628853A;
	Mon,  9 Mar 2026 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043965; cv=none; b=b8khr4u4dOs1hKuENXV8P0I9oP03KPwwyM+IDgzCxbwY8d9ZZ9uAU5I82wVfQ3baOz5Zmlrc98Ag6yC+WfpX5/CQNmdWEs5IR6oPCVjJF+0ESLiVWODR2Gd9VfOVcK5Mj3eOyw8g17iXNKImI6I6ByM46yV+Kbt52M6u2nNWopo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043965; c=relaxed/simple;
	bh=XhJcnehUlIof2Q8USK5PQMwZofvFby+iB/tUMALWuj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=QNjwxYFd6NPO3aoj2R+d8uVDyfX/Nm3PlzPnZmXaKasWRnrDDw6l+jP/FLOcP3m2sNTT16I4LG3cER5WYoTWeSuHxnVuMv7bF3Hzg3WfLkQEA82vwwEP8Dv7LafrdZVuFgDtH/3sJp4yDiOFII7DnnLq3LCuqyllcMTL3eqLh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=hDEdqk7L; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="hDEdqk7L"
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4fTqW66bkNz89Zs;
	Mon,  9 Mar 2026 09:12:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1773043954;
	bh=XhJcnehUlIof2Q8USK5PQMwZofvFby+iB/tUMALWuj8=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=hDEdqk7Lcqn9SMEi5OK1W7w8vkq6L3liPqFeQ9nvBE7ITn119ZGyaqyCgAxL8k3vx
	 OxhVx+63FMV7NG14sj4MOXSdgSVYIWm27RECx4IIbrmfo6IWGO2frMSb7Fs8xcuf0d
	 QETkoZ3T97j3/RQ6+0BU4wg41L276rkOPLZTvMRCH5Dtm5rRFYfdqkEJbXm/dhWUp+
	 Sb8Xu+ZIyLOw3KgMtA3Q5Re/w2/XyaEU8uao6+DwKvGK6KlBrzqAP0R1/C69qvM6dN
	 uj6Vo0Djv9Cxf34wm3GKUOJiQMshFyPQ4TexZ1t9As31B0IMp/liFkowuHU6kpEPxz
	 3Iu4vWOn9uisQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4fTqW65vTSz4xCK;
	Mon,  9 Mar 2026 09:12:34 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fTqW61qm8z8sWT;
	Mon,  9 Mar 2026 09:12:34 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 5A6F8632BF;
	Mon,  9 Mar 2026 09:12:33 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <68d90523-33dc-451f-a825-72eaa1c4bcb8@leemhuis.info>
Date: Mon, 9 Mar 2026 09:12:32 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.18.] ThinkPad T14 Gen 2 AMD (LEN2073) - Synaptics touchpad
 remains PS/2, intertouch=1 ineffective, lost sync events
To: =?UTF-8?B?UsOhY3ogTcOhdMOp?= <raczm0812@gmail.com>,
 linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
References: 
 <CANkKV92bTD11PCXYzz60WSxcP-0UCM8xtnY4_WraEwQx6TMjaw@mail.gmail.com>
 <CANkKV91Zfp_Bn_koM=Tb5vHQbog2Ja72C819aL-49kQ6PWA_Ow@mail.gmail.com>
 <CANkKV93wfs7oxU8kiyPWeafOs+ugpZSPLQrea7wtoSuGEG+pPw@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
Cc: Linux kernel regressions list <regressions@lists.linux.dev>
In-Reply-To: 
 <CANkKV93wfs7oxU8kiyPWeafOs+ugpZSPLQrea7wtoSuGEG+pPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177304395362.185231.15856629306627922848@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 5A6F8632BF
X-NC-CID: XHJyXWIdBplooTrDmV/uvz0OlEWkKYl6cd6fnod+LUaiHMeeJ8Q=

Hi!

On 3/5/26 19:07, Rácz Máté wrote:
> 
> I did some additional checks on my system with kernel 6.18.13-200.fc43.x86_64:

Have you tried if 7.0-rc is still affected?

And if it is: could you bisect? See
https://docs.kernel.org/admin-guide/bug-bisect.html
for details. Without a bisection developers developers from both
subsystems involved (i2c, input) might not look into this, as everyone
will suspect it might be some change to the other subsystems that causes
this.

Ciao, Thorsten

> 1. Kernel configuration (relevant parts):
> 
> $ grep -i "RMI\|SMBus" /boot/config-$(uname -r)
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> CONFIG_RMI4_CORE=m
> CONFIG_RMI4_I2C=m
> CONFIG_RMI4_SMB=m
> CONFIG_HID_RMI=m
> CONFIG_I2C_HID=y
> CONFIG_I2C_HID_ACPI=m
> 
> 2. dmesg output (filtered):
> 
> [ 1.615300] psmouse serio1: synaptics: Trying to set up SMBus access
> [ 1.618151] psmouse serio1: synaptics: SMbus companion is not ready yet
> [ 17.949336] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
> sync at byte 1
> [ 17.962506] psmouse serio1: issuing reconnect request
> (repeats multiple times)
> 
> 3. libinput reports:
> 
> $ sudo libinput list-devices | grep -i SynPS
> Device: SynPS/2 Synaptics TouchPad
> 
> Interpretation:
> 
> - The touchpad is recognized as a SynPS/2 device, i.e., fallback PS/2 mode.
> - SMBus/RMI4 driver stack does not get loaded, despite the kernel
> config enabling modules.
> - The "SMBus companion is not ready yet" messages indicate that
> psmouse attempts SMBus access but cannot reach the device.
> - I2C controllers are functional, yet the touchpad does not enumerate
> as an I2C HID device.
> 
> Workarounds:
> 
> - Using psmouse.proto=imps avoids lost sync events, confirming
> fallback to generic PS/2 handling.
> 
> Observation regarding previous reports:
> 
> - Unlike the 2021 report on ThinkPad P14s Gen 2 (AMD), I do not see
> any "bad SMBus base address" messages in dmesg.
> - The kernel attempts SMBus access, but fails because the RMI4/hid-rmi
> stack does not initialize. The device simply falls back to PS/2 mode.
> - Therefore, this does not appear to be the same base address issue as
> the earlier P14s case.
> 
> Conclusion:
> 
> - Behavior strongly suggests a missing DMI quirk or regression in the
> SMBus detection logic in combination with i2c_piix4 on this Lenovo
> ThinkPad T14 Gen 2 (AMD) with LEN2073 touchpad.
> - This is reproducible on multiple 6.18.x kernel versions on Fedora 43
> stock kernels.
> 
> I can provide full dmesg, libinput outputs, and acpidump if required.
> 
> Best regards,
> Mate Racz
> 
> Rácz Máté <raczm0812@gmail.com> ezt írta (időpont: 2026. márc. 4., Sze, 16:02):
>>
>> This might be related to the earlier report from 2021:
>>
>> https://lore.kernel.org/linux-input/3d6f7f74-3214-4c03-b352-a2a0d27ea42b@amd.com/
>>
>> and a similar report from 2025:
>>
>> https://lore.kernel.org/linux-input/b2d0af40-876e-4a2d-99a2-236b583e9497@gmail.com/
>>
>> The 2021 report describes incorrect SMBus address detection with
>> i2c_piix4 on ThinkPad P14s Gen 2 (AMD), resulting in RMI4/SMBus not
>> functioning correctly and the device remaining in PS/2 mode.
>>
>> On my system (LEN2073), the behaviour appears very similar:
>> - intertouch has no effect
>> - "SMBus companion is not ready yet" in dmesg
>> - device stays in PS/2 mode
>>
>> It seems possible that the same underlying piix4 SMBus detection
>> issue is still present.


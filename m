Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4BC33DEF7
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139429; cv=none; b=FyymIgFxfFMdHywjyeV6H27uTi7QbTB/q3s9zXd7QYziCzBBPSy+QBBTVKNbxc9nk69pSPmGwN4KQ7eDQRbQgGLNAsEcBkYxuICjkfAqfxcrU9Mc+YXqx4DN4nwYUfsiTUyvrLMjHtwLGP7vg9xjZNKAeror02dFUCLPELip2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139429; c=relaxed/simple;
	bh=8Dx744EN+WMSDIGF6mR0xXbp/4wUHu3RDSo7ma9VtiA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=chznpACrdHG3ZOW42coInlKMRMZ47yQ58elC2JggOcDHEiDVV6i5sKq+RCy8GHty/jzm6SUZb+GLbVtGQIis+94IfZ5JOKWNNX7nnUyQ+S5Xkbr62OT0p0kqX5J3wR4p/Qrf44MwK7fg0XAJJET80bp/J7jj6rs1uiKtVWt4NPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2p1sFpi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2p1sFpi"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47db714766aso1290826f8f.0
        for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 04:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787139426; x=1787744226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Dx744EN+WMSDIGF6mR0xXbp/4wUHu3RDSo7ma9VtiA=;
        b=s2p1sFpi2LPz7kuqTwqTzizR+QeWuBdPNA58DIO9fU7HQWBUCZ8U6hScO3k1/QduF9
         EGFt0ofM0MPxDlPBjXp3eLSHvanU2RtDjAoNRsErke15Ksj3wtaMCAprJKyT7dgZ5chE
         vMJTBrxl4R3EfsGXP8FuaRT9Gmk8kiHuVSveA8bKyLYZ39U/gg1TkN2q9rP4nCsXGvET
         URdWh8za5ysyIHdCcl487iPboS92uh9b7AaKzHksuSrweZWJEBaAtN2Z4UWJYxxgygaY
         pFOTd8iUWy4GFnrXx6nhGQ9KLHNtBI0eOBsoyzOuC/jHJgW3VCcEoO3g9BBSWAw5VxKZ
         R9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787139426; x=1787744226;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Dx744EN+WMSDIGF6mR0xXbp/4wUHu3RDSo7ma9VtiA=;
        b=eV/5j6Id9xqSpRoNdshinAQRDdouGewN3lNkSnerpjAhgsGTlqDonxM4T92He1vjRw
         uz0S5+sQUsoZZGSntX3mkBNvE3+rR85byPPwewLp58vWTm8qltLYgbTNuI3m+c4BhW5I
         9Atqh90uZ+HJmDKEQDtS+YDK+wS+I+K7V2HYyNXRxYiEQ0tospVU3yag/0mxwoQjYdCw
         vBE4ffs4sVsuIQeEZo976nPn9zy1Mke656S6Yubk+3wSRNIpIFi0n4gp2V4qJCDRivn5
         V+oBAfnew567Pp0z9H5F6paG+5JrZ9eBKlJzn+TNJKGLeQbV/Nbh8Mu0FKNLgeyBsx/Y
         ibKg==
X-Gm-Message-State: AOJu0YxWuNcubrdS+aPD25DLgxlrFhsf1VB6Ai0YSR61tSc7VM/ZXzTx
	kt8w24Uf2Qs29zF5y6yafBHFjg2LFGYir/tcH41fUI+BuYBNWCE4V8Rg0pEyDg==
X-Gm-Gg: AR+sD10ZIM9pAQPY9wu1Piq1G0a46nYER8C2dTDqvaaL3PKKxN8JL/wse7ZBFLOSaES
	BD5tktoRveqfjXskHCaow67qOKYmHTZlGiuEbTvg2U1+0A6cBRFqMHpnlrhVS1f3HO4P7+8axzM
	rK6z723MRN6E0WNqiCaqplwGW4SwBSEHvqDeupN903Vv9iGtM/c3Rts2gePRhNXXXYOLTDfzMCY
	G0BvBJ58NoCATbhwR7FnpwyQtWSU38dhXL2ZKU8yiQfKW7ncdCKytUQHBDG4B5ZU/4HER0iylOU
	Lp6hE+wBas/u6whe6mMy2Ie/2Kf8v6wuwysOLn8ZWnFLRFE4oiQ2XFaN9r0SFR4mbgI2mZda+ii
	+SuVfjALlxSux5AGrcaxvWypW6d+XZ7BnHABcPSIPb5g6viwDvz/jHjRwsknBbuRNV6ihP+CQiw
	VIeeeqjMZLmQ7dnOx1VD5QuwzAEC95OBKlsk5+yXVEGNee2bPhw+w9quNzSOT/v1HQ0wvmTxANg
	nr5XR+cOMSb/OvE7OAy8ps8yneAk7Fwj5Tt
X-Received: by 2002:a05:600c:3f10:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-499aa0f306fmr72739485e9.6.1787139425690;
        Wed, 19 Aug 2026 04:37:05 -0700 (PDT)
Received: from ?IPV6:2001:9e8:89ab:a85:6c4d:376a:c226:a52? ([2001:9e8:89ab:a85:6c4d:376a:c226:a52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9dfeb11sm23154175e9.2.2026.08.19.04.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 04:37:05 -0700 (PDT)
Message-ID: <6ad35436-63ac-4bc0-8d38-90ffe03b6db9@gmail.com>
Date: Wed, 19 Aug 2026 13:37:04 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: linux-input@vger.kernel.org
Cc: "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>
From: =?UTF-8?B?UmVnw7Zsw7YgTWFhc3M=?= <regoeloemaass@gmail.com>
Subject: amd-sfh: 10s resume delay from s2idle due to sensor status timeout
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

When closing the lid and reopening it again the screen is frozen for around 10s seconds before any keyboard input is recognized.
That results in every sensor being in a broken state i.e. "monitor-sensor" shows the accelerometer orientation as "bottom-up" and tilt as "undefined" and the ALS shows very low values.
The broken states of the sensors are: status 0x5 for sid 0x0 (accelerometer), status 0x4 for sid 0xf (operating-mode) and status 0x4 for sid 0x16 (ALS).

As on my current system the operating-mode is not recognized in userspace (No SW_TABLET_MODE Event) I can not be sure about it's state.
This resume bug happens consistently on every try based on my experience.

Here's the filtered dmes output:
[So, 16. Aug 2026, 13:30:49] PM: suspend entry (s2idle)
[So, 16. Aug 2026, 13:30:53] amdgpu 0000:03:00.0: dpm has been disabled
[So, 16. Aug 2026, 13:30:53] amdgpu 0000:03:00.0: SMU is resumed successfully!
[So, 16. Aug 2026, 13:31:03] pcie_mp2_amd 0000:03:00.7: resume sid 0x0 (accelerometer) status 0x5
[So, 16. Aug 2026, 13:31:03] pcie_mp2_amd 0000:03:00.7: resume sid 0xf (operating-mode) status 0x4
[So, 16. Aug 2026, 13:31:03] pcie_mp2_amd 0000:03:00.7: resume sid 0x16 (ALS) status 0x4
[So, 16. Aug 2026, 13:31:03] PM: suspend exit

As the dmesg output shows the resume operations for the sensor are delayed every time by exactly 10 seconds.

I managed to solve the issue about the frozen screen by disabling the amd_sfh driver via "modprobe -r amd_sfh", after which the resume operation was nearly instant and no freezing occurred.

I updated the BIOS version to the latest available version: TN3604YA.306.

Importantly I'm using the "mem_sleep_default=s2idle" flag as a grub argument.

I also opened a bug-report in bugzilla as a reference:
https://bugzilla.kernel.org/show_bug.cgi?id=221895

Kernel infos: Linux xxx-xxx 7.1.8-arch1-3 #1 SMP PREEMPT_DYNAMIC Tue, 11 Aug 2026 09:16:08 +0000 x86_64 GNU/Linux
HW: Asus Vivobook S 16 Flip (TN3604YA), AMD Ryzen 5 7530U

Happy to provide more info if needed or test patches.


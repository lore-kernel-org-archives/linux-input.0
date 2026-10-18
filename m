Received: from mta1.migadu.com (out-85.mta1.migadu.com [95.215.58.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB3D3D5227
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352907; cv=none; b=h22SVhoj/nxBlAEZOOPi7VHsmuDfCCLEcO0xQquxj9C82uJIAa5a9eFCAdyRXo2bqke2zgccMkWA0jOZTPbUo1nrkDHD1vY5V0LR+CDNO90EKFwXOSjff+J/s++4TJNBnmCB2e4kcOL2bQQNktvXgunBTuQdUptSpSDBsDLC6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352907; c=relaxed/simple;
	bh=/yIF3n4oT72GD7bhZKBGyWKTRaTdZ2UypHatGQorBfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOBZDuAz4+K1QA0espDODbrZPpgFEgjDFtTC/vNzY9T6IIB97N0tv3ZL1vaAZ8VXQGQAhR6SMPq9bpnD1Bau0SIf6S5j5FEA/KYTSgFZ9hxkCPYAH8QUiTPH++uoFwDVa5FYjFiID6FsOQ3cu60HdbAA8XNMqIrDt7eMDi1aVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v1uHodZb; arc=none smtp.client-ip=95.215.58.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v1uHodZb"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/yIF3n4oT72GD7bhZKBGyWKTRaTdZ2UypHatGQorBfQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792352903; v=1; x=1792957703;
 b=v1uHodZb87zwlKYen1ckw/Ssrvu49BHfqdxKcMm/BB16hMrdeQYCKGC5PkK77ocFgR2ZCykp
 +GXQPhbG5QvBXy2N7gmXPldGGiFpvg9rTchMpYmOx/ZaeV11jyPWXi3wSE96PVT3wsY/dMaygZk
 QLJ5GSmBU5VmkXAeSWhktd+Q=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f3608eb7e4297639;
	Sun, 18 Oct 2026 19:48:23 +0000
X-Mizu-Trace-ID: f3608eb7e4297639
X-Migadu-Flow: FLOW_OUT
Message-ID: <23dcbde2-26c3-4288-aa71-3bb3107e3f45@linux.dev>
Date: Sun, 18 Oct 2026 21:48:21 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] HID: asus: Re-send the Zenbook Duo keyboard
 handshake after probe
To: =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luke Jones <luke@ljones.dev>,
 Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 Ivan Levchenko <me@livan.pro>, Nathan Chancellor <nathan@kernel.org>,
 Paolo Pisati <p.pisati@gmail.com>
References: <4bf9e6b0-4f6e-4faf-a2b6-a57143ef3f23@linux.dev>
 <20261018191823.22123-1-rebecca.mara@posteo.de>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261018191823.22123-1-rebecca.mara@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/18/26 21:18, Rebecca Mara Müller wrote:
> On Sun, Oct 18, 2026 at 07:10:57PM +0200, Denis Benato wrote:
>> So this patch is based on an arbitrary wait that is based on the
>> assumption that some other device gets initialized...
>>
>> Can you try making this deterministic?
> Since this part came from my patch, I went back and measured it on my
> UX8407AA before trying to make it deterministic. The result: there is
> nothing to fix, so please drop 7/7.

That's good! The probe function is unfortunately a bit chaotic as it
is already... After all this driver must handle many different wildly
different devices so keeping it simpler benefits the addition of new
devices.

> I built v3 as an out-of-tree module against a 7.0.11-based distribution
> kernel, with only the schedule_delayed_work() call of 7/7 removed and my
> userspace workaround stopped, and checked whether the keyboard stays in
> hotkey mode (keyboard backlight key changing asus::kbd_backlight, plus
> usbmon on the keyboard's bus for part of the runs):
>
> - docking: 10 of 10
> - loading the module with the keyboard attached: 2 of 2
> - rebinding only the touchpad to hid-multitouch while docked: 4 of 4
> - s2idle suspend and resume: 3 of 3
> - reboot with the module loaded after hid-multitouch (rootfs only):
>   2 reboots, 1 cold boot, all fine
> - reboot with the module in the initramfs: 3 reboots, 1 cold boot,
>   all fine
>
> usbmon shows hid-asus sending the 0x5a handshake on interface 4 and
> hid-multitouch sending feature reports 0x07, 0x03 and 0x05 to the
> touchpad on interface 5 some 10-20 ms later, and the hotkeys keep
> arriving as 0x5a reports on interface 4 afterwards. The same happens
> when hid-multitouch reconfigures the touchpad on resume or on a rebind.
>
> I also went back through my notes from August to see why I believed
> otherwise. The conclusion came from a test where I rebound the touchpad
> and the brightness keys then did nothing. At that point my test module
> had neither the descriptor fixup nor the forced hid-input binding yet,
> so the hotkey interface had no input device at all and the keys could
> not have worked in either mode; my userspace workaround was stopped.
> All later tests that day already included the re-send, so they showed
> that the whole patch works, but never whether the re-send is needed.
>
> I am really sorry for the extra work this caused, Paolo, for carrying
> and adapting the patch, and Denis and everyone else for reviewing it.
> This was my first time this deep into a driver, and I should have
> tested the re-send on its own before sending it.

Well you know how this things go... Only who does nothing can claim
to have made no mistakes. There's no problem for me, in fact it happened
to me too to do work based on assumptions that ended up being false...
It just happens and is nobody's fault!

I actually like reading these things so I know what was done and tested
and what to look for in case I find myself in similar situations (and what
to look for when bringing up new hardware in the fastest way possible).

> Unrelated, in case it is useful: with the series applied, the keyboard
> backlight stays on while the laptop is in s2idle suspend.

I haven't looked much at these models beside the wmi side so I don't
know if they are like ROGs/TUFs but ROGs and TUFs have the keyboard
backlight that can be configured in s2idle and/or hibernation, but even
if powered on usually the pattern changes... So I am concerned that
hardware isn't entering s2idle properly... Are you sure it is?

You can use the amd-s2idle tool even if the CPU is an intel one to check
that.

I don't want to speculate too much, but if it really is sleeping then we are
either missing a way to configure backlight enablement on power states
or a command to send while suspending.

> Thanks,
> Rebecca

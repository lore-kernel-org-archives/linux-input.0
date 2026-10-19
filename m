Received: from mta0.migadu.com (out-154.mta0.migadu.com [91.218.175.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92C14848AC
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407826; cv=none; b=fdH9Qzlu0DdhM4pRX+stZ4dWGqiqmJY6n5Z/d73Odjk+S0WQtKLWbEB9I2zYpzLFuMkNViKalp9x3Wpdjbh8GiizAl9Z0tCrDiv6SQUz455CIOSrex/FdiLDBbAhEaD/OPQURPlUjXJVKtA1BFtTL/HSGBFlJsqMJRSWtXG7xxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407826; c=relaxed/simple;
	bh=8dpq3mDpomcA8zFagoSGMCdVIAudwCqw7fzKBya/kFk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cfT3WU2pncEMj2PqLurXe3JLPzLzoAxfbEFjBgZ1JMiF3H+TGc+ah4dncXHs9j7VKLMa0gsUbLkbnSfFBoP09vmNmYF/nfTzPC1GdPnxEeWhT/uXkmksomIlgzrnD/IW6ZLHm28sFItFXCB7KS0V0QK3jktrJDcgxcTq08gwalI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uIYLcXTB; arc=none smtp.client-ip=91.218.175.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uIYLcXTB"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8dpq3mDpomcA8zFagoSGMCdVIAudwCqw7fzKBya/kFk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792407821; v=1; x=1793012621;
 b=uIYLcXTB7di/4p6Q536aPLcC+0oyqPQW/O7KWjR0jBHEEiNQT0euZ9gHrkHEdNKcFgg3iT+e
 2vYN4QF7NwuNyyHUQdiZYA+g2ngdqjWF1SX12LFM8/rMLHoC3PAlscjFXfNbAge0PYogTQ4XnVM
 0vUA6pie7DavmseQXt3Pk1b4=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6234f7fefbe68d3c;
	Mon, 19 Oct 2026 11:03:41 +0000
X-Mizu-Trace-ID: 6234f7fefbe68d3c
X-Migadu-Flow: FLOW_OUT
Date: Mon, 19 Oct 2026 13:03:34 +0200
From: Denis Benato <denis.benato@linux.dev>
To: =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>, Nathan Chancellor <nathan@kernel.org>,
	Paolo Pisati <p.pisati@gmail.com>
Message-ID: <07076668-3291-4eb6-888b-0e6c518ef21b@linux.dev>
In-Reply-To: <20261019061209.415930-1-rebecca.mara@posteo.de>
References: <23dcbde2-26c3-4288-aa71-3bb3107e3f45@linux.dev> <20261019061209.415930-1-rebecca.mara@posteo.de>
Subject: Re: [PATCH v3 7/7] HID: asus: Re-send the Zenbook Duo keyboard
 handshake after probe
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <07076668-3291-4eb6-888b-0e6c518ef21b@linux.dev>

19 ott 2026 08:12:47 Rebecca Mara M=C3=BCller <rebecca.mara@posteo.de>:

> On Sun, Oct 18, 2026 at 09:48:21PM +0200, Denis Benato wrote:
>> Well you know how this things go... Only who does nothing can claim
>> to have made no mistakes.
>
> Thank you, Denis, that was kind.
>
>> So I am concerned that hardware isn't entering s2idle properly...
>> Are you sure it is?
>
> I checked it this morning on the UX8407AA (Panther Lake), keyboard
> docked, with 30 s of s2idle via rtcwake -m freeze -s 30, reading
> /sys/power/suspend_stats/last_hw_sleep and
> /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us:
>
> =C2=A0 without hid-asus (hid-generic):=C2=A0 27.6 s hardware sleep, S0ix =
+27.6 s
> =C2=A0 with v3 loaded:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28.6 s hardware sleep, =
S0ix +28.6 s
>
> So it does reach S0ix, with and without the series. With v3 loaded and
> the backlight set to level 3 before suspending, the keyboard backlight
> stayed on unchanged for the whole time, no change in brightness or
> pattern. So I guess it is the second case you mention: nothing tells
> the keyboard to switch the backlight off on suspend.
>

Very good to see it sleeps just fine. So yeah a command is missing... On to=
p of my mind there are a few possibilities:

- is has a tuf leds power devid in asus-wmi (please check in /sys/class/pla=
tform/asus* what's available
- as the previous one, but firmware is bugged and the query of the capabili=
ty returns not supported while the write goes through (there is at least an=
other model doing that)
- it supports ROG-style power controls of zones and asusctl is lacking supp=
ort
- it has some other devid for that

First thing I would do is to follow instructions in gitlab.com/asus-linux/r=
everse-engineering to grab the acpi and search for devid that does things (=
I suggest an llm to quickly find unmapped/missing IDS) and if that fails I =
would head to windows to see what the asus software sends over USB... On wh=
at I deal with (ROGs mainly) the application is armoury crate, but perhaps =
on zenbooks and other line-ups it's not available and you only have myasus.

If that fails, and windows gets leds off, with "fails" meaning there is no =
command to tell the firmware what to do on s2idle.... Fire up a windows VM,=
 pass the hid device to it, setup the vm for s2idle and run a capture with =
wireshark on linux.... That should tell you if an explicit command is neede=
d.

If that's the case setup userspace to turn leds off, don't do it in kernel =
or TUFs will break lighting while in s2idle.

> And if you ever need something tested, on this machine or anything
> else, feel free to ping me. I enjoyed this and learned a lot, and I
> would like to keep learning.
>
> Thanks,
> Rebecca


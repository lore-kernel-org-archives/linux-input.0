Received: from mail.thomae-home.info (v220260156322427693.bestsrv.de [159.195.70.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDE33D45EA
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.195.70.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784008475; cv=none; b=qvUuz9kKPt7YSKA25CYX5gH1nrHnVJpqopdJcqywtCRW+dw9zDa9DusJwCxyn5d7yn/3tZ80Y7iCnjHofK4aHtsNUU0Y/LIxo/paB9vnFp/s+bluN5ZA7UuQxIeSDMNCJlPSGDaPiEXJ0/y95EMqfQMmkldBzziNjPpvIeJOFaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784008475; c=relaxed/simple;
	bh=j0xLVR2JBewY/RwTXtqHJNEa/U6Jrnx6wA96QhiP0Oc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RIGe4xsEgg+xEOj3giPPjv/WYuQ/9CJ7NiY0EXDshk8MgNiB5WuSM6nCShUvt3BAho0lrsZ4uJwQ0RbCxKEbRM7smgAsgLfG0uX1gyH2so2ISlV0ctHeZwmfHcbj2pDo4hI2CocF+2hRyRuoDTtOBme/dKhSVCu1GMoLHgT90Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thomae-home.info; spf=none smtp.mailfrom=thomae-home.info; arc=none smtp.client-ip=159.195.70.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thomae-home.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=thomae-home.info
Received: by mail.thomae-home.info (Postfix, from userid 105)
	id 5C77689E; Tue, 14 Jul 2026 07:47:02 +0200 (CEST)
X-Spam-Level: 
Received: from [10.42.0.100] (185.39.67.211.cgn.tpponline.de [185.39.67.211])
	by mail.thomae-home.info (Postfix) with ESMTPSA id 5FF422CD
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 07:46:58 +0200 (CEST)
Message-ID: <504f3ea7-fd23-428b-873b-12ed8bbce3ca@thomae-home.info>
Date: Tue, 14 Jul 2026 07:46:57 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-input@vger.kernel.org
From: Sebastian Thomae <basti@thomae-home.info>
Subject: =?UTF-8?Q?Logitech_G502_X_=28046d=3Ac099=29=3A_REL=5FWHEEL=5FHI=5FR?=
 =?UTF-8?Q?ES_always_reports_=C2=B1120?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

This is my first bug report to the list, and i used a LLM to help 
translate and collect all information, i hope this is fine.

Kernel: 7.1.3-arch1-1
libinput: 1.31.3
DE: KDE Plasma 6 (Wayland)
Device: Logitech G502 X (wired)
USB ID: |046d:c099|
The device is bound to |hid-generic| and is not handled by 
|hid-logitech-hidpp|.
|$ grep C099 /lib/modules/$(uname -r)/modules.alias (no output) $ lsmod 
| grep hid_logitech (no output)|
*
**Problem*
The device advertises and emits |REL_WHEEL_HI_RES|, but every wheel 
event reports exactly:
|REL_WHEEL ±1 REL_WHEEL_HI_RES ±120|
No intermediate high-resolution values are ever generated, regardless of 
wheel speed.
As a result, scrolling behaves identically to a traditional detented 
mouse wheel, even when the mouse is configured for high-resolution 
scrolling.

Using Solaar:
|hires-smooth-resolution = True
hires-scroll-mode = False|
does not change the event stream.
|
hires-scroll-mode = True
|disables the sending of wheel events (at least libinput and evdev see none)
*
libinput debug-events*
Example output:
|POINTER_SCROLL_WHEEL vert 15.00/120.0*|
The output is always based on 120-unit wheel events.
*
libinput record*
Each wheel notch produces:
|EV_REL REL_WHEEL 1 EV_REL REL_WHEEL_HI_RES 120|
No events with values smaller than 120 are ever observed.
*
HID descriptor*
The mouse exposes:
|REL_WHEEL REL_WHEEL_HI_RES|
However, the HID report descriptor does not appear to expose a 
Resolution Multiplier feature for the wheel.
*
Expected behaviour*
If the device supports high-resolution scrolling, I would expect 
|REL_WHEEL_HI_RES| to provide intermediate values (or multiple smaller 
events) rather than always reporting ±120.
If this device is expected to behave differently, could you clarify 
whether support for USB device |046d:c099| is currently incomplete, or 
whether additional HID initialization is required?


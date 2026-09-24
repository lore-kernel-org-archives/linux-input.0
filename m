Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216B411A1C
	for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286109; cv=none; b=rALQIBiR/5UiyRVt5mXUwWkze3bRAoQwhVlUGdM8nSwkoHzUk2mDSYvNGUfH5Vum+xh7qixHykT4gpsHh+9ZddDCR4MJ7rTLVg9oQh05vZq2blEhe8iZF+7mIGgueWwjmSJCvfWWgIXxhKODuLQ+IPJUOECfc9LpWsBOi6weK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286109; c=relaxed/simple;
	bh=mB1lKnqG8AuGXcQNR1csYPfP5+PMcGwbkZuQoheHxxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eedMTOx0G0smfX2rxkWwE/wJjzliRUbr+r63GutZzqlXMCLE1Wo+62sr9m6xVcDsjzxgvSQr587NDrE4SCoQt8cDwwFkJhIUV2hc/XbBGeS4IrzWWCDtZ0XjHBi3y2//du8KsxGHY2QfonReLTEiA9sBTrKvnEiF4V/nrCI3XPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXY1w3wp; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXY1w3wp"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a8b9acbc6so43131066b.0
        for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790286106; x=1790890906; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UHm5NRcTpn9N2haWjZVbXQGdMzSK/m+AUPZA427MG1U=;
        b=QXY1w3wpQwAgbhTjT5CCS5WpabOu/IWI7Gi+tnfYOvUfqj2xVt/9nkrv4Z1Z3Tn96a
         ij8r44H+q//06756dO6hWo2eMOr0ebIYX7g+ApoF0Zpl23UI1t1oBMk1BbAvdES0mJtd
         6UMPAehliIhjk6eSFS7pcql6rzHmFafYr/w+T5G54uUzD5UvP+yzQrnxMXFIn0hS2NWp
         hZEPWg7q5idUr3zvY3roUyKerQ4rTc4ARXJ+1QTq0yoGAxQIHO1Uedm5E6rv0TcJEN7f
         JSTn1YcRm+HKg8HrpJ6HFmSy8U2pRess2ym2xsPdL/LhYM32Vjri+oNvYeCHl5HxLZmH
         t0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286106; x=1790890906;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UHm5NRcTpn9N2haWjZVbXQGdMzSK/m+AUPZA427MG1U=;
        b=y09vEiRjjyDAbCsGHFjXZcSkUmiR5EPnc/MletR0g7gTIsdm9un/3gfO2KJhsZottu
         CYn7XWSYDrJAxM9oWsQkhLBSohxuimy4dpb6zpnWzCK96GmooJMwT3p/9yoZAf9Szvhp
         p9Ww5P2gRq4nKnjWnxz43ivdvagE2oODN51qbeaMfSpS+YhIqzv3qU9NtZzOGx+wqXQh
         M645ZVhOI+Iw3vQMAO+ESyc3w1YKkzxxustoqqhI3OAqJgbuzHzZz4RVVSUhvGo8ModG
         uyHJMl9Hd4sRRSLQ6cDxRafazFlDyfgvm052dKNV6A5hS9Ok9hIUnwhld79+EUgZSCPX
         lXLg==
X-Forwarded-Encrypted: i=1; AKwUvBzerJ5ynbwITi9ohqJtQk1/90Z5pvEn31JyOthctzXLuL5QA9sIQF2eoU/WioIHOdWXD18EmRFOBccv/A==@vger.kernel.org
X-Gm-Message-State: AFuF++l2xJ68pN9LF+s9lb7iCIBA/Xt06r7ioQ7Pykm2im97xuWkLW0y
	ePag82aUUGk7uIh9TKj5dpm2yJ9y1du/qPycw0fX7BmZuQ9MvHhvbfO43HgwTI4/twI=
X-Gm-Gg: AYBFou1QAyGGm10Y+A4J3xjt7Ym+qyj2DczjNHKqe86rWE5L5gjNmvAr4vlkOT/VKTI
	xWP1V4o6YKXjUguMNCPJES09wMHenIBxXTvfEDCgiTdLzTVPuSrFirsnREgMx7+mS3syRCFzKWy
	bkSMy+jSNVO5TOdooy+Re3FwD5QWHFn5kcZtQwD59MGjKfX5IWkbluLtHA9uannt9y0OBGWvRFe
	F0uiOEwS8d+nDZUfC9ugd4bF8L8y+JmI/Nrxa4+8/1XcGYWHnMs0arqhcLNC3CsHefxsxHYmNqJ
	LKGd0oS5ftrBU0qVaOqVtwam25MTIGVZyg5Q3Xk3FbC00nN5Z3aCny5M90YoTUYrJyzNda0ny5W
	IjWizBn+IV+Lbf1iCOeAHhSlNbXc/VoLODRdbiCkloXNPDWO9tLf1C95/smCM/u7T5hcgKe4ep1
	3DONHmz92uWQs9d0vh9fWTUe3IPng+W292JREsLw3Lpt0IK54n7Ag1wgb+hv8X1qQVHk9BaeSQi
	Znx2uDWDHNBTbPE5jdiw0jmoM3ZOpfFPz5oRSs7BU1A7sm3stzxGQ==
X-Received: by 2002:a17:907:9285:b0:c29:f742:c532 with SMTP id a640c23a62f3a-c2ac246a374mr326439066b.40.1790286105689;
        Thu, 24 Sep 2026 14:41:45 -0700 (PDT)
Received: from fedora.localnet (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae678ec74sm19676366b.4.2026.09.24.14.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:41:44 -0700 (PDT)
From: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Filipe =?UTF-8?B?TGHDrW5z?= <lains@riseup.net>,
 Bastien Nocera <hadess@hadess.net>, Rafael Passos <rafael@rcpassos.me>,
 =?UTF-8?B?R3LDqWdvaXJl?= Stein <greyxor@protonmail.com>,
 Alexey Zagorodnikov <xglooom@gmail.com>,
 Roman Stingler <roman.stingler@gmail.com>,
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
 =?UTF-8?B?S2F0ZcWZaW5hIE1lZHbEm2RvdsOh?= <k8ie@mcld.eu>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: fix Bolt hi-res wheel handling
Date: Thu, 24 Sep 2026 23:41:41 +0200
Message-ID: <r8QjhQUkS86zOaJsxE4nUw@gmail.com>
In-Reply-To: <xpFXjeFKTb2mOjg5M5iN0g@natalenko.name>
References:
 <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
 <97b3c67c-03ea-4ae6-ba64-afcdbbd8f36b@gmail.com>
 <xpFXjeFKTb2mOjg5M5iN0g@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi again!

I have some semi-good news regarding both the quirks, the conflict with user-
space setting in Solaar, and regarding being able to separate reports by 
device, so e.g. different capability mice can be used simultaneously.

Long text with background and description first, so scroll down for the actual 
solution. :) 

In an effort to figure out if we could have separation of events by device, I 
tried digging into whether I could force the Bolt receiver into DJ mode, 
similar to what is done for Unifying devices, and I investigated how it's done 
for my Lightspeed device, given that it's treated differently from regular 
Unifying devices in code.
Some looking at the HID++ protocols that are available online, as well as some 
probing of the USB interfaces revealed that the Lightspeed receiver does 
indeed support DJ, but unfortunately the Bolt receiver does not.
At least it does not support the same command as Unifying and Lightspeed 
receivers and no digging online or by probing hardware revealed anything.

However, when digging around I realized that the Lightspeed receiver is NOT 
put into DJ mode, but still all three interfaces are claimed by the DJ driver, 
yet the mouse works as it should. With tshark capture of wire data I saw that 
for Lightspeed, mouse events come as regular native HID, not as HID++ 
reports., i.e. the DJ mode is not used. And frankly, since the Lightspeed 
supports at most 1 mouse and 1 keyboard, separating devices are not necessary, 
except for the HID++ report on device status, such as battery and connection 
status, and those are sent on HID++ regardless of mode.

But previously, the theory has been that generic HID reports can't go through 
the DJ driver, but obviously it works for Lightspeed but not Bolt mice. 
Although keyboard does work. So I investigated some more and it turns out that 
when the DJ driver creates a virtual HID device it sends a descriptor on to 
the HID core, and this descriptor describes a bunch of stuff, including the 
size of the mouse movement reports. This descriptor is different for different 
receivers, and the default one has a movement report size of 12 bits. However, 
when inspecting the real Bolt descriptor (the same one read by the native HID 
when we do NOT let DJ claim the mouse and keyboard interfaces), I saw that the 
real report is 16 bits. Same as most relatively modern receivers.

So, I now *strongly* suspect that the reports of overly sensitive or phantom 
moves, and possibly scrolls, are the result of the HID layer trying to 
interpret a 16-bit report as 12 bits.
Without a Bolt mouse I can't verify of course, so I'll need some help with 
that.

During my digging, I *also* realized that HID++ reports already carry a device 
index, thus making every report that comes through HID++ separable by device, 
as well as the fact that for the existing 0x2121 (High resolution scroll over 
HID++) functionality, there was a bug, and scrolling seems to not have worked 
for any mouse over HID++, regardless of receiver type.

So, to the solution then:

I'm currently working on a new version of the patch which will align the Bolt 
receiver much closer to how other receivers work, most close to the Lightspeed 
receiver, by letting the DJ driver claim all three interfaces again, but fixing 
the device descriptor, which should let the mouse movement work as intended.
This also means that scrolling, whether high or low resolution, should work as 
intended even when use_hidpp=0.
I'm also improving the 0x2121 handling so that the existing bug that would 
break scrolling for any existing mouse using `use_hidpp=1`, as well as 
retaining the improvement to respect user settings in Solaar. Also, the 0x2121 
protocol notes that the scroll invert setting only affects events sent through 
native HID, not diverted, so I will also fix that so inversion will work 
regardless of diversion.
I.e. now scrolling should work as intended regardless of `use_hidpp` and 
`high_resolution`, and there will be no more conflict between kernel and user-
space settings in Solaar or elsewhere!

However, as noted, only HID++ reports carry a device index. Thus, regular 
mouse and keyboard reports that will still go through interface 0 and 1 will 
be indistinguishable between devices, but for special keyboard keys (volume, 
brightness, screenshot, etc.) as well as scroll events when `use_hidpp=1`. 
I.e. for the reports that actually matter, distinction will be possible!

tl;dr:
I'm writing a new patch that I'm pretty confident will work without quirky 
workarounds, it aligns better with existing receivers and thus less complex 
code, while also improving 0x2121 scrolling for all mice and getting rid of 
the conflict with Solaar.

Patch should be coming within the next few days.

Oleksandr Natalenko wrote:
> 
> You are right, the "Scroll Wheel Diversion" diversion switch was off for me.
> I've enabled it along with "Scroll Wheel Resolution", and the scrolling
> stays normal and survives both resume and device switching.

Great, then I'm even more confident in my new patch. With it, it should work 
with Scroll Wheel Diversion on or off!

> 
> Somewhat unrelated note: if I enable "Thumb Wheel Diversion", the thumb
> wheel stops working altogether. It's probably not supported by the driver
> at all in HID++ mode?
> 

Correct, the driver does not implement 0x2150 (Thumbwheel) in HID++ at all. 
However, since we're interested in diverting through HID++ for device 
separation purposes, I'm looking into implementing 0x2150 too to enable that 
diversion for that too.
And while reading the protocol there, I noticed that it also supports touch 
events on the thumbwheel. There's three different statuses, single_tap, proxy, 
and touch. Touch is continuous touch, single_tap is tap, and proxy is whether 
a finger is in close proximity but not quite touching. 
Does your mouse by any chance support that? If so, can you tell if it sends a 
button event on tap or touch when in non-diverted mode? Or possibly if it does 
so in Windows. I don't know what I should map those events to really :) 

Benjamin Tissoires wrote:
> Bolt in kernel was adding in 7.3, so I'm going to revert it now, and
> we'll have to have a fully working plan for an eventual inclusion in a
> future kernel version.




Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442303;
	b=RBOUhTw1QdiDGdBmP9Rs1j8lXxsG+5GXFcLcYZWPCrDxTpuOdm6hH31DaBbvA46RU5Xy
	 MCClR9LRb6+qDbC6KWW+0GSW91Bvo+hhxTAUDBmFVuA89HWLqtP9eMQxoYZit6ary7GEl
	 essoaf2IXqo7HYIgiVYW/v3E7DRxSn7nr1qCyHJL3TXvZ7w53SNYKEF+6z1T1BvUubAX9
	 ZYG6GSSnk44E6NivAgnnjrrW8a23H31+3W6K/1rE0GTvMO1SMiuWRyh2gGZSat2jV3D8e
	 9lbsWDLsDg6t49SfXkk0SYX9ZJ92VukPSYePqW4HtsCawBW83EVGkNjqjrfvz5Dya2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442303;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=HicBhdq3FFz5Zw997fRIFryI1pXSgad+sCXMpVwuGsc=;
	b=02sKQVs1z8F9X7T2Mq75yxoZjo2rHR9woSwjEfvacn9zj5qjLs0SRWBZ1JyC1Vjbc7Ks
	 ER+oKB+TPHrVJaywhutqu1XCGatYaJDK0t6UZZS1wybQXGA2Tt+fx6QNiFHeQ9N+5rwK8
	 IDWpf+jD3peKZjwtY89CZc4jYmstdD8FQ5OfSE+h6KKG+TyEFVNWb+Y+AZ6Tnc4yLfNDp
	 cZoS5VErTw63WpZBxWD++H4u80YxGeiwOzpN3VmZpAUbxttfkVSQgwhG60XpeBze6jO8J
	 vYu8PKweQQa1g4FgKXw4eMq6F84hzk4ZkL7gxpEyixn6pGWxeqoeR8kwjrGehPOPspw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.4
Received: from mta1.migadu.com (out-4.mta1.migadu.com [95.215.58.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A2D606A320
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 20:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22A2D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pDuLM45vvYweqsInlLjAFK3/ehNdWBWqOomWqBmuzHc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792442292; v=1; x=1793047092;
 b=i0gwiP6vCdLbQD0caS7VpHtuQM+R6xWc5H1MLicWXr97xhLECrTNuB1fOUYCFAnvMVgIiJ9g
 QflQkcNZ4w107dv4xUUI2WI9rIXl6S5gZwE9/4j1o56Hzu3te6vs5XesVUta2Urtvqy5bvfUGgX
 AciMqmUeZyFAbVSJg9IZBYYM=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f830ea09c65c2622;
	Mon, 19 Oct 2026 20:38:11 +0000
X-Mizu-Trace-ID: f830ea09c65c2622
X-Migadu-Flow: FLOW_OUT
Message-ID: <5e44ab55-09e3-4043-a369-05b792b5e0d3@linux.dev>
Date: Mon, 19 Oct 2026 22:38:11 +0200
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
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
References: <07076668-3291-4eb6-888b-0e6c518ef21b@linux.dev>
 <20261019133557.14092-1-rebecca.mara@posteo.de>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261019133557.14092-1-rebecca.mara@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/19/26 15:36, Rebecca Mara Müller wrote:
> On Mon, Oct 19, 2026 at 01:03:34PM +0200, Denis Benato wrote:
>> Very good to see it sleeps just fine. So yeah a command is missing...
> Thank you for the roadmap, I went through it on the UX8407AA with
> BIOS UX8407AA.308. I have since updated to 310, the latest one; its
> ACPI tables only differ from 308 in relocated memory regions, so the
> findings below should hold for both:

Most findings will hold for multiple models across different years
as asus reuses a lot of code for the same lineup. Thankfully!

> - asus-nb-wmi only exposes the basics here (kbd_backlight 0-3,
>   throttle_thermal_policy, charge_mode, screenpad); no TUF/ROG lighting
>   or power-state attributes.

Fair enough.

> - In the decompiled DSDT, WMNB answers 75 device IDs. None of the
>   TUF LED power IDs is among them, so it is not a firmware that claims
>   "unsupported" and accepts the write anyway. The kbd backlight ID
>   0x00050021 goes to the EC (SLKB), which does not reach the detachable
>   keyboard, a separate USB/BT device.

Does this laptop have other lights? I wonder what that is changing...

> - The LPS0 _DSM in PEPD only notifies the EC (MS entry/exit 0x9a/0x9b,
>   display off/on 0xb7/0xb8, entry/exit 0xae/0xaf). With
>   pm_debug_messages on, Linux calls all of them on s2idle (screen off,
>   lps0 ms entry, lps0 entry, and the exits), so nothing is skipped on
>   our side.

I have a cursed TUF that does the same and looks correct and yet it
doesn't sleep in linux... Someday I will understand what's going on
with that. Thankfully it's not the case here as the sleep residency
is high for you.

> - With dynamic debug on usbcore, the keyboard does go to USB suspend
>   ("usb 3-6: usb suspend, wakeup 1", and "wakeup 0" with wakeup
>   disabled), and the backlight stays on in both cases.

Wow... okay... so it was actually designed this way. 

> - The backlight only goes off when the keyboard loses the connection:
>   lifting it off the dock during s2idle turns it off immediately.

Probably because the idea is that "keyboard lit" = "ready to go"/"press a key to resume".

> So the keyboard simply keeps its backlight while it is connected, and
> I guess Windows either cuts the port power in Modern Standby or MyASUS
> turns the light off. I have no Windows on this machine at the moment
> to check which.

Could be that they simply leave it on as said above.

Doesn't look like something to be investigated further, perhaps try to see
if there is some unknown devid in wmi that does something cool.

> Following your advice I did it in userspace: a systemd-sleep hook that
> saves asus::kbd_backlight and writes 0 on "pre", and restores it on
> "post". With v3 loaded the light now goes off just before the screen
> and comes back on resume. If it is useful to anyone else I can post it.

in the OGC discord (ex asus-linux discord, you find it on our website) people
are planning a GUI redesign, perhaps if you have spare time you can add an option
to asusd to shutdown leds when entering sleep to have a GUI on a widely used tool
but I think this is time consuming enough that is probably not worth unless you find
it funny to do.

> Thanks,
> Rebecca

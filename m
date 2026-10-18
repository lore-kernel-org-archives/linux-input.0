Received: from mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4339C3DB632
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792345961; cv=none; b=EtW+1DZfPKuW/Fd3mdFMceHh+a1We0Rt4n4b2pHeBWxfctwcxn5/GQHv3OPdaPIMQLwzEyLRQnc47GadJqLTZp70YgGgjgJ46FLej4Pm08gSMmuGDtGpZSi3nLu60FT+F1AUkWuiZRipHJefGx1gBQSOEJjRb9fd6v4NV++GVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792345961; c=relaxed/simple;
	bh=/yCtvJCYYZsJdgWykSebGCqCeeamJn7VHphtGEEsuG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKYGtbT2XhNfufd1UpxXyEoluRSPJXuYIdZ37mMxD4ZRNxW3r6Fa7J5dARaZpjJKKbvD7Jvn1qlFZPF1tcqSMONi+e1Z7TnTCYkL3xh/Jq2bEVHPGmS2c3UY8TtnhYRy5zSBnrTNJd57/vQdrwVEWVzVN0hZ/7G5ifU/P0IPqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kOrCkr4A; arc=none smtp.client-ip=91.218.175.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kOrCkr4A"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/yCtvJCYYZsJdgWykSebGCqCeeamJn7VHphtGEEsuG8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792345957; v=1; x=1792950757;
 b=kOrCkr4A8NyEgO1daBZdkdeG2Exmn3GSIto3NgBeaalIv2AhtL6gI4SBxIM6BZc51i6aLab6
 elesrPEn19JiOmZ1DNQR71IFYAJIn0Hjyk4RGXjgxu2CsW2LNBwT5jgMG5pG5plbySsYODmQja1
 HxbFlhyUrYn8dFPZjGyzXj8I=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6fd0374458e534e6;
	Sun, 18 Oct 2026 17:52:37 +0000
X-Mizu-Trace-ID: 6fd0374458e534e6
X-Migadu-Flow: FLOW_OUT
Message-ID: <e7326f97-6326-4f63-bcf1-fb728f41b381@linux.dev>
Date: Sun, 18 Oct 2026 19:52:35 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] HID: asus: Fix up Zenbook Duo report descriptors
To: =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luke Jones <luke@ljones.dev>,
 Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 Ivan Levchenko <me@livan.pro>, Nathan Chancellor <nathan@kernel.org>,
 Paolo Pisati <p.pisati@gmail.com>
References: <b22a521d-ec6e-4ac8-9aaa-d34e67ba898f@linux.dev>
 <20261018161826.1738483-1-rebecca.mara@posteo.de>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261018161826.1738483-1-rebecca.mara@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/18/26 18:18, Rebecca Mara Müller wrote:
> On Sun, Oct 18, 2026 at 05:50:08PM +0200, Denis Benato wrote:
>> Does the zenbook duo really needs fixing the report descriptor? I think you can avoid this
>> altogether on this hardware.
> Welcome back, Denis. I tested exactly that on my UX8407AA today, docked
> over USB: v3 built as an out-of-tree module against a 7.0.11-based
> distribution kernel, once as posted and once with only the Zenbook Duo
> fixup disabled (QUIRK_ZENBOOK_DUO_KEYBOARD removed from the fixup
> condition, nothing else changed), my userspace workaround stopped.

Thank you Rebecca!

> Without the fixup, the hotkey interface gets no input device at all:
>
>   asus 0003:0B05:1CD7.000A: hiddev2,hidraw8: USB HID v1.11 Device [...] on usb-0000:00:14.0-6/input4
>
> With the fixup:
>
>   asus 0003:0B05:1CD7.000A: Fixing up Zenbook Duo keyb report descriptor
>   asus 0003:0B05:1CD7.000A: input,hiddev2,hidraw8: USB HID v1.11 Device [...] on usb-0000:00:14.0-6/input4
>
> Without the fixup, volume up/down and mute still work, as they come from
> another interface, but screen brightness, keyboard backlight, mic mute
> and Fn+F profile cycling are dead (checked with an evdev reader and
> /sys/firmware/acpi/platform_profile). With the fixup all of them work.
> So yes, as far as I can tell this keyboard needs it.

Okay... Noted. Is the forcing of a name required too? It has caused a debate
in the past, we used to rename all input devices on hid-asus and now we
don't anymore so if can be avoided it would be great to follow the now
preferred way.

> On the Assisted-by format: my original patch (7/7) was written with
> Claude Code using claude-fable-5, so following
> Documentation/process/coding-assistants.rst that would be
>
> Assisted-by: Claude:claude-fable-5
>
> Paolo, feel free to use that above my Signed-off-by in a respin.
>
> Thanks,
> Rebecca

Thanks for your time and effort,
Denis

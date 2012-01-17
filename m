From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH v3] bcm5974: Set BUTTONPAD property
Date: Tue, 17 Jan 2012 20:06:45 +0100
Message-ID: <4F15C6C5.8060202@canonical.com>
References: <20120111100444.GA5573@polaris.bitmath.org> <4F0D5FCE.6080809@canonical.com> <20120111171848.GA21047@core.coreip.homeip.net> <4F0E00D0.4060201@canonical.com> <20120111215950.GE21047@core.coreip.homeip.net> <4F0E13C9.7090100@canonical.com> <20120112002221.GA7546@polaris.bitmath.org> <4F0EB3BC.3060602@canonical.com> <20120117180650.GA19995@core.coreip.homeip.net> <4F15BD26.1030700@canonical.com> <20120117185738.GA12487@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47334 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab2AQTGn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jan 2012 14:06:43 -0500
In-Reply-To: <20120117185738.GA12487@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jussi Pakkanen <jussi.pakkanen@canonical.com>, linux-input@vger.kernel.org

On 01/17/2012 07:57 PM, Henrik Rydberg wrote:
>> Imagine a tablet driver only has INPUT_PROP_DIRECT set. According to the
>> "unknown" definition, it's ok to leave INPUT_PROP_POINTER as unset. But
>> then userspace will end up treating it like a touchscreen instead of a
>> tablet.
> 
> INPUT_PROP_DIRECT and INPUT_PROP_POINTER go together, remember? Thus,
> there is no problem using the input properties to determine the
> (touchscreen, touchpad, tablet) types.

Sorry, I forgot. Which means this needs to be documented too :).

>> If you are unwilling to backport property bits to stable kernels, then I
>> don't think we have any other choice than to leave the definition as
>> "unset bits are unknown", but it clearly puts userspace in a bind.
>> Because the evdev event codes are clear (BTN_TOUCH means touchscreen,
>> BTN_TOOL_FINGER means touchpad) and these property bits are not, I doubt
>> userspace will ever rely on the direct and pointer property bits.
> 
> BUTTONPAD
> 
> If set, treat as button pad. If not set and bcm5974, look at result of
> older method. Else, treat as not button pad.
> 
> SEMIMT
> 
> If set, treat as semimt device. If not set, treat as not semimt
> device.
> 
> There, all four types are now fully defined and backwards compatible.

These two are more straightforward. We can easily handle these
properties as "unknown" without breaking things. It's the other bits
that are problematic.

-- Chase

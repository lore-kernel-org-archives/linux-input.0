From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] bcm5974: Set BUTTONPAD property
Date: Tue, 17 Jan 2012 19:57:38 +0100
Message-ID: <20120117185738.GA12487@polaris.bitmath.org>
References: <20120111100444.GA5573@polaris.bitmath.org>
 <4F0D5FCE.6080809@canonical.com>
 <20120111171848.GA21047@core.coreip.homeip.net>
 <4F0E00D0.4060201@canonical.com>
 <20120111215950.GE21047@core.coreip.homeip.net>
 <4F0E13C9.7090100@canonical.com>
 <20120112002221.GA7546@polaris.bitmath.org>
 <4F0EB3BC.3060602@canonical.com>
 <20120117180650.GA19995@core.coreip.homeip.net>
 <4F15BD26.1030700@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:38358 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab2AQS5d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jan 2012 13:57:33 -0500
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id 4FBFBDAB4
	for <linux-input@vger.kernel.org>; Tue, 17 Jan 2012 19:57:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F15BD26.1030700@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jussi Pakkanen <jussi.pakkanen@canonical.com>, linux-input@vger.kernel.org

> Imagine a tablet driver only has INPUT_PROP_DIRECT set. According to the
> "unknown" definition, it's ok to leave INPUT_PROP_POINTER as unset. But
> then userspace will end up treating it like a touchscreen instead of a
> tablet.

INPUT_PROP_DIRECT and INPUT_PROP_POINTER go together, remember? Thus,
there is no problem using the input properties to determine the
(touchscreen, touchpad, tablet) types.

> If you are unwilling to backport property bits to stable kernels, then I
> don't think we have any other choice than to leave the definition as
> "unset bits are unknown", but it clearly puts userspace in a bind.
> Because the evdev event codes are clear (BTN_TOUCH means touchscreen,
> BTN_TOOL_FINGER means touchpad) and these property bits are not, I doubt
> userspace will ever rely on the direct and pointer property bits.

BUTTONPAD

If set, treat as button pad. If not set and bcm5974, look at result of
older method. Else, treat as not button pad.

SEMIMT

If set, treat as semimt device. If not set, treat as not semimt
device.

There, all four types are now fully defined and backwards compatible.

Henrik

From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] bcm5974: Set BUTTONPAD property
Date: Tue, 17 Jan 2012 19:15:08 +0100
Message-ID: <20120117181508.GA12439@polaris.bitmath.org>
References: <4F0D5521.5030808@canonical.com>
 <20120111100444.GA5573@polaris.bitmath.org>
 <4F0D5FCE.6080809@canonical.com>
 <20120111171848.GA21047@core.coreip.homeip.net>
 <4F0E00D0.4060201@canonical.com>
 <20120111215950.GE21047@core.coreip.homeip.net>
 <4F0E13C9.7090100@canonical.com>
 <20120112002221.GA7546@polaris.bitmath.org>
 <4F0EB3BC.3060602@canonical.com>
 <20120117180650.GA19995@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:52968 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab2AQSPB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jan 2012 13:15:01 -0500
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 2DDCDE327
	for <linux-input@vger.kernel.org>; Tue, 17 Jan 2012 19:14:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120117180650.GA19995@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, Jussi Pakkanen <jussi.pakkanen@canonical.com>, linux-input@vger.kernel.org

> OK, so how about this:
> 
> INPUT_PROP_DIRECT:
> 
> This property idicates that device coordinates can be directly mapped to
> screen coordinates (not taking into account trivial transformations,
> such as scaling, flipping and rotating). Non-direct input devices
> require non-trivial transformation, such as absolute to relative
> transformation for touchpads. Typical direct input devices:
> touchscreens, drawing tablets; non-direct devices: touchpads, mice.
> 
> INPUT_PROP_POINTER:
> 
> This property indicates that the device is not transposed on the screen
> and thus requires use of an on-screen pointer to trace user's movements.
> Typical pointer devices: touchpads, tablets, mice; non-pointer device:
> touchscreen.
> 
> How does this sound?

Excellent, thanks for that. Fits nicely in a documentation patch - you or me?

Now, let's move on. ;-)

Thanks,
Henrik

From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Fri, 16 Sep 2011 12:50:36 +0200
Message-ID: <20110916105036.GA4455@polaris.bitmath.org>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
 <20110913080911.GA4986@polaris.bitmath.org>
 <CAPHpN5OAPdPQ1SmwrGT6pMvgWESBOSnRvb0jKUszkU_31MFXWg@mail.gmail.com>
 <20110914071524.GA3422@polaris.bitmath.org>
 <CAF8JNhKFz8-bJ4HMguU2qReageX4WBB1bWR0amRbYmaujNVX8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:46020 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab1IPKqz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 06:46:55 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id E0DA6EB3F7
	for <linux-input@vger.kernel.org>; Fri, 16 Sep 2011 12:46:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAF8JNhKFz8-bJ4HMguU2qReageX4WBB1bWR0amRbYmaujNVX8A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Linux Input <linux-input@vger.kernel.org>

> > I think the bottom line is that even if the "directness" of a device
> > is configurable, it still needs to have a default. Moreover, the
> > notion of kernel mode settings could be applicable here too.
> 
> Talking about default mode, there are cases that the mode is decided
> by the tools running on the device/tablet, instead of the tablet
> itself.
> 
> Take Wacom's Intuos and Graphire series for example, those tablets
> support both styli and mice. For styli, the default is absolute mode;
> while for mice, it is relative. So, only valid property the tablet can
> tell the user-land is: I am a tablet, i.e., not a touchscreen. Clients
> have to check the tool types to set the default mode to relative
> (BTN_TOOL_MOUSE/LENS) or absolute (BTN_TOOL_PEN/AIRBRUSH/RUBBER...).

And those modes can be determined using the available axes. However,
when all axes are the same, a statement like "I am a tablet" does not
exist. In that case, distinguishing between touchscreen, touchpad and
tablet becomes a question of interpreting the properties. Such a
distinction cannot be achieved using a single bit of information, and
that was never the intention.

In short: I think Chris' comments are spot on, and incorporating them
into the patch would be good to avoid further confusion.

Thanks,
Henrik

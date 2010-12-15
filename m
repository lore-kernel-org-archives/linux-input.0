From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 1/2] Input: synaptics - add multitouch packet support
Date: Wed, 15 Dec 2010 15:21:28 +0100
Message-ID: <4D08CEE8.9080804@euromail.se>
References: <1292280948-1933-1-git-send-email-rydberg@euromail.se> <4D06A7B1.6060609@canonical.com> <4D06A90C.90009@euromail.se> <4D07E38C.4020201@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:33350 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753942Ab0LOOVx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Dec 2010 09:21:53 -0500
In-Reply-To: <4D07E38C.4020201@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Takashi Iwai <tiwai@suse.de>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>

> After some testing this is mostly fine,

 but I have one of those terrible
> "integrated buttons" (or whatever we call it) trackpads. When switching
> to multitouch mode, the cursor will sometimes jump when I go to push the
> button.
> 
> Take the following sequence:
> 
> 1. Touch in top right corner of pad to position cursor
> 2. Touch in bottom left corner over button
> 3. Press button, but finger moves a little
> 
> Step 3 causes the primary coordinates in the synaptics MT protocol to
> flip to the button-pressing touch. This causes a cursor jump. *Many*
> times I have gone to press an "Ok" dialog button and found that I
> accidentally launched an application from my dock :).


I see - the behavior of the primary coordinates seems to vary between models,
then. On the other hand, if you point and click with the same finger, one could
possibly go around this problem, even though it means less precision. On my MT
laptop, I can click at the very edge of the pad without the cursor moving.

> I think we should perform some rudimentary touch tracking to ensure the
> same touch is always used for reporting ABS_X/ABS_Y. A simple distance
> comparison between the two touches, as I implemented in one of my other
> patches, would suffice.


One can certainly decide on the "best" coordinates when putting down the second
finger, as we tried for elantech. However, after some movement, when the second
finger is lifted, chances are you get a jump then instead.

> What do you think?


The general approach we have taken for the kernel is to provide a left button
for both the macbooks and these clickpads, and in addition provide enough
information (read mt data) to solve this problem in userspace. In other words,
one should probably see what additions are needed in the common X drivers to
make the experience a pleasant one.

Thanks,
Henrik

From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH, v2] input/imx2x: generic keypad handler for i.MX SoCs
Date: Fri, 17 Apr 2009 21:40:33 +0200
Message-ID: <200904172140.33542.hs4233@mail.mn-solutions.de>
References: <200904171640.14294.hs4233@mail.mn-solutions.de> <20090417160409.GB20999@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx51.mymxserver.com ([85.199.173.110]:61732 "EHLO
	mx51.mymxserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbZDQTlD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2009 15:41:03 -0400
In-Reply-To: <20090417160409.GB20999@dtor-d630.eng.vmware.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.arm.linux.org.uk

> It looks very nice, thank you. I wonder however whether a
> separate method for scancode to keycode conversion is really
> needed. Why can't you have platform code supply a keymap table
> and set up keycode, keycodesize and keycodemax fields of the
> input_dev structure? The generic code can easily set up
> keybits based on provided keymap. If you do this then input
> core will allow changing keymap at runtime with
> EVIOCGKEYCODE/EVIOCSKEYCODE.

For my application this wouldn't work, because my mapping from 
row/column pairs to input events is stateful. AFAIK the current 
kernel code cannot emulate the function of a cell-phone like 
keyboard.

See my mail to Paulius in this thread.

> I don't think you need both linux/input.h and forward
> declaration of input_dev.

Ok.


> > +#if 0
>
> Why is this code disabled?

Opps, I submitted the wrong version of the patch. Normally I 
don't submit things with #if 0 experimental code in it.

At first, I thought that the open function should do this kind of 
initialization. However, later I found that the open function 
was actually never called (with imxfb as framebuffer and a 
busybox-shell without login running there). So I moved the code 
away, inside the probe function.

> Hmm.. I wonder if the init() method should be returning error
> code. We don't really know the extent of setup needed by a
> particular board and whetehr any of the steps could fail.

In my case, I don't need that, but to get this more general 
usable, that would be a good idea.

> > +	if (kp) {
>
> Can' kp actually ever be NULL when this function is invoked?

I don't know. Do you?



> Hmm, we do init() before requesting IRQ and enabling clock...
> Maybe move exit() after disabling clock?

It might be the case that the exit code will still need to 
program the keypad function block, e.g. setting rows or colums 
to some definite state. If this case should happen AND if the 
clock is already turned off, your SoC might hang.

> With this code is likely being used in a PDA does it need
> suspendresume handlers by any chance?

Yes, it might. I actually think it's very desirable to have this 
feature. I event want to be able to use they keypad to get my 
system out of suspend.

However, my board currently doesn't yet do suspend/resume at all, 
so I wasn't able to code this. Should I add a FIXME/TODO/REVISIT 
marker?

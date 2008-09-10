From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: mousedev: Emulate right and middle buttons
	for single-button touchpads
Date: Wed, 10 Sep 2008 11:32:14 -0400
Message-ID: <20080910153213.GA6940@USFSHXP-002051>
References: <48C0893C.6060901@euromail.se> <20080910125228.GA25221@anvil.corenet.prv> <48C7DF08.4060208@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:33449 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbYIJPcV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2008 11:32:21 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1376449yxm.1
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2008 08:32:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48C7DF08.4060208@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: akpm@osdl.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 10, 2008 at 04:51:52PM +0200, Henrik Rydberg wrote:
> Greetings Dmitry,
> 
> > On Fri, Sep 05, 2008 at 03:19:56AM +0200, Henrik Rydberg wrote:
> >> On most linux-based systems, the right and middle buttons are used
> >> extensively. On computers lacking either of those buttons, such as
> >> the Apple Macbooks, emulation is needed. This patch adds emulation
> >> of the missing buttons via two-fingers-and-click and three-fingers-
> >> and-click operations, which has recently become standard, both in
> >> MacOS and in the Xorg synaptics driver.
> >>
> > 
> > The standard way of emulating right and middle button presses for
> > "button-deficient" devices is to use Macintosh emulation
> > (MAC_EMUMOUSEBTN) that works not only for touchpads but for regular mice
> > as well.
> 
> I have a hard time believing that in five years from now, people will
> still consider pressing a key on the keyboard the standard way to
> emulate a right click.

Well, what other options do you have if your device has only one
button and nothing else (i.e. it's a mouse, not a touchpad)? Anyway, I
hope in 5 years distros will switch to pure evdev-based interfaces and
won't use mousedev at all.

> Nevertheless, I can see the point in moving
> away from user-land decisions in the kernel. I will not pursue this one
> further, although it is a rather neat piece of functionality.
> 
> > Overall I don't think we should enhance mousedev for scenarios where
> > proper solution is to install Synaptics X driver. This also goes for
> > your other patch improving tapping in mousedev.
> 
> Regarding the tapping patch; it is addressing the correctness of
> already implemented functionality. I can see nothing wrong with that.
>

My position that since the isssue can be "fixed" by simply installing
the proper X driver I'd rather not include it. Mousedev purpose is to
provide good enough emulation in absence of a native driver and that's
it. Also, the default value would not work well on high-resiolution
devices (like Synaptics) and would require user fiddling with kernel
parameters - not worth it in my opinion.

-- 
Dmitry

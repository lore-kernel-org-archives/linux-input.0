From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.24: false double-clicks from USB mouse
Date: Fri, 7 Dec 2007 16:43:17 -0500
Message-ID: <d120d5000712071343t4f5c1919k21905e1f8fdf8798@mail.gmail.com>
References: <4752DB8C.50608@rtr.ca> <4752FEFE.3000600@rtr.ca>
	 <Pine.LNX.4.64.0712022007360.13260@jikos.suse.cz>
	 <47530680.6020206@rtr.ca>
	 <Pine.LNX.4.64.0712022025250.13260@jikos.suse.cz>
	 <47530B32.7080502@rtr.ca>
	 <Pine.LNX.4.64.0712022300490.13260@jikos.suse.cz>
	 <2c0942db0712070959v400901ax59f7b445ec701c27@mail.gmail.com>
	 <d120d5000712071032r35f7c837paa513e20a9029ab4@mail.gmail.com>
	 <2c0942db0712071323q8c4c888k3cba4e093f6eb145@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:62774 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbXLGVnT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Dec 2007 16:43:19 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1051410ugc
        for <linux-input@vger.kernel.org>; Fri, 07 Dec 2007 13:43:18 -0800 (PST)
In-Reply-To: <2c0942db0712071323q8c4c888k3cba4e093f6eb145@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Mark Lord <lkml@rtr.ca>, rubini@vision.unipv.it, linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-usb-devel@lists.sourceforge.net

On Dec 7, 2007 4:23 PM, Ray Lee <ray-lk@madrabbit.org> wrote:
>
> On Dec 7, 2007 10:32 AM, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Dec 7, 2007 12:59 PM, Ray Lee <ray-lk@madrabbit.org> wrote:
> > > On Dec 2, 2007 2:07 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> > > > Thanks. To sum up this longish thread:
> > > >
> > > > - Mark seems to be able to reproduce the problem quite easily; I was not
> > > >   successful reproducing this no matter how hard I tried, and I also
> > > >   didn't receive any similar bugreports from anyone else
> > > > - we are currently waiting for Mark to provide HID_DEBUG (and preferably
> > > >   also usbmon) output from the situation where multiple clicks are
> > > >   being generated incorrectly
> > >
> > > Okay, I'm having a problem with 2.6.24-rc4 that I didn't with 2.6.23-rc6.
> > >
> > > When the problem hits, my mouse (synaptics touchpad) is randomly
> > > moving about and clicking things whenever I have my finger on the
> > > trackpad. This behavior will persists for five to ten minutes (is
> > > happening now), and seems to be triggered by load (watching online
> > > videos in flash player, for example -- this matches Mark's experience
> > > with a make -j4).
> > >
> > > I *think* the touchpad is connected via ps2, which looks like it'd
> > > clear usb of any blame. It's /dev/input/event6 at any rate.
> > >
> > > This has been happening about once a day, and seems to start because
> > > of high CPU usage. ONce the CPU is idle, it still happens though, so
> > > I'm not sure why it clears up.
> > >
> > > Any clues for where I should hunt from here?
> > >
> >
> > Can you try replacing drivers/input/ and include/linux/input.h from
> > 2.6.23-rc6 and see if it works or not? That should give us idea if
> > input locking changes are to blame.
>
> I'm hitting a number of build errors, trying to compile a hybrid
> between the two.
>
> git checkout v2.6.24-rc4
> git checkout v2.6.23 include/linux/input.h drivers/input
> make
> # fails with kconfig issues
> git checkout v2.6.24-rc4 drivers/input/misc/Kconfig
> make
> # fails
> ...adding to include/linux/input.h:
> #define KEY_CNT                   (KEY_MAX+1)
>
> takes the build a little farther until it dies on more missing
> definitions. Doing a checkout of 2.6.24-rc4's include/linux/input.h
> leads to different build errors.
>
> Looking at git log for drivers/input, it appears the patches you're
> talking about are the ones starting with 8006479c9b? If so, perhaps I
> should just build the revision right before that commit and test that?
>

Yes doing this and then buildig
b9d2d110b10f7b4788d0fdd328cf57e34b767817s shoulds isolate msot input
core changes.

-- 
Dmitry

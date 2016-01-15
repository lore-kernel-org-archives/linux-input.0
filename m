From: Lauri Kasanen <cand@gmx.com>
Subject: Re: MOUSE_PS2_VMMOUSE and input/mice
Date: Fri, 15 Jan 2016 13:23:12 +0200
Message-ID: <20160115132312.654ad5aa.cand@gmx.com>
References: <20160115123928.d06e1fed.cand@gmx.com>
	<5698D343.3000606@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:59482 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757784AbcAOLXN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 06:23:13 -0500
In-Reply-To: <5698D343.3000606@vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Hellstrom <thellstrom@vmware.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Fri, 15 Jan 2016 12:08:51 +0100
Thomas Hellstrom <thellstrom@vmware.com> wrote:

> > Seems the new and shiny VMWare mouse driver does not pass events
> > to /dev/input/mice, rudely breaking userspace that doesn't
> > support absolute input devices.
> >
> > Can this be changed? Would there be any downside to passing those
> > events?
>
> Hi, Lauri.
> What particular use-case is broken?

VMWare + 4.2 kernel + Xvesa. This was reported for the current TinyCore
beta, which has that kernel.

> I'm assuming what's happening is that only the relative device gets
> recognized as a mouse, and by default we don't send events through that
> device.
> 
> In the vmware gui there is a workaround, one can select 
> edit->preferences->input->"Optimize mouse for games"->Always
> 
> This will send events through the relative USB mouse, and if there is no
> USB controller in the VM, through the relative MOUSE_PS2_VMMOUSE
> 
> The other option is to limit the number of protocols the PS2 driver
> checks for and avoid enabling the vmmmouse functionality. There is a
> kernel module option for that, although I can't remember it offhand.
> 
> We can't send both relative and absolute events simultaneously since
> that would confuse the X server severely.

Yeah, I know of the psmouse.proto=imps workaround. But requiring either
bootcodes or VM setting tweaks is not nice, as what the users see will
be "distro version X worked in my VMWare, in version Y the mouse does
not work".

If we instead disable MOUSE_PS2_VMMOUSE, I assume a future
xf86-input-vmmouse version will drop support for the userspace-side
mouse synchronization, and then VMWare+Xorg users will suffer.

Can you think of any solution that would detect things at runtime?

- Lauri

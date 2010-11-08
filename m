From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ir-core and default IR maps
Date: Sun, 7 Nov 2010 23:23:17 -0800
Message-ID: <20101108072317.GB6977@core.coreip.homeip.net>
References: <AANLkTikfeu4DnV8E7rKahUdu2k_d08BOFZjLzBMRA2o+@mail.gmail.com>
 <20101107060147.GC3823@core.coreip.homeip.net>
 <AANLkTinbTw26wTvbUVJU+sEGyH0DCt4WvmfO2_nvcLjR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50070 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab0KHHXY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 02:23:24 -0500
Received: by ywc21 with SMTP id 21so3124773ywc.19
        for <linux-input@vger.kernel.org>; Sun, 07 Nov 2010 23:23:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinbTw26wTvbUVJU+sEGyH0DCt4WvmfO2_nvcLjR@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Mauro Carvalho Chehab <mchehab@redhat.com>, Jarod Wilson <jarod@redhat.com>

On Sun, Nov 07, 2010 at 09:36:23AM -0500, jonsmirl@gmail.com wrote:
> On Sun, Nov 7, 2010 at 1:01 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Sat, Nov 06, 2010 at 06:08:57PM -0400, jonsmirl@gmail.com wrote:
> >> I thought about this some more and I think the default maps should
> >> stay in the drivers. The maps are marked __init so they don't take any
> >> room after they are loaded. This is an important piece and plug and
> >> play and we should keep it. Only the keymaps for default remote
> >> controls that ship with the specific hardware should be included in
> >> the driver. All other keymaps are in user space.
> >>
> >
> > Plug and play does not have to be implemented in kernel and udev is
> > perfectly capable doing it in userspace for us. Embedded products that
> > absolutely not want to ship udev and want to limit themselves to a
> > single vendor-supplied remote will have to adjust their startup scripts
> > to load the proper keymap.
> 
> I agree that it doesn't have to be implemented in the kernel. This is
> an ease of use decision, not a requirement.

For the user it will be completely transparent (on a sane distribution)
even if keymaps are managed by udev.

> 
> For user space support either the end user has to be aware that after
> he buys the MSMCE he also has to install a user space package to make
> it work, or the distros always have to install the package.

The distributions will install the package, the same way they install
lirc, udev, firmware (you noticed we do not ship most firmware with the
kernel anymore?) and other things.

> 
> For the kernel side I only see a maintenance issue. All of the keycode
> support is marked _init and vaporizes after boot so there is no
> run-time impact.
> 
> Another solution could be for the distros to add a distro specific
> default udev action that installs the package if the user starts using
> IR. This has to be distro specific since they all install things
> differently. What we need is a hardware triggered package install
> mechanism paralleling what happens with loadmodule. On windows it pops
> up and says - search for a driver - we don't have that on any Linux
> distribution I've used.

I'd expect this package either be always installed or marked as a
prerequisite for programs that might use remote controllers (mplayer,
mythtv, etc). Always installed is probably the simplest option.

-- 
Dmitry

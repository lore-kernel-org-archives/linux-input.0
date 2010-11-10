From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ir-core and default IR maps
Date: Tue, 9 Nov 2010 22:51:33 -0800
Message-ID: <20101110065133.GA22666@core.coreip.homeip.net>
References: <AANLkTikfeu4DnV8E7rKahUdu2k_d08BOFZjLzBMRA2o+@mail.gmail.com>
 <20101107060147.GC3823@core.coreip.homeip.net>
 <AANLkTinbTw26wTvbUVJU+sEGyH0DCt4WvmfO2_nvcLjR@mail.gmail.com>
 <4CD7F6A7.8040206@redhat.com>
 <AANLkTinc_SuTrP6E8aoyXxGKEQwu=QRieRPt3z4b6Xn_@mail.gmail.com>
 <AANLkTimPKkvdWWTPoWGCRmp-biwup1dEQpaKYEk8t9ED@mail.gmail.com>
 <4CD805D8.2000808@redhat.com>
 <20101109063242.GA10496@core.coreip.homeip.net>
 <4CD920AE.8090406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59747 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab0KJGvl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 01:51:41 -0500
Received: by ywc21 with SMTP id 21so146855ywc.19
        for <linux-input@vger.kernel.org>; Tue, 09 Nov 2010 22:51:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CD920AE.8090406@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: "jonsmirl@gmail.com" <jonsmirl@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Jarod Wilson <jarod@redhat.com>

On Tue, Nov 09, 2010 at 08:21:34AM -0200, Mauro Carvalho Chehab wrote:
> Em 09-11-2010 04:32, Dmitry Torokhov escreveu:
> > On Mon, Nov 08, 2010 at 12:14:48PM -0200, Mauro Carvalho Chehab wrote:
> >> Em 08-11-2010 11:41, jonsmirl@gmail.com escreveu:
> >>> On Mon, Nov 8, 2010 at 8:34 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> >>>> To achieve plug and play at least one of four choices has to happen:
> >>>
> >>> There is another option, the IR maps get integrated into user space
> >>> keyboard mapping package. This may be possible with the new
> >>> libxkbcommon package.
> >>
> >> That seems interesting.
> >>
> > 
> > I disagree here. libxkbcommon provides X interface while applications
> > might want to access evdev nodes directly. 
> 
> Let me express better: I don't think we should integrate X with the udev tool, 
> but, eventually, we could make some X package dependent of v4l-utils. Not sure
> if libxkbdcommon is the better way to do it, as I don't have it installed here
> on my machines.
> 
> > If anything, parts of
> > ir-utils dealing with keymap selection should be moved into udev. Maybe
> > we should split utilities that select protocol from the keymap setting
> > and use udev keymap utilities to do the task.
> 
> It doesn't make sense to split keymap and protocol selection. Just loading a
> keyboard table but not changing the IR protocol is useless, as the device will
> not be selected. Besides that, the tool that do both is really simple (and, btw,
> it also allows changing the map for a non-RC device, by using one parameter that
> skips the usage of the sysfs nodes at /sys/class/rc):
> 
> # ir-keytable -d /dev/input/event4 -r
> scancode 0x0000 = KEY_LEFTCTRL (0x1d)
> Enabled protocols: 

OTOH loading keymap and selecting protocol are 2 distinct actions and
udev already has a tool to load keymaps that should also work for all
devices, including remotes.

Basically I do not see the reason for having 2 tools doing pretty much
the same thing.

-- 
Dmitry

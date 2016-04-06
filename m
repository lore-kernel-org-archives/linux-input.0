From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [Linux-v4.6-rc2] atkbd serio0: Unknown key pressed (translated
 set 2, code 0xa8 on isa0060/serio0).
Date: Wed, 6 Apr 2016 12:33:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1604061233270.27368@cbobk.fhfr.pm>
References: <CA+icZUV0MGYme3EvLwYaW7HaAdKq7KQm6jgbcy58z4Vk3+n7qg@mail.gmail.com> <CA+icZUVZ05ri=Vs6UGWN0ks74_R2Q48u0=xoh2LSFwSLhpfabg@mail.gmail.com> <CA+icZUW0MFrV5gcVy=R6Jh+Fr7=5cr-ns0_ZXUjuY=LuiduLYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38110 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754738AbcDFKdv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Apr 2016 06:33:51 -0400
In-Reply-To: <CA+icZUW0MFrV5gcVy=R6Jh+Fr7=5cr-ns0_ZXUjuY=LuiduLYw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-usb@vger.kernel.org

On Wed, 6 Apr 2016, Sedat Dilek wrote:

> >> I cannot use cursor up and down on my notebook and see this in my dmesg.
> >>
> >> [  685.425634] atkbd serio0: Unknown key pressed (translated set 2,
> >> code 0xa8 on isa0060/serio0).
> >> [  685.425648] atkbd serio0: Use 'setkeycodes e028 <keycode>' to make it known.
> >>
> >> Known issue?
> >>
> >> Do you need more input?
> >>
> >> Linux-config and dmesg-output attached.
> >>
> >> Regards,
> >> - Sedat Dilek -
> >
> > Attached is output of...
> >
> >    $ xmodmap -pke > /tmp/xmodmap-pke.txt
> >
> 
> [ CC (USB)HID folks ]
> 
> I forgot to tell that I have some patches on top of vanilla Linux v4.6-rc2.
> 
> Dropping the patches from <jikos/hid.git#for-4.6/upstream-fixes> makes
> the issue go away.

Thanks for the useful report!

> Unsure what is the cause. On the way, try to look this evening or 
> tommorrow into this.

I don't seem to see the beginning of this thread anywhere.

What hardware is this?

-- 
Jiri Kosina
SUSE Labs


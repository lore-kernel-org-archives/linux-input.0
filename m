From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: conflict of wiimote and hid-sony
Date: Tue, 19 Nov 2013 11:30:50 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1311191130370.6657@pobox.suse.cz>
References: <CADwLDZsUsHduucFXrb218wemsGaWM76BCqQUY_OobuSf0UEP1Q@mail.gmail.com> <CANq1E4TVhxDk7JvNOMQG2Qddktdp2zzRayeAhQ0Zc=vghyGw7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48943 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab3KSKaz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Nov 2013 05:30:55 -0500
In-Reply-To: <CANq1E4TVhxDk7JvNOMQG2Qddktdp2zzRayeAhQ0Zc=vghyGw7g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Michel Kraus <mksolpa@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Sun, 17 Nov 2013, David Herrmann wrote:

> > commit 86b84167 HID: wiimote: add LEGO-wiimote VID
> >
> > introduced a VID/PID conflict with its original owner: hid-wiimote got
> > hid:b0005g*v0000054Cp00000306 added but hid-sony already has this id for
> > the PS3 Remote.
> >
> > I think the original and legitimate owner should remain the default for this
> > VID/PID combination.
> 
> Thanks for the report! It's indeed officially allocated as USB ID to Sony.
> 
> @Jiri, can you revert the following commit (note: it was already
> backported to stable):
> 
> commit 86b84167d4e67372376a57ea9955c5d53dae232f
> Author: David Herrmann <dh.herrmann@gmail.com>
> Date:   Fri Oct 18 16:26:22 2013 +0200
> 
>     HID: wiimote: add LEGO-wiimote VID
> 
> I will write a bluez-patch to force the official wiimote-id on the
> device, based on a name-comparison. This should allow us to support
> both devices.

Thanks a lot for the report. I have queued the revert for 3.13.

-- 
Jiri Kosina
SUSE Labs

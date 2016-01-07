From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Subject: Re: [Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech
 G920 Wheel
Date: Thu, 07 Jan 2016 23:50:16 +0100
Message-ID: <1452207016.7572.7.camel@devoid-pointer.net>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org>
	 <1447345535-2912-2-git-send-email-simon@mungewell.org>
	 <alpine.LNX.2.00.1511191449130.20111@pobox.suse.cz>
	 <20151119183106.GC24773@dtor-ws>
	 <CAKdAkRTaTA8KFQripYP0ZcFb+5G7OC_Ecnhrwum4L9hsQ-PVxg@mail.gmail.com>
	 <CAKdAkRRBtVfTss9AV+DgTtCXf8PVks5pCB4VnR5sQvgW=S3HyA@mail.gmail.com>
	 <20151210170853.GC16026@mail.corp.redhat.com>
	 <CAKdAkRSBTBTW8ma79hh+0sr4izJ70SnvUb1gmPFy3MoVWYaUbA@mail.gmail.com>
	 <20160104095524.GB20222@mail.corp.redhat.com>
	 <alpine.LNX.2.00.1601061535440.3402@cbobk.fhfr.pm>
	 <20160107014721.GA35823@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160107014721.GA35823@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Edwin <Edwin@velds.nl>, elias vanderstuyft <elias.vds@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wed, 2016-01-06 at 17:47 -0800, Dmitry Torokhov wrote:
> On Wed, Jan 06, 2016 at 03:36:57PM +0100, Jiri Kosina wrote:
> > On Mon, 4 Jan 2016, Benjamin Tissoires wrote:
> > 
> > > Jiri, I *think* this commit still is in your next pull request
> > > for
> > > Linus. We might want to drop it before it hits Linus' tree.
> > 
> > What exactly would be the reasoning for dropping it?
> 
> It is wrong. Aside form the fact that IMO xpad.c is the wrong place
> for
> this code to be in, why are we waiting for the input device to be
> opened by userspace before we do the switch instead of doing it
> immediately?
> 

Hi all,

I have to disagree with the xpad driver being the wrong place to handle
this. The xpad driver matches devices it should handle by interface
class, subclass and protocol. When G920 first appears on the USB bus,
it for all intents and purposes looks like a Xbox One controller so the
xpad driver picks it up even if there is no G920-specific code in the
driver. Unless there is a way how to blacklist certain idProduct
values, the switch from XBone mode to HID mode will have to be done in
the xpad driver.

I'm pretty much done with the simple switching module but it will be of
no use if we cannot make the xpad module ignore G920 first.

Michal

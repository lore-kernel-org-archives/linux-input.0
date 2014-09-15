From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Mon, 15 Sep 2014 15:58:09 -0700
Message-ID: <20140915225809.GA31798@core.coreip.homeip.net>
References: <1410750811-11156-1-git-send-email-michaelwr@google.com>
 <CANq1E4RY8cF1de4_rdS3Whjrf0bboYMtii4_nYNM2mEJuAKMfQ@mail.gmail.com>
 <CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>
 <20140915215728.GB13468@core.coreip.homeip.net>
 <CANq1E4TK1=mD0Xh5KuydoONqiex79HggvoM9XRhorogmxqBqhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56575 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220AbaIOW6P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Sep 2014 18:58:15 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so7482834pad.14
        for <linux-input@vger.kernel.org>; Mon, 15 Sep 2014 15:58:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANq1E4TK1=mD0Xh5KuydoONqiex79HggvoM9XRhorogmxqBqhw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Michael Wright <michaelwr@android.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Jiri Kosina <jkosina@suse.cz>

Hi David,

On Tue, Sep 16, 2014 at 12:15:08AM +0200, David Herrmann wrote:
> Hi
> 
> On Mon, Sep 15, 2014 at 11:57 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Mon, Sep 15, 2014 at 11:03:47AM -0700, Michael Wright wrote:
> >> > Why not introduce all 8 player LEDs as described in the document? You
> >> > should be safe increasing LED_MAX to 0x1f.
> >>
> >> Wasn't sure if it was safe to bump it since it could potentially break apps
> >> until they recompile against the new API.
> >
> > I'd rather we did not add any new input LED definitions but rather
> > looked into switching to LED subsystem, at least for new LEDs.
> 
> Why?

Because we have a proper subsystem that represents LEDs.

> The LED subsystem lacks any unprivileged API to control LEDs.

As far as I can see it is the same as for input devices. You just need
to make sure the device owner can access needed attributes, such as
brightness.

> There's no cdev to control write-access to the LED API. /sys has never
> been intended as unprivileged API

chmod/chown works just fine on sysfs attributes.

> so I'd really prefer if we add
> proper input codes to control those. At least I cannot see the
> advantage of the led subsystem over input EV_LED codes. Care to
> elaborate?
> 

LEDs should be controlled via LED subsystem. The fact that they happen
to be located on a given device does not mean they belong to input
subsystem. The same as LEds on network card are not part of network stack,
etc.

Thanks.

-- 
Dmitry

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/8] PS
Date: Fri, 10 Mar 2017 09:52:06 -0800
Message-ID: <20170310175206.GA21811@dtor-ws>
References: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
 <20170310155735.GA706@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36034 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdCJRwK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 12:52:10 -0500
Content-Disposition: inline
In-Reply-To: <20170310155735.GA706@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Mar 10, 2017 at 04:57:35PM +0100, Benjamin Tissoires wrote:
> Hi Dmitry,
> 
> On Mar 09 2017 or thereabouts, Dmitry Torokhov wrote:
> > Hi,
> > 
> > This is refresh of Benjamin's patches trying to bridge PS/2 and SMbus
> > devices for better support of Synaptics RMI4 touchpads (and Elans later).
> 
> Thanks!
> 
> I have some issues/comments and am still working on those. Here are some
> general comments:
> 
> > 
> > The main difference is that we do not have platform device, as it only
> > adds another indirection level, and have psmouse create SMBus companion
> 
> The purpose of having the platform device was to not have dependency
> between psmouse and I2C. Right now I think that patch 6/8 will fail to
> compile if I2C=m and PSMOUSE=y (I may be wrong).

This is taken care by the following guards in users if MOUSE_PS2_SMBUS:

depends on I2C=y || I2C=MOUSE_PS2

I am perfectly fine to tie psmouse to I2C *core*, we do not need to have
adapters loaded for it to work (hopefully).

> 
> > directly. Because serio ports complete registration asynchronously, we do
> > not deadlock on psmouse_mutex when even if we have a pass-through port.
> > (Frankly we need to revisit this whole serio and psmouse thing, use of
> > global serio_mutex and psmouse_mutex is hurting us; they were needed when
> > driver core could not recursively iterate over device and driver lists).
> 
> Agree, this is a giant PITA.
> 
> > 
> > We also do not allow overriding serio driver, instead we teach psmouse
> > about "special" devices and let it continue own the serio port and make
> > sure nobody else touches it.
> > 
> > To work around issue with psmouse_reconnect() running sometimes too late,
> > we add "fast reconnect" option to serio. Not too pretty, but gets the job
> > done. We may need to revisit whole serio PM story later and stop "cheating"
> > and pretending that device is resumed when it is not, but for that we need
> > to teach PM core about devices that are OK not to wait for before resuming
> > userspace. Anyway, much bigger topic for later.
> 
> I thought there was already the ability to say that a driver needs to be
> run in a different thread for PM functions (IIRC i2c-hid uses
> device_enable_async_suspend(&client->dev); and this "should" do the
> trick).

The issue is that currently asynchronous resume still has to complete
before we start resuming userspace, as PS/2 is way too slow. So the
current solution marks device as resumed right away, and mouse may
become responsive 2 seconds later, but that is good as we do not idly
sit and wait but have userspace start turning on the screen and do other
useful stuff. Maybe user can already start typing their password into
screen locker.

We would need to give a way to drivers to indicate to PM core just how
asynchronous our resume can be.

> 
> > 
> > This seems to be working on X1 Carbon and also not breaking my HP 1040 with
> > forcepad (unfortunately it seems to be using some other SMBus controller
> > for connecting Synaptics, as I see nothing at 0x2c when loading i2c-i801).
> 
> Well, on my T450, the SMBus connection is dead too. I can't seem to talk
> to the device at all. This happens when the firmware believes it needs
> to stay on PS/2 and gets completely deaf to I2C. I solved this by
> calling psmouse_deactivate(), but this time, it looks like some other
> function needs to be called.
> 
> I'll keep investigating and report back.

I've heard a rumors that HP 1020 uses a Microtech SMbus controller for
its touchpad, it could be that 1040 is similar.

When your SMBus connection is dead do you see anything on the bus? At
that address? Or it is completely unresponsive?

Thanks.

-- 
Dmitry

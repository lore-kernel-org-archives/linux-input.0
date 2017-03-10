From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/8] PS
Date: Fri, 10 Mar 2017 16:57:35 +0100
Message-ID: <20170310155735.GA706@mail.corp.redhat.com>
References: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754128AbdCJP5k (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 10:57:40 -0500
Content-Disposition: inline
In-Reply-To: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Dmitry,

On Mar 09 2017 or thereabouts, Dmitry Torokhov wrote:
> Hi,
> 
> This is refresh of Benjamin's patches trying to bridge PS/2 and SMbus
> devices for better support of Synaptics RMI4 touchpads (and Elans later).

Thanks!

I have some issues/comments and am still working on those. Here are some
general comments:

> 
> The main difference is that we do not have platform device, as it only
> adds another indirection level, and have psmouse create SMBus companion

The purpose of having the platform device was to not have dependency
between psmouse and I2C. Right now I think that patch 6/8 will fail to
compile if I2C=m and PSMOUSE=y (I may be wrong).

> directly. Because serio ports complete registration asynchronously, we do
> not deadlock on psmouse_mutex when even if we have a pass-through port.
> (Frankly we need to revisit this whole serio and psmouse thing, use of
> global serio_mutex and psmouse_mutex is hurting us; they were needed when
> driver core could not recursively iterate over device and driver lists).

Agree, this is a giant PITA.

> 
> We also do not allow overriding serio driver, instead we teach psmouse
> about "special" devices and let it continue own the serio port and make
> sure nobody else touches it.
> 
> To work around issue with psmouse_reconnect() running sometimes too late,
> we add "fast reconnect" option to serio. Not too pretty, but gets the job
> done. We may need to revisit whole serio PM story later and stop "cheating"
> and pretending that device is resumed when it is not, but for that we need
> to teach PM core about devices that are OK not to wait for before resuming
> userspace. Anyway, much bigger topic for later.

I thought there was already the ability to say that a driver needs to be
run in a different thread for PM functions (IIRC i2c-hid uses
device_enable_async_suspend(&client->dev); and this "should" do the
trick).

> 
> This seems to be working on X1 Carbon and also not breaking my HP 1040 with
> forcepad (unfortunately it seems to be using some other SMBus controller
> for connecting Synaptics, as I see nothing at 0x2c when loading i2c-i801).

Well, on my T450, the SMBus connection is dead too. I can't seem to talk
to the device at all. This happens when the firmware believes it needs
to stay on PS/2 and gets completely deaf to I2C. I solved this by
calling psmouse_deactivate(), but this time, it looks like some other
function needs to be called.

I'll keep investigating and report back.

Cheers,
Benjamin

> 
> Thanks,
> Dmitry
> 
> Benjamin Tissoires (2):
>   Input: psmouse - add support for SMBus companions
>   Input: synaptics - add support for Intertouch devices
> 
> Dmitry Torokhov (6):
>   i2c: export i2c_client_type structure
>   Input: serio - add fast reconnect option
>   Input: psmouse - implement fast reconnect option
>   Input: psmouse - store pointer to current protocol
>   Input: psmouse - introduce notion of SMBus companions
>   Input: synaptics - split device info into a separate structure
> 
>  drivers/i2c/i2c-core.c              |   4 +-
>  drivers/input/mouse/Kconfig         |  16 +
>  drivers/input/mouse/Makefile        |   2 +
>  drivers/input/mouse/psmouse-base.c  | 213 ++++++---
>  drivers/input/mouse/psmouse-smbus.c | 280 ++++++++++++
>  drivers/input/mouse/psmouse.h       | 106 +++--
>  drivers/input/mouse/synaptics.c     | 832 +++++++++++++++++++++++-------------
>  drivers/input/mouse/synaptics.h     |  33 +-
>  drivers/input/serio/serio.c         |  22 +-
>  include/linux/i2c.h                 |   1 +
>  include/linux/serio.h               |   1 +
>  11 files changed, 1100 insertions(+), 410 deletions(-)
>  create mode 100644 drivers/input/mouse/psmouse-smbus.c
> 

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 0/9] PS/2 and SMBus companions
Date: Tue, 21 Mar 2017 16:17:33 +0100
Message-ID: <20170321151733.GB26316@mail.corp.redhat.com>
References: <20170320002231.31152-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757386AbdCUPRj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 11:17:39 -0400
Content-Disposition: inline
In-Reply-To: <20170320002231.31152-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mar 19 2017 or thereabouts, Dmitry Torokhov wrote:
> Hi,
> 
> This is refresh of Benjamin's patches trying to bridge PS/2 and SMbus
> devices for better support of Synaptics RMI4 touchpads (and Elans later).
> 
> The main difference is that we do not have platform device, as it only
> adds another indirection level, and have psmouse create SMBus companion
> directly. Because serio ports complete registration asynchronously, we do
> not deadlock on psmouse_mutex when even if we have a pass-through port.
> (Frankly we need to revisit this whole serio and psmouse thing, use of
> global serio_mutex and psmouse_mutex is hurting us; they were needed when
> driver core could not recursively iterate over device and driver lists).
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
> 
> This seems to be working on X1 Carbon and HP 1040 with forcepad, but
> to fully support forcepad we need implementation of RMI F21, so patch #9
> is more of FYI.
> 
> Please do shout if you see something wrong, otherwise I'll queue it for
> next in the next couple of days (sans forcetouch patch).
> 

I just gave it a quick test, and it still behave properly on the T450s
as well. So I vote yes for including it ;)

Cheers,
Benjamin

> Thanks,
> Dmitry
> 
> v3: stop trying to detect presence of SMbus companion device when new
> adapter is discovered, as it does not really work. Instead issue serio
> rescan request and let probe code deal with it (which seems to be more
> reliable).
> Fix various compile glitches with different config options.
> Added Benjamin's reviewed-bys.
> 
> V2: incorporated Benjamin's change to keep platform data around until
> companion device is destroyed, enabled forcepad support.
> 
> Benjamin Tissoires (2):
>   Input: psmouse - add support for SMBus companions
>   Input: synaptics - add support for Intertouch devices
> 
> Dmitry Torokhov (7):
>   i2c: export i2c_client_type structure
>   Input: serio - add fast reconnect option
>   Input: psmouse - implement fast reconnect option
>   Input: psmouse - store pointer to current protocol
>   Input: psmouse - introduce notion of SMBus companions
>   Input: synaptics - split device info into a separate structure
>   [NEEDS F21] Input: synaptics - switch forcepad devices over to SMbus
>     access
> 
>  drivers/i2c/i2c-core.c              |   4 +-
>  drivers/input/mouse/Kconfig         |  16 +
>  drivers/input/mouse/Makefile        |   2 +
>  drivers/input/mouse/psmouse-base.c  | 213 ++++++---
>  drivers/input/mouse/psmouse-smbus.c | 294 +++++++++++++
>  drivers/input/mouse/psmouse.h       | 102 +++--
>  drivers/input/mouse/synaptics.c     | 841 +++++++++++++++++++++++-------------
>  drivers/input/mouse/synaptics.h     |  33 +-
>  drivers/input/serio/serio.c         |  22 +-
>  include/linux/i2c.h                 |   1 +
>  include/linux/serio.h               |   1 +
>  11 files changed, 1122 insertions(+), 407 deletions(-)
>  create mode 100644 drivers/input/mouse/psmouse-smbus.c
> 
> -- 
> 2.12.0.367.g23dc2f6d3c-goog
> 

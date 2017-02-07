From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 03/10] Input: synaptics-rmi4 - f30/f03: Forward mechanical buttons on buttonpads to PS/2 guest
Date: Tue,  7 Feb 2017 17:25:37 +0100
Message-ID: <20170207162539.5577-1-benjamin.tissoires@redhat.com>
References: <20170206192327.GA17441@dtor-ws>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754020AbdBGQZs (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Feb 2017 11:25:48 -0500
In-Reply-To: <20170206192327.GA17441@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Andrew Duggan <aduggan@synaptics.com>
Cc: Adrian Alves <aalves@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Dmitry,

On Feb 06 2017 or thereabouts, Dmitry Torokhov wrote:
> Hi Benjamin,
> 
> On Tue, Jan 10, 2017 at 05:11:21PM +0100, Benjamin Tissoires wrote:
> > +void rmi_f03_commit_buttons(struct rmi_function *fn)
> > +{
> > +   struct f03_data *f03 = dev_get_drvdata(&fn->dev);
> > +   int i;
> > +
> > +   f03->serio->extra_byte = f03->overwrite_buttons;
> > +
> > +   for (i = 0; i < 3; i++)
> > +           serio_interrupt(f03->serio, 0x00, 0x00);
> 
> How does this work with protocols larger than 3 bytes (i.e. anything but
> bare PS/2)? Or F03 limits the kind of devices we connect to RMI4 device?

Right, there is no such constraint.

> 
> Overall, I am very uncomfortable with the concept of "extra byte" at
> serio level. Maybe we should define a new flag, something like
> SERIO_SYNTHETIC or SERIO_OOB_DATA, and have something like:
> 
> void rmi_f03_commit_buttons(struct rmi_function *fn)
> {
>       struct serio *serio = f03->serio;
> 
>       serio_pause_rx(serio);
>       if (serio->drv) {
>               serio->drv->interrupt(serio, PSMOUSE_EXTRA_BTNS,
>                                     SERIO_OOB_DATA);
>               serio->drv->interrupt(serio, f03->overwrite_buttons.
>                                     SERIO_OOB_DATA);
>       }
>       serio_pause_rx(serio);
> }
> 
> and have psmouse driver store and use it as it sees fit.

Sounds good to me. Would the 2 following patches be OK?

Cheers,
Benjamin


Benjamin Tissoires (2):
  Input: psmouse - add a custom serio protocol to send extra information
  Input: synaptics-rmi4 - f30/f03: Forward mechanical buttons on
    buttonpads to PS/2 guest

 drivers/input/mouse/psmouse-base.c | 39 +++++++++++++++++++--
 drivers/input/mouse/psmouse.h      |  5 +++
 drivers/input/rmi4/rmi_driver.h    | 14 ++++++++
 drivers/input/rmi4/rmi_f03.c       | 39 +++++++++++++++++++++
 drivers/input/rmi4/rmi_f30.c       | 72 ++++++++++++++++++++++++++++++--------
 include/uapi/linux/serio.h         |  7 ++--
 6 files changed, 155 insertions(+), 21 deletions(-)

-- 
2.9.3


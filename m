From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] Input: elan_i2c - always output the device information
Date: Thu, 13 Oct 2016 14:16:05 +0200
Message-ID: <20161013121605.GL15950@mail.corp.redhat.com>
References: <1476357810-11324-1-git-send-email-benjamin.tissoires@redhat.com>
 <CAAZ5spB5Y_6=xKTz7hbgGjS=yYEr0hA3KoY19WCy1fJ6BbY-VQ@mail.gmail.com>
 <CAAZ5spAq7_yEZe9eYnSPenzLWw4sZgkmJZRmXkoe72mJKeKRWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754066AbcJMMQK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Oct 2016 08:16:10 -0400
Content-Disposition: inline
In-Reply-To: <CAAZ5spAq7_yEZe9eYnSPenzLWw4sZgkmJZRmXkoe72mJKeKRWg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michel Hermier <michel.hermier@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>

On Oct 13 2016 or thereabouts, Michel Hermier wrote:
> Le 13 oct. 2016 13:49, "Benjamin Tissoires" <benjamin.tissoires@redhat.com>
> a écrit :
> >
> > it's always easier to retrieve these information in bug reports when
> > it is always printed in the dmesg.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > ---
> >
> > changes in v2:
> > - split the version information message and the touchpad characteristics
> > - keep sending the versions as info (on one line)
> > - send the characteristics on debug only
> >
> > Hi Dmitry,
> >
> > This is a respin of one of the patches I sent for elan_i2c. Given that you
> > applied the fixed one for SMBus and that I don't currently have a way to
> > check from I2C if the trackstick is going to be used, this one is the only
> > one left (also given SMBus Host Notify might meld into client->irq).
> >
> > So, well, yes, there it comes, a single patch which IMO is useful
> > when we receive bug reports.
> >
> > Cheers,
> > Benjamin
> >
> > ---
> >  drivers/input/mouse/elan_i2c_core.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/input/mouse/elan_i2c_core.c
> b/drivers/input/mouse/elan_i2c_core.c
> > index d15b338..dc7c94d 100644
> > --- a/drivers/input/mouse/elan_i2c_core.c
> > +++ b/drivers/input/mouse/elan_i2c_core.c
> > @@ -1093,19 +1093,18 @@ static int elan_probe(struct i2c_client *client,
> >         if (error)
> >                 return error;
> >
> > +       dev_info(&client->dev,
> > +               "Elan Touchpad: Module ID: 0x%04x, Firmware: 0x%04x,
> Sample: 0x%04x, IAP: 0x%04x\n",
> > +               data->product_id,
> > +               data->fw_version,
> > +               data->sm_version,
> > +               data->iap_version);
> > +
> >         dev_dbg(&client->dev,
> > -               "Elan Touchpad Information:\n"
> > -               "    Module product ID:  0x%04x\n"
> > -               "    Firmware Version:  0x%04x\n"
> > -               "    Sample Version:  0x%04x\n"
> > -               "    IAP Version:  0x%04x\n"
> > +               "Elan Touchpad Extra Information:\n"
> 
> Looks like there is an indent issue here.

I can't seem to see it. Could you explain a little bit more?

Cheers,
Benjamin

> 
> >                 "    Max ABS X,Y:   %d,%d\n"
> >                 "    Width X,Y:   %d,%d\n"
> >                 "    Resolution X,Y:   %d,%d (dots/mm)\n",
> > -               data->product_id,
> > -               data->fw_version,
> > -               data->sm_version,
> > -               data->iap_version,
> >                 data->max_x, data->max_y,
> >                 data->width_x, data->width_y,
> >                 data->x_res, data->y_res);
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: joydev - ignore accelerometer devices
Date: Mon, 19 Jun 2017 19:57:10 -0700
Message-ID: <20170620025710.GF21379@dtor-ws>
References: <20170609203547.17691-1-roderick@gaikai.com>
 <20170609203547.17691-2-roderick@gaikai.com>
 <20170612070953.GA29589@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34539 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdFTC5N (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 22:57:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id d5so20450780pfe.1
        for <linux-input@vger.kernel.org>; Mon, 19 Jun 2017 19:57:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170612070953.GA29589@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Roderick Colenbrander <roderick@gaikai.com>, linux-input@vger.kernel.org, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Mon, Jun 12, 2017 at 09:09:53AM +0200, Benjamin Tissoires wrote:
> On Jun 09 2017 or thereabouts, Roderick Colenbrander wrote:
> > From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> > 
> > Gamepads like DualShock 3 / 4 as of 4.12 started reporting motion
> > sensors on a separate evdev node. Joydev is picking these devices
> > up as well, but they don't make sense for the joydev interface.
> > 
> > Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> > ---
> 
> Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hmm, I think you can quite often use accelerometer as a joystick, it is
only the composite devices that we want to ignore I think.

> 
> Cheers,
> Benjamin
> 
> >  drivers/input/joydev.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> > index 29d677c..a5ceaaf 100644
> > --- a/drivers/input/joydev.c
> > +++ b/drivers/input/joydev.c
> > @@ -819,6 +819,10 @@ static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
> >  	if (joydev_dev_is_absolute_mouse(dev))
> >  		return false;
> >  
> > +	/* Avoid accelerometers */
> > +	if (test_bit(INPUT_PROP_ACCELEROMETER, dev->propbit))
> > +		return false;
> > +
> >  	return true;
> >  }
> >  
> > -- 
> > 2.9.3
> > 

-- 
Dmitry

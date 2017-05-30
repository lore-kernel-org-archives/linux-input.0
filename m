From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: synaptics - warn the users when there is a
 better mode
Date: Mon, 29 May 2017 20:17:55 -0700
Message-ID: <20170530031755.GF32841@dtor-ws>
References: <20170523083657.11148-1-benjamin.tissoires@redhat.com>
 <20170523083657.11148-2-benjamin.tissoires@redhat.com>
 <20170523212051.GC34299@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36694 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdE3DR6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 May 2017 23:17:58 -0400
Content-Disposition: inline
In-Reply-To: <20170523212051.GC34299@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 23, 2017 at 02:20:51PM -0700, Dmitry Torokhov wrote:
> On Tue, May 23, 2017 at 10:36:56AM +0200, Benjamin Tissoires wrote:
> > The Synaptics touchpads are now either using i2c-hid or rmi-smbus.
> > Warn the users if they are missing the rmi-smbus modules and have no
> > chance of reporting correct data.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >  drivers/input/mouse/synaptics.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> > index 58ff388..fc42259 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -1814,6 +1814,10 @@ int synaptics_init(struct psmouse *psmouse)
> >  	}
> >  
> >  	if (SYN_CAP_INTERTOUCH(info.ext_cap_0c)) {
> > +#if !IS_ENABLED(CONFIG_RMI4_SMB) || !defined(CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS)
> > +		psmouse_warn(psmouse, "The touchpad can support a better bus than the too old PS/2 protocol.\n"
> > +			"Make sure MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better touchpad experience.\n");
> > +#endif
> 
> I'll pull the checks into "if" to avoid preprocessor and also add checks
> for forcepad PNP IDs as forcepads are not usable with RMI at the moment
> since they need F21.

I made the changes I mentioned and pushed to my for-linus branch, please
take a peek and yell if I screwed up.

> 
> >  		error = synaptics_setup_intertouch(psmouse, &info, true);
> >  		if (!error)
> >  			return PSMOUSE_SYNAPTICS_SMBUS;
> > -- 
> > 2.9.4
> > 
> 
> Thanks.
> 
> -- 
> Dmitry

-- 
Dmitry

From: Wang Yafei <wangyafei@goodix.com>
Subject: Re: [PATCH v3] Input: Add driver for GOODiX GTx5 series touchsereen
Date: Fri, 23 Jun 2017 22:38:22 +0800
Message-ID: <20170623143821.GA7883@andrew-dell>
References: <20170620130021.GA29031@andrew-dell>
 <1498149148.2559.37.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Mailgw01.goodix.com ([58.250.26.195]:2234 "EHLO
        barracuda.goodix.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751999AbdFWOif (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 23 Jun 2017 10:38:35 -0400
Content-Disposition: inline
In-Reply-To: <1498149148.2559.37.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, andrew@goodix.com, mouse@goodix.com

On Thu, Jun 22, 2017 at 06:32:28PM +0200, Bastien Nocera wrote:

Hi Bastien,

  Thanks for your advises.

> Hey,
> 
> Very shallow review. There are tons of typos in the code and comments,
> including in the subject line for this patch ("touchsereen"), including
> "godix", "excuted", etc. Please run a spell-check over the whole patch,
> and have somebody review all the text.
> 
> On Tue, 2017-06-20 at 21:00 +0800, Wang Yafei wrote:
> > This driver is for GOODiX GTx5 series touchscreen controllers
> > such as GT8589, GT7589. This driver designed with hierarchial 
> 
> "hierarchical"
> 
> > structure,
> > for that can be modified to support subsequent controllers easily.
> > Some zones of the touchscreen can be set to buttons(according to the
> > hardware). That is why it handles button and multitouch events.
> > 
> > A brief description of driver structure
> > - Core Layer: This layer responsible for basic input events report,
> >   GPIO pinctrl, Interrupt, Power resources manager and submodules
> > manager.
> > - Hardware Layer: This layer responsible for controllers
> > initialization,
> >   irq handle as well as bus read/write.
> > - External Module Layer: This layer used for support more features
> >   such as firmware update, debug tools and gesture wakeup.
> 
> I think that the driver should be split up in multiple patches. The
> first one should handle the basics for the device (I'd say parity with
> the driver for the older models would be fine), then add the various
> features on top (firmware loading, gesture wakeup, etc.) as those
> features probably need more thought as to what the external APIs should
> be.

I have rechecked the code spell problems and in the [PATCH v4].
We have considered your suggestion carefully, and in the new patch
will only contains basic touch function. Other functions such as
fw_update, gesture update will be submitted separately, and device
preparatory description file patches is ready I will commit it soon.

> > Signed-off-by: Wang Yafei <wangyafei@goodix.com>
> > ---
> > Goodix driver that the kernel already have, is for our gt9xx series
> > touchscreen controllers. This new driver is for out new generation
> > touchscreen controllers, consider this two generations are very
> > different with each other. We wrote a new driver instead of make
> > a patch on the old driver.
> 
> You'll probably need a preparatory patch which makes changes to the
> description and KConfig for the old driver, spelling out exactly what
> the old driver supports, maybe renaming it.
> 
> You'll also need to decide whether the company is called GOODiX, GOODIX
> or Goodix, whether the new devices are "sunrise", "GTx5" or something
> else.
> 
> > Changes in v2:
> >  - replace touchscreen properties according to the description in
> >    Documentation/devicetree/bindings/input/touchscreen/touchscreen.tx
> > t
> >  - Droped all compat stuff for older kernels
> >  - Removed Android stuff (EARLY_SUSPEND, CONFIG_FB)
> 
> There's still an ifdef with "COMPAT" in the name, not sure compat with
> what.
> 
> >  - Use device_property_read_*  get device properties
> >  - use get-unaligned_*() API
> >  - Use dev_err() dev_dbg() for logging
> >  - remove pinctrl functions
> >  - remove some unused functions
> 
> Cheers

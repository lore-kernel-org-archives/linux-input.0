From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] HID: Add driver for ION iCade
Date: Wed, 31 Oct 2012 16:49:13 +0100
Message-ID: <1351698553.5172.1.camel@novo.hadess.net>
References: <1351681810.14430.1.camel@sirocco.hadess.net>
	 <alpine.LNX.2.00.1210311553300.12781@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43651 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757618Ab2JaPtQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 11:49:16 -0400
In-Reply-To: <alpine.LNX.2.00.1210311553300.12781@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com

On Wed, 2012-10-31 at 15:54 +0100, Jiri Kosina wrote:
> On Wed, 31 Oct 2012, Bastien Nocera wrote:
> 
> > 
> > Add a driver for the ION iCade mini arcade cabinet [1]. The device
> > generates a key press and release for each joystick movement or
> > button press or release. For example, moving the stick to the
> > left will generate the "A" key being pressed and the released.
> > 
> > A list of all the combinations is available in the iCade
> > developer guide [2].
> > 
> > This driver hides all this and makes the device work as a generic
> > joystick.
> > 
> > [1]: http://www.ionaudio.com/products/details/icade
> > [2]: http://www.ionaudio.com/downloads/iCade_Dev_Resource_v1.3.pdf
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  drivers/hid/Kconfig     |   9 ++
> >  drivers/hid/Makefile    |   1 +
> >  drivers/hid/hid-core.c  |   1 +
> >  drivers/hid/hid-icade.c | 259 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/hid/hid-ids.h   |   3 +
> >  5 files changed, 273 insertions(+)
> >  create mode 100644 drivers/hid/hid-icade.c
> > 
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 1630150..813f0fe 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -265,6 +265,15 @@ config HID_GYRATION
> >       ---help---
> >       Support for Gyration remote control.
> >  
> > +config HID_ICADE
> > +     tristate "ION iCade arcade controller"
> > +     depends on (BT_HIDP)
> 
> Why the spurious brackets here?
> 
> Otherwise the patch looks good, thanks (and thanks Benjamin for review), I 
> apply and remove the brackets.

Probably because whatever I copy/pasted it from had the brackets. Did
you make the typos changes in the commit message itself as well?

Cheers



From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v5 1/9] Input: goodix - sort includes alphabetically
Date: Mon, 5 Oct 2015 14:14:57 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0EE716@irsmsx105.ger.corp.intel.com>
References: <1441636583-14188-1-git-send-email-irina.tirdea@intel.com>
 <1441636583-14188-2-git-send-email-irina.tirdea@intel.com>
 <20151004194632.GA27633@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22937 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbbJEOPG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Oct 2015 10:15:06 -0400
In-Reply-To: <20151004194632.GA27633@xo-6d-61-c0.localdomain>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>



> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: 04 October, 2015 22:47
> To: Tirdea, Irina
> Cc: Dmitry Torokhov; Bastien Nocera; Aleksei Mamlin; linux-input@vger.kernel.org; Mark Rutland; Purdila, Octavian; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v5 1/9] Input: goodix - sort includes alphabetically
> 
> On Mon 2015-09-07 17:36:15, Irina Tirdea wrote:
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > ---
> >  drivers/input/touchscreen/goodix.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Don't.
> 
> Yes, we sometimes sort includes... to avoid patch rejects.
> 
> This is guaranteed to cause rejects.
> 
> If we do sort them, we use "longest-first" usually.
> 

When using random order, I've been told by reviewers that my ordering
is wrong [1], but I could not figure out what the "right" ordering is in order to apply.
I did not find any mention of how to sort includes in  Documentation/CodingStyle,
but I've seen patches in the kernel that fix random ordering by sorting them
alphabetically [2].

However, I do not feel strongly about this so I can drop this patch.

Thanks,
Irina

[1] https://lkml.org/lkml/2015/5/28/363
[2] https://patchwork.ozlabs.org/patch/408022/

> >
> > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> > index e36162b..6ae28c5 100644
> > --- a/drivers/input/touchscreen/goodix.c
> > +++ b/drivers/input/touchscreen/goodix.c
> > @@ -14,18 +14,18 @@
> >   * Software Foundation; version 2 of the License.
> >   */
> >
> > -#include <linux/kernel.h>
> > +#include <linux/acpi.h>
> > +#include <linux/delay.h>
> >  #include <linux/dmi.h>
> >  #include <linux/i2c.h>
> >  #include <linux/input.h>
> >  #include <linux/input/mt.h>
> > -#include <linux/module.h>
> > -#include <linux/delay.h>
> > -#include <linux/irq.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/slab.h>
> > -#include <linux/acpi.h>
> > +#include <linux/irq.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/slab.h>
> >  #include <asm/unaligned.h>
> >
> >  struct goodix_ts_data {
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

From: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 6/7] input: cyapa: add of match device support and
 description document
Date: Mon, 15 Jun 2015 02:31:28 +0000
Message-ID: <CY1PR06MB181753C20435AA655AD17C1BD1B80@CY1PR06MB1817.namprd06.prod.outlook.com>
References: <1434092198-13018-1-git-send-email-dudl@cypress.com>
 <1434092198-13018-7-git-send-email-dudl@cypress.com>
 <20150613035358.GA18645@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150613035358.GA18645-ZO/ZziT/ZXRSq9BJjBFyUp/QNRX+jHPU@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeremiah Mahler <jmmahler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org" <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org>, "bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Jeremiah,

Thanks for the review.

I made the patch based on dtor-next's code based.
I will make the next v1 patches based on the linux-next to avoid this problem.

Thanks,
Dudley

> -----Original Message-----
> From: Jeremiah Mahler [mailto:jmmahler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: 2015?6?13? 11:54
> To: Dudley Du
> Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org; bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH 6/7] input: cyapa: add of match device support and description
> document
>
> Dudley,
>
> On Fri, Jun 12, 2015 at 02:56:37PM +0800, Dudley Du wrote:
> > Add of_match_device machanism support for Cypress trackpad device, and
> > add the sample description document of adding the trackpad device node in DT.
> > TEST=test on Chromebook.
> >
> > Signed-off-by: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
> > ---
> >  .../devicetree/bindings/input/cypress,cyapa.txt    | 44
> ++++++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
> >  drivers/input/mouse/cyapa.c                        | 10 +++++
> >  3 files changed, 55 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/input/cypress,cyapa.txt
> >
> [...]
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 728cd0e..4813437 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -48,6 +48,7 @@ cnxtConexant Systems, Inc.
> >  cortinaCortina Systems, Inc.
> >  cosmicCosmic Circuits
> >  crystalfontzCrystalfontz America, Inc.
> > +cypressCypress Semiconductor Corporation
> >  dallasMaxim Integrated Products (formerly Dallas Semiconductor)
> >  davicomDAVICOM Semiconductor, Inc.
> >  denxDenx Software Engineering
> > diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> > index 86f2263..7e7613f 100644
> > --- a/drivers/input/mouse/cyapa.c
> > +++ b/drivers/input/mouse/cyapa.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/uaccess.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/acpi.h>
> > +#include <linux/of.h>
> >  #include "cyapa.h"
> >
> >
> > @@ -1562,12 +1563,21 @@ static const struct acpi_device_id cyapa_acpi_id[] =
> {
> >  MODULE_DEVICE_TABLE(acpi, cyapa_acpi_id);
> >  #endif
> >
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id cyapa_of_match[] = {
> > +{ .compatible = "cypress,cyapa" },
> > +{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, cyapa_of_match);
> > +#endif
> > +
> >  static struct i2c_driver cyapa_driver = {
> >  .driver = {
> >  .name = "cyapa",
> >  .owner = THIS_MODULE,
> >  .pm = &cyapa_pm_ops,
> >  .acpi_match_table = ACPI_PTR(cyapa_acpi_id),
> > +.of_match_table = of_match_ptr(cyapa_of_match),
> >  },
> >
> >  .probe = cyapa_probe,
> > --
> > 1.9.1
>
> This patch fails to apply on linux-next 20150611 because of difference
> in vendor-prefixes.txt.  Probably just needs to be updated.
>
>   Applying: input: cyapa: add of match device support and description
>   document
>   error: patch failed:
>   Documentation/devicetree/bindings/vendor-prefixes.txt:48
>   error: Documentation/devicetree/bindings/vendor-prefixes.txt: patch does
>   not apply
>   Patch failed at 0001 input: cyapa: add of match device support and
>   description document
>
> --
> - Jeremiah Mahler

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

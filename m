From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] alter_ps2: Add devicetree support
Date: Mon, 17 Jan 2011 15:04:15 -0700
Message-ID: <20110117220415.GB17963@angua.secretlab.ca>
References: <4D040D1C.2020705@home.nl>
	<1295245760-4566-1-git-send-email-thomas@wytron.com.tw>
	<20110117213100.GC27245@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110117213100.GC27245-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 17, 2011 at 01:31:01PM -0800, Dmitry Torokhov wrote:
> On Mon, Jan 17, 2011 at 02:29:20PM +0800, Thomas Chou wrote:
> > From: Walter Goossens <waltergoossens-CmkmPbn3yAE@public.gmane.org>
> > 
> 
> For my education, why is this needed?
> 
> > Signed-off-by: Walter Goossens <waltergoossens-CmkmPbn3yAE@public.gmane.org>
> > Signed-off-by: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
> > ---
> >  drivers/input/serio/altera_ps2.c |   16 ++++++++++++++++
> >  1 files changed, 16 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
> > index 7998560..93054a1 100644
> > --- a/drivers/input/serio/altera_ps2.c
> > +++ b/drivers/input/serio/altera_ps2.c
> > @@ -19,6 +19,9 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/io.h>
> >  #include <linux/slab.h>
> > +#ifdef CONFIG_OF
> > +#include <linux/of.h>
> > +#endif
> 
> Does it have to be guarded?

Shouldn't need to be.

> 
> >  
> >  #define DRV_NAME "altera_ps2"
> >  
> > @@ -173,6 +176,16 @@ static int __devexit altera_ps2_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_OF
> > +static struct of_device_id altera_ps2_match[] = {
> 
> Not const?
> 
> > +	{ 
> > +		.compatible = "altera,altera_ps2",
> > +	},
> > +	{},
> > +}
> > +MODULE_DEVICE_TABLE(of, altera_jtaguart_match);
> > +#endif /* CONFIG_OF */
> > +
> >  /*
> >   * Our device driver structure
> >   */
> > @@ -182,6 +195,9 @@ static struct platform_driver altera_ps2_driver = {
> >  	.driver	= {
> >  		.name	= DRV_NAME,
> >  		.owner	= THIS_MODULE,
> > +#ifdef CONFIG_OF
> > +		.of_match_table = altera_ps2_match,
> > +#endif
> 
> Can't we spare 4 bytes per driver and have .of_match_table always
> present?

Yeah, probably.  I've been trying to avoid it, but I suppose that is
much ado about a tiny amount of data.  I'll craft a patch.

g.

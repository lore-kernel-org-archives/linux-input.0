From: "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v9 2/9] Input: goodix - reset device at init
Date: Wed, 14 Oct 2015 16:44:03 +0300
Message-ID: <20151014134403.GA25691@lahna.fi.intel.com>
References: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
 <1444663477-30062-3-git-send-email-irina.tirdea@intel.com>
 <20151012164819.GA4010@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE432@irsmsx105.ger.corp.intel.com>
 <20151013070824.GA22304@dtor-ws>
 <1F3AC3675D538145B1661F571FE1805F2F0FE683@irsmsx105.ger.corp.intel.com>
 <20151013100724.GG1492@lahna.fi.intel.com>
 <20151014062303.GC20406@dtor-ws>
 <20151014111820.GV1492@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151014111820.GV1492-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 14, 2015 at 02:18:20PM +0300, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org wrote:
> On Tue, Oct 13, 2015 at 11:23:03PM -0700, Dmitry Torokhov wrote:
> > I understand why one might use acpi_dev_add_driver_gpios() to augment
> > data in ACPI, however here we have completely different issue: driver
> > that expects named gpios gets returned gpio that has nothing to do with
> > what it requested, because gpiolib acpi code always falls back to
> > unnamed gpio if it does not find named gpio. That can be acceptable if
> > driver uses the same con_id for all requests to gpiolib, but is not
> > working when driver supplies different con_ids.
> 
> Right, the ACPI fallback ignores con_id completely and uses only the
> index.
> 
> AFAIK there is only one driver using ACPI _CRS index method:
> sdhci-[acpi|pci].c. If we can convert that to use acpi_dev_add_driver_gpios()
> to feed names for card detection GPIOs, I think we can remove the
> fallback alltogether in favor of named GPIOs for ACPI.

Nah, there seems to be several drivers relying on this already :-/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/2] Input: gpio-keys: do not reference platform_data
	after .probe exits
Date: Tue, 19 Jul 2011 08:48:41 +0100
Message-ID: <20110719074841.GB26574@n2100.arm.linux.org.uk>
References: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
	<1311007508-8096-2-git-send-email-shawn.guo@linaro.org>
	<201107181002.45170.dmitry.torokhov@gmail.com>
	<20110719011725.GB3838@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110719011725.GB3838-+NayF8gZjK2ctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Phil Blundell <pb-CN5wO63fgwogsBAKwltoeQ@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 19, 2011 at 09:17:26AM +0800, Shawn Guo wrote:
> On Mon, Jul 18, 2011 at 10:02:44AM -0700, Dmitry Torokhov wrote:
> > On Monday, July 18, 2011 09:45:07 AM Shawn Guo wrote:
> > > The patch makes a copy of platform data into driver data, so that any
> > > reference to platform_data after .probe exits can be avoided.
> > 
> > And why is this beneficial? I am of the opinion that platform data should
> > stay on (and be accessed through a const pointer to ensure that the driver
> > will not alter it).
> > 
> To me, it's a common sense that platform data should not be referenced
> after .probe exits, so that any platform code providing the data can
> claim the data as __initconst.

That's totally buggered, and that's putting it kindly.

Consider a driver built as a module, vs built-in.  If you build it as a
module, your driver data is stale by the time you insert the module.
It's not much better with it built-in - if you have hotplug enabled, you
can unbind and rebind the driver, which means that the .probe function
can be called long after the .init sections have been discarded.

So no, this is no justification for the patch.

Don't *ever* make any platform devices or any data pointed to by a
platform device discardable after init time.  It's an oops waiting to
happen.

From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: da9052_tsi: make TSI reference regulator
 configurable
Date: Fri, 22 Mar 2013 08:58:20 -0700
Message-ID: <9897835.LCtlOrd5pn@dtor-d630.eng.vmware.com>
References: <1363964129-23392-1-git-send-email-p.zabel@pengutronix.de>
 <514C7DFB.8000708@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <514C7DFB.8000708-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Ashish Jangam <ashish.jangam-edWfh0lVHvKWbvRemg0rlA@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Friday, March 22, 2013 12:51:23 PM Fabio Estevam wrote:
> Philipp Zabel wrote:
> >  	if (!tsi->stopped) {
> > 
> > +		error = regulator_enable(tsi->tsiref);
> > +		if (error < 0) {
> > +			dev_err(tsi->da9052->dev,
> > +				"Failed to enable TSIREF regualtor: %d\n",
> 
> s/regualtor/regulator
> 
> > @@ -274,12 +287,20 @@ static int da9052_ts_probe(struct platform_device
> > *pdev)> 
> >  	/* Disable ADC */
> >  	da9052_ts_adc_toggle(tsi, false);
> > 
> > +	tsi->tsiref = regulator_get(tsi->da9052->dev, "tsiref");
> 
> You could use devm_regulator_get here ...

The rest of the driver does not use managed resources. Mixing styles is not 
the best idea.

Thanks.

-- 
Dmitry

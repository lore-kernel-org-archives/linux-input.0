From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 4/4] Input: auo_pixcir_ts - add devicetree support
Date: Sun, 24 Feb 2013 10:58:00 +0100
Message-ID: <201302241058.01412.heiko@sntech.de>
References: <201302231255.23772.heiko@sntech.de>
 <201302231258.16498.heiko@sntech.de>
 <20130224080015.GA20590@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130224080015.GA20590-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
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
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Am Sonntag, 24. Februar 2013, 09:00:15 schrieb Dmitry Torokhov:
> Hi Heiko,
> =

> On Sat, Feb 23, 2013 at 12:58:16PM +0100, Heiko St=FCbner wrote:
> > +static struct auo_pixcir_ts_platdata *auo_pixcir_parse_dt(struct device
> > *dev) +{
> > +	struct auo_pixcir_ts_platdata *pdata =3D NULL;
> > +
> > +#ifdef CONFIG_OF
> > +	struct device_node *np =3D dev->of_node;
> > +
> > +	if (!np)
> > +		return NULL;
> > +
> > +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata) {
> > +		dev_err(dev, "failed to allocate platform data\n");
> > +		return NULL;
> > +	}
> =

> I disike #ifdefs in the middle of the code, also it would be nice if we
> signal the proper error instead of always using -EINVAL when there are
> issues with platform/DT data.
> =

> How about the version of the patch below?

I tested it and everything of course still works :-) .

I have no real preference for one way or the other. I had seen both types i=
n =

different drivers and could not really decide which I like better, so I'm f=
ine =

with using your variant instead.


Thanks
Heiko

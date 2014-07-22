From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] iio: exynos-adc: add experimental touchscreen support
Date: Tue, 22 Jul 2014 20:33:44 +0200
Message-ID: <5072247.HRN2kuegE2@wuerfel>
References: <5068889.1KfVx3ksNo@wuerfel> <20140722180904.GB5489@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140722180904.GB5489-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, heiko.stuebner-K3U4GQvHnyU@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tuesday 22 July 2014 11:09:04 Dmitry Torokhov wrote:
> > @@ -565,6 +722,15 @@ static int exynos_adc_probe(struct platform_device *pdev)
> >       if (info->data->init_hw)
> >               info->data->init_hw(info);
> >  
> > +     /* leave out any TS related code if unreachable */
> > +     if (IS_BUILTIN(CONFIG_INPUT) ||
> > +         (IS_MODULE(CONFIG_INPUT) && config_enabled(MODULE)))
> 
> This is ugly... We need IS_SUBSYSTEM_AVAILABLE() wrapper for this...
> 
> Anyway,
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> 

I actually have a patch to introduce IS_REACHABLE() for this purpose,
but I haven't sent it out for review yet. The main user of this would
be drivers/media, which had the correct logic earlier until someone
tried to "simplify" it by replacing it all with IS_ENABLED()...

	Arnd

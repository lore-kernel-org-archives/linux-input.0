From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv4 2/3] Input: twl4030-pwrbutton: use dev_err for errors
Date: Wed, 23 Oct 2013 12:38:14 -0700
Message-ID: <1382557094.22433.40.camel@joe-AO722>
References: <1382550852-11508-1-git-send-email-sre@debian.org>
	 <1382550852-11508-3-git-send-email-sre@debian.org>
	 <1382552266.22433.36.camel@joe-AO722>
	 <20131023193112.GB30437@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131023193112.GB30437-SfvFxonMDyemK9LvCR3Hrw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 2013-10-23 at 21:31 +0200, Sebastian Reichel wrote:
> On Wed, Oct 23, 2013 at 11:17:46AM -0700, Joe Perches wrote:
> > On Wed, 2013-10-23 at 19:54 +0200, Sebastian Reichel wrote:
> > > Use dev_err() to output errors instead of dev_dbg().
> > []
> > > diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
> > []
> > > @@ -60,7 +60,7 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
> > >  
> > >  	pwr = input_allocate_device();
> > >  	if (!pwr) {
> > > -		dev_dbg(&pdev->dev, "Can't allocate power button\n");
> > > +		dev_err(&pdev->dev, "Can't allocate power button\n");
> > >  		return -ENOMEM;
> > >  	}
> > 
> > input_allocate_device uses kzalloc and it will emit a
> > standardized OOM message along with a dump_stack()
> > so this dev_err/dev_dbg is redundant and not necessary.
> 
> I saw you sent a big patchset changing this for all drivers.
> Should I drop this patch?

I think the 2 other bits of this patch are fine.
Maybe resend with this section dropped?

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

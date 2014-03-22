From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v2 1/8] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
Date: Sat, 22 Mar 2014 20:08:03 +0100
Message-ID: <20140322190803.GA20987@localhost.fastwebnet.it>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-2-git-send-email-carlo@caione.org>
 <20140318155919.GS25478@lee--X1>
 <20140322165132.GC20668@localhost.fastwebnet.it>
 <20140322173313.GU552@sirena.org.uk>
 <CAOQ7t2Yg5pp_rXYfsdnHpy-zGFGimzT3EW15P_0ugYMtgPtOrw@mail.gmail.com>
 <20140322184201.GA27611@core.coreip.homeip.net>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBSV6W6MQKGQECDVB3ZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140322184201.GA27611-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, Mar 22, 2014 at 11:42:01AM -0700, Dmitry Torokhov wrote:
> On Sat, Mar 22, 2014 at 07:13:36PM +0100, Carlo Caione wrote:
> > On Sat, Mar 22, 2014 at 6:33 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > > On Sat, Mar 22, 2014 at 05:51:32PM +0100, Carlo Caione wrote:
> > >> On Tue, Mar 18, 2014 at 03:59:19PM +0000, Lee Jones wrote:
> > >
> > >> > > + of_id = of_match_device(axp20x_of_match, &i2c->dev);
> > >> > > + if (!of_id) {
> > >> > > +         dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
> > >> > > +         return -ENODEV;
> > >> > > + }
> > >> > > + axp20x->variant = (int) of_id->data;
> > >
> > >> > No need to cast from void *.
> > >
> > >> My compiler says otherwise :)
> > >
> > > Are you sure your compiler isn't correctly telling you not to cast away
> > > const?  If the compiler is complaining about a cast on void then it's
> > > spotted a definite bug.
> > 
> > [resend since gmail decided to not put broonie in CC]
> > 
> > drivers/mfd/axp20x.c:172:18: warning: assignment makes integer
> > frompointer without a cast [enabled by default]
> 
> You need to cast to long, otherwise you will get warnings when compiling
> on 64 bit arches.

Actually no warning also with (int) cast.

-- 
Carlo Caione

From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v2 1/8] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
Date: Sat, 22 Mar 2014 19:05:52 +0100
Message-ID: <CAOQ7t2a+_6ecOkGkFU5yXMKLmfR9uXmaEk2+mE5B4MYR2GjvnA@mail.gmail.com>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
	<1394898225-28452-2-git-send-email-carlo@caione.org>
	<20140318155919.GS25478@lee--X1>
	<20140322165132.GC20668@localhost.fastwebnet.it>
	<20140322173313.GU552@sirena.org.uk>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBKVCW6MQKGQEKL47O4Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140322173313.GU552-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, Mar 22, 2014 at 6:33 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sat, Mar 22, 2014 at 05:51:32PM +0100, Carlo Caione wrote:
>> On Tue, Mar 18, 2014 at 03:59:19PM +0000, Lee Jones wrote:
>
>> > > + of_id = of_match_device(axp20x_of_match, &i2c->dev);
>> > > + if (!of_id) {
>> > > +         dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
>> > > +         return -ENODEV;
>> > > + }
>> > > + axp20x->variant = (int) of_id->data;
>
>> > No need to cast from void *.
>
>> My compiler says otherwise :)
>
> Are you sure your compiler isn't correctly telling you not to cast away
> const?  If the compiler is complaining about a cast on void then it's
> spotted a definite bug.

drivers/mfd/axp20x.c:172:18: warning: assignment makes integer from
pointer without a cast [enabled by default]

-- 
Carlo Caione

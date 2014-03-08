From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH 6/7] regulator: AXP20x: Add support for
 regulators subsystem
Date: Sat, 8 Mar 2014 12:43:04 +0100
Message-ID: <CAOQ7t2YSidSPVSBrBzj3R1SYS_Xb10a2vfEs+u1DEkrhEJQCaQ@mail.gmail.com>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
	<1393692352-10839-7-git-send-email-carlo@caione.org>
	<20140307182213.GC607@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDWJTUUC5UCBB24E5SMAKGQEXCWNM7I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140307182213.GC607@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Mar 7, 2014 at 7:22 PM, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Sat, Mar 01, 2014 at 05:45:51PM +0100, Carlo Caione wrote:
>> +static struct platform_driver axp20x_regulator_driver = {
>> +     .probe  = axp20x_regulator_probe,
>> +     .remove = axp20x_regulator_remove,
>> +     .driver = {
>> +             .name           = "axp20x-regulator",
>> +             .owner          = THIS_MODULE,
>> +     },
>> +};
>> +
>> +static int __init axp20x_regulator_init(void)
>> +{
>> +     return platform_driver_register(&axp20x_regulator_driver);
>> +}
>> +
>> +subsys_initcall(axp20x_regulator_init);
>
> Hmmm, really?
>
> I thought the AXP was only connected through I2C? How is that a
> platform device then?

Not really. It is plain wrong.
I'll fix it in v2.

Thanks,

-- 
Carlo Caione

From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v3 01/10] mfd: AXP20x: Add mfd driver
 for AXP20x PMIC
Date: Fri, 11 Apr 2014 11:26:54 +0200
Message-ID: <CAOQ7t2a4FbkuboTJWT=rpAVnq6a_mo7j58Dr9Rkg_yiHCuzbBQ@mail.gmail.com>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
	<1395955764-18103-2-git-send-email-carlo@caione.org>
	<20140328092154.GF17779@lee--X1>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDWJTUUC5UCBB7PKT2NAKGQEGKZ2YRI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140328092154.GF17779@lee--X1>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Mar 28, 2014 at 10:21 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

[...]

>> +static struct resource axp20x_pek_resources[] = {
>> +     {
>> +             .name   = "PEK_DBR",
>> +             .start  = AXP20X_IRQ_PEK_RIS_EDGE,
>> +             .end    = AXP20X_IRQ_PEK_RIS_EDGE,
>> +             .flags  = IORESOURCE_IRQ,
>> +     }, {
>> +             .name   = "PEK_DBF",
>> +             .start  = AXP20X_IRQ_PEK_FAL_EDGE,
>> +             .end    = AXP20X_IRQ_PEK_FAL_EDGE,
>> +             .flags  = IORESOURCE_IRQ,
>> +     },
>> +};
>
> Have you considered doing this in the Device Tree? It's a lot less
> code/overhead.

Hi Lee,
in v4 (I will send it soon) I left this code in since the resources
are well managed by the MFD core and adding it in the DT results in
pretty much the same code/overhead (atm the input device is not
present in the DT).
If you really think that it is the case to move the code in the DT,
please comment it in the v4.

Thanks,

-- 
Carlo Caione

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys: support wakeup system from freeze mode
Date: Thu, 26 Dec 2013 15:35:30 -0800
Message-ID: <20131226233530.GG18562@core.coreip.homeip.net>
References: <1387822880-30382-1-git-send-email-b20788@freescale.com>
 <20131224003036.GA16590@core.coreip.homeip.net>
 <971c266b465e460bbea8b968d3e19cd4@BY2PR03MB315.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34469 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab3LZXfd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Dec 2013 18:35:33 -0500
Received: by mail-pa0-f49.google.com with SMTP id kx10so8668112pab.36
        for <linux-input@vger.kernel.org>; Thu, 26 Dec 2013 15:35:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <971c266b465e460bbea8b968d3e19cd4@BY2PR03MB315.namprd03.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Anson.Huang@freescale.com" <Anson.Huang@freescale.com>
Cc: "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Anson,

On Tue, Dec 24, 2013 at 02:29:54AM +0000, Anson.Huang@freescale.com
wrote:
> Hi, Dmitry
>=20
> 	See below:
>=20
> Best Regards.  Anson huang =E9=BB=84=E5=8B=87=E6=89=8D =C2=A0 Freesca=
le Semiconductor Shanghai
> =E4=B8=8A=E6=B5=B7=E6=B5=A6=E4=B8=9C=E6=96=B0=E5=8C=BA=E4=BA=AE=E6=99=
=AF=E8=B7=AF192=E5=8F=B7A=E5=BA=A72=E6=A5=BC 201203 Tel:021-28937058
>=20
>=20
> >-----Original Message----- From: Dmitry Torokhov
> >[mailto:dmitry.torokhov@gmail.com] Sent: Tuesday, December 24, 2013
> >8:31 AM To: Huang Yongcai-B20788 Cc: sachin.kamat@linaro.org;
> >linux-input@vger.kernel.org Subject: Re: [PATCH] Input: gpio_keys:
> >support wakeup system from freeze mode
> >
> >Hi Anson,
> >
> >On Mon, Dec 23, 2013 at 01:21:20PM -0500, Anson Huang wrote:
> >> For "freeze" mode of suspend, cpu will go into idle and those
> >> wakeup sources' irq should NOT be disabled during devices suspend,
> >> so we need to add IRQF_NO_SUSPEND flag for those wakeup sources.
> >>
> >> Steps to test this patch:
> >>
> >> 1. echo freeze > /sys/power/state; 2. press gpio key which has
> >> wakeup function, then system will resume.
> >
> >I do no think this is correct approach, otheriwse every driver that
> >can be a wakeup source would have to use IRQF_NO_SUSPEND flag. The
> >driver does use enable_irq_wake() in its suspend path, and platform
> >code should perform all necessary work for this IRQ to be usable as =
a
> >wakeup source.
> >
> >Thanks.
>=20
>=20
> From the suspend flow, we can see that kernel will disable all
> devices' irq unless its IRQF_NO_SUSPEND flag is set. For freeze mode,
> as cpu will be in idle, SOC is not in low power mode, that means
> freeze mode equals cpu in idle and devices in suspend. The wakeup
> source must come from GIC. Yes, for normal standby/mem mode's suspend=
,
> the enable_irq_wake will make everything done for waking up a system,
> in gic_set_wake routine, it will call extern irq chip's wakeup
> function, but for freeze mode, the wakeup process is same as normal
> wakeup from cpu idle, so the wakeup source must be not masked in gic.=
=20
>=20
> Take our i.MX6 SOC for example, there is GPC module which is used to
> wake up SOC from STOP mode(low power mode of SOC), normal standby/mem
> mode suspend, the wakeup source's enable_irq_wake will set GPC to
> monitor these irq source and wakeup system from STOP mode when there
> is an wakeup event. But for freeze mode, kernel's suspend flow will
> not finish the SOC's low level power management, the secondary CPUs
> are even not disabled, kernel just suspend the devices and put CPU
> into idle and waiting for wakeup even, in GIC's gic_set_wake routine,
> it only calls our GPC's imx_gpc_irq_set_wake, here comes the problem,
> as our SOC is not entering STOP mode, GPC has no use to set this
> wakeup source enabled. So either we should enable GIC's wakeup in GIC
> driver, or just set this flag to make kernel do NOT disable this
> wakeup source's irq when executing a freeze mode suspend.
>
> Otherwise, we need to modify the GIC driver?

Yes, I believe it is the task of platform code to make sure that
enable_irq_wake() enables irq wakeup properly, be it suspend or
hibernate.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

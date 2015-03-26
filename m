From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 2/5] power: max77843_charger: Add Max77843 charger
 device driver
Date: Thu, 26 Mar 2015 13:54:12 +0000
Message-ID: <20150326135412.GJ5951@x1>
References: <1425291038-18269-3-git-send-email-jaewon02.kim@samsung.com>
 <20150307201340.GF5233@earth>
 <54FCEABE.9000007@samsung.com>
 <CAJKOXPcLoOp30j5ZwFv2_nT5B+nZOnV6utck5KDw3vt-tmWRew@mail.gmail.com>
 <54FD880E.30903@samsung.com>
 <1425903199.13415.9.camel@AMDC1943>
 <54FEF541.6000305@samsung.com>
 <551119DE.2070402@samsung.com>
 <CAJKOXPdd5dDgH91NeytobJWg71pYOw5XnhB9N1=m2Mjmxxjv-A@mail.gmail.com>
 <551408E0.3060901@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34603 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbbCZNyR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Mar 2015 09:54:17 -0400
Received: by wibg7 with SMTP id g7so17104145wib.1
        for <linux-input@vger.kernel.org>; Thu, 26 Mar 2015 06:54:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <551408E0.3060901@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Jaewon Kim <jaewon02.kim@samsung.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, 26 Mar 2015, Beomho Seo wrote:
> On 03/24/2015 05:38 PM, Krzysztof Kozlowski wrote:
> > 2015-03-24 9:01 GMT+01:00 Beomho Seo <beomho.seo@samsung.com>:
> >> On 03/10/2015 10:44 PM, Beomho Seo wrote:
> >>> On 03/09/2015 09:13 PM, Krzysztof Kozlowski wrote:
> >>>> On pon, 2015-03-09 at 20:46 +0900, Beomho Seo wrote:
> >>>>> On 03/09/2015 08:02 PM, Krzysztof Kozlowski wrote:
> >>>>>> 2015-03-09 1:35 GMT+01:00 Beomho Seo <beomho.seo@samsung.com>:
> >>>>>>> On 03/08/2015 05:13 AM, Sebastian Reichel wrote:
> >>>>>>>> On Mon, Mar 02, 2015 at 07:10:35PM +0900, Jaewon Kim wrote:
> >>>>>>>>> From: Beomho Seo <beomho.seo@samsung.com>
> >>>>>>>>>
> >>>>>>>>> This patch adds device driver of max77843 charger. This dri=
ver provide
> >>>>>>>>> initialize each charging mode(e.g. fast charge, top-off mod=
e and constant
> >>>>>>>>> charging mode so on.). Additionally, control charging param=
ters to use
> >>>>>>>>> i2c interface.
> >>>>>>>>>
> >>>>>>>>> Cc: Sebastian Reichel <sre@kernel.org>
> >>>>>>>>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> >>>>>>>>
> >>>>>>>> Reviewed-By: Sebastian Reichel <sre@kernel.org>
> >>>>>>>>
> >>>>>>>> I can't take it as is, since it depends on the private heade=
r file
> >>>>>>>> of PATCHv1.
> >>>>>>>>
> >>>>>>>> -- Sebastian
> >>>>>>>>
> >>>>>>>
> >>>>>>> This patch reviewed by Sebastian.
> >>>>>>> Could you Please merge that your git tree ?
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> ... and again we are adding a new driver for very similar chip=
set to
> >>>>>> already supported. I looked at spec and the charger's register=
s are
> >>>>>> almost the same as for max77693. Their layout and addresses ar=
e the
> >>>>>> same. I see some minor differences, probably the most importan=
t would
> >>>>>> be different values current (fast-charge, top-off). But still =
90% of
> >>>>>> registers are the same... Do we really have to add new driver?
> >>>>>>
> >>>>>> Best regards,
> >>>>>> Krzysztof
> >>>>>>
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> Thank you for your comment. As you say, both chip set are simil=
ar.
> >>>>> But new driver need for support max77843. It is support differe=
nt below
> >>>>> - Provide Battery presence information.
> >>>>
> >>>> Another set of power supply properties could be added for that c=
hip.
> >>>> This way the get_property() function would be the same but actua=
lly the
> >>>> POWER_SUPPLY_PROP_PRESENT won't be called for max77693.
> >>>>
> >>>>> - Can OTG FET control.
> >>>>
> >>>> Where the OTG FET feature is it enabled in your driver? I couldn=
't find
> >>>> it.
> >>>>
> >>>
> >>> Sorry. This driver don't control OTG FET feature.
> >>>
> >>>>> - Bigger Fast charge current, Top Off current Threshold selecti=
on.
> >>>>> - Various and bigger OTG current limitation.
> >>>>> - Bigger primary charger termination voltage setting.
> >>>>> - Different maximum input current limit selection(Different ste=
p).
> >>>>
> >>>> Yes, I mentioned some of these differences (the Fast/top-off
> >>>> differences). These are differences in values so it does not req=
uire new
> >>>> driver. There is need to develop new driver just to support diff=
erent
> >>>> current (3.0 A instead of 2.1 A) or voltage threshold.
> >>>>
> >>>
> >>> They are different charging current, OTG current limitation, top =
off current,
> >>> charging limitation value. In case OTG current limitation differe=
nt not
> >>> limitation value but using register bit(max77843 use[7:6] max7769=
3 use[7]
> >>> bit only). Even if this driver not support all feature, some regi=
ster
> >>> different with max77693(support value, use register bit).
> >>>
> >>> If this driver will combined with max77693 may even be beneficial=
 for
> >>> new Maxim driver. But the present, this driver is related with
> >>> max77843 core driver and max77843-regulator. So I hope this drive=
r
> >>> merge first. And then will extend two driver(max77843 charger and=
 max77693 charger).
> >=20
> > I still prefer merging common drivers into one instead of creating
> > some more of them.
> > However I understand your point and I am not entirely opposed again=
st.
> > Especially that you invested quite a bit of time for developing thi=
s
> > and my feedback was quite late. To summarize I am fine with your
> > approach.
> >=20
> > Best regards,
> > Krzysztof
> >
>=20
> Dear Lee Jones,
>=20
> Could you please merge that your git tree ?

Sorry, I'm lost.  Why am I taking this though the MFD tree?  What
patches are left?  Where are they going?  Am I taking any other
patches?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

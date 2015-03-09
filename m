From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v7 2/5] power: max77843_charger: Add Max77843 charger
 device driver
Date: Mon, 09 Mar 2015 13:13:19 +0100
Message-ID: <1425903199.13415.9.camel@AMDC1943>
References: <1425291038-18269-1-git-send-email-jaewon02.kim@samsung.com>
 <1425291038-18269-3-git-send-email-jaewon02.kim@samsung.com>
 <20150307201340.GF5233@earth> <54FCEABE.9000007@samsung.com>
 <CAJKOXPcLoOp30j5ZwFv2_nT5B+nZOnV6utck5KDw3vt-tmWRew@mail.gmail.com>
 <54FD880E.30903@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <54FD880E.30903@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaewon Kim <jaewon02.kim@samsung.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On pon, 2015-03-09 at 20:46 +0900, Beomho Seo wrote:
> On 03/09/2015 08:02 PM, Krzysztof Kozlowski wrote:
> > 2015-03-09 1:35 GMT+01:00 Beomho Seo <beomho.seo@samsung.com>:
> >> On 03/08/2015 05:13 AM, Sebastian Reichel wrote:
> >>> On Mon, Mar 02, 2015 at 07:10:35PM +0900, Jaewon Kim wrote:
> >>>> From: Beomho Seo <beomho.seo@samsung.com>
> >>>>
> >>>> This patch adds device driver of max77843 charger. This driver provide
> >>>> initialize each charging mode(e.g. fast charge, top-off mode and constant
> >>>> charging mode so on.). Additionally, control charging paramters to use
> >>>> i2c interface.
> >>>>
> >>>> Cc: Sebastian Reichel <sre@kernel.org>
> >>>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> >>>
> >>> Reviewed-By: Sebastian Reichel <sre@kernel.org>
> >>>
> >>> I can't take it as is, since it depends on the private header file
> >>> of PATCHv1.
> >>>
> >>> -- Sebastian
> >>>
> >>
> >> This patch reviewed by Sebastian.
> >> Could you Please merge that your git tree ?
> > 
> > Hi,
> > 
> > ... and again we are adding a new driver for very similar chipset to
> > already supported. I looked at spec and the charger's registers are
> > almost the same as for max77693. Their layout and addresses are the
> > same. I see some minor differences, probably the most important would
> > be different values current (fast-charge, top-off). But still 90% of
> > registers are the same... Do we really have to add new driver?
> > 
> > Best regards,
> > Krzysztof
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> Hi,
> 
> Thank you for your comment. As you say, both chip set are similar.
> But new driver need for support max77843. It is support different below
> - Provide Battery presence information.

Another set of power supply properties could be added for that chip.
This way the get_property() function would be the same but actually the
POWER_SUPPLY_PROP_PRESENT won't be called for max77693.

> - Can OTG FET control.

Where the OTG FET feature is it enabled in your driver? I couldn't find
it.

> - Bigger Fast charge current, Top Off current Threshold selection.
> - Various and bigger OTG current limitation.
> - Bigger primary charger termination voltage setting.
> - Different maximum input current limit selection(Different step).

Yes, I mentioned some of these differences (the Fast/top-off
differences). These are differences in values so it does not require new
driver. There is need to develop new driver just to support different
current (3.0 A instead of 2.1 A) or voltage threshold.

So the only new feature - battery presence - can be easily added to
existing driver. The driver can be extended for different
current/voltage values. Such extension may even be beneficial for new
Maxim MUIC/PMIC chipsets.


Best regards,
Krzysztof

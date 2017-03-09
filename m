From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/3] tps6507x-ts: add DT bindings description
Date: Thu, 9 Mar 2017 09:55:30 -0800
Message-ID: <20170309175530.GC20077@dtor-ws>
References: <1489069869-3849-1-git-send-email-yegorslists@googlemail.com>
 <1489069869-3849-4-git-send-email-yegorslists@googlemail.com>
 <CAL_Jsq+bvWVi=8-HjBZ+O5R6SRHL1NuQkA9ZAhFUZmt8VAf+Sw@mail.gmail.com>
 <CAGm1_kvdVFK9F_A3PrD8PLtrnno9pikg2RxENLqkPUe3vE_zkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33727 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754497AbdCISFG (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Mar 2017 13:05:06 -0500
Received: by mail-pf0-f196.google.com with SMTP id v190so8046343pfb.0
        for <linux-input@vger.kernel.org>; Thu, 09 Mar 2017 10:04:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGm1_kvdVFK9F_A3PrD8PLtrnno9pikg2RxENLqkPUe3vE_zkA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Andrey Skvortsov <andrej.skvortzov@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>

On Thu, Mar 09, 2017 at 04:18:40PM +0100, Yegor Yefremov wrote:
> On Thu, Mar 9, 2017 at 3:49 PM, Rob Herring <robh@kernel.org> wrote:
> > On Thu, Mar 9, 2017 at 8:31 AM,  <yegorslists@googlemail.com> wrote:
> >> From: Yegor Yefremov <yegorslists@googlemail.com>
> >
> > This needs to go to DT list.
> 
> Will do.
> 
> >>
> >> Provide description for following properties:
> >>
> >> - ti,poll-period
> >> - ti,min-pressure
> >>
> >> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> >> ---
> >>  Documentation/devicetree/bindings/mfd/tps6507x.txt | 16 ++++++++++++++--
> >>  1 file changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/tps6507x.txt b/Documentation/devicetree/bindings/mfd/tps6507x.txt
> >> index 8fffa3c..8875662 100644
> >> --- a/Documentation/devicetree/bindings/mfd/tps6507x.txt
> >> +++ b/Documentation/devicetree/bindings/mfd/tps6507x.txt
> >> @@ -1,4 +1,8 @@
> >> -TPS6507x Power Management Integrated Circuit
> >> +TPS6507x Multifunctional Device.
> >> +
> >> +Features provided by TPS6507x:
> >> +        1. Power Management Integrated Circuit.
> >> +        2. Touch-Screen.
> >>
> >>  Required properties:
> >>  - compatible: "ti,tps6507x"
> >> @@ -30,6 +34,12 @@ Regulator Optional properties:
> >>                         1: If defdcdc pin of DCDC2/DCDC3 is driven HIGH.
> >>    If this property is not defined, it defaults to 0 (not enabled).
> >>
> >> +Touchscreen Optional properties:
> >> +- ti,poll-period: Time at which touch input is getting sampled in ms.
> >> +                 Default value: 30 ms.
> >
> > Isn't there a standard property for this?
> 
> Such a value will be already used in [1]. I've looked at [2], but it
> doesn't have such a field.
> 
> [1] Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> [2] Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

I think the bigger question (since we are adding this to DT I assume it
is not longer "toy" driver) can we convert it to a proper
interrupt-driven scheme? Polling for real shipping devices is not
efficient, I do not think we should even try to allow this mode in DTS
bindings (note that tsc2007 use is different: it allows to specify
sampling interval once touch is detected).

Thanks.

-- 
Dmitry

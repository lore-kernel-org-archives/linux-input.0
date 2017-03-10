From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/3] tps6507x-ts: add DT bindings description
Date: Fri, 10 Mar 2017 10:26:55 -0600
Message-ID: <CAL_Jsq+Zt0JxhPtUqvxr7iq8va28B7WA7Yw9auPQttxZt-kpnA@mail.gmail.com>
References: <1489069869-3849-1-git-send-email-yegorslists@googlemail.com>
 <1489069869-3849-4-git-send-email-yegorslists@googlemail.com>
 <CAL_Jsq+bvWVi=8-HjBZ+O5R6SRHL1NuQkA9ZAhFUZmt8VAf+Sw@mail.gmail.com>
 <CAGm1_kvdVFK9F_A3PrD8PLtrnno9pikg2RxENLqkPUe3vE_zkA@mail.gmail.com> <20170309175530.GC20077@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754157AbdCJQ1V (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 11:27:21 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 2A76F2058A
        for <linux-input@vger.kernel.org>; Fri, 10 Mar 2017 16:27:19 +0000 (UTC)
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com [209.85.161.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CC920552
        for <linux-input@vger.kernel.org>; Fri, 10 Mar 2017 16:27:17 +0000 (UTC)
Received: by mail-yw0-f176.google.com with SMTP id v76so26852313ywg.0
        for <linux-input@vger.kernel.org>; Fri, 10 Mar 2017 08:27:17 -0800 (PST)
In-Reply-To: <20170309175530.GC20077@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Andrey Skvortsov <andrej.skvortzov@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>

On Thu, Mar 9, 2017 at 11:55 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Mar 09, 2017 at 04:18:40PM +0100, Yegor Yefremov wrote:
>> On Thu, Mar 9, 2017 at 3:49 PM, Rob Herring <robh@kernel.org> wrote:
>> > On Thu, Mar 9, 2017 at 8:31 AM,  <yegorslists@googlemail.com> wrote:
>> >> From: Yegor Yefremov <yegorslists@googlemail.com>
>> >
>> > This needs to go to DT list.
>>
>> Will do.
>>
>> >>
>> >> Provide description for following properties:
>> >>
>> >> - ti,poll-period
>> >> - ti,min-pressure
>> >>
>> >> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> >> ---
>> >>  Documentation/devicetree/bindings/mfd/tps6507x.txt | 16 ++++++++++++++--
>> >>  1 file changed, 14 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/mfd/tps6507x.txt b/Documentation/devicetree/bindings/mfd/tps6507x.txt
>> >> index 8fffa3c..8875662 100644
>> >> --- a/Documentation/devicetree/bindings/mfd/tps6507x.txt
>> >> +++ b/Documentation/devicetree/bindings/mfd/tps6507x.txt
>> >> @@ -1,4 +1,8 @@
>> >> -TPS6507x Power Management Integrated Circuit
>> >> +TPS6507x Multifunctional Device.
>> >> +
>> >> +Features provided by TPS6507x:
>> >> +        1. Power Management Integrated Circuit.
>> >> +        2. Touch-Screen.
>> >>
>> >>  Required properties:
>> >>  - compatible: "ti,tps6507x"
>> >> @@ -30,6 +34,12 @@ Regulator Optional properties:
>> >>                         1: If defdcdc pin of DCDC2/DCDC3 is driven HIGH.
>> >>    If this property is not defined, it defaults to 0 (not enabled).
>> >>
>> >> +Touchscreen Optional properties:
>> >> +- ti,poll-period: Time at which touch input is getting sampled in ms.
>> >> +                 Default value: 30 ms.
>> >
>> > Isn't there a standard property for this?
>>
>> Such a value will be already used in [1]. I've looked at [2], but it
>> doesn't have such a field.
>>
>> [1] Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
>> [2] Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>
> I think the bigger question (since we are adding this to DT I assume it
> is not longer "toy" driver) can we convert it to a proper
> interrupt-driven scheme? Polling for real shipping devices is not
> efficient, I do not think we should even try to allow this mode in DTS
> bindings (note that tsc2007 use is different: it allows to specify
> sampling interval once touch is detected).

I guess I was assuming that polling period corresponded to sampling
period or rate. The latter makes more sense for a binding and I would
think is fairly common whether the h/w has functionality or the driver
has to implement the sampling rate in s/w.

Rob

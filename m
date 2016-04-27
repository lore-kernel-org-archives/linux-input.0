From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/5] Input: zforce_ts: Add device tree support for
 scanning frequency
Date: Wed, 27 Apr 2016 09:44:02 -0500
Message-ID: <CAL_JsqJhtBp6vp6AL4=gKTbvzm_ae0TGzHHitc4=6pdiE=V_sA@mail.gmail.com>
References: <1461135285-17582-1-git-send-email-dirk.behme@de.bosch.com>
 <1461135285-17582-3-git-send-email-dirk.behme@de.bosch.com> <20160425211122.GD26059@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47834 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758AbcD0OoZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Apr 2016 10:44:25 -0400
In-Reply-To: <20160425211122.GD26059@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Oleksij Rempel <linux@rempel-privat.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Apr 25, 2016 at 4:11 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Adding devicetree overlords...
>
> On Wed, Apr 20, 2016 at 08:54:43AM +0200, Dirk Behme wrote:
>> From: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
>>
>> Add device tree support for idle and finger scanning frequency.
>>
>> Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>> ---
>>  .../devicetree/bindings/input/touchscreen/zforce_ts.txt   |  4 ++++
>>  drivers/input/touchscreen/zforce_ts.c                     | 15 ++++++++++++++-
>>  include/linux/platform_data/zforce_ts.h                   |  2 ++
>>  3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
>> index e3c27c4..09ead84 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
>> @@ -11,6 +11,8 @@ Required properties:
>>  Optional properties:
>>  - irq-gpios : interrupt gpio the chip is connected to

BTW, this should really be an "interrupts" property

>>  - vdd-supply: Regulator controlling the controller supply
>> +- scan-freq-idle: idle scanning frequency in Hz (0 - 65535 Hz; default 10 Hz)
>> +- scan-freq-finger: touch scanning frequeny in Hz (0 - 65535 Hz; default 50 Hz)

I use my toes for touchscreens.

Can you really scan at 65kHz?

a typo here as well.

> Should we cal it scan-freq-active instead?

Don't we have a standard property for this?  These should really have
-hz appended. So scan-idle-hz and scan-active-hz, but at least the
active case should be common IMO. Idle scan seems a bit unusual unless
you don't have an interrupt.

Rob

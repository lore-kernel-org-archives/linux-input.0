From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] dt-bindings: touchscreen: silead gsl1680: Document all
 compatibles
Date: Wed, 17 Aug 2016 10:58:26 +0200
Message-ID: <df9de5f7-97af-269d-d901-5d7bb134b069@redhat.com>
References: <1471338091-3259-1-git-send-email-hdegoede@redhat.com>
 <46861471402766@web24j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51826 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753827AbcHQI6c (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2016 04:58:32 -0400
In-Reply-To: <46861471402766@web24j.yandex.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Icenowy Zheng <icenowy@aosc.xyz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On 17-08-16 04:59, Icenowy Zheng wrote:
>
>
> 16.08.2016, 17:06, "Hans de Goede" <hdegoede@redhat.com>:
>> The silead gsl1680 driver / binding supports a whole series of devices,
>> list the compatibles for all of them in the binding.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  .../devicetree/bindings/input/touchscreen/silead_gsl1680.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>> index 1112e0d..37a9370 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>> @@ -2,6 +2,11 @@
>>
>>  Required properties:
>>  - compatible : "silead,gsl1680"
>> + or: "silead,gsl1688"
>> + or: "silead,gsl3670"
>> + or: "silead,gsl3675"
>> + or: "silead,gsl3692"
>> + or: "silead,mssl1680"
> I think “mssl1680" is only a string which exists in ACPI tables.
> I have disassembled one of my tablet, which is said to have "MSSL1680" in it in
> ACPI table (a BayTrail tablet). What I got is a plain GSL1680.
> So it shouldn't exist in the compatible list.

Ah, right, I was already wondering about that one I guess mssl stands for
"microsoft silead" (just a guess). Anyways I'll send a v2 dropping it.

Thanks & Regards,

Hans



>>  - reg : I2C slave address of the chip (0x40)
>>  - interrupt-parent : a phandle pointing to the interrupt controller
>>                              serving the interrupt for this chip
>> --
>> 2.7.4
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

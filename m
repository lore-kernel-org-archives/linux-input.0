From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH v4 4/4] mfd: max77693: Update DT binding to support haptic
Date: Tue, 16 Sep 2014 16:59:58 +0900
Message-ID: <5417EDFE.7030700@samsung.com>
References: <1410440062-19963-1-git-send-email-jaewon02.kim@samsung.com>
 <1410440062-19963-5-git-send-email-jaewon02.kim@samsung.com>
 <20140915230043.GI25162@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54444 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbaIPIAI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Sep 2014 04:00:08 -0400
In-reply-to: <20140915230043.GI25162@lee--X1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Dear Lee Jones,


2014=EB=85=84 09=EC=9B=94 16=EC=9D=BC 08:00=EC=97=90 Lee Jones =EC=9D=B4=
(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> On Thu, 11 Sep 2014, Jaewon Kim wrote:
>
>> This patch add haptic DT binding documentation and example
>> to support haptic driver in max77693 Multifunction device.
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/max77693.txt |   18 ++++++++=
++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/max77693.txt b/Do=
cumentation/devicetree/bindings/mfd/max77693.txt
>> index 11921cc..d178b9e 100644
>> --- a/Documentation/devicetree/bindings/mfd/max77693.txt
>> +++ b/Documentation/devicetree/bindings/mfd/max77693.txt
>> @@ -27,6 +27,17 @@ Optional properties:
>>  =20
>>   	[*] refer Documentation/devicetree/bindings/regulator/regulator.t=
xt
>>  =20
>> +- haptic : The haptic of max77693 have to be instantiated under sub=
nod
> Perhaps a description as to what "The haptic" is might be handy?
Ok, I will add description about haptic.

>
> s/have/has
>
> s/subnod/subnode
>
> What do you mean by "under" a subnode?  Do you mean "as a" subnode?
>
>> +  named "haptic" using the following haptic format in example.
> What is the "haptic format"?  It just looks like a normal node to me.
>
>> +  Haptic sensation from motor can be changed by changing a period c=
ycle in pwms.
> Is "Haptic sensation" a technical term?
>
> s/from motor/from a motor/
>
> s/changed by changing/changed by varying/
>
> s/period cycle/duty cycle/
>
> s/in pwms/in the pwms property/
How is it if I change in this way?

haptic : Referring to the term Haptic, It is the use of advanced=20
vibration patterns
     and waveforms to convey information to a user or operator.

     MAX77693 uses PWM and MOTOR in order to give Haptic.
     The Haptic from a motor can be changed by varying a period/duty=20
cycle in pwms.

>
>> +
>> + Required properties:
>> +	- compatible : Must be "maxim,max77693-hpatic"
>> +	- haptic-supply : power supply for haptic motor
> s/for haptic/for the haptic/
>
>> +		[*] refer Documentation/devicetree/bindings/regulator/regulator.t=
xt
>> +	- pwms : phandle to the physical PWM device,
> It's not just the phandle though is it?
Do you want more description?
Or it mean the wrong?

>
>> +		[*] refer Documentation/devicetree/bindings/pwm/pwm.txt
>> +
>>   Example:
>>   	max77693@66 {
>>   		compatible =3D "maxim,max77693";
>> @@ -52,4 +63,11 @@ Example:
>>   					regulator-boot-on;
>>   			};
>>   		};
>> +
>> +		haptic {
>> +			compatible =3D "maxim,max77693-haptic";
>> +			haptic-supply =3D <&haptic_supply>;
>> +			pwms =3D <&pwm 0 40000 0>;
>> +			pwm-names =3D "haptic";
>> +		};
>>   	};

Thank you for feedback.
And plz review "[PATCH v4 3/4] mfd: max77693: add haptic of_compatible=20
in mfd_cell".

thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

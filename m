From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCHv4 3/4] dt-bindings: mfd: da9052: support TSI as ADC
Date: Sat, 22 Jul 2017 08:09:08 -0700
Message-ID: <b0d58a26-d0b4-a6ec-811a-159bbb8b44d1@roeck-us.net>
References: <20170630143506.10541-1-sebastian.reichel@collabora.co.uk>
 <20170630143506.10541-4-sebastian.reichel@collabora.co.uk>
 <20170717104945.6qn6to7s3mlepxgj@dell>
 <20170717112711.eskydrt4pu32v74g@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170717112711.eskydrt4pu32v74g@earth>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 07/17/2017 04:27 AM, Sebastian Reichel wrote:
> Hi Lee,
> 
> On Mon, Jul 17, 2017 at 11:49:45AM +0100, Lee Jones wrote:
>> On Fri, 30 Jun 2017, Sebastian Reichel wrote:
>>
>>> DA9052 allows using the touchscreen input pins as general purpose
>>> analogue input pin by wiring analogue inputs to X+, X-, Y+ and Y-
>>> and providing a reference voltage at TSIREF pin.
>>>
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
>>> ---
>>>   Documentation/devicetree/bindings/mfd/da9052-i2c.txt | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt b/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
>>> index 9554292dc6cb..57fa74e65664 100644
>>> --- a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
>>> +++ b/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
>>> @@ -4,6 +4,14 @@ Required properties:
>>>   - compatible : Should be "dlg,da9052", "dlg,da9053-aa",
>>>   			 "dlg,da9053-ab", or "dlg,da9053-bb"
>>>   
>>> +Optional properties:
>>> +- dlg,tsi-as-adc : Boolean, if set the X+, X-, Y+, Y- touchscreen
>>> +                    input lines are used as general purpose analogue
>>> +					input.
>>> +- tsiref-supply: Phandle to the regulator, which provides the reference
>>> +                 voltage for the TSIREF pin. Must be provided when the
>>> +			     touchscreen pins are used for ADC purposes.
>>> +
>>
>> DT Ack please.
> 
> There is a v5 of this series, which has Acked-by from Rob already
> and got positive feedback from Guenter Roeck for the hwmon parts:
> 
> http://lkml.iu.edu/hypermail/linux/kernel/1707.0/00518.html
> 
> (if you received v4, v5 should also be in your INBOX)
> 

Yes, but you dropped all the Acks in v6. That is supposed to mean that there
was a substantial change to the patch, and that it needs to be re-reviewed.
For the hwmon patches, I ran a diff against v5 and noticed that there was no
change between v5 and v6, yet you dropped my Acks. Do you really expect us
to do all that work on your behalf ?

Sorry if I sound a bit annoyed. That is because I _am_ a bit annoyed.
Please keep in mind that you are taking our time.

Thanks,
Guenter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

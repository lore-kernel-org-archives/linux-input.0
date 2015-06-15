From: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/2] dt: add cap11xx LED documentation
Date: Mon, 15 Jun 2015 01:48:04 -0700
Message-ID: <CAKzfze9Ji73youadk9zzqahN6E4VCJUXOgzmP4wnoynrQSwRMQ@mail.gmail.com>
References: <1434169054-11035-1-git-send-email-mranostay@gmail.com>
	<1434169054-11035-2-git-send-email-mranostay@gmail.com>
	<557E8990.5060702@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <557E8990.5060702-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jun 15, 2015 at 1:15 AM, Jacek Anaszewski
<j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi Matt,
>
> On 06/13/2015 06:17 AM, Matt Ranostay wrote:
>>
>> Some cap11xx devices have LEDs that can be controlled from userpace
>> and via triggers. Document their use and functionality here.
>>
>> Signed-off-by: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>   .../devicetree/bindings/input/cap11xx.txt          | 23
>> ++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/cap11xx.txt
>> b/Documentation/devicetree/bindings/input/cap11xx.txt
>> index 7d0a300..ef89c27 100644
>> --- a/Documentation/devicetree/bindings/input/cap11xx.txt
>> +++ b/Documentation/devicetree/bindings/input/cap11xx.txt
>> @@ -38,6 +38,11 @@ Optional properties:
>>                                 defaults. The array must have exactly six
>>                                 entries.
>>
>> +       linux,led-brightness:   Defines the ON brightness when the
>> optional LED
>> +                               functionality is used. Valid values are
>> 0-15.
>> +                               By default a value of 15 is set.
>
>
> The ON brightness is controlled with the 'brightness' sysfs property.
> The levels start from 1 and 0 turns the LED off. I think that this
> property is useless then.
>

Yes but this defines the brightness for the ON state.. since it can be
from 0-100% duty cycle.

>
>> +
>>   Example:
>>
>>   i2c_controller {
>> @@ -55,5 +60,23 @@ i2c_controller {
>>                                  <105>,         /* KEY_LEFT */
>>                                  <109>,         /* KEY_PAGEDOWN */
>>                                  <104>;         /* KEY_PAGEUP */
>> +
>> +               linux,led-brightness = <15>;
>> +
>> +               usr@0 {
>> +                       label = "cap11xx:green:usr0";
>> +                       reg = <0>;
>> +               };
>> +
>> +               usr@1 {
>> +                       label = "cap11xx:green:usr1";
>> +                       reg = <1>;
>> +               };
>> +
>> +               alive@2 {
>> +                       label = "cap11xx:green:alive";
>> +                       reg = <2>;
>> +                       linux,default_trigger = "heartbeat";
>> +               };
>>         };
>>   }
>>
>
> --
> Best Regards,
> Jacek Anaszewski
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

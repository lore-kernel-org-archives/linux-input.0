From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v4 1/2] dt: add cap11xx LED documentation
Date: Tue, 16 Jun 2015 07:31:32 -0700
Message-ID: <CAKzfze8h85jPx82W_T=hoXK69ijhGaeMERkLM5jaM7dukyXfrA@mail.gmail.com>
References: <1434422770-26896-1-git-send-email-mranostay@gmail.com>
	<1434422770-26896-2-git-send-email-mranostay@gmail.com>
	<557FD6E8.6010606@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <557FD6E8.6010606@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Daniel Mack <zonque@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-leds@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 16, 2015 at 12:57 AM, Jacek Anaszewski
<j.anaszewski@samsung.com> wrote:
> On 06/16/2015 04:46 AM, Matt Ranostay wrote:
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>   .../devicetree/bindings/input/cap11xx.txt          | 23
>> ++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/cap11xx.txt
>> b/Documentation/devicetree/bindings/input/cap11xx.txt
>> index 7d0a300..01bb5b8 100644
>> --- a/Documentation/devicetree/bindings/input/cap11xx.txt
>> +++ b/Documentation/devicetree/bindings/input/cap11xx.txt
>> @@ -38,6 +38,11 @@ Optional properties:
>>                                 defaults. The array must have exactly six
>>                                 entries.
>>
>> +       linux,led-brightness:   Defines the ON brightness when the
>> optional LED
>> +                               functionality is used. Valid values are
>> 1-15.
>> +                               By default a value of 15 is set.
>> +
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
>
>
> You are missing here:
>
> #address-cells = <1>;
> #size-cells = <0>;
>
> Otherwise you will get warnings during compilation of dtc file.

Will fix in v5.

>
>
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
>
> --
> Best Regards,
> Jacek Anaszewski

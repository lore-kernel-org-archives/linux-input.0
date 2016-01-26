From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Subject: Re: [PATCH 2/3] input: touchscreen: ad7879: fix default x/y axis
 assignment
Date: Tue, 26 Jan 2016 09:04:20 -0800
Message-ID: <53cf5cb2a96a236925bb2901e3c417f8@agner.ch>
References: <1453777477-29706-1-git-send-email-stefan@agner.ch>
 <1453777477-29706-2-git-send-email-stefan@agner.ch>
 <56A72734.9000303@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56A72734.9000303-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 2016-01-25 23:58, Michael Hennerich wrote:
> On 01/26/2016 04:04 AM, Stefan Agner wrote:
>> The measurements read from the controller which are temporary stored
>> in conversion_data, are interpreted wrong. The first measurement X+
>> contains the Y position, and the second measurement Y+ the X position
>> (see also Table 11 Register Table in the data sheet).
>>
>> The problem is already known and a swap option has been introduced:
>> commit 6680884a4420 ("Input: ad7879 - add option to correct xy axis")
>>
>> However, with that the meaning of the new boolean is inverted since
>> the underlying values are already swapped. With this change, a true
>> in swap_xy actually swaps the two axis.
>>
>> Signed-off-by: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
>> ---
>> Hi Michael,
>>
>> It seems that swap_xy is not used in any board which is in mainline,
>> hence swap_xy is always false. Therefore, up until now all boards
>> actually used swapped axis. However, I doubt that the blackfin boards
>> really have those axis swapped, it is probably more likely that the
>> userspace calibration took care of it.
>>
>> However, if they are really swapped, we should set the swap_xy flag
>> to 1 for those board...
>>
>> Do you happen to now what is the case with those boards?
>>
> 
> 
> Hi Stefan,
> 
> I would be hesitant to invert the default behaviour of the driver.
> Too many people in the field already using it as it is.

Afaik, we should be able to change in-kernel API's (especially if they
are wrong) since we do not guarantee any API...

> 
> A XY swap can have multiple reasons.
> 
> Lot's of small VGA/QVGA TFTs have the option to switch the scan
> direction from Landscape to Portrait. In addition you can also rotate
> and flip or mirror using VDMA options. So it really depends on the use
> case, how the touch panel is mounted to the screen or how it is wired.

Ok, I see the reason for that functionality.

I am mainly concerned about the new DT bindings. The touchscreen binding
documents specify touchscreen-swapped-x-y, see:
https://www.kernel.org/doc/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

I would like to make sure that this property is really swapping axis
(and not necessary if the hardware is implemented according to the
datasheet...)

We could also implement a workaround to keep the platform data behavior
as is (invert the swap_xy flag)...

--
Stefan


>> --
>> Stefan
>>
>>   drivers/input/touchscreen/ad7879.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
>> index a73934b..e290e7b 100644
>> --- a/drivers/input/touchscreen/ad7879.c
>> +++ b/drivers/input/touchscreen/ad7879.c
>> @@ -94,8 +94,8 @@
>>   #define AD7879_TEMP_BIT			(1<<1)
>>
>>   enum {
>> -	AD7879_SEQ_XPOS  = 0,
>> -	AD7879_SEQ_YPOS  = 1,
>> +	AD7879_SEQ_YPOS  = 0,
>> +	AD7879_SEQ_XPOS  = 1,
>>   	AD7879_SEQ_Z1    = 2,
>>   	AD7879_SEQ_Z2    = 3,
>>   	AD7879_NR_SENSE  = 4,
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

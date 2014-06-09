From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 2/3] IIO: Add iio_chan modifier for True/Magnetic North
 HID usages
Date: Mon, 09 Jun 2014 18:52:15 +0100
Message-ID: <5395F44F.8010005@kernel.org>
References: <1401750890-31854-1-git-send-email-reyad.attiyat@gmail.com> <1401750890-31854-3-git-send-email-reyad.attiyat@gmail.com> <5395F424.4070407@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5395F424.4070407-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 09/06/14 18:51, Jonathan Cameron wrote:
> On 03/06/14 00:14, Reyad Attiyat wrote:
>> Updated iio modifier enum for compass north usages,
>> including magnetic/true north with tilt compensation.
>>
>> Signed-off-by: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> This looks fine.
gah. With the from_ prefix you suggested of course!
>> ---
>>   drivers/iio/industrialio-core.c | 4 ++++
>>   include/linux/iio/types.h       | 4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index ede16aec..2f523b5 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -84,6 +84,10 @@ static const char * const iio_modifier_names[] = {
>>       [IIO_MOD_LIGHT_RED] = "red",
>>       [IIO_MOD_LIGHT_GREEN] = "green",
>>       [IIO_MOD_LIGHT_BLUE] = "blue",
>> +    [IIO_MOD_NORTH_MAGN] = "north_magnetic",
>> +    [IIO_MOD_NORTH_TRUE] = "north_true",
>> +    [IIO_MOD_NORTH_MAGN_TILT_COMP] = "north_magnetic_tilt_comp",
>> +    [IIO_MOD_NORTH_TRUE_TILT_COMP] = "north_true_tilt_comp",
>>   };
>>
>>   /* relies on pairs of these shared then separate */
>> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
>> index 084d882..5bf8847 100644
>> --- a/include/linux/iio/types.h
>> +++ b/include/linux/iio/types.h
>> @@ -53,6 +53,10 @@ enum iio_modifier {
>>       IIO_MOD_LIGHT_RED,
>>       IIO_MOD_LIGHT_GREEN,
>>       IIO_MOD_LIGHT_BLUE,
>> +    IIO_MOD_NORTH_MAGN,
>> +    IIO_MOD_NORTH_TRUE,
>> +    IIO_MOD_NORTH_MAGN_TILT_COMP,
>> +    IIO_MOD_NORTH_TRUE_TILT_COMP
>>   };
>>
>>   enum iio_event_type {
>>
>

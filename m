From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iio: fix pressure data output unit in
 hid-sensor-attributes
Date: Sat, 3 Sep 2016 17:10:38 +0100
Message-ID: <768770a0-978a-cef3-23a8-929e63a5c414@kernel.org>
References: <1472467856-14526-1-git-send-email-hock.leong.kweh@intel.com>
 <1472586592.5025.3.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472586592.5025.3.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Kweh, Hock Leong" <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Lay, Kuan Loon" <kuan.loon.lay-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "knaack.h-Mmb7MZpHnFY@public.gmane.org" <knaack.h-Mmb7MZpHnFY@public.gmane.org>, "Ong, Boon Leong" <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org" <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "Ooi, Joyce" <joyce.ooi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Lim, Lee Booi" <lee.booi.lim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 30/08/16 20:49, Pandruvada, Srinivas wrote:
> On Mon, 2016-08-29 at 18:50 +0800, Kweh, Hock Leong wrote:
>> From: "Kweh, Hock Leong" <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>
>> According to IIO ABI definition, IIO_PRESSURE data output unit is
>> kilopascal:
>> http://lxr.free-electrons.com/source/Documentation/ABI/testing/sysfs-
>> bus-iio
>>
>> This patch fix output unit of HID pressure sensor IIO driver from
>> pascal to
>> kilopascal to follow IIO ABI definition.
>>
>> Signed-off-by: Kweh, Hock Leong <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Thanks,

Applied to the fixes-togreg branch of iio.git and marked for stable.

Jonathan
> 
>> ---
>>  .../iio/common/hid-sensors/hid-sensor-attributes.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> index e81f434..dc33c1d 100644
>> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> @@ -56,8 +56,8 @@ static struct {
>>  	{HID_USAGE_SENSOR_ALS, 0, 1, 0},
>>  	{HID_USAGE_SENSOR_ALS, HID_USAGE_SENSOR_UNITS_LUX, 1, 0},
>>  
>> -	{HID_USAGE_SENSOR_PRESSURE, 0, 100000, 0},
>> -	{HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL,
>> 1, 0},
>> +	{HID_USAGE_SENSOR_PRESSURE, 0, 100, 0},
>> +	{HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL,
>> 0, 1000},
>>  };
>>  
>>  static int pow_10(unsigned power)

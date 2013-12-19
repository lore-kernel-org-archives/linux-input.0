From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 7/9] Input: pixcir_i2c_ts: Implement Type B Multi Touch
 reporting
Date: Thu, 19 Dec 2013 11:19:33 +0530
Message-ID: <52B288ED.80904@ti.com>
References: <1387358480-8313-1-git-send-email-rogerq@ti.com> <1387358480-8313-8-git-send-email-rogerq@ti.com> <20131218141841.GE28504@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131218141841.GE28504-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, jcbian-mY6CKx1T+M6Pt1CcHtbs0g@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 12/18/2013 07:48 PM, Dmitry Torokhov wrote:
> On Wed, Dec 18, 2013 at 02:51:18PM +0530, Roger Quadros wrote:
>> Some pixcir controllers e.g. tangoC family report finger IDs with
>> the co-ordinates and are more suitable for Type-B MT protocol.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> Acked-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/input/touchscreen/pixcir_i2c_ts.c | 202 +++++++++++++++++++++++-------
>>  1 file changed, 155 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
>> index ff68246..9e14415 100644
>> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
>> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
>> @@ -23,84 +23,173 @@
>>  #include <linux/slab.h>
>>  #include <linux/i2c.h>
>>  #include <linux/input.h>
>> +#include <linux/input/mt.h>
>>  #include <linux/input/pixcir_ts.h>
>>  #include <linux/gpio.h>
>>  #include <linux/of.h>
>>  #include <linux/of_gpio.h>
>>  #include <linux/of_device.h>
>>  
>> +#define MAX_FINGERS	5	/* Maximum supported by the driver */
>> +
>>  struct pixcir_i2c_ts_data {
>>  	struct i2c_client *client;
>>  	struct input_dev *input;
>>  	const struct pixcir_ts_platform_data *pdata;
>>  	bool exiting;
>> +	u8 max_fingers;		/* Maximum supported by the chip */
>>  };
>>  
>> -static void pixcir_ts_poscheck(struct pixcir_i2c_ts_data *data)
>> +static void pixcir_ts_typea_report(struct pixcir_i2c_ts_data *tsdata)
> 
> Hmm, I do not think we should keep Type A reports if we can do Type B.
> The protocols are not new and userspace should be able to handle MT-B by
> now.
> 

It seems the controller the original driver was written for does not report
touch ID and just reports 2 touch co-ordinates. I'm not sure how this fits into
Type B reporting model.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

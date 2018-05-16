From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH v3 2/2] Input: xen-kbdfront - allow better run-time
 configuration
Date: Wed, 16 May 2018 20:47:30 +0300
Message-ID: <e9882c52-3641-7c32-1f64-dd9c4f35de5f@gmail.com>
References: <20180514144029.16019-1-andr2000@gmail.com>
 <20180514144029.16019-2-andr2000@gmail.com> <20180516171528.GD21971@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516171528.GD21971@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jgross@suse.com, lyan@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

On 05/16/2018 08:15 PM, Dmitry Torokhov wrote:
> Hi Oleksandr,
>
> On Mon, May 14, 2018 at 05:40:29PM +0300, Oleksandr Andrushchenko wrote:
>> @@ -211,93 +220,114 @@ static int xenkbd_probe(struct xenbus_device *dev,
>>   	if (!info->page)
>>   		goto error_nomem;
>>   
>> -	/* Set input abs params to match backend screen res */
>> -	abs = xenbus_read_unsigned(dev->otherend,
>> -				   XENKBD_FIELD_FEAT_ABS_POINTER, 0);
>> -	ptr_size[KPARAM_X] = xenbus_read_unsigned(dev->otherend,
>> -						  XENKBD_FIELD_WIDTH,
>> -						  ptr_size[KPARAM_X]);
>> -	ptr_size[KPARAM_Y] = xenbus_read_unsigned(dev->otherend,
>> -						  XENKBD_FIELD_HEIGHT,
>> -						  ptr_size[KPARAM_Y]);
>> -	if (abs) {
>> -		ret = xenbus_write(XBT_NIL, dev->nodename,
>> -				   XENKBD_FIELD_REQ_ABS_POINTER, "1");
>> -		if (ret) {
>> -			pr_warn("xenkbd: can't request abs-pointer\n");
>> -			abs = 0;
>> -		}
>> -	}
>> +	/*
>> +	 * The below are reverse logic, e.g. if the feature is set, then
>> +	 * do not expose the corresponding virtual device.
>> +	 */
>> +	with_kbd = !xenbus_read_unsigned(dev->nodename,
>> +					 XENKBD_FIELD_FEAT_DSBL_KEYBRD, 0);
>>   
>> -	touch = xenbus_read_unsigned(dev->nodename,
>> -				     XENKBD_FIELD_FEAT_MTOUCH, 0);
>> -	if (touch) {
>> +	with_ptr = !xenbus_read_unsigned(dev->nodename,
>> +					 XENKBD_FIELD_FEAT_DSBL_POINTER, 0);
>> +
>> +	/* Direct logic: if set, then create multi-touch device. */
>> +	with_mtouch = xenbus_read_unsigned(dev->nodename,
>> +					   XENKBD_FIELD_FEAT_MTOUCH, 0);
>> +	if (with_mtouch) {
>>   		ret = xenbus_write(XBT_NIL, dev->nodename,
>>   				   XENKBD_FIELD_REQ_MTOUCH, "1");
>>   		if (ret) {
>>   			pr_warn("xenkbd: can't request multi-touch");
>> -			touch = 0;
>> +			with_mtouch = 0;
>>   		}
>>   	}
> Does it make sense to still end up calling xenkbd_connect_backend() when
> all interfaces (keyboard, pointer, and multitouch) are disabled? Should
> we do:
>
> 	if (!(with_kbd || || with_ptr || with_mtouch))
> 		return -ENXIO;
>
> ?
It does make sense. Then we probably need to move all xenbus_read_unsigned
calls to the very beginning of the .probe, so no memory allocations are made
which will be useless if we return -ENXIO, e.g. something like

static int xenkbd_probe(struct xenbus_device *dev,
                   const struct xenbus_device_id *id)
{
     int ret, i;
     bool with_mtouch, with_kbd, with_ptr;
     struct xenkbd_info *info;
     struct input_dev *kbd, *ptr, *mtouch;

<read with_mtouch, with_kbd, with_ptr here>

if (!(with_kbd | with_ptr | with_mtouch))
         return -ENXIO;

Does the above looks ok?
> Thanks.
>
Thank you,
Oleksandr

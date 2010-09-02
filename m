From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] identify firmware version
Date: Wed, 01 Sep 2010 20:12:30 -0400
Message-ID: <4C7EEBEE.5030203@seas.upenn.edu>
References: <20100901020634.GD23585@core.coreip.homeip.net> <1283334517-15121-1-git-send-email-rafi@seas.upenn.edu> <4C7EB3A3.7050402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fox.seas.upenn.edu ([158.130.68.12]:47876 "EHLO
	fox.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab0IBAMr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Sep 2010 20:12:47 -0400
In-Reply-To: <4C7EB3A3.7050402@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, micki@n-trig.com, rydberg@euromail.se, chatty@enac.fr



On 09/01/2010 04:12 PM, Jiri Slaby wrote:
> On 09/01/2010 11:48 AM, Rafi Rubin wrote:
>> --- a/drivers/hid/hid-ntrig.c
>> +++ b/drivers/hid/hid-ntrig.c
>> @@ -90,6 +90,26 @@ struct ntrig_data {
>>   };
>>
>>
>> +/*
>> + * This function converts the 4 byte raw firmware code into
>> + * a string containing 5 comma separated numbers.
>> + */
>> +static int ntrig_version_string(unsigned char *raw, char *buf)
>> +{
>> +	__u8 a =  (raw[1]&  0b00001110)>>  1;
>> +	__u8 b =  (raw[0]&  0b00111100)>>  2;
>> +	__u8 c = ((raw[0]&  0b00000011)<<  3) | ((raw[3]&  0b11100000)>>  5);
>> +	__u8 d = ((raw[3]&  0b00000111)<<  3) | ((raw[2]&  0b11100000)>>  5);
>> +	__u8 e =   raw[2]&  0b00000111;
>
> This won't compile with gcc 3.4 which we still support. Maybe time to
> kill the support?
>
> ...

Why not?  If its the binary notation, I was just trying to show the mapping more 
visually, hex is fine with me if preferred.  If its anything aside from that, 
then I'd be afraid, there's nothing fancy here.

>> @@ -848,10 +871,39 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>   	if (report)
>>   		usbhid_submit_report(hdev, report, USB_DIR_OUT);
>>
>> +	data = kmalloc(8, GFP_KERNEL);
>> +	if (!data) {
>> +		ret = -ENOMEM;
>> +		goto err_free;
>> +	}
>> +
>> +	ret = usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0),
>> +			      USB_REQ_CLEAR_FEATURE,
>> +			      USB_TYPE_CLASS | USB_RECIP_INTERFACE |
>> +			      USB_DIR_IN,
>> +			      0x30c, 1, data, 8,
>> +			      USB_CTRL_SET_TIMEOUT);
>> +
>> +	if (ret == 8) {
>> +		buf = kmalloc(20, GFP_KERNEL);
>> +		if (!buf) {
>> +			ret = -ENOMEM;
>> +			goto err_free_data;
>> +		}
>> +
>> +		ret = ntrig_version_string(&data[2], buf);
>> +
>> +		dev_info(&hdev->dev,
>> +			 "Firmware version: %s (%02x%02x %02x%02x)\n",
>> +			 buf, data[2], data[3], data[4], data[5]);
>> +	}
>> +
>>   	ret = sysfs_create_group(&hdev->dev.kobj,
>>   			&ntrig_attribute_group);
>>
>>   	return 0;
>
> Two leaks here.

buf and data, noted and will fix.

>> +err_free_data:
>> +	kfree(data);
>>   err_free:
>>   	kfree(nd);
>>   	return ret;
>
>

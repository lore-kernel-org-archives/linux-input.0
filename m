From: "Arend van Spriel" <arend@broadcom.com>
Subject: Re: [PATCH 3/5] drivers/hid/hid-roccat.c: eliminate a null
 pointer dereference
Date: Sat, 29 Oct 2011 11:36:55 +0200
Message-ID: <4EABC937.60600@broadcom.com>
References: <1319846297-2985-3-git-send-email-julia@diku.dk>
 <20111029062412.GG14881@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:4682 "EHLO MMS3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932178Ab1J2JhN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Oct 2011 05:37:13 -0400
In-Reply-To: <20111029062412.GG14881@longonot.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Julia Lawall <julia@diku.dk>, Jiri Kosina <jkosina@suse.cz>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 10/29/2011 08:24 AM, Dan Carpenter wrote:
> On Sat, Oct 29, 2011 at 01:58:15AM +0200, Julia Lawall wrote:
>> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
>> index 2596321..36a28b8 100644
>> --- a/drivers/hid/hid-roccat.c
>> +++ b/drivers/hid/hid-roccat.c
>> @@ -163,14 +163,15 @@ static int roccat_open(struct inode *inode, struct file *file)
>>  
>>  	device = devices[minor];
>>  
>> -	mutex_lock(&device->readers_lock);
>> -
>>  	if (!device) {
>>  		pr_emerg("roccat device with minor %d doesn't exist\n", minor);
>> -		error = -ENODEV;
>> -		goto exit_err;
>> +		kfree(reader);
>> +		mutex_lock(&devices_lock);
> 
> Typo.  mutex_unlock() instead of mutex_lock().

This is no typo, but simply wrong. Remove the mutex_lock() as we are
leaving the function here in error flow.

>> +		return -ENODEV;
>>  	}
>>  
>> +	mutex_lock(&device->readers_lock);
>> +
>>  	if (!device->open++) {
>>  		/* power on device on adding first reader */
>>  		error = hid_hw_power(device->hid, PM_HINT_FULLON);
>>
> 
> regards,
> dan carpenter

Gr. AvS


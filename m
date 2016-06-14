From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] hid: migrate Dream Cheeky LED driver from USB misc to HID
Date: Tue, 14 Jun 2016 21:34:20 +0200
Message-ID: <9d2c2ae6-3340-55e4-03f5-1fc95b2517cb@gmail.com>
References: <8474eef0-3895-70db-c21a-3040417157df@gmail.com>
 <1465891515.29352.3.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33559 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbcFNTel (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2016 15:34:41 -0400
In-Reply-To: <1465891515.29352.3.camel@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>

Am 14.06.2016 um 10:05 schrieb Oliver Neukum:
> On Tue, 2016-06-14 at 07:51 +0200, Heiner Kallweit wrote:
> 
>> +	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>> +	if (ret)
>> +		return ret;
>> +
>> +	minor = ((struct hidraw *) hdev->hidraw)->minor;
>> +
>> +	ret = dc_init_device(dcdev);
> 
> That is a race condition. You announced an uninitialized device to the
> rest of the system.
> 
I don't see a race. The hdev and lock elements of dcdev are initialized
and dc_init_device just calls dc_send to send the init command to the device.
It doesn't announce anything.

>> +	if (ret)
>> +		goto err;
>> +
>> +	ret = dc_init_rgb(dcdev, minor);
>> +	if (ret)
>> +		goto err;
>> +
>> +	dev_info(&hdev->dev, "Dream Cheeky Webmail Notifier %d initialized\n", minor);
>> +
>> +	return 0;
>> +
>> +err:
>> +	hid_hw_stop(hdev);
>> +	return ret;
>> +}
> 
> 	Regards
> 		Oliver
> 
> 
> 


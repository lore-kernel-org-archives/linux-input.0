From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 08/10] HID: move apple quirks
Date: Mon, 09 Jun 2008 12:40:42 +0200
Message-ID: <484D08AA.1080300@gmail.com>
References: <1210931362-18422-1-git-send-email-jirislaby@gmail.com> <1210931362-18422-2-git-send-email-jirislaby@gmail.com> <1210931362-18422-3-git-send-email-jirislaby@gmail.com> <1210931362-18422-4-git-send-email-jirislaby@gmail.com> <1210931362-18422-5-git-send-email-jirislaby@gmail.com> <1210931362-18422-6-git-send-email-jirislaby@gmail.com> <1210931362-18422-7-git-send-email-jirislaby@gmail.com> <1210931362-18422-8-git-send-email-jirislaby@gmail.com> <Pine.LNX.4.64.0806041610240.10085@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:62553 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759284AbYFIKlt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jun 2008 06:41:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1466387fgg.17
        for <linux-input@vger.kernel.org>; Mon, 09 Jun 2008 03:41:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0806041610240.10085@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com

On 06/04/2008 04:13 PM, Jiri Kosina wrote:
> On Fri, 16 May 2008, Jiri Slaby wrote:
> 
> 
>> +static int apple_probe(struct hid_device *hdev,
>> +		const struct hid_device_id *id)
>> +{
>> +	unsigned long quirks = id->driver_data;
>> +	struct apple_sc *asc;
>> +	int ret;
>> +
>> +	/* return something else or move to hid layer? device will reside
>> +	   allocated */
>> +	if (id->bus == BUS_USB && (id->driver_data & APPLE_IGNORE_MOUSE) &&
>> +			to_usb_interface(hdev->dev.parent)->cur_altsetting->
>> +			desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_MOUSE)
>> +		return -ENODEV;
>> +
>> +	asc = kzalloc(sizeof(*asc), GFP_KERNEL);
>> +	if (asc == NULL) {
>> +		dev_err(&hdev->dev, "can't alloc apple descriptor\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	hid_set_drvdata(hdev, asc);
>> +
>> +	if (quirks & APPLE_HIDDEV)
>> +		hdev->quirks |= HID_QUIRK_HIDDEV;
>> +	if (quirks & APPLE_IGNORE_HIDINPUT)
>> +		hdev->quirks |= HID_QUIRK_IGNORE_HIDINPUT;
>> +
>> +	ret = hid_parse(hdev);
>> +	if (ret) {
>> +		dev_err(&hdev->dev, "parse failed\n");
>> +		goto err_free;
>> +	}
>> +
>> +	ret = hid_hw_start(hdev);
>> +	if (ret) {
>> +		dev_err(&hdev->dev, "hw start failed\n");
>> +		goto err_free;
>> +	}
>> +
>> +	return 0;
>> +err_free:
>> +	kfree(asc);
>> +	return ret;
>> +}
> 
> Hi Jiri,
> 
> you don't seem to set asc->quirks anywhere, but the rest of the code is 
> testing this flag. Is something like
> 
> 	asc->quirks = id->driver_data;
> 
> missing in the _probe routine?

Blah, good catch! Do you want me to post a patch, or will you fix this on your own?

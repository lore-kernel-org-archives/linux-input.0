From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 06/10] HID: move logitech report quirks
Date: Mon, 09 Jun 2008 12:33:50 +0200
Message-ID: <484D070E.9050707@gmail.com>
References: <1210931362-18422-1-git-send-email-jirislaby@gmail.com> <1210931362-18422-2-git-send-email-jirislaby@gmail.com> <1210931362-18422-3-git-send-email-jirislaby@gmail.com> <1210931362-18422-4-git-send-email-jirislaby@gmail.com> <1210931362-18422-5-git-send-email-jirislaby@gmail.com> <1210931362-18422-6-git-send-email-jirislaby@gmail.com> <Pine.LNX.4.64.0806041520140.10085@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:50688 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759307AbYFIKey (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jun 2008 06:34:54 -0400
Received: by gv-out-0910.google.com with SMTP id e6so476297gvc.37
        for <linux-input@vger.kernel.org>; Mon, 09 Jun 2008 03:34:53 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0806041520140.10085@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com

On 06/04/2008 03:21 PM, Jiri Kosina wrote:
> On Fri, 16 May 2008, Jiri Slaby wrote:
> 
>>  static const struct hid_device_id hid_blacklist[] = {
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER) },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER) },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER_2) },
>>  	{ }
>>  };
> 
> This shouldn't be needed as soon as the userspace supports the proper 
> module autoloading, right?

This is needed to tell generic drivers not to bind these, its' generic 
blacklist. I have no idea how this could be done better with current drivers/base/.

>> +#define LOGITECH_RDESC	0x1
>> +
>> +/*
>> + * Certain Logitech keyboards send in report #3 keys which are far
>> + * above the logical maximum described in descriptor. This extends
>> + * the original value of 0x28c of logical maximum to 0x104d
>> + */
>> +static void lg_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>> +		unsigned int rsize)
>> +{
>> +	if (rsize >= 90 && rdesc[83] == 0x26
>> +			&& rdesc[84] == 0x8c
>> +			&& rdesc[85] == 0x02) {
>> +		dev_info(&hdev->dev, "fixing up Logitech keyboard report "
>> +				"descriptor\n");
>> +		rdesc[84] = rdesc[89] = 0x4d;
>> +		rdesc[85] = rdesc[90] = 0x10;
>> +	}
>> +}
>> +
>> +static const struct hid_device_id lg_devices[] = {
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER),
>> +		.driver_data = LOGITECH_RDESC },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER),
>> +		.driver_data = LOGITECH_RDESC },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER_2),
>> +		.driver_data = LOGITECH_RDESC },
>> +	{ }
> 
> You set the LOGITECH_RDESC flag here, but it is then never used anywhere. 
> I guess that your original intent was to check for this flag in 
> lg_report_fixup(), right?

I assumed use of these in the second round (see my previous email) :). Anyway 
they are useless now.

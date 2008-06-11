From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 06/10] HID: move logitech report quirks
Date: Wed, 11 Jun 2008 20:35:54 +0200
Message-ID: <48501B0A.2020902@gmail.com>
References: <1210931362-18422-1-git-send-email-jirislaby@gmail.com> <484D070E.9050707@gmail.com> <Pine.LNX.4.64.0806111611540.10085@jikos.suse.cz> <200806111739.24421.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:43780 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716AbYFKShH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jun 2008 14:37:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2205762fgg.17
        for <linux-input@vger.kernel.org>; Wed, 11 Jun 2008 11:37:04 -0700 (PDT)
In-Reply-To: <200806111739.24421.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com

On 06/11/2008 05:39 PM, Oliver Neukum wrote:
> Am Mittwoch 11 Juni 2008 16:13:43 schrieb Jiri Kosina:
>> On Mon, 9 Jun 2008, Jiri Slaby wrote:
>>
>>>>> static const struct hid_device_id hid_blacklist[] = {
>>>>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>>>> USB_DEVICE_ID_MX3000_RECEIVER) },
>>>>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER)
>>>>> },
>>>>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>>>> USB_DEVICE_ID_S510_RECEIVER_2) },
>>>>>  	{ }
>>>>>  };
>>>> This shouldn't be needed as soon as the userspace supports the proper module
>>>> autoloading, right?
>>> This is needed to tell generic drivers not to bind these, its' generic
>>> blacklist. I have no idea how this could be done better with current
>>> drivers/base/.
>> Hmm ... but if we make sure that the order in `modules.order' puts all the 
>> specialized drivers before the generic one, the binding should be done 
>> correctly even without blacklist, right?
> 
> No. You might have two devices connected. The first correctly triggers
> the loading of the generic driver. The second would first load the specialised
> driver but the already loaded driver will be faster.

Hm, the problem here is, that report (supported inputs et al.) parsing needs to 
be done some time. Since some devices have reports broken too, some of their 
reports need to be fixed before parsing. So the parsing is postponed after 
*first* driver binds, then it's checked if the coming driver has report_fixup 
hook and if yes, it's executed and the device is finally parsed and set up. If 
it has not (e.g. generic), it's just parsed and set up.

If you bind the generic driver as the first driver and the particular device 
needs report fixing, it never performs the fixup. Actually what I don't know is 
how to solve this effectively.

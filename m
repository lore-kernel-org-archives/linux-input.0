From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: HID bus
Date: Tue, 22 Apr 2008 01:05:28 +0200
Message-ID: <480D1DB8.20109@gmail.com>
References: <Pine.LNX.4.64.0804181333180.12972@jikos.suse.cz> <1208644696-29129-1-git-send-email-jirislaby@gmail.com> <480B6C16.40806@gmail.com> <Pine.LNX.4.64.0804211124060.19002@twin.jikos.cz> <20080421133621.GA27646@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:13738 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbYDUXFo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 19:05:44 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1671484mue.1
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 16:05:42 -0700 (PDT)
In-Reply-To: <20080421133621.GA27646@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Anssi Hannula <anssi.hannula@gmail.com>, linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, mit-devel@lists.printk.net, linux-kernel@vger.kernel.org

On 04/21/2008 03:36 PM, Dmitry Torokhov wrote:
> On Mon, Apr 21, 2008 at 11:25:43AM +0200, Jiri Kosina wrote:
>> On Sun, 20 Apr 2008, Anssi Hannula wrote:
>>
>>> Why not just do something like
>>>
>>> #define HID_DEVICE(vend, dev) \
>>> 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE | \
>>> 		       USB_DEVICE_ID_MATCH_INT_CLASS, \
>>> 	.idVendor = (vend), \
>>> 	.idProduct = (prod), \
>>> 	.bInterfaceClass = USB_INTERFACE_CLASS_HID
>>> (see linux/usb.h)
>>>
>>> and use USB hotplugging?
>>> Or do we plan to match against something else as well, such as hid
>>> reports or something?
>> No, we plan to do matching based solely on VID/PID. The report-specific 
>> stuff is then handled between the specific driver and HID generic code.
>>
> 
> Hmm, [ab]using USB modalias makes me a bit uneasy. What about bluetooth
> HID devices?

I do agree, it won't be nice and abstract enough. Working on it, give me some 
time, please.

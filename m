From: Michael Gebetsroither <michael@mgeb.org>
Subject: Re: [PATCH] usbtouchscreen: add elo intellitouch 2700 support
Date: Tue, 08 Nov 2011 17:54:27 +0100
Message-ID: <4EB95EC3.8070205@mgeb.org>
References: <1320315318-15998-1-git-send-email-michael@mgeb.org> <1320315318-15998-2-git-send-email-michael@mgeb.org> <4EB335A1.7010809@cn.fujitsu.com> <20111105065631.GB31111@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.mgeb.org ([178.63.91.126]:56269 "EHLO mail.mgeb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901Ab1KHQya (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Nov 2011 11:54:30 -0500
In-Reply-To: <20111105065631.GB31111@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, linux-input@vger.kernel.org

On 2011-11-05 07:56, Dmitry Torokhov wrote:
> On Fri, Nov 04, 2011 at 08:45:21AM +0800, Wanlong Gao wrote:
>>>  
>>>  static struct usbtouch_device_info usbtouch_dev_info[] = {
>>> +#ifdef CONFIG_TOUCHSCREEN_USB_ELO
>>> +	[DEVTYPE_ELO] = {
>>> +		.min_xc		= 0x0,
>>> +		.max_xc		= 0x0fff,
>>> +		.min_yc		= 0x0,
>>> +		.max_yc		= 0x0fff,
>>> +		.max_press	= 0xff,
>>> +		.rept_size	= 8,
>>> +		.read_data	= elo_read_data,
>>> +	},
>>> +#endif
>>
>>
>> Maybe you can move this *dev_info* to end to be consistent with the order of *enum*?
>>
> 
> I did that locally and applied to my 3.3 queue; thanks everyone.

Thx dimitry!

Kind Regards,
Michael Gebetsroither



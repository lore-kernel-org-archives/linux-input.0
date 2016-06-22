From: ghzhong <ghzhong@yifangdigital.com>
Subject: Re: [PATCH v2] HID: i2c-hid: set power sleep before shutdown
Date: Wed, 22 Jun 2016 19:15:51 +0800
Message-ID: <576A7367.8040904@yifangdigital.com>
References: <1466504865-19907-1-git-send-email-ghzhong@yifangdigital.com>
 <alpine.LNX.2.00.1606211308590.6874@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.yifangdigital.com ([121.15.200.100]:4866 "EHLO
	yifangdigital.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751077AbcFVLYW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jun 2016 07:24:22 -0400
In-Reply-To: <alpine.LNX.2.00.1606211308590.6874@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Benson Leung <bleung@chromium.org>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org



On 06/21/2016 07:09 PM, Jiri Kosina wrote:
> On Tue, 21 Jun 2016, Guohua Zhong wrote:
>
>> Add i2c_hid_shutdown for i2c-hid driver to send suspend cmd & free
>> irq before device shutdown.
>>
>> Some HW design (i.e. Umaro, a chromebook model) is that the power to
>> i2c hid device won't down after device shutdown. Also the i2c-hid driver
>> do not send suspend cmd to the hid i2c device and free its irq before
>> shutdown.So if We touch the touchscreen or some other i2c hid device,
>> the power consumtion will be go up even when the device is in shutdown
>> state.
>>
>> Though the root cause maybe a HW issue. But it seems that it is a
>> good pratice to set power sleep for i2c-hid device before shutdown.
> Applied, thanks.
>
Do you mean that the Patch V2 has been reviewed & approved? Or I make something wrong and need  to do something else?




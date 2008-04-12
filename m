From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [PATCH] xpad - Set buffer length for outgoing requests
Date: Sat, 12 Apr 2008 09:14:28 +0300
Message-ID: <48005344.2010700@gmail.com>
References: <74d457500804080405x50098dcfi6dfe965da2a962ef@mail.gmail.com> <20080411113140.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:42012 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754016AbYDLGOg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Apr 2008 02:14:36 -0400
In-Reply-To: <20080411113140.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Gruber <lists.mg@googlemail.com>, linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> Hi Michael,
> 
> On Tue, Apr 08, 2008 at 01:05:27PM +0200, Michael Gruber wrote:
>> From: Michael Gruber <lists.mg@googlemail.com>
>>
>> The messages for led/rumble are exactly 3 and 8 bytes respectively.
>> Hence set up the transfer_buffer_length accordingly.
>>
>> Signed-off-by: Michael Gruber <lists.mg@googlemail.com>
>>
> 
> Thank you for the patch, it seems reasonable. Anssi, any objections?

Seems ok, though I'm not a urb expert.

Acked-by: Anssi Hannula <anssi.hannula@gmail.com>

>> ---
>>
>> Hi, my Xbox360 Controller will not work at all unless this is set up correctly.
>> I am new to linux kernel programming and would appreciate any kinds of comments.
>>
>>  drivers/input/joystick/xpad.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> --- a/drivers/input/joystick/xpad.c	2008-04-05 15:18:37.000000000 +0200
>> +++ b/drivers/input/joystick/xpad.c	2008-04-05 15:18:25.000000000 +0200
>> @@ -558,6 +558,7 @@ static int xpad_play_effect(struct input
>>  		xpad->odata[5] = 0x00;
>>  		xpad->odata[6] = 0x00;
>>  		xpad->odata[7] = 0x00;
>> +		xpad->irq_out->transfer_buffer_length = 8;
>>  		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
>>  	}
>>
>> @@ -594,6 +595,7 @@ static void xpad_send_led_command(struct
>>  		xpad->odata[0] = 0x01;
>>  		xpad->odata[1] = 0x03;
>>  		xpad->odata[2] = command;
>> +		xpad->irq_out->transfer_buffer_length = 3;
>>  		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
>>  		mutex_unlock(&xpad->odata_mutex);
>>  	}
> 


-- 
Anssi Hannula

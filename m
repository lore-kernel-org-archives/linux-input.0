From: Eduard Hasenleithner <eduard@hasenleithner.at>
Subject: Re: [PATCH] Wacom Intuos4 LED and OLED control
Date: Fri, 06 May 2011 18:28:47 +0200
Message-ID: <4DC421BF.9020204@hasenleithner.at>
References: <1302303254-3062-1-git-send-email-eduard@hasenleithner.at> <20110506155204.GA4754@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ftw.at ([213.235.244.131]:58898 "EHLO mail.ftw.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756618Ab1EFQnd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 May 2011 12:43:33 -0400
In-Reply-To: <20110506155204.GA4754@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry.

On 2011-05-06 17:52, Dmitry Torokhov wrote:
>> This "led" group only shows up when the correct device (M, L,
>> or XL) is detected. Four write-only attributes are created:
>> * "luminance":
>> 	array of three integers specfying
>> 	* status led brightness when no button is pressed (0..127)
>> 	* status led brightness when a button is pressed (0..127)
>> 	* brightness of the OLED display (0..15)
>
> This violates "one value per attribute" sysfs principle. I think these
> should be split into brightness on, brightness off, and display brightness.

The intention behind grouping these three together is that on the 
USB-protocol level they are always set at the same time. Furthermore, on 
the logical level they are very closely related. I have seen some other 
driver doing it like that: Writing individual settings into different 
properties, and then activating them at the same time by means of some 
"tigger" property. Would you be fine with that?

> I also wonder if status LED should be wired into LED subsystem... Not
> sure though... The tablet does not allow controlling when LEDs are
> activated, does it?

I'm not sure what you mean with "controlling". You can set the status 
LED at any time, other functions are not affected (at least as far I 
know.) But I would perfer of not putting the LED into the LED subsystem 
for several reasons:
1. It is harder from user-space to get the connection
	between LED-Device and Tablet-device
2. yet another interface to support in Kernel and User-Space, and
3. the four status LEDs are exclusive, only one of them can be
	"on" at a time.

>> * "status_select":
>> 	specifies the id (0..3) of the status led, -1 = none
>
> I think we should create 4 separate groups led0 .. led3 each containing
> the attributes above instead of implementing the selector which is
> inherently racy.

It selects the led which is "on", the others are implicitly off. So for 
the status led, there are five different settings, either 0..3, or -1 
for all LEDs to be off.  Maybe "selector" is not the best naming?

>> * "button_select":
>> 	specifies the button id (0..7) of the image
>> * "button_rawimg":
>> 	sets the raw image data of the button (binary, 1024 octets)
>
> Same here, create as many binary attributes as needed (probably putting
> into separate group).

Well "button_select" is different from "status_select". While 
status_select actually does something (change which led is on), 
button_select just pre-sets which button image will be overwritten at 
the next write.

I will change the interface to have "buttonN_rawimg" parameters, where N 
is the button number.

> Also please document these attributes in
> Documentation/ABI/testing/sysfs-wacom

I was already planning to add this to this patch, but hesitated to do it 
because the "README" tells to add the documentation when "interfaces are 
felt to be stable as the main development of this interface has been 
completed". Since we are still discussing the interface, I got the 
feeling it is not yet "stable".

Thanks for your comments,
Eduard

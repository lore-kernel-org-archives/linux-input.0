From: "Murphy, Dan" <dmurphy@ti.com>
Subject: Re: [v2] input: drv260x: Add TI drv260x haptics driver
Date: Mon, 28 Jul 2014 18:02:23 +0000
Message-ID: <00FC9A978A94B7418C33AFAE8A35ED49DAF68F@DFLE09.ent.ti.com>
References: <1406566403-1436-1-git-send-email-dmurphy@ti.com>
 <20140728174334.GD8982@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Dmitry

Thanks for the comments

On 07/28/2014 12:43 PM, Dmitry Torokhov wrote:
> Hi Dan,
> 
> On Mon, Jul 28, 2014 at 11:53:23AM -0500, Dan Murphy wrote:
>> Add the TI drv260x haptics/vibrator driver.
>> This device uses the input force feedback
>> to produce a wave form to driver an
>> ERM or LRA actuator device.
>>
>> The initial driver supports the devices
>> real time playback mode.  But the device
>> has additional wave patterns in ROM.
> 
> As it presented the device appears to be a memoryless device, however
> you present it to the rest of the system as if it can support playback
> of multiple effects simultaneously, which is incorrect.
> 
> My guess that you need to engage the memoryless input library to schedule
> handling multiple effects for your device, including ramping up, ramping
> down, stopping playback when effects runs out, etc.
> 
> Thanks.
>  
> 


I had written the driver originally to be a memless device.

But when calling the driver from user space I was not getting the duration,
strength of any information from the ff_device structure except the type.
The values in the structure were all being passed as 0's.

I will attempt it again as a memless device.

Dan

-- 
------------------
Dan Murphy

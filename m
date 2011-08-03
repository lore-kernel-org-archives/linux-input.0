From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup control
Date: Wed, 03 Aug 2011 16:12:12 +0800
Message-ID: <4E3902DC.9040006@cn.fujitsu.com>
References: <20110802154916.624619D401C@zog.reactivated.net> <20110803065920.GC23399@core.coreip.homeip.net>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:54333 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752594Ab1HCINL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Aug 2011 04:13:11 -0400
In-Reply-To: <20110803065920.GC23399@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Drake <dsd@laptop.org>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, dilinger@queued.net

On 08/03/2011 02:59 PM, Dmitry Torokhov wrote:
> Hi Daniel,
>
> On Tue, Aug 02, 2011 at 04:49:15PM +0100, Daniel Drake wrote:
>> The OLPC XO laptop is able to use the PS/2 controller as a wakeup source.
>> When used as a wakeup source, the key press/mouse motion must not be lost.
>>
>> Add infrastructure to allow controllers to be marked as wakeup-capable,
>> and avoid doing power control/reset on the i8042/serio/input devices when
>> running in this mode. For systems where this functionality is available,
>> you are expected to enable wakeups on the i8042 device, the serio
>> devices, and the relevant input devices, to ensure that the hardware is
>> left powered and untouched throughout the suspend/resume.
>>
>> Signed-off-by: Daniel Drake<dsd@laptop.org>
>> ---
>>   drivers/input/input.c                 |    6 +++-
>>   drivers/input/keyboard/atkbd.c        |    4 ++-
>>   drivers/input/mouse/hgpk.c            |    2 +
>>   drivers/input/mouse/psmouse-base.c    |    4 ++-
>>   drivers/input/serio/i8042-io.h        |    4 ++
>>   drivers/input/serio/i8042-ip22io.h    |    4 ++
>>   drivers/input/serio/i8042-jazzio.h    |    4 ++
>>   drivers/input/serio/i8042-ppcio.h     |    4 ++
>>   drivers/input/serio/i8042-snirm.h     |    4 ++
>>   drivers/input/serio/i8042-sparcio.h   |    4 ++
>>   drivers/input/serio/i8042-x86ia64io.h |    4 ++
>>   drivers/input/serio/i8042.c           |   62 +++++++++++++++++++++++++++++---
>>   drivers/input/serio/serio.c           |   29 +++++++++++++--
>>   13 files changed, 122 insertions(+), 13 deletions(-)
>>

>>   	serio->port_data	= port;
>> -	serio->dev.parent	=&i8042_platform_device->dev;
>> +	serio->dev.parent	= parent;
>> +	device_set_wakeup_capable(&serio->dev, device_can_wakeup(parent));
>>   	if (idx<  0) {
>>   		strlcpy(serio->name, "i8042 AUX port", sizeof(serio->name));
>>   		strlcpy(serio->phys, I8042_AUX_PHYS_DESC, sizeof(serio->phys));
>> @@ -1403,6 +1450,9 @@ static int __init i8042_probe(struct platform_device *dev)
>>   		i8042_dritek_enable();
>>   #endif
>>
>> +	if (i8042_enable_wakeup)
>> +		device_set_wakeup_capable(&dev->dev, true);
>> +
>
> 	device_set_wakeup_capable(&dev->dev, i8042_enable_wakeup); ?
>
Hi Daniel:
	May be you missed this comment by Dmitry?

Thanks
Best Regards
Wanlong Gao

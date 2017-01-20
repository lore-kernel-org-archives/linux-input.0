From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v3 0/3] input: pwm-beeper: add feature to set volume level
Date: Fri, 20 Jan 2017 13:11:08 -0600
Message-ID: <43679b65-8710-4255-2006-8c47dd755497@lechnology.com>
References: <0e2dec4d-7550-9495-f12a-020391183304@exceet.de>
 <cover.1484838551.git.frieder.schrempf@exceet.de>
 <20170119213700.GC13542@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:55057 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752961AbdATTLF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Jan 2017 14:11:05 -0500
In-Reply-To: <20170119213700.GC13542@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frieder Schrempf <frieder.schrempf@exceet.de>
Cc: robh@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, luis@debethencourt.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/19/2017 03:37 PM, Dmitry Torokhov wrote:
> On Thu, Jan 19, 2017 at 04:24:07PM +0100, Frieder Schrempf wrote:
>> Make the driver accept switching volume levels via sysfs.
>> This can be helpful if the beep/bell sound intensity needs
>> to be adapted to the environment of the device.
>>
>> The number of volume levels available and their values can
>> be specified via device tree (similar to pwm-backlight).
>>
>> The volume adjustment is done by changing the duty cycle of
>> the pwm signal.
>
> I wonder how this all will mesh up with beepers that have dedicated
> amplifiers (support is being added by David Lechner).

This will work very well with it. I fact, it is a feature I would like 
to have but I was not sure about a good way to implement it. Please Cc: 
me on future revisions of this series and I will be glad to test it.

One thing that would be nice would be for a more generic way to change 
the volume from userspace. Having a sysfs attribute on the platform 
device will work, but it requires very specific knowledge from any 
userspace program that wants to control the volume. Would it be possible 
to add an alsa mixer volume control or something like that?


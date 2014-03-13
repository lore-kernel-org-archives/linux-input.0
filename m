From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCH v2 7/8] HID: sony: Initialize the controller LEDs with
 the device ID value
Date: Thu, 13 Mar 2014 10:24:30 -0400
Message-ID: <5321BF9E.1020206@oh.rr.com>
References: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>	<1394145176-24174-8-git-send-email-frank.praznik@oh.rr.com> <20140310235902.e09d0855b9c848a098b7ca36@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:43592 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751061AbaCMOYd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Mar 2014 10:24:33 -0400
In-Reply-To: <20140310235902.e09d0855b9c848a098b7ca36@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>, Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, dh.herrmann@gmail.com

On 3/10/2014 18:59, Antonio Ospite wrote:
> On Thu,  6 Mar 2014 17:32:55 -0500
> Frank Praznik<frank.praznik@oh.rr.com>  wrote:
>
>> Use the device ID to initialize the Sixaxis and DualShock 4 controller LEDs to
>> default values.  The number or color of the controller is set relative to other
>> connected Sony controllers.
>>
> You already know I am not a huge fan of this idea for the sixaxis and I
> found another reason why: the Sixaxis requires the user to press the PS
> button before it starts to actually send events and the all-blink
> pattern is there to tell the user:
>    
>    "Look, even if the device is connected, it isn't fully functional yet,
>     some action is required".
>
> That's also why the BlueZ sixaxis plugin waits for events before
> actually setting the LEDs via USB.
>
> Furthermore I still seem to get the all-blink pattern even with the
> patch applied, it seems to start _after_ the kernel driver set the
> default as per your patch; do you also experience this?
> And I still need a recent BLueZ with the sixaxis plugin to use the
> controller via BT so I don't see the benefits of defaults over BT
> either, but I am obviously biased.

Yeah, without the BlueZ plugin it keeps blinking on USB unless the PS 
button is pressed almost immediately since the controller overrides the 
initial settings and a new output report isn't sent until there is a 
reason to do so (a rumble event or the LEDs changing in sysfs).  I'm not 
really sure how to fix that in the driver without some hack-ish 
workarounds that may interfere with settings made in userland.  It's 
just an unavoidable quirk of the controller and no different from the 
existing behavior in that specific case.

I can still see setting the defaults in the driver being of some use on 
the Bluetooth side since there are a lot of distros that are still using 
BlueZ 4.x which doesn't have the plugin (everything Debian based for 
instance).  You need a third party program like sixpair to do the 
initial pairing, but it's still usable.

> Just please, if you can, test your changes in conjunction with the
> BlueZ sixaxis plugin in order to make sure the two don't step on each
> other toes too much.

I've tested it against the BlueZ plugin and there are no conflicts that 
I've experienced.  Like I've said before, the LEDs are only set to 
defaults during initialization and then never touched by the driver once 
the device is exposed to the system so the driver will never "step on 
the toes" of userland settings.  The driver has actually been setting 
the LEDs to default values since someone else added the LED controls for 
the Sixaxis in 3.14 and it doesn't seem to cause any problems.  The only 
difference this patch makes is that the LEDs are set to some meaningful 
default instead of "all-off".

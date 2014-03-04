From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH 0/6] HID: sony: More Sony controller fixes and improvements.
Date: Tue, 04 Mar 2014 09:54:30 -0500
Message-ID: <5315E926.6@gmail.com>
References: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>	<20140301145346.d1b3305ba0b186d452a34beb@ao2.it>	<53135BA6.9090501@oh.rr.com> <20140304133426.ea711f53198ec62894a630de@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:58896 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188AbaCDOyh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Mar 2014 09:54:37 -0500
Received: by mail-ie0-f172.google.com with SMTP id as1so7197934iec.17
        for <linux-input@vger.kernel.org>; Tue, 04 Mar 2014 06:54:37 -0800 (PST)
In-Reply-To: <20140304133426.ea711f53198ec62894a630de@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>, Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, dh.herrmann@gmail.com

On 3/4/2014 07:34, Antonio Ospite wrote:
> This can be done in the driver. See
> https://www.mail-archive.com/linux-input@vger.kernel.org/msg08103.html
>
>
> xpad is a joystick driver, while hid-sony is a HID driver.
I tried it and the hack works from HID space with some tweaking, but, 
yeah, it's a hack and doesn't belong in *any* driver.
> Let me answer the last question first, the rationale was:
>
>   1. the common use case for the sixaxis is considered to be its use
>      via Bluetooth, can we agree on that?
>   2. under this assumption BlueZ was chosen as a convenient place to do
>      the pairing and association.
>   3. Paring requires to access the device via USB in order to retrieve
>      its bdaddr and set the master bdaddr.
>   4. Once we are accessing the device via USB and BT in the BlueZ plugin
>      anyway, just let's set the LEDs here.
>
> A more general "excuse" is that clutter in userspace is slightly more
> acceptable than clutter in kernel code.
>
> And to reply to the other questions, yes, the bluez plugin is not
> perfect by any means: it enforces dependencies, it's not using the leds
> class yet, but it can be improved and IMHO it's still the most
> convenient way to have responsibilities separated: the kernel driver
> provides access to the hardware functionality and the userspace
> software decides what to do with them.
>
> However, since you are the one currently working on things you are
> entitled with a stronger voice here, I am just whispering my opinions :)
>
> Ciao,
>     Antonio
>
I understand your rationale, but I still think that the driver should 
assign sane defaults for cases where there isn't userspace software to 
set the LEDs.  Leaving the Sixaxis LEDs blinking doesn't differentiate 
between whether or not the controller is connected or trying to connect 
and on the Dualshock 4 the default is a bright-white battery draining 
light.  On the other hand, the current default of 'all-off', which has 
been the default since the initial LED patch, doesn't indicate whether 
the controller connected successfully or timed-out when using Bluetooth.

I currently have David's suggestion of assigning an id via an IDA 
allocator implemented in my working copy.  This can be used to both 
initialize the LEDs relative to other Sony controllers and provide a 
sane unique identifier for the battery identification string instead of 
the constantly incrementing atomic integer used now.  This is the most 
ideal solution IMO since it clearly communicates the current power and 
connection status of the controller, lets the user easily differentiate 
between controllers 1, 2, etc... and it provides defaults that most 
users shouldn't find annoying.  Of course, these are just defaults so if 
you want to use a BlueZ plugin or something else to set the values via 
userspace, there is nothing stopping you.

I'm going wait on v2 of this series until Benjamin Tissoires finishes 
his latest patches since I think patch #2 and beyond will conflict with 
his work.  Patch #1 is just a trivial one-line fix though, so that 
should still be good to go.

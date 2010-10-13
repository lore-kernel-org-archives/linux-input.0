From: Alan Ott <alan@signal11.us>
Subject: Re: [RFC, PATCH 0/2] Enable setting leds via hidraw on Sixaxis
Date: Wed, 13 Oct 2010 18:15:05 -0400
Message-ID: <4CB62F69.1070809@signal11.us>
References: <4CA9DD89.2010106@signal11.us> <1287003458-3791-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:45164 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab0JMWPG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 18:15:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 6FE591CCAAAC
	for <linux-input@vger.kernel.org>; Wed, 13 Oct 2010 18:15:04 -0400 (EDT)
In-Reply-To: <1287003458-3791-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, =?ISO-8859-1?Q?Mikko_Virkkil=E4?= <mvirkkil@cc.hut.fi>, falktx@gmail.com

On 10/13/2010 04:57 PM, Antonio Ospite wrote:
> Hi,
>
> this series adds a new quirk to force output reports to be sent over the
> control endpoint rather than the interrupt ep, this is needed on our
> "beloved" Sixaxis controller in order to set leds via hidraw, sending
> the output report on the interrupt endpoint does not have any effect
> whatsoever.
>
> This is just an RFC for now, the quirk name can be improved, and I have
> to make clear in the code and in the commit messages if this is for
> hidraw only, but you can get the idea already.
>
> Thanks,
>     Antonio
>
>
> Antonio Ospite (2):
>    HID: usbhid, new quirk to force out reports on the control ep
>    HID: hid-sony, use HID_QUIRK_FORCE_OUT_CONTROL_EP for Sixaxis
>
>   include/linux/hid.h           |    1 +
>   drivers/hid/hid-sony.c        |    4 +++-
>   drivers/hid/usbhid/hid-core.c |    3 ++-
>   3 files changed, 6 insertions(+), 2 deletions(-)
>
>
>    

Hi Antonio,

If it were me, I'd just call usb_control_msg() from inside your driver 
(hid-sony) instead of calling usbhid_output_report(). What's wrong with 
doing that?

Alan.



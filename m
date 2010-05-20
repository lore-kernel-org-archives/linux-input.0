From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH][RFC] input: Add KEY_MIC_MUTE
Date: Thu, 20 May 2010 12:17:23 -0500
Message-ID: <1274375843.25409.16.camel@laptop>
References: <1274374228.24413.150.camel@laptop>
	 <1274374800.27274.3795.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:54881 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab0ETRR3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 13:17:29 -0400
In-Reply-To: <1274374800.27274.3795.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

On Thu, 2010-05-20 at 18:00 +0100, Bastien Nocera wrote:
> On Thu, 2010-05-20 at 11:50 -0500, Jerone Young wrote:
> > Today Lenovo Thinkpads are coming with a new key for muting the
> > microphone. They started this with the T400s & it is now on T410(s)/510,
> > W510/W710, L412/512, X100e, Edge 13/14/15 Thinkpads. Currently 12
> > models, with more coming in the foreseeable future.
> 
> There's a "Microphone" usage name listed in the HID Usage Tables (under
> Consumer Page) which would probably do fine.

Thanks for the pointer.  HID Usage Table seems like it would be in line
to what I'm trying to do. Though still doesn't define a set keycode
anywhere (this would actually be great to line this up to a standard).

> 
> Do this button toggle the mute status?

Yes it's a toggle for microphone (though done all in software) .. so no
hardware controls going on here. Right now on these Thinkpads sends an
acpi event, we can remap that to a standard key code once it is defined
(done in module thinkpad-acpi).

I also failed to mention before that there is also Thinkpad USB keyboard
as well with the key:
http://www.thinkpads.com/wp-content/gallery/thinkpad-usb-keyboard/lenovo_thinkpad_usb_ultranav_keyboard-top.jpg
It sends a keycode..though that can be remmapped in udev to whatever
ends up getting defined.

			Thanks,
				Jerone

> 
> Cheers
> 



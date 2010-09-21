From: Philipp Merkel <mail@philmerk.de>
Subject: Re: [PATCH] Fix for problems with eGalax/DWAV multi-touch-screen
Date: Tue, 21 Sep 2010 10:20:15 +0200
Message-ID: <1285057215.1567.28.camel@PhEeeTab>
References: <1284476919.3732.10.camel@PhEeeTab>
	 <DAB0AEF8-B5D1-4D21-83E2-6535B8AA0A4B@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.planet-school.de ([194.116.187.5]:33010 "EHLO
	turboconrad.planet-school.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755801Ab0IUIU1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 04:20:27 -0400
In-Reply-To: <DAB0AEF8-B5D1-4D21-83E2-6535B8AA0A4B@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

> > 1) While there is a dedicated multitouch driver for the screen
> >    (hid-egalax.c), the MULTI_INPUT quirk is also applied, preventing
> >    the hid-egalax driver from working. This patch removes the quirk
> >    so the hid-egalax driver can handle the device correctly.
> 
> No opinion here, I'm not comfortable with MULTI_INPUT and multitouch  
> (too much variability from one device to another).
I can only tell you what I experienced: Before the hid_egalax driver,
one had to use the MULTI_INPUT quirk in order to make the device work as
a single-touch screen, otherwise the coordinates were sent for the wrong
axes. But now with hid_egalax handling the device, the MULTI_INPUT quirk
is of no use any more for this device and instead seems to prevent
hid_egalax from working (it's loaded, but doesn't seem to handle the
device as no multitouch events are sent). So it's a leftover from before
hid_egalax and can safely be removed.

> > 2) The x and y coordinates sent by the screen in multi-touch mode are
> >    shifted by three bits from the events sent in single-touch mode,  
> > thus
> >    the coordinates are out of range, leading to the pointer being  
> > stuck
> >    in the bottom-right corner if no additional calibration is applied
> >    (e.g. in the X evdev driver). This patch shifts the coordinates  
> > back.
> >    This does not decrease accuracy as the last three bits of the  
> > "wrong"
> >    coordinates are always 0.
> 
> Mmm. This would be a bug in the firmware? I'll notify the eGalax  
> folks. Anyway, if there's a bug we must fix it. But the driver was  
> (probably too quickly) registered for another eGalax product with a  
> different protocol: 0x0eef:0x720c (the one in the Joojoo). Can  
> someone check if the fix applies to this product as well? Otherwise  
> we'll have to devise a solution.
I don't have a Joojoo, but as its touch screen seems to be quite
different, it's probably necessary to distinguish the devices in the
driver anyway. At least from what I know from other T101MT users, all
screens with the id 0x0eef:0x480d seem to suffer from this problem.

Another possibility would maybe be the following: If the coordinates of
the first touch after loading the driver are within the range, the
device is set to "Normal" mode and all coordinates are passed as they
are. If the first touch is out of range, the device is set to "Quirks"
mode and all coordinates are shifted by three bits. This way, the driver
would continue working even if the bug in the firmware was corrected for
new devices with the same ID. It would be no problem to adapt my patch
this way.

For me, the values are as follows: In the HID descriptor, a range of
0-4095 is given for the X and Y axes. So the only situation in which the
above solution would not switch the mode correctly would be if the first
touch after loading the driver would be in the very top-left corner,
with an X and Y coordinate between 0 and 4, as in this case it would be
reported as <=4000 and thus not registered as being out of range. This
is very unlikely as at least for my screen, one has to press the stylus
with force into the corner in order to get such coordinates, which
probably no user will do just after turning on his machine...

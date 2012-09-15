From: Daniel Nicoletti <dantti12@gmail.com>
Subject: HID battery strength does not emit power_suppy udev events
Date: Fri, 14 Sep 2012 23:30:17 -0300
Message-ID: <CACo8zOe7MFp_O_2rQhkSPc_+LaSUBxHvsQwSY38ukKRioDHusA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64396 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755152Ab2IOCaV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 22:30:21 -0400
Received: by vbbff1 with SMTP id ff1so1259759vbb.19
        for <linux-input@vger.kernel.org>; Fri, 14 Sep 2012 19:30:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Richard Hughes <richard@hughsie.com>

Hi,
it's been a while that my patch to probe the battery
strength of HID devices got upstream, though the probe
is working quite well, upower wasn't, it only worked well
if the device was there before upower starts.
So when adding/removing the device upower didn't update,
and of course I thought the fault was on upower, since on
cold plug it worked...

Well today I decided to add udev support to one of my applications
and decided to see what actually happens on the add/remove
case of my mouse. You can find the whole output
(removing, empty space, then adding) here http://fpaste.org/Uvbh/

So in short there is no udev event being emitted for the power_supply
path, which means upower will never be notified, but when starting
and scanning the udev devices it will find.

But I'm don't know exactly what to do differently since the power_supply
code seems quite right, does anyone has any hints on where to start?

BTW: why HID has to be built-in for this feature to be available (no I didn't
write that part :P )

Best,

-- 
Daniel Nicoletti

KDE Developer - http://dantti.wordpress.com

From: Ben Hardill <b.hardill@gmail.com>
Subject: RE: [PATCH] HID: driver for BTC "Emprex 3009URF III Vista MCE Remote"
 quirky remote
Date: Sat, 27 Feb 2010 11:32:21 +0000
Message-ID: <4B8902C5.5000508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:38130 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966166Ab0B0LcY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Feb 2010 06:32:24 -0500
Received: by ewy20 with SMTP id 20so504071ewy.21
        for <linux-input@vger.kernel.org>; Sat, 27 Feb 2010 03:32:23 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz
Cc: Wayne Thomas <waynethomas69@gmail.com>

> > are using this usage page as standard.  I was going to fiddle
> > around with this but instead will wait to see how this will be
> > implemented in udev. Sorry I couldn't relieve some of your
> > work-load.
>
>  udev keymaps are described in README.keymap.txt in udev package. You
>  can find current version on
> 
http://git.kernel.org/?p=linux/hotplug/udev.git;a=blob;f=extras/keymap/README.keymap.txt;h=9c2d5dc16a151d57720b1dfe39e784f1b1d47367;hb=HEAD
>
>
>
Thanks,

Jiri,

I've tried to follow the instructions in the README.keymap but when I 
run /lib/udev/keymap -i input/eventX against both of the event devices I 
get nothing out, not even the "unknown" message mentioned in the doc.

I'm not totally up to speed with this yet, but I think i may be down to 
the "e0x0ffbc0000 HID usage page" that Wayne mentioned earlier not being 
read by the input layer and passed to the udev layer. If this is the 
case then before udev can be used to make hardware like this work the 
input layer will need to add support for this page.

Thanks,

Ben


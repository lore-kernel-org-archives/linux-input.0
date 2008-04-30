From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: support for Logitech Wave
Date: Wed, 30 Apr 2008 11:21:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804301119050.7756@jikos.suse.cz>
References: <200804250012.19227.linux-user@kmilburn.me.uk>
 <Pine.LNX.4.64.0804280851580.7756@jikos.suse.cz> <200804281131.06389.linux-user@kmilburn.me.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:48444 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757028AbYD3JVS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Apr 2008 05:21:18 -0400
In-Reply-To: <200804281131.06389.linux-user@kmilburn.me.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Milburn <linux-user@kmilburn.me.uk>
Cc: linux-input@vger.kernel.org

On Mon, 28 Apr 2008, Kevin Milburn wrote:

> > If so, then that's the very same receiver that Logitech ships with 
> > S510 keyboards, so we'll have to put this extra mappings into the 
> > quirk_logitech_wireless() function.
> Yes, the device is reported as vendor ID 0x046d and product ID 0xc517r

OK, so I will add the new mapping into quirk_logitech_wireless() and will 
send you a patch to test.

> > Could you please be more specific here? Those keys for which there is 
> > some 'evbug' output should definitely also appear in evtest output (if 
> > X driver will then receive the code or not is a different story).
> Evtest is connecting to the device correctly and reports keypess 
> information for the standard keys, but nothing is output when one of the 
> extra keys is pressed..
[ ... ]
> Apr 28 10:47:31 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input0, 
> Type: 4, Code: 4, Value: 458796
> Apr 28 10:47:31 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input0, 
> Type: 1, Code: 57, Value: 1
> Apr 28 10:47:31 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input0, 
> Type: 0, Code: 0, Value: 0
> Apr 28 10:47:31 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input0, 
> Type: 4, Code: 4, Value: 458796
> Apr 28 10:47:31 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input0, 
> Type: 1, Code: 57, Value: 0
> Apr 28 10:47:31 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input0, 
> Type: 0, Code: 0, Value: 0
> Apr 28 10:48:09 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input1, 
> Type: 4, Code: 4, Value: 786613
> Apr 28 10:48:09 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input1, 
> Type: 1, Code: 163, Value: 1
> Apr 28 10:48:09 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input1, 
> Type: 0, Code: 0, Value: 0
> Apr 28 10:48:09 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input1, 
> Type: 4, Code: 4, Value: 786613
> Apr 28 10:48:09 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input1, 
> Type: 1, Code: 163, Value: 0
> Apr 28 10:48:09 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input1, 
> Type: 0, Code: 0, Value: 0

The keyboard probably has two separate interfaces, with some multimedia 
keys being reported on a different one. That's why you see them in evbug 
output, but not in evtest output, because they appear under different 
event device.

-- 
Jiri Kosina
SUSE Labs

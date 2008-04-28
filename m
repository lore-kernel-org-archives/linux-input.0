From: Kevin Milburn <linux-user@kmilburn.me.uk>
Subject: Fwd: Re: support for Logitech Wave
Date: Mon, 28 Apr 2008 19:37:52 +0100
Message-ID: <200804281937.52943.linux-user@kmilburn.me.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ptb-relay01.plus.net ([212.159.14.212]:45392 "EHLO
	ptb-relay01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932531AbYD1SiA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Apr 2008 14:38:00 -0400
Received: from [84.92.13.49] (helo=ganges)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1JqYEc-0007Im-5I
	for linux-input@vger.kernel.org; Mon, 28 Apr 2008 19:37:54 +0100
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi Jiri 

On Monday 28 April 2008 07:59:22 you wrote:

> is the device in question vendor ID 0x046d and product ID 0xc517? (you can
> find out using lsusb, for example).
>
> If so, then that's the very same receiver that Logitech ships with S510
> keyboards, so we'll have to put this extra mappings into the
> quirk_logitech_wireless() function.
>

Yes,  the device is reported as vendor ID 0x046d and product ID 0xc517r

evtest output : 
Input driver version is 1.0.0
Input device ID: bus 0x3 vendor 0x46d product 0xc517 version 0x110
Input device name: "Logitech USB Receiver"

> > I've tested the keyboard with evtest, and none of the extra keys are
> > recognized, and no information reported when they are pressed
>
> Could you please be more specific here? Those keys for which there is some
> 'evbug' output should definitely also appear in evtest output (if X driver
> will then receive the code or not is a different story).

Evtest is connecting to the device correctly and reports keypess information 
for the standard keys,  but nothing is output when one of the extra keys is 
pressed..  

pressing the spacebar produces
Event: time 1209376051.548896, type 4 (Misc), code 4 (ScanCode), value 7002c
Event: time 1209376051.548916, type 1 (Key), code 57 (Space), value 1
Event: time 1209376051.548920, -------------- Report Sync ------------
 Event: time 1209376051.604889, type 4 (Misc), code 4 (ScanCode), value 7002c
Event: time 1209376051.604907, type 1 (Key), code 57 (Space), value 0
Event: time 1209376051.604912, -------------- Report Sync ------------

while pressing the 'next track' key evtest does not produce any output,   but 
my music changes as X did pickup the keypress through its kdb driver.

However,  both keypresses were reported by evbug.

Apr 28 10:47:31 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input0, 
Type: 4, Code: 4, Value: 458796
Apr 28 10:47:31 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input0, 
Type: 1, Code: 57, Value: 1
Apr 28 10:47:31 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input0, 
Type: 0, Code: 0, Value: 0
Apr 28 10:47:31 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input0, 
Type: 4, Code: 4, Value: 458796
Apr 28 10:47:31 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input0, 
Type: 1, Code: 57, Value: 0
Apr 28 10:47:31 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input0, 
Type: 0, Code: 0, Value: 0
Apr 28 10:48:09 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input1, 
Type: 4, Code: 4, Value: 786613
Apr 28 10:48:09 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input1, 
Type: 1, Code: 163, Value: 1
Apr 28 10:48:09 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input1, 
Type: 0, Code: 0, Value: 0
Apr 28 10:48:09 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input1, 
Type: 4, Code: 4, Value: 786613
Apr 28 10:48:09 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input1, 
Type: 1, Code: 163, Value: 0
Apr 28 10:48:09 ganges kernel: evbug.c: Event. Dev: usb-0000:00:02.0-7/input1, 
Type: 0, Code: 0, Value: 0

There is no change in behaviour if I run evtest from a terminal in X,  or from 
the console without X running.

>
> > I've attached a copy of information from a debug session of the HID, and
> > information from evbug.  It also indicates which keys work (depending on
> > layout).
>
> Thanks, this is all the information that will be needed for establishing
> proper mappings for non-working keys, but I'd like to understand first
> whether there are keys that appear in evbug output, but there is no event
> happening on evdev (as seen by evtest).

I'm definitely seeing results from evbug which are not showing up in evtest..  

Could it be caused by an out of date evtest package?  If I can figure out 
where it came from,  I'll try a new version to see if it helps..

>
> A few remarks from quick look at the output:
>
> - what are the "Vista Flip" and "Vista Gadget" keys supposed to do?
> - the keys that are labelled "works depending on layout" -- what exactly
>   does that mean? Is there still output from hid-debug, no matter the
>   layout?

The 'Vista Flip'  key is used within vista to access the 3d view of the 
available windows.  The 'Application Switcher' and other plugins within 
compiz  offers similar behaviour.

The 'Vista Gadet' key has something to do with Vista's gadget sidebar..  I 
think it allows selection of the desired gadgets to appear on the desktop..

The 'works depending on layout' is related to using the keys within X windows,  
and is related to the xkbd layout used.  for example,  the layout for the 
Logitech LX-300 gets all the media keys right, but a few of the other keys 
are wrong,  and most are non responsive.   

I realise this is outside the scope of the kernel,  but I thought it might be 
usefull information to know which keys seem to do something even if the 
interpretation was wrong..

Kevin.

-------------------------------------------------------

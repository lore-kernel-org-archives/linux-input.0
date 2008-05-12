From: Annick et Jean-Philippe <jpmeuret@free.fr>
Subject: Re: G25 + Linux
Date: Mon, 12 May 2008 18:30:14 +0200
Message-ID: <48287096.7070105@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-g19.free.fr ([212.27.42.36]:58399 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbYELQaU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 May 2008 12:30:20 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 8A0755FD6B
	for <linux-input@vger.kernel.org>; Mon, 12 May 2008 18:30:18 +0200 (CEST)
Received: from [62.147.58.26] (c5850-a2-3-62-147-58-26.dial.proxad.net [62.147.58.26])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 5AAD25FE54
	for <linux-input@vger.kernel.org>; Mon, 12 May 2008 18:30:17 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi, all.

For the happy owners of a Logitech G25 wheel that did not manage yet
to enjoy the full features of the beast under Linux, this is a small
summary of what I found on the net and my own humble experience about it
on a 2.6.22.9 Kernel (Mandriva 2008.0 x86_64) :

Note: This is only my own understanding and summarizing of what people cleverer
       than me discovered by themselves. My work only consisted to put
       all the stuff together in an as clear, simple and explict as possible
       sum-up. See at the bottom for references and real authors.

1) when plugged in, the G25 identies itself as a Logitech Formula Force EX
    USB device (046d:c294) ; you only get 4 axes and 12 buttons, that is
    neither clutch pedal nor any of the 3trd to 6th gear on the grid shifter
2) to get the lacking native features of the beast, it must be sent a command
    to switch to its native mode, that makes it disconnect and reconnect
    as itself this time (USB device ids 046d:c299)
    Note: Another similar command can also switch it to the Logitech Driving
          Force Pro mode.
3) to send the command, you need a userland tool that basically writes
    the associated bytes on the USB device, and the one I am using is
    usbtool <ftp://srv.l14.ru/pub/usbtool-0.1.tar.gz>
    (the package includes pre-built binaries for python 2.5,
     and sources if you need to build it yourself) ;

    to swhitch the G25 to its native mode, after plugging it in, I simply use :
      ./usbtool -v g25-set-extended-mode

    Note: you can also send other pre-configured commands with the usbtool
          (run ./usbtool --list-commands to see which)
          like g25-set-range-wheel-900 (teasing ;-)
    BUT: I never succeeded to send 2 successive commands to the device :
         the first one is generally OK (sometimes, though, you may need to repeat
         it), but the second (and following ones) seems to be completely ignored.

4) but this makes disappear the /dev/jsX and /dev/input/eventY devices !
    to get them back and be able to play with the G25, I use :
      sudo rmmod joydev
      sudo rmmod usbhid
      sudo modprobe usbhid
    (man sudo and sudoers to be able to run these root commands)

5) Then, if you find that the "dead zone" at the center of the wheel
    is too large (the centered angle where nothing happens when you steer into),
    it is only beacause you need to calibrate your device.
    I use jscal (ff-utils @ http://www.sourceforge.net/projects/libff)
    to do that :
    a) plug-in the device
    b) send the native mode-switch command if you like (see above 3)
    c) jscal -c /dev/jsX (X being 0, 1, ... look which in /dev after plugging-in)
    d) jstest /dev/jsX (to test if everything fits your desire)
    e) jscal -p /dev/jsX (to get the jscal command to put in your .bashrc
       or any script you would run before your favorite games ...)

Note: All this stuff should also work for a Driving Force Pro, and some says
       that it's also true for the Momo Racing wheels ... but don't tested.

Now, as far as force feedback is concerned, I have no such good news
for the moment : fftest and ffcstress don't work for me for the moment.

References:

Thanks to avl, eckzow, anrp, thelusiv, tof8pool, synapse247 and cuckoo,
  on http://vdrift.net forum :
   http://vdrift.net/Forum/viewtopic.php?t=412&postdays=0&postorder=asc&start=60
   http://vdrift.net/Forum/viewtopic.php?p=3751&highlight=linuxinput#3751
   ftp://srv.l14.ru/pub/usbtool-0.1.tar.gz

Thanks to Jiri Kosina, Chris Guirl,
  from the Linux input dev team
   http://www.mail-archive.com/linux-input@atrey.karlin.mff.cuni.cz
   http://www.mail-archive.com/linux-input@vger.kernel.org
(search "g25" on each list)

Hoping this helps ...

Jean-Philippe.


From: "Richie Ward" <richies@gmail.com>
Subject: G25 + Linux
Date: Tue, 27 May 2008 07:20:42 +0100
Message-ID: <6b33c0ac0805262320g38b2cb40h5dc6ab3b7c77230e@mail.gmail.com>
References: <48287096.7070105@free.fr>
	 <d43da00b0805122015v9793aafj96bdcb9e5cb68d1c@mail.gmail.com>
	 <6b33c0ac0805262319y423b20b3u11cb61b72638d6a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:8533 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757201AbYE0GUr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 May 2008 02:20:47 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1607345tic.23
        for <linux-input@vger.kernel.org>; Mon, 26 May 2008 23:20:45 -0700 (PDT)
In-Reply-To: <6b33c0ac0805262319y423b20b3u11cb61b72638d6a2@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Don't expect help from Logitech unless an employee is a friend there.
Maybe someone can reverse engineer windows drivers or sniff the usb.

I have usbtool mirrored on my site:
http://richieward.com/files/usbtool-0.1-compiled.tar.gz
People should make more mirrors.

I made some of that into a bash script (run script as root):
#!/bin/bash
./usbtool g25-set-extended-mode
sleep 1
./usbtool g25-set-range-wheel-900
sleep 1
rmmod joydev
sleep 1
rmmod usbhid
sleep 1
modprobe usbhid

some ff attempts:
richie@richie-desktop:~/Downloads/ff-utils$ sudo ./ffcfstress -d /dev/input/js0
ERROR: can not get key bits (Invalid argument) [ffcfstress.c:118]

richie@richie-desktop:~/Downloads/ff-utils$ sudo ./ffcfstress -d
/dev/input/by-id/usb-046d_G25_Racing_Wheel-event-joystick
ERROR: device (or driver) has no force feedback support [ffcfstress.c:165]

richie@richie-desktop:~/Downloads/ff-utils$ sudo ./ffcfstress -d
/dev/input/by-id/usb-046d_G25_Racing_Wheel-joystick
ERROR: can not get key bits (Invalid argument) [ffcfstress.c:118]

On Tue, May 13, 2008 at 4:15 AM, D. Ragno <homerj@icculus.org> wrote:
> I never did get all of this to work with a MOMO Racing (black) wheel.
> The wheel by itself was ok, however i had combined not separate axis
> for the pedals and no FF.
>
> I'd like do some further investigation on the why, I only really
> started to look into it, when rFactor and GTR2 started to work in
> wine. I think this wheel is acting similar to the G25, starting in a
> compatibility mode, and needed commands to set it to native. I'm not
> sure if the hardware itself is a single axis for the pedals, with some
> separation done in the driver to report two separate ones. I've seen a
> patch for a 2.4 kernel to this effect.
>
> If there's some serious work going into better support of the Logitech
> loops, I'd like to keep in the loop and contribute. Jean-Philippe
> probably has the best overall explanation of it all, as when I was
> looking for information, it was sparse at best and conflicting at
> worst. Is there someone at Logitech that could offer up some actual
> documentation?
>
> 2008/5/12 Annick et Jean-Philippe <jpmeuret@free.fr>:
>> Hi, all.
>>
>> For the happy owners of a Logitech G25 wheel that did not manage yet
>> to enjoy the full features of the beast under Linux, this is a small
>> summary of what I found on the net and my own humble experience about it
>> on a 2.6.22.9 Kernel (Mandriva 2008.0 x86_64) :
>>
>> Note: This is only my own understanding and summarizing of what people cleverer
>>      than me discovered by themselves. My work only consisted to put
>>      all the stuff together in an as clear, simple and explict as possible
>>      sum-up. See at the bottom for references and real authors.
>>
>> 1) when plugged in, the G25 identies itself as a Logitech Formula Force EX
>>   USB device (046d:c294) ; you only get 4 axes and 12 buttons, that is
>>   neither clutch pedal nor any of the 3trd to 6th gear on the grid shifter
>> 2) to get the lacking native features of the beast, it must be sent a command
>>   to switch to its native mode, that makes it disconnect and reconnect
>>   as itself this time (USB device ids 046d:c299)
>>   Note: Another similar command can also switch it to the Logitech Driving
>>         Force Pro mode.
>> 3) to send the command, you need a userland tool that basically writes
>>   the associated bytes on the USB device, and the one I am using is
>>   usbtool <ftp://srv.l14.ru/pub/usbtool-0.1.tar.gz>
>>   (the package includes pre-built binaries for python 2.5,
>>    and sources if you need to build it yourself) ;
>>
>>   to swhitch the G25 to its native mode, after plugging it in, I simply use :
>>     ./usbtool -v g25-set-extended-mode
>>
>>   Note: you can also send other pre-configured commands with the usbtool
>>         (run ./usbtool --list-commands to see which)
>>         like g25-set-range-wheel-900 (teasing ;-)
>>   BUT: I never succeeded to send 2 successive commands to the device :
>>        the first one is generally OK (sometimes, though, you may need to repeat
>>        it), but the second (and following ones) seems to be completely ignored.
>>
>> 4) but this makes disappear the /dev/jsX and /dev/input/eventY devices !
>>   to get them back and be able to play with the G25, I use :
>>     sudo rmmod joydev
>>     sudo rmmod usbhid
>>     sudo modprobe usbhid
>>   (man sudo and sudoers to be able to run these root commands)
>>
>> 5) Then, if you find that the "dead zone" at the center of the wheel
>>   is too large (the centered angle where nothing happens when you steer into),
>>   it is only beacause you need to calibrate your device.
>>   I use jscal (ff-utils @ http://www.sourceforge.net/projects/libff)
>>   to do that :
>>   a) plug-in the device
>>   b) send the native mode-switch command if you like (see above 3)
>>   c) jscal -c /dev/jsX (X being 0, 1, ... look which in /dev after plugging-in)
>>   d) jstest /dev/jsX (to test if everything fits your desire)
>>   e) jscal -p /dev/jsX (to get the jscal command to put in your .bashrc
>>      or any script you would run before your favorite games ...)
>>
>> Note: All this stuff should also work for a Driving Force Pro, and some says
>>      that it's also true for the Momo Racing wheels ... but don't tested.
>>
>> Now, as far as force feedback is concerned, I have no such good news
>> for the moment : fftest and ffcstress don't work for me for the moment.
>>
>> References:
>>
>> Thanks to avl, eckzow, anrp, thelusiv, tof8pool, synapse247 and cuckoo,
>>  on http://vdrift.net forum :
>>  http://vdrift.net/Forum/viewtopic.php?t=412&postdays=0&postorder=asc&start=60
>>  http://vdrift.net/Forum/viewtopic.php?p=3751&highlight=linuxinput#3751
>>  ftp://srv.l14.ru/pub/usbtool-0.1.tar.gz
>>
>> Thanks to Jiri Kosina, Chris Guirl,
>>  from the Linux input dev team
>>  http://www.mail-archive.com/linux-input@atrey.karlin.mff.cuni.cz
>>  http://www.mail-archive.com/linux-input@vger.kernel.org
>> (search "g25" on each list)
>>
>> Hoping this helps ...
>>
>> Jean-Philippe.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--
Thanks, Richie Ward

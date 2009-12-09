From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] HID: add multi-input quirk for NextWindow Touchscreen.
Date: Wed, 09 Dec 2009 10:42:45 +0100
Message-ID: <87hbs0mqju.fsf@macbook.be.48ers.dk>
References: <20091203050810.GA26595@barra.bne.redhat.com>
	<87zl60s17o.fsf@macbook.be.48ers.dk> <4B1836A6.405@redhat.com>
	<871vjasxnm.fsf@macbook.be.48ers.dk> <4B190D88.4090102@redhat.com>
	<87ws12rh5j.fsf@macbook.be.48ers.dk> <4B1C96C4.5080709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B1C96C4.5080709-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> (Peter Hutterer's message of "Mon,
	07 Dec 2009 15:46:44 +1000")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hutterer <peter.hutterer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

>>>>> "Peter" == Peter Hutterer <peter.hutterer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> writes:

Hi,

 Peter> evtest output for the mouse device on kernel
 Peter> 2.6.31.6-150.fc12.x86_64, I'll spare you the keyboard device,
 Peter> it's not particularly interesting.

 Peter> Testing ... (interrupt to exit)
 Peter> Event: time 1260143900.146760, type 1 (Key), code 320 (ToolPen), value 1
 Peter> Event: time 1260143900.146775, type 3 (Absolute), code 2 (Z), value 14953
 Peter> Event: time 1260143900.146777, type 3 (Absolute), code 3 (Rx), value 19456
 Peter> Event: time 1260143900.146780, -------------- Report Sync ------------

Sorry, it seems like the nw controller I used the other day had old
firmware (product 0x1, firmware 2.91). With 2.92 I see the same
list of supported events, but I get X/Y events on motion instead of Z / Rx:

Event: time 1260344704.138808, type 3 (Absolute), code 0 (X), value 19097
Event: time 1260344704.138814, type 3 (Absolute), code 1 (Y), value 16704
Event: time 1260344704.138819, -------------- Report Sync ------------
Event: time 1260344704.158801, type 3 (Absolute), code 0 (X), value 19033
Event: time 1260344704.158808, type 3 (Absolute), code 1 (Y), value 16700
Event: time 1260344704.158814, -------------- Report Sync ------------
Event: time 1260344704.174803, type 4 (Misc), code 4 (ScanCode), value 90001
Event: time 1260344704.174807, type 1 (Key), code 272 (LeftBtn), value 0
Event: time 1260344704.174825, -------------- Report Sync ------------

 Peter> [root@touchie sbin]# ./nwtool -u -i
 Peter> Version:		2.99
 Peter> Serial:			617241
 Peter> Model:			1901
 Peter> HW capabilities:	0x40
 Peter> Rightclick delay:	1000 ms
 Peter> Doubleclick time:	200 ms
 Peter> Report mode:		4
 Peter> Drag threshold:		500
 Peter> Buzzer time:		40 ms
 Peter> Buzzer tone:		40
 Peter> Calibration key:	4
 Peter> Calibration presses:	3

Hmm, what is report mode 4? Some kind of multi touch mode?

What do you see if you install the Nextwindow USB config tool under
Windows (unfortunately doesn't work under Wine) and look in the mouse
tab? I guess you have a 4th option here.

I see this:  http://peter.korsgaard.com/nw.png

You can get usb config here:
http://www.nextwindow.com/nextwindow_support/software.html

 >> It's probably offtopic here, but we can move the discussion to the X
 >> list if you prefer - Last time I asked there I didn't get any reply
 >> though:
 >> 
 >> http://article.gmane.org/gmane.comp.freedesktop.xorg/40071/

 Peter> Ask louder :) I think I remember your email but it got flooded out of
 Peter> my inbox. In general there should be some method to do that though I
 Peter> need to check the implementation.

OK, great - Let me know what you find. I did hack something up with
evtouch, but would like to move to evdev instead.
I'm willing to work on getting evdev to handle multi screen touchscreen
setups better if needed, I just need a bit of guidance on how it should
be handled.

-- 
Bye, Peter Korsgaard
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

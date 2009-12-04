From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] HID: add multi-input quirk for NextWindow Touchscreen.
Date: Fri, 04 Dec 2009 14:40:56 +0100
Message-ID: <87ws12rh5j.fsf@macbook.be.48ers.dk>
References: <20091203050810.GA26595@barra.bne.redhat.com>
	<87zl60s17o.fsf@macbook.be.48ers.dk> <4B1836A6.405@redhat.com>
	<871vjasxnm.fsf@macbook.be.48ers.dk> <4B190D88.4090102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B190D88.4090102-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> (Peter Hutterer's message of "Fri,
	04 Dec 2009 23:24:24 +1000")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hutterer <peter.hutterer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

>>>>> "Peter" == Peter Hutterer <peter.hutterer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> writes:

Hi,

 Peter> with the quirk, the device exposes three /dev/input/event files, the
 Peter> highest of which sends the actual events now (in X/Y). number two
 Peter> looks like a mouse device (like yours), number three like a
 Peter> touchscreen (BTN_TOUCH, etc.)
 Peter> without the quirk, I only get two devices, the second of which looks
 Peter> like a mix of mouse/touchscreen and it sends ABS_Z/ABS_RX while ABS_X
 Peter> and ABS_Y are mute. I can get you the full evtest blurb but not before
 Peter> Monday, the screen is in the office.

Ahh ok, strange that I'm not seing the same as you. The reason why
there's two devices by default is that the NW pretends to be a keyboard
with numlock/scrolllock/caplock so it can go into calibration mode if
you press the button a number of times (by default 6).

 Peter> where do I get nwtool from? google is unusually quiet about it.

I guess I need more google-foo ;) It's a tool I wrote:

http://git.korsgaard.com/cgi-bin/gitweb.cgi?p=nwtool.git;a=summary

You can git clone from http://git.korsgaard.com/git/nwtool.git

Nextwindow unfortunately never documented the really interesting
commands (like how to make settings persistent), so it cannot do
everything the Windows tool can.

 Peter> is it possible that you changed the report mode (or have it different
 Peter> to me anyway) and that affects things?

Not that I'm aware - I just plugged the device in seconds before running
evtest.

FYI, now that we're talking about NW touchscreens - How is multiscreen
setups with evdev supposed to work? We need something to bind a
touchscreen to an Xrandr output to translate (and with 1.3+ reverse
transform) the coordinates. In the old days you could use evtouch with
seperate X screens and bind the touchscreens to each screen.

It's probably offtopic here, but we can move the discussion to the X
list if you prefer - Last time I asked there I didn't get any reply
though:

http://article.gmane.org/gmane.comp.freedesktop.xorg/40071/

-- 
Bye, Peter Korsgaard
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] HID: add multi-input quirk for NextWindow Touchscreen.
Date: Sat, 19 Dec 2009 23:05:53 +0100
Message-ID: <87638239ha.fsf@macbook.be.48ers.dk>
References: <20091203050810.GA26595@barra.bne.redhat.com>
	<87zl60s17o.fsf@macbook.be.48ers.dk> <4B1836A6.405@redhat.com>
	<871vjasxnm.fsf@macbook.be.48ers.dk> <4B190D88.4090102@redhat.com>
	<87ws12rh5j.fsf@macbook.be.48ers.dk> <4B1C96C4.5080709@redhat.com>
	<87hbs0mqju.fsf@macbook.be.48ers.dk> <4B2B0CCE.2020406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B2B0CCE.2020406-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> (Peter Hutterer's message of "Fri,
	18 Dec 2009 15:02:06 +1000")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hutterer <peter.hutterer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

>>>>> "Peter" == Peter Hutterer <peter.hutterer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> writes:

Hi,

 >> I see this:  http://peter.korsgaard.com/nw.png

 Peter> argh. now you made me use vista! ;)

Sorry, I promise it won't happen again ;)

 Peter> For reporting mode 4 and 3, the events are Z/Rx + touch
 Peter> For reporting mode 1 and 9, the events are ABS_X/Y and left button
 Peter> For reporting mode 0 and 8, no events are sent (unsurprisingly)

 Peter> So it seems the only difference between our two models is the default
 Peter> reporting mode - assuming that 4 is the default, we've had this thing
 Peter> for a year without doing much with it but it could well be that
 Peter> someone set it earlier or one of the HP Touchsmart software pieces
 Peter> changed it.

Ok, thanks for checking it all out! Just to be completely sure, the
quirk doesn't cause any problems in mode 1/9, right?

 >> I'm willing to work on getting evdev to handle multi screen touchscreen
 >> setups better if needed, I just need a bit of guidance on how it should
 >> be handled.

 Peter> replying to your email right now.

Thanks.

-- 
Bye, Peter Korsgaard
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

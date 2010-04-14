From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH 0/4] Various intel small device drivers
Date: Wed, 14 Apr 2010 15:19:03 +0100
Message-ID: <20100414151903.0f367563@lxorguk.ukuu.org.uk>
References: <20100414124913.23181.75903.stgit@localhost.localdomain>
	<20100414153052.4e07f0cc@hyperion.delvare>
	<20100414144912.12c83f51@lxorguk.ukuu.org.uk>
	<4BC5C96B.7050901@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BC5C96B.7050901-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

> If you like, feel free to (re)start an argument with Linus on the ambient light
> sensor front.  Or see that thread for yet another round about discussion of
> where these sensors should be. 
> 
> http://lkml.org/lkml/2010/3/1/367
> 
> Basically if it is primarily an input device for human interaction, see if

Its a sensor on an embedded board, it might be managing the backlight or
measuring the dirt level in a sewage pipe depending upon application.

> Dmitry is willing to take it into input (though note he may quite rightly
> take some convincing!)

Its easy enough to make it an input device but that would then end up
with polled_input_dev which keeps waking up and costs battery. A lot of
the polled input model is somewhat broken in that regard but I can see
Linus point.

> Otherwise, misc with the intent to sweep them all up when an agreed upon
> subsystem is in place.

Looks like goes into misc for the moment with all the other light sensors
and I'll see if I can merge it with the 29007 support while I am at it.

Thanks

Alan

From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH 0/4] Various intel small device drivers
Date: Wed, 14 Apr 2010 14:49:12 +0100
Message-ID: <20100414144912.12c83f51@lxorguk.ukuu.org.uk>
References: <20100414124913.23181.75903.stgit@localhost.localdomain>
	<20100414153052.4e07f0cc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100414153052.4e07f0cc-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

> > Kalhan Trisal (4):
> >       emc1403: thermal sensor support
> >       liss331d1: accelerometer driver
> >       isl29020: ambient light sensor
> >       hmc6352: Add driver for the HMC6352 compass
> 
> The liss331d1, isl29020 and hmc6352 are not hardware monitoring drivers

Disagree somewhat. In fact on close grepping I find that there is another
related lis33 implementation in drivers/hwmon already 8)

Given all the accelerometers are in drivers/hwmon where do you think they
should be, and do you have pending patches to move the others ?

I'd also be interested where you think the compass fits if its not hwmon,
ditto the ambient light sensor ?

I'll bounce the emc1403 onto lm-sensors.

Thanks
Alan

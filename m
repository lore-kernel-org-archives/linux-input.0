From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH 0/4] Various intel small device drivers
Date: Wed, 14 Apr 2010 14:55:55 +0100
Message-ID: <4BC5C96B.7050901@cam.ac.uk>
References: <20100414124913.23181.75903.stgit@localhost.localdomain>	<20100414153052.4e07f0cc@hyperion.delvare> <20100414144912.12c83f51@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100414144912.12c83f51-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 04/14/10 14:49, Alan Cox wrote:
>>> Kalhan Trisal (4):
>>>       emc1403: thermal sensor support
>>>       liss331d1: accelerometer driver
>>>       isl29020: ambient light sensor
>>>       hmc6352: Add driver for the HMC6352 compass
>>
>> The liss331d1, isl29020 and hmc6352 are not hardware monitoring drivers
> 
> Disagree somewhat. In fact on close grepping I find that there is another
> related lis33 implementation in drivers/hwmon already 8)
> 
> Given all the accelerometers are in drivers/hwmon where do you think they
> should be, and do you have pending patches to move the others ?
> 
> I'd also be interested where you think the compass fits if its not hwmon,
> ditto the ambient light sensor ?

If you like, feel free to (re)start an argument with Linus on the ambient light
sensor front.  Or see that thread for yet another round about discussion of
where these sensors should be. 

http://lkml.org/lkml/2010/3/1/367

Basically if it is primarily an input device for human interaction, see if
Dmitry is willing to take it into input (though note he may quite rightly
take some convincing!)

Otherwise, I'm happy to take more general sensors into IIO, but obviously that
is still in staging and evolving reasonably quickly at the moment (large number
of abi clean up patches half way through cleanup at the mo.)

Otherwise, misc with the intent to sweep them all up when an agreed upon
subsystem is in place.

> 
> I'll bounce the emc1403 onto lm-sensors.
> 
> Thanks
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

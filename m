From: simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org
Subject: Re: Handling Controllers with Acc/Gyro/Mag via HID system
Date: Tue, 9 Jun 2015 13:12:29 -0400
Message-ID: <3e2df3769656eb8b7eb448e9a540e30f.squirrel@mungewell.org>
References: <02179134fef3a932cff19b793006f020.squirrel@mungewell.org>
    <1433843657.12204.18.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433843657.12204.18.camel-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Praznik <frank.praznik-oKii7tqusJgAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


> The IIO subsystem's user-space API is awful, and root only. I said as
> much here:
> http://thread.gmane.org/gmane.linux.kernel.iio/14421

Just getting started with this idea, and found this which might waylay
some of the pain....
https://github.com/analogdevicesinc/libiio


> I wrote this for accelerometers that are in tablets/convertibles:
> https://github.com/hadess/iio-sensor-proxy/

Thanks I'll check it out. Thinking more of a AHRS rather than 'just'
rotating the screen. ;-)
Simon

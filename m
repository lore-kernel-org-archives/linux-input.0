From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: Handling Controllers with Acc/Gyro/Mag via HID system
Date: Tue, 09 Jun 2015 11:54:17 +0200
Message-ID: <1433843657.12204.18.camel@hadess.net>
References: <02179134fef3a932cff19b793006f020.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <02179134fef3a932cff19b793006f020.squirrel-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Praznik <frank.praznik-oKii7tqusJgAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, 2015-06-08 at 22:38 -0400, simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org wrote:
> > 
> > Hi all,
> > I'm in the process of fixing the HID descriptor for the PS3 Move
> Controller. which has a particularly convoluted layout for it's
> > Accelormeters, Gyros and Magnetometers involving 2 sets of data per 
> > output
> > report.
> > https://github.com/nitsch/moveonpc/wiki/Input-report
> 
> > The plan is/was to massage the HID descriptor so the first set of
> Accels/Gyro/Mag appear in a set a axis, as a simple way of getting to
> this
> > data.
> 
> [snip]
> 
> > Given that more controllers are coming with 'motion' controls, is 
> > there a
> > framework in place for unifying support?
> 
> A little more poking around has got me looking at the IIO subsystem, 
> which
> seems to be everything Accel/Gyro/Mag...

The IIO subsystem's user-space API is awful, and root only. I said as
much here:
http://thread.gmane.org/gmane.linux.kernel.iio/14421

> I note that there are a few 'HID'ish things there too, although I'm 
> not
> sure whether they are useful to us, or just intended for connecting 
> motion
> devices via the HID bus and then onto IIO.
> --
> drivers/iio/accel/hid-sensor-accel-3d.c
> drivers/iio/gyro/hid-sensor-gyro-3d.c
> drivers/iio/magnetometer/hid-sensor-magn-3d.c
> drivers/iio/orientation/hid-sensor-rotation.c
> --
> 
> Does the idea of the drivers for the HID (gaming) controllers opening 
> up a
> connection to IIO system and pushing the Accel/Gyro/Mag values there
> (rather than exposing them on the joystick interface) make sense?
> 
> Are there any examples of other devices doing this, so I can re-use 
> the code?

I wrote this for accelerometers that are in tablets/convertibles:
https://github.com/hadess/iio-sensor-proxy/

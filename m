From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: iio/hid-sensor-accel-3d: no output from /dev/iio:device*?
Date: Thu, 17 Dec 2015 17:16:30 -0800
Message-ID: <1450401390.5427.22.camel@linux.intel.com>
References: <CAOhV88ODTazDA2jmn9DP5idMmXXQa9jKB9Ur_aWTD_3WYZM1fw@mail.gmail.com>
	 <1450399868.5427.11.camel@linux.intel.com>
	 <CAOhV88MYvtD508toqR2KLOdpSq_tU=kwQKOf252t1sdiK4SviQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOhV88MYvtD508toqR2KLOdpSq_tU=kwQKOf252t1sdiK4SviQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nish Aravamudan <nish.aravamudan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, 2015-12-17 at 17:07 -0800, Nish Aravamudan wrote:
> On Thu, Dec 17, 2015 at 4:51 PM, Srinivas Pandruvada
> <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > On Thu, 2015-12-17 at 15:38 -0800, Nish Aravamudan wrote:
> > > [Starting a new thread from https://lkml.org/lkml/2015/12/15/663,
> > > as
> > > now my laptop is displaying values in the sysfs *raw* files.]
> > > 
> > > So I'm trying to understand exactly how the hid-sensor-accel-3d
> > > driver works.
> > > 
> > > If I turn up debugging, when I `cat
> > > /sys/bus/iio/devices/device*/*raw*`, I see "iio iio:device3:
> > > accel_3d_proc_event" and I think that means that
> > > hid_sensor_push_data() is getting called.
> > > 
> > > But read()'s on /dev/iio:device3 never produces anything, which
> > > is
> > > what iio-sensor-proxy uses to translate events to dbus.
> > > 
> > > Is it expected that the dev-node is "silent"? Just trying to
> > > understand if an extension to the driver to support a chardev
> > > based
> > > output is appropriate, or if iio-sensor-proxy needs to be changed
> > > to
> > > handle this device.
> > 
> > You are saying there is some regression. This used to work and now
> > it
> > doesn't work. Is raw values are displayed correctly, when you do
> > "cat"?
> > If cat of raw values is working then power on of sensors is
> > working.
> 
> Sorry, I was unclear. I don't know if this is a regression. I can try
> going back to an older kernel to see if the /dev/iio:device* files
> produced any output.
> 
> Yes, the *raw* files in sysfs are producing output, that is changing
> as I move the laptop around. But the /dev/ nodes seem to produce no
> output (I'm still reading through the driver code to understand where
> that data should be coming from.
> 
> > Turn on HID debug prints. If it is regression we can do git bisect.
> > Any ACPI or PM changes can break this. Usually there will be GPIOs
> > which will be involved in power on, where ACPI comes into play.
> > This
> > will be done by i2c-hid. There are some prints in i2c-hid which can
> > be
> > enabled also.
> 
> Ok, I will try this, as well.
> 

Try increasing in_accel_sampling_frequency
echo 100 > in_accel_sampling_frequency
Adjust hysteresis to a low value
echo 0 > in_accel_hysteresis
These values are very vendor specific.

Thanks,
Srinivas

> -Nish

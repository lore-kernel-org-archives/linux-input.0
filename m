From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] HID: Add quirk for Lenovo Yoga 910 with ITE Chips
Date: Tue, 18 Jul 2017 01:22:03 +0200
Message-ID: <1500333723.24690.8.camel@hadess.net>
References: <20170715122721.6908-1-ctx.xda@gmail.com>
         <1500128998.2468.1.camel@hadess.net>
         <CAA7d1im1hxM13SrsF5pQsJmtugjT2CJZnJdmbC2KxL5_QPXd_Q@mail.gmail.com>
         <1500141490.2490.1.camel@hadess.net> <20170715200518.GA24502@foobar>
         <1500322784.21514.33.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500322784.21514.33.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Patrick <ctx.xda@gmail.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, jic23@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, 2017-07-17 at 13:19 -0700, Srinivas Pandruvada wrote:
> On Sat, 2017-07-15 at 22:05 +0200, Patrick wrote:
> > On Sat, Jul 15, 2017 at 07:58:10PM +0200, Bastien Nocera wrote:
> > > 
> > > On Sat, 2017-07-15 at 19:52 +0200, Patrick Pedersen wrote:
> > > > 
> > > > On Sat, Jul 15, 2017 at 4:29 PM, Bastien Nocera <hadess@hadess.
> > > > ne
> > > > t>
> > > > wrote:
> > > > > 
> > > > > On Sat, 2017-07-15 at 14:27 +0200, Patrick Pedersen wrote:
> > > > > > 
> > > > > > As with previous generations of this device (see https://pa
> > > > > > tc
> > > > > > hwor
> > > > > 
> > > > > k.ke
> > > > > > 
> > > > > > rnel.org/patch/7887361/), the ITE
> > > > > > HID Sensor Hub, responsible for the accelerometer and als
> > > > > > sensor,
> > > > > > requires a quirk entry.
> > > > > > 
> > > > > > Without the entry, the Sensor Hub can't be accessed and the
> > > > > 
> > > > > kernel
> > > > > > 
> > > > > > fails to report any movements. As a result
> > > > > > iio-sensor-proxy receives no new data.
> > > > > > 
> > > > > > It shall additionally be noted that the i2c-hid 'sleep' bug
> > > > > 
> > > > > (present
> > > > > > 
> > > > > > since kernel ver. 4.3)
> > > > > > still affects the driver. This means that the sensor hub
> > > > > > will
> > > > > > not
> > > > > > report any movement, until
> > > > > > the device is suspended and resumed.

Those are the same symptoms as the problem I reported here:
https://www.spinics.net/lists/linux-iio/msg29983.html

> Can you try some tests for this for test? I want to see if sensors
> are
> powered off or transport didn't wake up? So forcing the sensors to
> keep
> power on.

I tested the patch below using a HID sensor (ColorHug ALS) and it
failed in the same way with and without the patch you have below.

Hans also had an idea that this might be due to the PM suspend. The 3-
second sleep that you need to remove from iio-sensor-proxy matches the
default autosuspend delay at:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/common/hid-sensors/hid-sensor-trigger.c#n285

But setting "->common_attributes.data_ready" to 1 in each of the
driver's original states didn't work out.

Knowing that it affects both i2c and USB is a good bit of information
though, meaning that the problem probably lies in the IIO subsystem.

Or possibly a change of behaviour in the PM subsystem which made the
IIO trigger stop working. If Rafael could do a review on the code
linked above, that'd be really helpful.

Note that in addition to the patches I mentioned in the kernel thread
above, you'll need to revert this patch in iio-sensor-proxy:
https://github.com/hadess/iio-sensor-proxy/commit/5468452f7a72566d2e6ddc44f9396d3d088fa9fb

Otherwise things work :/

> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 16ade0a..a70df7e 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -110,6 +110,9 @@ static int _hid_sensor_power_state(struct
> hid_sensor_common *st, bool state)
>         int report_val;
>         s32 poll_value = 0;
>  
> +       st->power_state.logical_minimum = 1;
> +       st->report_state.logical_minimum = 1;
> +
>         if (state) {
>                 if (!atomic_read(&st->user_requested_state))
>                         return 0;
> @@ -146,6 +149,9 @@ static int _hid_sensor_power_state(struct
> hid_sensor_common *st, bool state)
>                         HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVEN
> TS
> _ENUM);
>         }
>  
> +       state_val = 0;
> +       report_val = 0;
> +       
>         if (state_val >= 0) {
>                 state_val += st->power_state.logical_minimum;
>                 sensor_hub_set_feature(st->hsdev, st-
> > power_state.report_id,

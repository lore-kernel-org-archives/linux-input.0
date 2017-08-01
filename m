From: Patrick <ctx.xda@gmail.com>
Subject: Re: [PATCH] HID: Add quirk for Lenovo Yoga 910 with ITE Chips
Date: Tue, 1 Aug 2017 14:23:19 +0200
Message-ID: <20170801122319.GB1751@foobar>
References: <20170715122721.6908-1-ctx.xda@gmail.com>
 <1500321494.21514.29.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500321494.21514.29.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, jic23@kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Sorry for the late response.

I can confirm that the ITE8186 hub successfully reports input data
on the latest linux-next release with the linked patch applied and no
quirks added.

On Mon, Jul 17, 2017 at 12:58:14PM -0700, Srinivas Pandruvada wrote:
> On Sat, 2017-07-15 at 14:27 +0200, Patrick Pedersen wrote:
> > As with previous generations of this device (see https://patchwork.ke
> > rnel.org/patch/7887361/), the ITE
> > HID Sensor Hub, responsible for the accelerometer and als sensor,
> > requires a quirk entry.
> 
> I want to get rid of these quirks as this is now the defacto standard.
> Can you try with this change without any quirk.
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 16ade0a..1fb407f 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -110,6 +110,9 @@ static int _hid_sensor_power_state(struct
> hid_sensor_common *st, bool state)
> ????????????????int report_val;
> ????????????????s32 poll_value = 0;
> ??
> +??????????????st->power_state.logical_minimum = 1;
> +??????????????st->report_state.logical_minimum = 1;
> +
> ????????????????if (state) {
> ????????????????????????????????if (!atomic_read(&st->user_requested_state))
> ????????????????????????????????????????????????return 0;
> 
> 
> Thanks,
> Srinivas
> 
> > 
> > Without the entry, the Sensor Hub can't be accessed and the kernel
> > fails to report any movements. As a result
> > iio-sensor-proxy receives no new data.
> > 
> > It shall additionally be noted that the i2c-hid 'sleep' bug (present
> > since kernel ver. 4.3)
> > still affects the driver. This means that the sensor hub will not
> > report any movement, until
> > the device is suspended and resumed.
> > 
> > Signed-off-by: Patrick Pedersen <ctx.xda@gmail.com>
> > ---
> > ??drivers/hid/hid-ids.h????????????????| 1 +
> > ??drivers/hid/hid-sensor-hub.c | 3 +++
> > ??2 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 4f9a3938189a..b427a0bcfbe8 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -565,6 +565,7 @@
> > ??#define USB_DEVICE_ID_ITE_LENOVO_YOGA??????0x8386
> > ??#define USB_DEVICE_ID_ITE_LENOVO_YOGA2????0x8350
> > ??#define USB_DEVICE_ID_ITE_LENOVO_YOGA900	0x8396
> > +#define USB_DEVICE_ID_ITE_LENOVO_YOGA910	0x8186
> > ??
> > ??#define USB_VENDOR_ID_JABRA		0x0b0e
> > ??#define USB_DEVICE_ID_JABRA_SPEAK_410	0x0412
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> > hub.c
> > index 4ef73374a8f9..85b8425483bd 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -820,6 +820,9 @@ static const struct hid_device_id
> > sensor_hub_devices[] = {
> > ??	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > USB_VENDOR_ID_ITE,
> > ??			USB_DEVICE_ID_ITE_LENOVO_YOGA900),
> > ??			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> > +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > USB_VENDOR_ID_ITE,
> > +			USB_DEVICE_ID_ITE_LENOVO_YOGA910),
> > +			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> > ??	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > USB_VENDOR_ID_INTEL_0,
> > ??			0x22D8),
> > ??			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},

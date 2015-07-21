From: Gregor Riepl <onitake@gmail.com>
Subject: Re: [PATCH] Add generic driver for Silead tochscreens
Date: Tue, 21 Jul 2015 15:21:28 +0200
Message-ID: <55AE4758.70100@gmail.com>
References: <55A18959.7050502@gmail.com> <CAFPB+YdNTUCRsQZZVCZQGyAdmOnSGs_fqOFxRm9u8rFPLDobCQ@mail.gmail.com> <55A3CA05.5030302@gmail.com> <CAFPB+YcZnzHVdztqYuD63fNGhedDZR4xEW8Nkd+zJ_H_gm+L-w@mail.gmail.com> <55A3D6DA.9090206@gmail.com> <CAFPB+Ycury020k0W6LVK9mnbS6hFXNdqr6qPP21PMXbNy8TYmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35412 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbbGUNWc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2015 09:22:32 -0400
Received: by wgav7 with SMTP id v7so90889706wga.2
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2015 06:22:30 -0700 (PDT)
In-Reply-To: <CAFPB+Ycury020k0W6LVK9mnbS6hFXNdqr6qPP21PMXbNy8TYmQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Dolca <robert.dolca@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Robert

> For the existing devices you can override the ACPI tables using initrd.
> https://www.kernel.org/doc/Documentation/acpi/initrd_table_override.txt
> 
> There is some work being done that will allow to amend (no need to
> completely override) the ACPI tables with custom data.
> https://lkml.org/lkml/2015/6/18/947

I see.
I was under the impression that modifying the DSDT is generally frowned upon
and will result in a tainted kernel.

> Device tree already has support for overlays.
> 
> Giving this I think that we should keep the driver as simple as possible.

I absolutely agree. However, as long as there is no alternative way to pass
the necessary parameters, a driver will not work on all machines, particularly
those that were designed to be shipped with Microsoft Windows. I suspect that
vendors will be reluctant to change their (UEFI) BIOSes to accommodate full
Linux support in such devices.

> I will come back with the info on the touch id after I check the docs.

Thanks.

> axis swapping, mirroring sound like a good addon.
> there is currently support for width, height, number of touch points and
> firmware name

Those features are fairly easy to implement, and thanks to the great work by
the linux-input team, even finger tracking is not difficult to integrate.

Some example code is included below.

> IMHO it's not a good idea to do the config using sysfs.

You are probably right, yes.

In the meantime, I had a different idea. Instead of passing the panel and
firmware parameters (width, height, number of touch areas, mirroring,
swapping, tracking support) through device_property_read, they could be
contained in the firmware, in a special header.
As practically every single device seems to require its own firmware, users
and platform builders would need to obtain it anyway. Why not include all the
information the driver requires with the firmware image itself?

Reading the firmware name from the DSDT/DT like all the other parameters is an
option, of course. However... If you have, let's say, 100 different devices on
the market, all with different firmware, you'd have to install 100 different
firmware images to make automatic detection and device startup possible. This
doesn't seem very reasonable. On the other hand, just logging an error that a
specific firmware is required and requiring the user to manually download and
install that firmware isn't much better than logging vendor/device data from
the DMI, then provide a tool or website that provides the appropriate firmware
for that device.

Another obvious approach would be device quirks. Many drivers in the Linux
kernel follow this approach, but I'm not sure if it's a preferable solution.
Again, assuming there are a 100 different devices with a limited DSDT out
there, one would need 100 different device quirks.

That number is, obviously, purely hypothetical. But I hope you get the picture.



Code example: Swapping, mirroring and finger tracking support (error checking
omitted for simplicity):

/* 0 = unlimited distance */
#define MAX_DISTANCE 0
#define MAX_CONTACTS 10
struct gsl_ts_data {
	struct input_dev *input;
	/* ... */
	unsigned int x_max;
	unsigned int y_max;
	unsigned int multi_touches;
	bool x_reversed;
	bool y_reversed;
	bool xy_swapped;
	bool soft_tracking;
};
static int gsl_ts_probe(struct i2c_client *client, const struct i2c_device_id *id)
{
	struct gsl_ts_data *ts;
	/* ... */
	ts = devm_kzalloc(&client->dev, sizeof(struct gsl_ts_data), GFP_KERNEL);
	ts->input = devm_input_allocate_device(&client->dev);
	if (ts->soft_tracking) {
		input_mt_init_slots(ts->input, ts->multi_touches, INPUT_MT_DIRECT |
INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK);
	} else {
		input_mt_init_slots(ts->input, ts->multi_touches, INPUT_MT_DIRECT |
INPUT_MT_DROP_UNUSED);
	}
	/* ... */
}

static void gsl_ts_mt_event(struct gsl_ts_data *ts, u8 *buf)
{
	size_t i;
	struct input_mt_pos positions[MAX_CONTACTS];
	int slots[MAX_CONTACTS];
	/* ... */
	if (num_touches > MAX_CONTACTS) {
		num_touches = MAX_CONTACTS;
	}
	for (i = 0; i < num_touches; i++) {
		/* ... */
		if (ts->xy_swapped) {
			swap(x, y);
		}
		if (ts->x_reversed) {
			x = ts->x_max - x;
		}
		if (ts->y_reversed) {
			y = ts->y_max - y;
		}
		positions[i].x = x;
		positions[i].y = y;
		if (!ts->soft_tracking) {
			slots[i] = id;
		}
	}
	if (ts->soft_tracking) {
#if LINUX_VERSION_CODE < KERNEL_VERSION(4,0,0)
		rc = input_mt_assign_slots(input, slots, positions, touches);
#else
		rc = input_mt_assign_slots(input, slots, positions, touches, MAX_DISTANCE);
#endif
		if (rc < 0) {
			dev_err(dev, "%s: input_mt_assign_slots returned %d\n", __func__, rc);
			return;
		}
	}
	for (i = 0; i < num_touches; i++) {
		input_mt_slot(input, slots[i]);
		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
		input_report_abs(input, ABS_MT_POSITION_X, positions[i].x);
		input_report_abs(input, ABS_MT_POSITION_Y, positions[i].y);
	}
	input_mt_sync_frame(input);
	input_sync(input);
}


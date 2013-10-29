From: Rafael Brune <mail@rbrune.de>
Subject: Re: [PATCH] HID: wiimote: add pro-controller analog stick calibration
Date: Wed, 30 Oct 2013 00:28:47 +0100
Message-ID: <7969D126-74F7-4B91-9B5C-213AC76B3A66@rbrune.de>
References: <1382978960-849-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tyrell.rbrune.de ([83.169.16.173]:37677 "EHLO tyrell.rbrune.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182Ab3J2X2v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Oct 2013 19:28:51 -0400
In-Reply-To: <1382978960-849-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>


On Oct 28, 2013, at 5:49 PM, David Herrmann <dh.herrmann@gmail.com> wro=
te:

> The analog sticks of the pro-controller might report slightly off val=
ues.
> To guarantee a uniform setup, we now calibrate analog-stick values du=
ring
> pro-controller setup.
>=20
> Unfortunately, the pro-controller fails during normal EEPROM reads an=
d I
> couldn't figure out whether there are any calibration values stored o=
n the
> device. Therefore, we now use the first values reported by the device=
 (iff
> they are not _way_ off, which would indicate movement) to initialize =
the
> calibration values. To allow users to change this calibration data, w=
e
> provide a pro_calib sysfs attribute.
>=20
> We also change the "flat" values so user-space correctly smoothes our
> data. It makes slightly off zero-positions less visible while still
> guaranteeing highly precise movement reports. Note that the pro contr=
oller
> reports zero-positions in a quite huge range (at least: -100 to +100)=
=2E
>=20
> Reported-by: Rafael Brune <mail@rbrune.de>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

Tested-by: Rafael Brune <mail@rbrune.de>

> ---
> Hi Rafael
>=20
> Could you give this a try? It works for me quite well.
>=20
> Thanks
> David

Hi David,

also for me it works very well. As much as I don=92t like the =91initia=
lize by first
observed values=92 approach, with the capability to change the calibrat=
ion
values from user-space it=92s a simple and good solution.
Also I like the changes of the =91flat=92 values.
We should keep our eyes open if other pro- or third-party controllers
exceed the +/- 0x400 range of values more than our ones. But I think
Nintendo does the calibration very similar and therefore that should no=
t
happen.
Great work!

Regards,
 Rafael


>=20
> Documentation/ABI/testing/sysfs-driver-hid-wiimote |  18 ++++
> drivers/hid/hid-wiimote-modules.c                  | 117 ++++++++++++=
+++++++--
> drivers/hid/hid-wiimote.h                          |   2 +
> 3 files changed, 128 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-wiimote b/Doc=
umentation/ABI/testing/sysfs-driver-hid-wiimote
> index ed5dd56..39dfa5c 100644
> --- a/Documentation/ABI/testing/sysfs-driver-hid-wiimote
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
> @@ -57,3 +57,21 @@ Description:	This attribute is only provided if th=
e device was detected as a
> 		Calibration data is already applied by the kernel to all input
> 		values but may be used by user-space to perform other
> 		transformations.
> +
> +What:		/sys/bus/hid/drivers/wiimote/<dev>/pro_calib
> +Date:		October 2013
> +KernelVersion:	3.13
> +Contact:	David Herrmann <dh.herrmann@gmail.com>
> +Description:	This attribute is only provided if the device was detec=
ted as a
> +		pro-controller. It provides a single line with 4 calibration
> +		values for all 4 analog sticks. Format is: "x1:y1 x2:y2". Data
> +		is prefixed with a +/-. Each value is a signed 16bit number.
> +		Data is encoded as decimal numbers and specifies the offsets of
> +		the analog sticks of the pro-controller.
> +		Calibration data is already applied by the kernel to all input
> +		values but may be used by user-space to perform other
> +		transformations.
> +		Calibration data is detected by the kernel during device setup.
> +		You can write "scan\n" into this file to re-trigger calibration.
> +		You can also write data directly in the form "x1:y1 x2:y2" to
> +		set the calibration values manually.
> diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiim=
ote-modules.c
> index e30567a..6b61f01 100644
> --- a/drivers/hid/hid-wiimote-modules.c
> +++ b/drivers/hid/hid-wiimote-modules.c
> @@ -1655,10 +1655,39 @@ static void wiimod_pro_in_ext(struct wiimote_=
data *wdata, const __u8 *ext)
> 	ly =3D (ext[4] & 0xff) | ((ext[5] & 0x0f) << 8);
> 	ry =3D (ext[6] & 0xff) | ((ext[7] & 0x0f) << 8);
>=20
> -	input_report_abs(wdata->extension.input, ABS_X, lx - 0x800);
> -	input_report_abs(wdata->extension.input, ABS_Y, 0x800 - ly);
> -	input_report_abs(wdata->extension.input, ABS_RX, rx - 0x800);
> -	input_report_abs(wdata->extension.input, ABS_RY, 0x800 - ry);
> +	/* zero-point offsets */
> +	lx -=3D 0x800;
> +	ly =3D 0x800 - ly;
> +	rx -=3D 0x800;
> +	ry =3D 0x800 - ry;
> +
> +	/* Trivial automatic calibration. We don't know any calibration dat=
a
> +	 * in the EEPROM so we must use the first report to calibrate the
> +	 * null-position of the analog sticks. Users can retrigger calibrat=
ion
> +	 * via sysfs, or set it explicitly. If data is off more than abs(50=
0),
> +	 * we skip calibration as the sticks are likely to be moved already=
=2E */
> +	if (!(wdata->state.flags & WIIPROTO_FLAG_PRO_CALIB_DONE)) {
> +		wdata->state.flags |=3D WIIPROTO_FLAG_PRO_CALIB_DONE;
> +		if (abs(lx) < 500)
> +			wdata->state.calib_pro_sticks[0] =3D -lx;
> +		if (abs(ly) < 500)
> +			wdata->state.calib_pro_sticks[1] =3D -ly;
> +		if (abs(rx) < 500)
> +			wdata->state.calib_pro_sticks[2] =3D -rx;
> +		if (abs(ry) < 500)
> +			wdata->state.calib_pro_sticks[3] =3D -ry;
> +	}
> +
> +	/* apply calibration data */
> +	lx +=3D wdata->state.calib_pro_sticks[0];
> +	ly +=3D wdata->state.calib_pro_sticks[1];
> +	rx +=3D wdata->state.calib_pro_sticks[2];
> +	ry +=3D wdata->state.calib_pro_sticks[3];
> +
> +	input_report_abs(wdata->extension.input, ABS_X, lx);
> +	input_report_abs(wdata->extension.input, ABS_Y, ly);
> +	input_report_abs(wdata->extension.input, ABS_RX, rx);
> +	input_report_abs(wdata->extension.input, ABS_RY, ry);
>=20
> 	input_report_key(wdata->extension.input,
> 			 wiimod_pro_map[WIIMOD_PRO_KEY_RIGHT],
> @@ -1766,12 +1795,70 @@ static int wiimod_pro_play(struct input_dev *=
dev, void *data,
> 	return 0;
> }
>=20
> +static ssize_t wiimod_pro_calib_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *out)
> +{
> +	struct wiimote_data *wdata =3D dev_to_wii(dev);
> +	int r;
> +
> +	r =3D 0;
> +	r +=3D sprintf(&out[r], "%+06hd:", wdata->state.calib_pro_sticks[0]=
);
> +	r +=3D sprintf(&out[r], "%+06hd ", wdata->state.calib_pro_sticks[1]=
);
> +	r +=3D sprintf(&out[r], "%+06hd:", wdata->state.calib_pro_sticks[2]=
);
> +	r +=3D sprintf(&out[r], "%+06hd\n", wdata->state.calib_pro_sticks[3=
]);
> +
> +	return r;
> +}
> +
> +static ssize_t wiimod_pro_calib_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct wiimote_data *wdata =3D dev_to_wii(dev);
> +	int r;
> +	s16 x1, y1, x2, y2;
> +
> +	if (!strncmp(buf, "scan\n", 5)) {
> +		spin_lock_irq(&wdata->state.lock);
> +		wdata->state.flags &=3D ~WIIPROTO_FLAG_PRO_CALIB_DONE;
> +		spin_unlock_irq(&wdata->state.lock);
> +	} else {
> +		r =3D sscanf(buf, "%hd:%hd %hd:%hd", &x1, &y1, &x2, &y2);
> +		if (r !=3D 4)
> +			return -EINVAL;
> +
> +		spin_lock_irq(&wdata->state.lock);
> +		wdata->state.flags |=3D WIIPROTO_FLAG_PRO_CALIB_DONE;
> +		spin_unlock_irq(&wdata->state.lock);
> +
> +		wdata->state.calib_pro_sticks[0] =3D x1;
> +		wdata->state.calib_pro_sticks[1] =3D y1;
> +		wdata->state.calib_pro_sticks[2] =3D x2;
> +		wdata->state.calib_pro_sticks[3] =3D y2;
> +	}
> +
> +	return strnlen(buf, PAGE_SIZE);
> +}
> +
> +static DEVICE_ATTR(pro_calib, S_IRUGO|S_IWUSR|S_IWGRP, wiimod_pro_ca=
lib_show,
> +		   wiimod_pro_calib_store);
> +
> static int wiimod_pro_probe(const struct wiimod_ops *ops,
> 			    struct wiimote_data *wdata)
> {
> 	int ret, i;
> +	unsigned long flags;
>=20
> 	INIT_WORK(&wdata->rumble_worker, wiimod_rumble_worker);
> +	wdata->state.calib_pro_sticks[0] =3D 0;
> +	wdata->state.calib_pro_sticks[1] =3D 0;
> +	wdata->state.calib_pro_sticks[2] =3D 0;
> +	wdata->state.calib_pro_sticks[3] =3D 0;
> +
> +	spin_lock_irqsave(&wdata->state.lock, flags);
> +	wdata->state.flags &=3D ~WIIPROTO_FLAG_PRO_CALIB_DONE;
> +	spin_unlock_irqrestore(&wdata->state.lock, flags);
>=20
> 	wdata->extension.input =3D input_allocate_device();
> 	if (!wdata->extension.input)
> @@ -1786,6 +1873,13 @@ static int wiimod_pro_probe(const struct wiimo=
d_ops *ops,
> 		goto err_free;
> 	}
>=20
> +	ret =3D device_create_file(&wdata->hdev->dev,
> +				 &dev_attr_pro_calib);
> +	if (ret) {
> +		hid_err(wdata->hdev, "cannot create sysfs attribute\n");
> +		goto err_free;
> +	}
> +
> 	wdata->extension.input->open =3D wiimod_pro_open;
> 	wdata->extension.input->close =3D wiimod_pro_close;
> 	wdata->extension.input->dev.parent =3D &wdata->hdev->dev;
> @@ -1806,20 +1900,23 @@ static int wiimod_pro_probe(const struct wiim=
od_ops *ops,
> 	set_bit(ABS_RX, wdata->extension.input->absbit);
> 	set_bit(ABS_RY, wdata->extension.input->absbit);
> 	input_set_abs_params(wdata->extension.input,
> -			     ABS_X, -0x800, 0x800, 2, 4);
> +			     ABS_X, -0x400, 0x400, 4, 100);
> 	input_set_abs_params(wdata->extension.input,
> -			     ABS_Y, -0x800, 0x800, 2, 4);
> +			     ABS_Y, -0x400, 0x400, 4, 100);
> 	input_set_abs_params(wdata->extension.input,
> -			     ABS_RX, -0x800, 0x800, 2, 4);
> +			     ABS_RX, -0x400, 0x400, 4, 100);
> 	input_set_abs_params(wdata->extension.input,
> -			     ABS_RY, -0x800, 0x800, 2, 4);
> +			     ABS_RY, -0x400, 0x400, 4, 100);
>=20
> 	ret =3D input_register_device(wdata->extension.input);
> 	if (ret)
> -		goto err_free;
> +		goto err_file;
>=20
> 	return 0;
>=20
> +err_file:
> +	device_remove_file(&wdata->hdev->dev,
> +			   &dev_attr_pro_calib);
> err_free:
> 	input_free_device(wdata->extension.input);
> 	wdata->extension.input =3D NULL;
> @@ -1837,6 +1934,8 @@ static void wiimod_pro_remove(const struct wiim=
od_ops *ops,
> 	input_unregister_device(wdata->extension.input);
> 	wdata->extension.input =3D NULL;
> 	cancel_work_sync(&wdata->rumble_worker);
> +	device_remove_file(&wdata->hdev->dev,
> +			   &dev_attr_pro_calib);
>=20
> 	spin_lock_irqsave(&wdata->state.lock, flags);
> 	wiiproto_req_rumble(wdata, 0);
> diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
> index 75db0c4..03065f1 100644
> --- a/drivers/hid/hid-wiimote.h
> +++ b/drivers/hid/hid-wiimote.h
> @@ -46,6 +46,7 @@
> #define WIIPROTO_FLAG_DRM_LOCKED	0x8000
> #define WIIPROTO_FLAG_BUILTIN_MP	0x010000
> #define WIIPROTO_FLAG_NO_MP		0x020000
> +#define WIIPROTO_FLAG_PRO_CALIB_DONE	0x040000
>=20
> #define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 =
| \
> 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
> @@ -135,6 +136,7 @@ struct wiimote_state {
>=20
> 	/* calibration/cache data */
> 	__u16 calib_bboard[4][3];
> +	__s16 calib_pro_sticks[4];
> 	__u8 cache_rumble;
> };
>=20
> --=20
> 1.8.4.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH v2 1/6] hid: new driver for PicoLCD device
Date: Sun, 21 Mar 2010 17:37:37 +0100
Message-ID: <20100321173737.5fcf3580@neptune.home>
References: <20100320170014.440959a8@neptune.home>
	<20100320170241.55258b0d@neptune.home>
	<20100321034600.GE29360@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100321034600.GE29360-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rick L. Vinyard Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>, Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Jaya Kumar <jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, 20 March 2010 Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
> On Sat, Mar 20, 2010 at 05:02:41PM +0100, Bruno Pr=C3=A9mont wrote:
> > +/* Input device
> > + *
> > + * The PicoLCD has an IR receiver header, a built-in keypad with 5=
 keys
> > + * and header for 4x4 key matrix. The built-in keys are part of th=
e matrix.
> > + */
> > +#define PICOLCD_KEYS 17
> > +
> > +static const int def_keymap[PICOLCD_KEYS] =3D {
>=20
> def_keymap[] =3D {
> ...
> };
> #define PICOLCD_KEYS ARRAY_SIZE(def_keymap);
>=20
> would be safe.  Also unsigned short should cover it.

Ok

> > +	KEY_RESERVED,	/* none */
> > +	KEY_BACK,	/* col 4 + row 1 */
> > +	KEY_HOMEPAGE,	/* col 3 + row 1 */
> > +	KEY_RESERVED,	/* col 2 + row 1 */
> > +	KEY_RESERVED,	/* col 1 + row 1 */
> > +	KEY_SCROLLUP,	/* col 4 + row 2 */
> > +	KEY_OK,		/* col 3 + row 2 */
> > +	KEY_SCROLLDOWN,	/* col 2 + row 2 */
> > +	KEY_RESERVED,	/* col 1 + row 2 */
> > +	KEY_RESERVED,	/* col 4 + row 3 */
> > +	KEY_RESERVED,	/* col 3 + row 3 */
> > +	KEY_RESERVED,	/* col 2 + row 3 */
> > +	KEY_RESERVED,	/* col 1 + row 3 */
> > +	KEY_RESERVED,	/* col 4 + row 4 */
> > +	KEY_RESERVED,	/* col 3 + row 4 */
> > +	KEY_RESERVED,	/* col 2 + row 4 */
> > +	KEY_RESERVED,	/* col 1 + row 4 */
> > +};
> > +
> > +/* Description of in-progress IO operation, used for operations
> > + * that trigger response from device */
> > +struct picolcd_pending {
> > +	struct hid_report *out_report;
> > +	struct hid_report *in_report;
> > +	int raw_size;
> > +	u8 raw_data[64];
> > +};
> > +
> > +/* Per device data structure */
> > +struct picolcd_data {
> > +	struct hid_device *hdev;
> > +#ifdef CONFIG_DEBUG_FS
> > +	int addr_sz;
> > +#endif
> > +	u8 version[2];
> > +	/* input stuff */
> > +	u8 pressed_keys[2];
> > +	struct input_dev *input_keys;
> > +	struct input_dev *input_cir;
> > +	int keycode[PICOLCD_KEYS];
> > +
> > +	/* Housekeeping stuff */
> > +	spinlock_t lock;
> > +	struct picolcd_pending *pending;
> > +	struct completion ready;
> > +	int status;
> > +#define PICOLCD_BUSY 1
> > +#define PICOLCD_FAILED 4
> > +#define PICOLCD_BOOTLOADER 8
> > +};
> > +
> > +
> > +/* Find a given report */
> > +#define picolcd_in_report(id, dev) picolcd_report(id, dev, HID_INP=
UT_REPORT)
> > +#define picolcd_out_report(id, dev) picolcd_report(id, dev, HID_OU=
TPUT_REPORT)
> > +
> > +static struct hid_report *picolcd_report(int id, struct hid_device=
 *hdev, int dir)
> > +{
> > +	struct list_head *feature_report_list =3D &hdev->report_enum[dir]=
=2Ereport_list;
> > +	struct hid_report *report =3D NULL;
> > +
> > +	list_for_each_entry(report, feature_report_list, list) {
> > +		if (report->id =3D=3D id)
> > +			return report;
> > +	}
> > +	dev_warn(&hdev->dev, "No report with id 0x%x found\n", id);
> > +	return NULL;
> > +}
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +static void picolcd_debug_out_report(struct picolcd_data *data,
> > +		struct hid_device *hdev, struct hid_report *report);
> > +#define usbhid_submit_report(a, b, c) \
> > +	picolcd_debug_out_report(hid_get_drvdata(a), a, b); \
> > +	usbhid_submit_report(a, b, c)
> > +#endif
> > +
> > +/* Submit a report and wait for a reply from device - if device fa=
des away
> > + * or does not respond in time, return NULL */
> > +static struct picolcd_pending* picolcd_send_and_wait(struct hid_de=
vice *hdev,
> > +		int report_id, const u8 *raw_data, int size)
> > +{
> > +	struct picolcd_data *data =3D hid_get_drvdata(hdev);
> > +	struct picolcd_pending *work;
> > +	struct hid_report *report =3D picolcd_out_report(report_id, hdev)=
;
> > +	unsigned long flags;
> > +	int status, i, j, k;
> > +
> > +	if (!report)
> > +		return NULL;
> > +	work =3D kzalloc(sizeof(*work), GFP_KERNEL);
> > +	if (!work)
> > +		return NULL;
> > +
> > +	work->out_report =3D report;
> > +	work->in_report  =3D NULL;
> > +	work->raw_size   =3D 0;
> > +
> > +retry:
> > +	/* try to get lock and enqueue our job */
> > +	spin_lock_irqsave(&data->lock, flags);
> > +	status =3D data->status;
> > +	if (data->pending || (status & PICOLCD_FAILED)) {
> > +		/* some job already pending,
> > +		 * wait for it to complete and try again */
> > +		spin_unlock_irqrestore(&data->lock, flags);
> > +		if (status & PICOLCD_FAILED) {
> > +			kfree(work);
> > +			return NULL;
> > +		}
> > +		wait_for_completion_interruptible_timeout(&data->ready, HZ*2);
> > +		goto retry;
>=20
> Umm, can we do this with a mutex? Like you take a mutex and don't
> release till you are done talking to the device. So that other guy wi=
ll
> wait on the mutex instead of waking up and rechecking condition.
>=20
> > +	}
> > +	data->status |=3D PICOLCD_BUSY;
> > +	data->pending =3D work;
> > +	for (i =3D k =3D 0; i < report->maxfield; i++)
> > +		for (j =3D 0; j < report->field[i]->report_count; j++) {
> > +			hid_set_field(report->field[i], j, k < size ? raw_data[k] : 0);
> > +			k++;
> > +		}
> > +	usbhid_submit_report(data->hdev, report, USB_DIR_OUT);
> > +	complete_all(&data->ready);
> > +	INIT_COMPLETION(data->ready);
>=20
> Umm, what does this do, exactly?

It wakes up anyone waiting on the completion and then resets the comple=
tion
as otherwise any future attempt to wait on it would succeed immediately=
=2E

The complete_all() instead of just complete() comes from the reset() fu=
nction.
I can probably reduce it here.

Will check this combined with your mutex suggestion above.

> > +	spin_unlock_irqrestore(&data->lock, flags);
> > +	/* wait for our job to complete */
> > +	wait_for_completion_interruptible_timeout(&data->ready, HZ*2);
> > +
> > +	spin_lock_irqsave(&data->lock, flags);
> > +	if (data->pending =3D=3D work) {
> > +		data->status  &=3D ~PICOLCD_BUSY;
> > +		data->pending =3D NULL;
> > +		complete_all(&data->ready);
> > +		spin_unlock_irqrestore(&data->lock, flags);
> > +		return work;
> > +	} else {
> > +		spin_unlock_irqrestore(&data->lock, flags);
> > +		kfree(work);
> > +		return NULL;
> > +	}
> > +}
> > +
> > +/*
> > + * input class device
> > + */
> > +static int picolcd_raw_keypad(struct hid_device *hdev,
> > +		struct hid_report *report, u8 *raw_data, int size)
> > +{
> > +	/*
> > +	 * Keypad event
> > +	 * First and second data bytes list currently pressed keys,
> > +	 * 0x00 means no key and at most 2 keys may be pressed at same ti=
me
> > +	 */
> > +	struct picolcd_data *data =3D hid_get_drvdata(hdev);
> > +	int i, j;
> > +
> > +	/* determine newly pressed keys */
> > +	for (i =3D 0; i < size; i++) {
> > +		int key_code;
> > +		if (raw_data[i] =3D=3D 0)
> > +			continue;
> > +		for (j =3D 0; j < sizeof(data->pressed_keys); j++)
> > +			if (data->pressed_keys[j] =3D=3D raw_data[i])
> > +				goto key_already_down;
> > +		for (j =3D 0; j < sizeof(data->pressed_keys); j++)
> > +			if (data->pressed_keys[j] =3D=3D 0) {
> > +				data->pressed_keys[j] =3D raw_data[i];
> > +				break;
> > +			}
> > +		input_event(data->input_keys, EV_MSC, MSC_SCAN, raw_data[i]);
> > +		if (input_get_keycode(data->input_keys, raw_data[i], &key_code))
> > +			key_code =3D KEY_UNKNOWN;
>=20
> Just get keycode directly from the driver's table, no need to jump th=
rough hoops
> here,

Ok

> > +		if (key_code !=3D KEY_UNKNOWN) {
> > +			dbg_hid(PICOLCD_NAME " got key press for %u:%d", raw_data[i], k=
ey_code);
> > +			input_report_key(data->input_keys, key_code, 1);
> > +		}
> > +		input_sync(data->input_keys);
> > +key_already_down:
> > +		continue;
> > +	}
> > +
> > +	/* determine newly released keys */
> > +	for (j =3D 0; j < sizeof(data->pressed_keys); j++) {
> > +		int key_code;
> > +		if (data->pressed_keys[j] =3D=3D 0)
> > +			continue;
> > +		for (i =3D 0; i < size; i++)
> > +			if (data->pressed_keys[j] =3D=3D raw_data[i])
> > +				goto key_still_down;
> > +		input_event(data->input_keys, EV_MSC, MSC_SCAN, data->pressed_ke=
ys[j]);
> > +		if (input_get_keycode(data->input_keys, data->pressed_keys[j], &=
key_code))
> > +			key_code =3D KEY_UNKNOWN;
> > +		if (key_code !=3D KEY_UNKNOWN) {
> > +			dbg_hid(PICOLCD_NAME " got key release for %u:%d", data->presse=
d_keys[j], key_code);
> > +			input_report_key(data->input_keys, key_code, 0);
> > +		}
> > +		input_sync(data->input_keys);
> > +		data->pressed_keys[j] =3D 0;
> > +key_still_down:
> > +		continue;
> > +	}
> > +	return 1;
> > +}
> > +
> > +static int picolcd_raw_cir(struct hid_device *hdev,
> > +		struct hid_report *report, u8 *raw_data, int size)
> > +{
> > +	/* Need understanding of CIR data format to implement ... */
> > +	return 1;
> > +}
> > +
> > +
> > +
> > +/*
> > + * Reset our device and wait for answer to VERSION request
> > + */
> > +static int picolcd_reset(struct hid_device *hdev)
> > +{
> > +	struct picolcd_data *data =3D hid_get_drvdata(hdev);
> > +	struct hid_report *report =3D picolcd_out_report(REPORT_RESET, hd=
ev);
> > +	struct picolcd_pending *verinfo;
> > +	unsigned long flags;
> > +
> > +	if (!data || !report || report->maxfield !=3D 1)
> > +		return -ENODEV;
> > +
> > +	spin_lock_irqsave(&data->lock, flags);
> > +	complete_all(&data->ready);
> > +	INIT_COMPLETION(data->ready);
> > +	if (hdev->product =3D=3D USB_DEVICE_ID_PICOLCD_BOOTLOADER)
> > +		data->status |=3D PICOLCD_BOOTLOADER;
> > +
> > +	/* perform the reset */
> > +	hid_set_field(report->field[0], 0, 1);
> > +	usbhid_submit_report(hdev, report, USB_DIR_OUT);
> > +	spin_unlock_irqrestore(&data->lock, flags);
> > +
> > +	verinfo =3D picolcd_send_and_wait(hdev, REPORT_VERSION, NULL, 0);
> > +	if (verinfo && verinfo->raw_size =3D=3D 2) {
> > +		if (data->status & PICOLCD_BOOTLOADER) {
> > +			dev_info(&hdev->dev, "PicoLCD reset successful, bootloader vers=
ion %d.%d\n",
> > +					verinfo->raw_data[0], verinfo->raw_data[1]);
> > +			data->version[0] =3D verinfo->raw_data[0];
> > +			data->version[1] =3D verinfo->raw_data[1];
> > +		} else {
> > +			dev_info(&hdev->dev, "PicoLCD reset successful, firmware versio=
n %d.%d\n",
> > +					verinfo->raw_data[1], verinfo->raw_data[0]);
> > +			data->version[0] =3D verinfo->raw_data[1];
> > +			data->version[1] =3D verinfo->raw_data[0];
> > +		}
> > +		kfree(verinfo);
> > +		verinfo =3D NULL;
> > +	} else if (verinfo) {
> > +		dev_err(&hdev->dev, "confused, got unexpected version response f=
rom PicoLCD after reset\n");
> > +		kfree(verinfo);
> > +		verinfo =3D NULL;
> > +	} else {
> > +		dev_err(&hdev->dev, "no version response from PicoLCD after rese=
t");
> > +		return -EBUSY;
> > +	}
> > +
>=20
> I am pretty sure it could be written clearer instead of checking for
> verinfo several times...
>=20
> 	if (!verinfo) {
> 		dev_err(..);
> 		return -EBUSY;
> 	}
>=20
> 	if (verinfo->raw_size =3D=3D 2) {
> 		...
> 	} else {
> 		dev_err(...)
> 	}
>=20
> 	kfree(verinfo);

See below

> > +	return 0;
> > +}
> > +
> > +/*
> > + * The "operation_mode" sysfs attribute
> > + */
> > +static ssize_t picolcd_operation_mode_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	struct picolcd_data *data =3D dev_get_drvdata(dev);
> > +
> > +	if (data->status & PICOLCD_BOOTLOADER)
> > +		return snprintf(buf, PAGE_SIZE, "<bootloader> lcd\n");
> > +	else
> > +		return snprintf(buf, PAGE_SIZE, "bootloader <lcd>\n");
> > +}
> > +
> > +static ssize_t picolcd_operation_mode_store(struct device *dev,
> > +		struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct picolcd_data *data =3D dev_get_drvdata(dev);
> > +	struct hid_report *report =3D NULL;
> > +	size_t cnt =3D count;
> > +	int timeout =3D 5000;
> > +	unsigned u;
> > +	unsigned long flags;
> > +
> > +	if (cnt >=3D 3 && strncmp("lcd", buf, 3) =3D=3D 0) {
> > +		if (data->status & PICOLCD_BOOTLOADER)
> > +			report =3D picolcd_out_report(REPORT_EXIT_FLASHER, data->hdev);
> > +		buf +=3D 3;
> > +		cnt -=3D 3;
> > +	} else if (cnt >=3D 10 && strncmp("bootloader", buf, 10) =3D=3D 0=
) {
> > +		if (!(data->status & PICOLCD_BOOTLOADER))
> > +			report =3D picolcd_out_report(REPORT_EXIT_KEYBOARD, data->hdev)=
;
> > +		buf +=3D 10;
> > +		cnt -=3D 10;
> > +	}
> > +	if (!report)
> > +		return -EINVAL;
> > +
> > +	while (cnt > 0 && (*buf =3D=3D ' ' || *buf =3D=3D '\t')) {
> > +		buf++;
> > +		cnt--;
> > +	}
> > +	while (cnt > 0 && (buf[cnt-1] =3D=3D '\n' || buf[cnt-1] =3D=3D '\=
r'))
> > +		cnt--;
> > +	if (cnt > 0) {
> > +		if (sscanf(buf, "%u", &u) !=3D 1)
> > +			return -EINVAL;
> > +		if (u > 30000)
> > +			return -EINVAL;
> > +		else
> > +			timeout =3D u;
> > +	}
> > +
> > +	spin_lock_irqsave(&data->lock, flags);
> > +	hid_set_field(report->field[0], 0, timeout & 0xff);
> > +	hid_set_field(report->field[0], 1, (timeout >> 8) & 0xff);
> > +	usbhid_submit_report(data->hdev, report, USB_DIR_OUT);
> > +	spin_unlock_irqrestore(&data->lock, flags);
> > +	return count;
> > +}
> > +
> > +static DEVICE_ATTR(operation_mode, 0644, picolcd_operation_mode_sh=
ow,
> > +		picolcd_operation_mode_store);
> > +
> > +
> > +#ifdef CONFIG_DEBUG_FS

=2E.. snip reports dumping to debugfs's events ...

> > +#else
> > +#define picolcd_debug_raw_event(data, hdev, report, raw_data, size=
)
> > +#endif
> > +
> > +/*
> > + * Handle raw report as sent by device
> > + */
> > +static int picolcd_raw_event(struct hid_device *hdev,
> > +		struct hid_report *report, u8 *raw_data, int size)
> > +{
> > +	struct picolcd_data *data =3D hid_get_drvdata(hdev);
> > +	unsigned long flags;
> > +	int ret =3D 0;
> > +
> > +	if (data =3D=3D NULL)
> > +		return 1;
> > +
> > +	if (report->id =3D=3D REPORT_KEY_STATE) {
> > +		if (data->input_keys)
> > +			ret =3D picolcd_raw_keypad(hdev, report, raw_data+1, size-1);
> > +	} else if (report->id =3D=3D REPORT_IR_DATA) {
> > +		if (data->input_cir)
> > +			ret =3D picolcd_raw_cir(hdev, report, raw_data+1, size-1);
> > +	} else {
> > +		spin_lock_irqsave(&data->lock, flags);
> > +		/*
> > +		 * We let the caller of picolcd_send_and_wait() check if the rep=
ort
> > +		 * we got is one of the expected ones or not.
> > +		 */
> > +		if (data->pending) {
> > +			memcpy(data->pending->raw_data, raw_data+1, size-1);
> > +			data->pending->raw_size  =3D size-1;
> > +			data->pending->in_report =3D report;
> > +			complete_all(&data->ready);
> > +		}
> > +		spin_unlock_irqrestore(&data->lock, flags);
> > +	}
> > +
> > +	picolcd_debug_raw_event(data, hdev, report, raw_data, size);
> > +	return 1;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int picolcd_suspend(struct hid_device *hdev)
> > +{
> > +	dbg_hid(PICOLCD_NAME " device ready for suspend\n");
> > +	return 0;
> > +}
> > +
> > +static int picolcd_resume(struct hid_device *hdev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int picolcd_reset_resume(struct hid_device *hdev)
> > +{
> > +	int ret;
> > +	ret =3D picolcd_reset(hdev);
> > +	if (ret)
> > +		dbg_hid(PICOLCD_NAME " resetting our device failed: %d\n", ret);
> > +	return 0;
> > +}
> > +#endif
> > +
> > +/* initialize keypad input device */
> > +static inline int picolcd_init_keys(struct picolcd_data *data,
> > +		struct hid_report *report)
> > +{
> > +	struct hid_device *hdev =3D data->hdev;
> > +	struct input_dev *idev;
> > +	int error, i;
> > +
> > +	if (!report)
> > +		return -ENODEV;
> > +	if (report->maxfield !=3D 1 || report->field[0]->report_count !=3D=
 2 ||
> > +			report->field[0]->report_size !=3D 8) {
> > +		dev_err(&hdev->dev, "unsupported KEY_STATE report");
> > +		return -EINVAL;
> > +	}
> > +
> > +	idev =3D input_allocate_device();
> > +	if (idev =3D=3D NULL) {
> > +		dev_err(&hdev->dev, "failed to allocate input device");
> > +		return -ENOMEM;
> > +	}
> > +	input_set_drvdata(idev, hdev);
> > +	memcpy(data->keycode, def_keymap, sizeof(def_keymap));
> > +	idev->name =3D hdev->name;
> > +	idev->phys =3D hdev->phys;
> > +	idev->uniq =3D hdev->uniq;
> > +	idev->id.bustype =3D hdev->bus;
> > +	idev->id.vendor  =3D hdev->vendor;
> > +	idev->id.product =3D hdev->product;
> > +	idev->id.version =3D hdev->version;
> > +	idev->dev.parent =3D hdev->dev.parent;
> > +	idev->keycode     =3D &data->keycode;
> > +	idev->keycodemax  =3D PICOLCD_KEYS;
> > +	idev->keycodesize =3D sizeof(int);
> > +	input_set_capability(idev, EV_MSC, MSC_SCAN);
> > +	set_bit(EV_REP, idev->evbit);
> > +	for (i =3D 0; i < PICOLCD_KEYS; i++) {
> > +		int key =3D ((int *)idev->keycode)[i];
> > +		if (key < KEY_MAX && key >=3D 0)
> > +			input_set_capability(idev, EV_KEY, key);
> > +	}
> > +	error =3D input_register_device(idev);
> > +	if (error) {
> > +		dev_err(&hdev->dev, "error registering the input device");
> > +		input_free_device(idev);
> > +		return error;
> > +	}
> > +	data->input_keys =3D idev;
> > +	return 0;
> > +}
> > +
> > +static void picolcd_exit_keys(struct picolcd_data *data)
> > +{
> > +	struct input_dev *idev =3D data->input_keys;
> > +
> > +	data->input_keys =3D NULL;
> > +	if (idev)
> > +		input_unregister_device(idev);
> > +}
> > +
> > +/* initialize CIR input device */
> > +static inline int picolcd_init_cir(struct picolcd_data *data, stru=
ct hid_report *report)
> > +{
> > +	/* support not implemented yet */
> > +	return 0;
> > +}
> > +
> > +static void picolcd_exit_cir(struct picolcd_data *data)
> > +{
> > +}
> > +
> > +static inline int picolcd_probe_lcd(struct hid_device *hdev, struc=
t picolcd_data *data)
> > +{
> > +	struct picolcd_pending *verinfo;
> > +	struct hid_report *report;
> > +	int error;
> > +
> > +	verinfo =3D picolcd_send_and_wait(hdev, REPORT_VERSION, NULL, 0);
> > +	if (!verinfo || !verinfo->in_report) {
> > +		kfree(verinfo);
> > +		dev_err(&hdev->dev, "failed to query FW version of device\n");
> > +		return -ENODEV;
> > +	} else if (verinfo->in_report->id =3D=3D REPORT_VERSION && verinf=
o->raw_size =3D=3D 2) {
> > +		dev_info(&hdev->dev, "detected PicoLCD with firmware version %d.=
%d\n",
> > +				verinfo->raw_data[0], verinfo->raw_data[1]);
> > +		data->version[0] =3D verinfo->raw_data[1];
> > +		data->version[1] =3D verinfo->raw_data[0];
> > +		if (data->version[0] !=3D 0 && data->version[1] !=3D 3)
> > +			dev_info(&hdev->dev, "Device with untested firmware revision, "
> > +				"please submit /sys/kernel/debug/hid/%s/rdesc for this device.=
\n",
> > +				dev_name(&hdev->dev));
> > +		kfree(verinfo);
> > +		verinfo =3D NULL;
> > +	} else {
> > +		dev_err(&hdev->dev, "unexpected version response from PicoLCD"
> > +				" (report=3D0x%02x, size=3D%d)\n",
> > +				verinfo->in_report->id, verinfo->raw_size);
> > +		kfree(verinfo);
> > +		verinfo =3D NULL;
> > +		return -ENODEV;
> > +	}
>=20
>=20
> Please consolidate freeing of acquired resources.

See below

> > +
> > +	/* Setup keypad input device */
> > +	error =3D picolcd_init_keys(data, picolcd_in_report(REPORT_KEY_ST=
ATE, hdev));
> > +	if (error)
> > +		goto err;
> > +
> > +	/* Setup CIR input device */
> > +	error =3D picolcd_init_cir(data, picolcd_in_report(REPORT_IR_DATA=
, hdev));
> > +	if (error)
> > +		goto err;
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +	report =3D picolcd_out_report(REPORT_READ_MEMORY, hdev);
> > +	if (report && report->maxfield =3D=3D 1 && report->field[0]->repo=
rt_size =3D=3D 8)
> > +		data->addr_sz =3D report->field[0]->report_count - 1;
> > +	else
> > +		data->addr_sz =3D -1;
> > +#endif
> > +	return 0;
> > +err:
> > +	picolcd_exit_cir(data);
> > +	picolcd_exit_keys(data);
> > +	return error;
> > +}
> > +
> > +static inline int picolcd_probe_bootloader(struct hid_device *hdev=
, struct picolcd_data *data)
> > +{
> > +	struct picolcd_pending *verinfo;
> > +	struct hid_report *report;
> > +
> > +	verinfo =3D picolcd_send_and_wait(hdev, REPORT_VERSION, NULL, 0);
> > +	if (!verinfo || !verinfo->in_report) {
> > +		kfree(verinfo);
> > +		dev_err(&hdev->dev, "failed to query FW version of device\n");
> > +		return -ENODEV;
> > +	} else if (verinfo->in_report->id =3D=3D REPORT_VERSION && verinf=
o->raw_size =3D=3D 2) {
> > +		dev_info(&hdev->dev, "detected PicoLCD with bootloader version %=
d.%d\n",
> > +				verinfo->raw_data[1], verinfo->raw_data[0]);
> > +		data->version[0] =3D verinfo->raw_data[1];
> > +		data->version[1] =3D verinfo->raw_data[0];
> > +		if (data->version[0] !=3D 1 && data->version[1] !=3D 0)
> > +			dev_info(&hdev->dev, "Device with untested bootloader revision,=
 "
> > +				"please submit /sys/kernel/debug/hid/%s/rdesc for this device.=
\n",
> > +				dev_name(&hdev->dev));
> > +		kfree(verinfo);
> > +		verinfo =3D NULL;
> > +	} else {
> > +		dev_err(&hdev->dev, "unexpected version response from PicoLCD"
> > +				" (report=3D0x%02x, size=3D%d)\n",
> > +				verinfo->in_report->id, verinfo->raw_size);
> > +		kfree(verinfo);
> > +		verinfo =3D NULL;
> > +		return -ENODEV;
> > +	}
> >=20
>=20
> Please consolidate freeing of acquired resources. Wait, I just saw
> afucntion like that... can we combine them somehow?

Yeah, there are 3 blocks of very similar code though the important
difference is the operation mode (bootloader versus firmware).
According to the behavior and what bootloader mode displays
the version numbers are not in the same order for both cases.

The code distribution was looking worse some internal revisions ago
as by then I did allocate verinfo->raw_data separately ...

Will try to extract version check to a function.

> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +	report =3D picolcd_out_report(REPORT_BL_READ_MEMORY, hdev);
> > +	if (report && report->maxfield =3D=3D 1 && report->field[0]->repo=
rt_size =3D=3D 8)
> > +		data->addr_sz =3D report->field[0]->report_count - 1;
> > +	else
> > +		data->addr_sz =3D -1;
> > +#endif
> > +	return 0;
> > +}
> > +
> > +static int picolcd_probe(struct hid_device *hdev,
> > +		     const struct hid_device_id *id)
> > +{
> > +	struct picolcd_data *data;
> > +	int error =3D -ENOMEM;
> > +
> > +	dbg_hid(PICOLCD_NAME " hardware probe...\n");
> > +
> > +	/*
> > +	 * Let's allocate the picolcd data structure, set some reasonable
> > +	 * defaults, and associate it with the device
> > +	 */
> > +	data =3D kzalloc(sizeof(struct picolcd_data), GFP_KERNEL);
> > +	if (data =3D=3D NULL) {
> > +		dev_err(&hdev->dev, "can't allocate space for Minibox PicoLCD de=
vice data\n");
> > +		error =3D -ENOMEM;
> > +		goto err_no_cleanup;
> > +	}
> > +
> > +	spin_lock_init(&data->lock);
> > +	init_completion(&data->ready);
> > +	data->hdev =3D hdev;
> > +	if (hdev->product =3D=3D USB_DEVICE_ID_PICOLCD_BOOTLOADER)
> > +		data->status |=3D PICOLCD_BOOTLOADER;
> > +	hid_set_drvdata(hdev, data);
> > +
> > +	/* Parse the device reports and start it up */
> > +	error =3D hid_parse(hdev);
> > +	if (error) {
> > +		dev_err(&hdev->dev, "device report parse failed\n");
> > +		goto err_cleanup_data;
> > +	}
> > +
> > +	/* We don't use hidinput but hid_hw_start() fails if nothing is
> > +	 * claimed. So spoof claimed input. */
> > +	hdev->claimed =3D HID_CLAIMED_INPUT;
> > +	error =3D hid_hw_start(hdev, 0);
> > +	hdev->claimed =3D 0;
> > +	if (error) {
> > +		dev_err(&hdev->dev, "hardware start failed\n");
> > +		goto err_cleanup_data;
> > +	}
> > +
> > +	error =3D hdev->ll_driver->open(hdev);
> > +	if (error) {
> > +		dev_err(&hdev->dev, "failed to open input interrupt pipe for key=
 and IR events\n");
> > +		goto err_cleanup_hid_hw;
> > +	}
> > +
> > +	error =3D sysfs_create_file(&(hdev->dev.kobj), &dev_attr_operatio=
n_mode.attr);
>=20
> device_create_file?

Thanks for the pointer, will switch

> > +	if (error) {
> > +		dev_err(&hdev->dev, "failed to create sysfs attributes\n");
> > +		goto err_cleanup_hid_ll;
> > +	}
> > +

Thanks for your review,
Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

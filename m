From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/3] mfd: apple-ibridge: Add Apple iBridge MFD driver.
Date: Mon, 22 Apr 2019 12:34:26 +0100
Message-ID: <20190422123426.2d0b4bdf@archlinux>
References: <20190422031251.11968-1-ronald@innovation.ch>
        <20190422031251.11968-2-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422031251.11968-2-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ronald =?UTF-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 21 Apr 2019 20:12:49 -0700
Ronald Tschal=C3=A4r <ronald@innovation.ch> wrote:

> The iBridge device provides access to several devices, including:
> - the Touch Bar
> - the iSight webcam
> - the light sensor
> - the fingerprint sensor
>=20
> This driver provides the core support for managing the iBridge device
> and the access to the underlying devices. In particular, since the
> functionality for the touch bar and light sensor is exposed via USB HID
> interfaces, and the same HID device is used for multiple functions, this
> driver provides a multiplexing layer that allows multiple HID drivers to
> be registered for a given HID device. This allows the touch bar and ALS
> driver to be separated out into their own modules.
>=20
> Signed-off-by: Ronald Tschal=C3=A4r <ronald@innovation.ch
Hi Ronald,

I've only taken a fairly superficial look at this.  A few global
things to note though.

1. Please either use kernel-doc style for function descriptions, or
   do not.  Right now you are sort of half way there.
2. There is quite a complex nest of separate structures being allocated,
   so think about whether they can be simplified.  In particular
   use of container_of macros can allow a lot of forwards and backwards
   pointers to be dropped if you embed the various structures directly.

This obviously needs hid and mfd review though as neither is my
area of expertise!

Jonathan
>
> ---
>  drivers/mfd/Kconfig               |  15 +
>  drivers/mfd/Makefile              |   1 +
>  drivers/mfd/apple-ibridge.c       | 883 ++++++++++++++++++++++++++++++
>  include/linux/mfd/apple-ibridge.h |  39 ++
>  4 files changed, 938 insertions(+)
>  create mode 100644 drivers/mfd/apple-ibridge.c
>  create mode 100644 include/linux/mfd/apple-ibridge.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 76f9909cf396..d55fa77faacf 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1916,5 +1916,20 @@ config RAVE_SP_CORE
>  	  Select this to get support for the Supervisory Processor
>  	  device found on several devices in RAVE line of hardware.
> =20
> +config MFD_APPLE_IBRIDGE
> +	tristate "Apple iBridge chip"
> +	depends on ACPI
> +	depends on USB_HID
> +	depends on X86 || COMPILE_TEST
> +	select MFD_CORE
> +	help
> +	  This MFD provides the core support for the Apple iBridge chip
> +	  found on recent MacBookPro's. The drivers for the Touch Bar
> +	  (apple-ib-tb) and light sensor (apple-ib-als) need to be
> +	  enabled separately.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called apple-ibridge.
> +
>  endmenu
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 12980a4ad460..c364e0e9d313 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -241,4 +241,5 @@ obj-$(CONFIG_MFD_MXS_LRADC)     +=3D mxs-lradc.o
>  obj-$(CONFIG_MFD_SC27XX_PMIC)	+=3D sprd-sc27xx-spi.o
>  obj-$(CONFIG_RAVE_SP_CORE)	+=3D rave-sp.o
>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+=3D rohm-bd718x7.o
> +obj-$(CONFIG_MFD_APPLE_IBRIDGE)	+=3D apple-ibridge.o
> =20
> diff --git a/drivers/mfd/apple-ibridge.c b/drivers/mfd/apple-ibridge.c
> new file mode 100644
> index 000000000000..56d325396961
> --- /dev/null
> +++ b/drivers/mfd/apple-ibridge.c
> @@ -0,0 +1,883 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Apple iBridge Driver
> + *
> + * Copyright (c) 2018 Ronald Tschal=C3=A4r
> + */
> +
> +/**
> + * MacBookPro models with a Touch Bar (13,[23] and 14,[23]) have an Apple
> + * iBridge chip (also known as T1 chip) which exposes the touch bar,
> + * built-in webcam (iSight), ambient light sensor, and Secure Enclave
> + * Processor (SEP) for TouchID. It shows up in the system as a USB device
> + * with 3 configurations: 'Default iBridge Interfaces', 'Default iBridge
> + * Interfaces(OS X)', and 'Default iBridge Interfaces(Recovery)'. While
> + * the second one is used by MacOS to provide the fancy touch bar
> + * functionality with custom buttons etc, this driver just uses the firs=
t.
> + *
> + * In the first (default after boot) configuration, 4 usb interfaces are
> + * exposed: 2 related to the webcam, and 2 USB HID interfaces representi=
ng
> + * the touch bar and the ambient light sensor (and possibly the SEP,
> + * though at this point in time nothing is known about that). The webcam
> + * interfaces are already handled by the uvcvideo driver; furthermore, t=
he
> + * handling of the input reports when "keys" on the touch bar are pressed
> + * is already handled properly by the generic USB HID core. This leaves
> + * the management of the touch bar modes (e.g. switching between function
> + * and special keys when the FN key is pressed), the touch bar display
> + * (dimming and turning off), the key-remapping when the FN key is
> + * pressed, and handling of the light sensor.
> + *
> + * This driver is implemented as an MFD driver, with the touch bar and A=
LS
> + * functions implemented by appropriate subdrivers (mfd cells). Because
> + * both those are basically hid drivers, but the current kernel driver
> + * structure does not allow more than one driver per device, this driver
> + * implements a demuxer for hid drivers: it registers itself as a hid
> + * driver with the core, and in turn it lets the subdrivers register
> + * themselves as hid drivers with this driver; the callbacks from the co=
re
> + * are then forwarded to the subdrivers.
> + *
> + * Lastly, this driver also takes care of the power-management for the
> + * iBridge when suspending and resuming.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/list.h>
> +#include <linux/mfd/apple-ibridge.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/rculist.h>
> +#include <linux/slab.h>
> +#include <linux/srcu.h>
> +#include <linux/usb.h>
> +
> +#include "../hid/usbhid/usbhid.h"
> +
> +#define USB_ID_VENDOR_APPLE	0x05ac
> +#define USB_ID_PRODUCT_IBRIDGE	0x8600
> +
> +#define APPLETB_BASIC_CONFIG	1
> +
> +#define	LOG_DEV(ib_dev)		(&(ib_dev)->acpi_dev->dev)
> +
> +struct appleib_device {
> +	struct acpi_device	*acpi_dev;
> +	acpi_handle		asoc_socw;
> +	struct list_head	hid_drivers;
> +	struct list_head	hid_devices;
> +	struct mfd_cell		*subdevs;
> +	struct mutex		update_lock; /* protect updates to all lists */
> +	struct srcu_struct	lists_srcu;
> +	bool			in_hid_probe;
> +};
> +
> +struct appleib_hid_drv_info {
> +	struct list_head	entry;
> +	struct hid_driver	*driver;
> +	void			*driver_data;
> +};
> +
> +struct appleib_hid_dev_info {
> +	struct list_head		entry;
> +	struct list_head		drivers;
> +	struct hid_device		*device;
> +	const struct hid_device_id	*device_id;
> +	bool				started;
> +};
> +
> +static const struct mfd_cell appleib_subdevs[] =3D {
> +	{ .name =3D PLAT_NAME_IB_TB },
> +	{ .name =3D PLAT_NAME_IB_ALS },
> +};
> +
> +static struct appleib_device *appleib_dev;
> +
> +#define	call_void_driver_func(drv_info, fn, ...)			\

This sort of macro may seem like a good idea because it saves a few lines
of code.  However, that comes at the cost of readability, so just
put the code inline.

> +	do {								\
> +		if ((drv_info)->driver->fn)				\
> +			(drv_info)->driver->fn(__VA_ARGS__);		\
> +	} while (0)
> +
> +#define	call_driver_func(drv_info, fn, ret_type, ...)			\
> +	({								\
> +		ret_type rc =3D 0;					\
> +									\
> +		if ((drv_info)->driver->fn)				\
> +			rc =3D (drv_info)->driver->fn(__VA_ARGS__);	\
> +									\
> +		rc;							\
> +	})
> +
> +static void appleib_remove_driver(struct appleib_device *ib_dev,
> +				  struct appleib_hid_drv_info *drv_info,
> +				  struct appleib_hid_dev_info *dev_info)
> +{
> +	list_del_rcu(&drv_info->entry);
> +	synchronize_srcu(&ib_dev->lists_srcu);
> +
> +	call_void_driver_func(drv_info, remove, dev_info->device);
> +
> +	kfree(drv_info);
> +}
> +
> +static int appleib_probe_driver(struct appleib_hid_drv_info *drv_info,
> +				struct appleib_hid_dev_info *dev_info)
> +{
> +	struct appleib_hid_drv_info *d;
> +	int rc =3D 0;
> +
> +	rc =3D call_driver_func(drv_info, probe, int, dev_info->device,
> +			      dev_info->device_id);
> +	if (rc)
> +		return rc;
> +
> +	d =3D kmemdup(drv_info, sizeof(*drv_info), GFP_KERNEL);
> +	if (!d) {
> +		call_void_driver_func(drv_info, remove, dev_info->device);
> +		return -ENOMEM;
> +	}
> +
> +	list_add_tail_rcu(&d->entry, &dev_info->drivers);
> +	return 0;
> +}
> +
> +static void appleib_remove_driver_attachments(struct appleib_device *ib_=
dev,
> +					struct appleib_hid_dev_info *dev_info,
> +					struct hid_driver *driver)
> +{
> +	struct appleib_hid_drv_info *drv_info;
> +	struct appleib_hid_drv_info *tmp;
> +
> +	list_for_each_entry_safe(drv_info, tmp, &dev_info->drivers, entry) {
> +		if (!driver || drv_info->driver =3D=3D driver)
> +			appleib_remove_driver(ib_dev, drv_info, dev_info);
> +	}
> +}
> +
> +/*
> + * Find all devices that are attached to this driver and detach them.
> + *
> + * Note: this must be run with update_lock held.
> + */
> +static void appleib_detach_devices(struct appleib_device *ib_dev,
> +				   struct hid_driver *driver)
> +{
> +	struct appleib_hid_dev_info *dev_info;
> +
> +	list_for_each_entry(dev_info, &ib_dev->hid_devices, entry)
> +		appleib_remove_driver_attachments(ib_dev, dev_info, driver);
> +}
> +
> +/*
> + * Find all drivers that are attached to this device and detach them.
> + *
> + * Note: this must be run with update_lock held.
> + */
> +static void appleib_detach_drivers(struct appleib_device *ib_dev,
> +				   struct appleib_hid_dev_info *dev_info)
> +{
> +	appleib_remove_driver_attachments(ib_dev, dev_info, NULL);
> +}
> +
> +/**
> + * Unregister a previously registered HID driver from us.
> + * @ib_dev: the appleib_device from which to unregister the driver
> + * @driver: the driver to unregister
> + */
> +int appleib_unregister_hid_driver(struct appleib_device *ib_dev,
> +				  struct hid_driver *driver)
> +{
> +	struct appleib_hid_drv_info *drv_info;
> +
> +	mutex_lock(&ib_dev->update_lock);
> +
> +	list_for_each_entry(drv_info, &ib_dev->hid_drivers, entry) {
> +		if (drv_info->driver =3D=3D driver) {

This block does look like it perhaps should be in helper function?
Would help with readability.

> +			appleib_detach_devices(ib_dev, driver);
> +			list_del_rcu(&drv_info->entry);
> +			mutex_unlock(&ib_dev->update_lock);
> +			synchronize_srcu(&ib_dev->lists_srcu);
> +			kfree(drv_info);
> +			dev_info(LOG_DEV(ib_dev), "unregistered driver '%s'\n",
> +				 driver->name);
> +			return 0;
> +		}
> +	}
> +
> +	mutex_unlock(&ib_dev->update_lock);
> +
> +	return -ENOENT;
> +}
> +EXPORT_SYMBOL_GPL(appleib_unregister_hid_driver);
> +
> +static int appleib_start_hid_events(struct appleib_hid_dev_info *dev_inf=
o)
> +{
> +	struct hid_device *hdev =3D dev_info->device;
> +	int rc;
> +
> +	rc =3D hid_connect(hdev, HID_CONNECT_DEFAULT);
> +	if (rc) {
> +		hid_err(hdev, "ib: hid connect failed (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	rc =3D hid_hw_open(hdev);
> +	if (rc) {
> +		hid_err(hdev, "ib: failed to open hid: %d\n", rc);
> +		hid_disconnect(hdev);
> +	}
> +
> +	if (!rc)
> +		dev_info->started =3D true;
> +
> +	return rc;
> +}
> +
> +static void appleib_stop_hid_events(struct appleib_hid_dev_info *dev_inf=
o)
> +{
> +	if (dev_info->started) {
> +		hid_hw_close(dev_info->device);
> +		hid_disconnect(dev_info->device);
> +		dev_info->started =3D false;
> +	}
> +}
> +
> +/**
> + * Register a HID driver with us.
> + * @ib_dev: the appleib_device with which to register the driver
> + * @driver: the driver to register
> + * @data: the driver-data to associate with the driver; this is available
> + *        from appleib_get_drvdata(...).
> + */
> +int appleib_register_hid_driver(struct appleib_device *ib_dev,
> +				struct hid_driver *driver, void *data)
> +{
> +	struct appleib_hid_drv_info *drv_info;
> +	struct appleib_hid_dev_info *dev_info;
> +	int rc;
> +
> +	if (!driver->probe)
> +		return -EINVAL;
> +
> +	drv_info =3D kzalloc(sizeof(*drv_info), GFP_KERNEL);
> +	if (!drv_info)
> +		return -ENOMEM;
> +
> +	drv_info->driver =3D driver;
> +	drv_info->driver_data =3D data;
> +
> +	mutex_lock(&ib_dev->update_lock);
> +
> +	list_add_tail_rcu(&drv_info->entry, &ib_dev->hid_drivers);
> +
> +	list_for_each_entry(dev_info, &ib_dev->hid_devices, entry) {
> +		appleib_stop_hid_events(dev_info);
> +
> +		appleib_probe_driver(drv_info, dev_info);
> +
> +		rc =3D appleib_start_hid_events(dev_info);
> +		if (rc)
> +			appleib_detach_drivers(ib_dev, dev_info);
> +	}
> +
> +	mutex_unlock(&ib_dev->update_lock);
> +
> +	dev_info(LOG_DEV(ib_dev), "registered driver '%s'\n", driver->name);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(appleib_register_hid_driver);
> +
> +/**
> + * Get the driver-specific data associated with the given, previously
> + * registered HID driver (provided in the appleib_register_hid_driver()
> + * call).
> + * @ib_dev: the appleib_device with which the driver was registered
> + * @driver: the driver for which to get the data
> + */
> +void *appleib_get_drvdata(struct appleib_device *ib_dev,
> +			  struct hid_driver *driver)
> +{
> +	struct appleib_hid_drv_info *drv_info;
> +	void *drv_data =3D NULL;
> +	int idx;
> +
> +	idx =3D srcu_read_lock(&ib_dev->lists_srcu);
> +
> +	list_for_each_entry_rcu(drv_info, &ib_dev->hid_drivers, entry) {
> +		if (drv_info->driver =3D=3D driver) {
> +			drv_data =3D drv_info->driver_data;
> +			break;
> +		}
> +	}
> +
> +	srcu_read_unlock(&ib_dev->lists_srcu, idx);
> +
> +	return drv_data;
> +}
> +EXPORT_SYMBOL_GPL(appleib_get_drvdata);
> +
> +/*
> + * Forward a hid-driver callback to all registered sub-drivers. This is =
for
> + * callbacks that return a status as an int.
> + * @hdev the hid-device
> + * @forward a function that calls the callback on the given driver
> + * @args arguments for the forward function
> + */
> +static int appleib_forward_int_op(struct hid_device *hdev,
> +				  int (*forward)(struct appleib_hid_drv_info *,
> +						 struct hid_device *, void *),
> +				  void *args)
> +{
> +	struct appleib_device *ib_dev =3D hid_get_drvdata(hdev);
> +	struct appleib_hid_dev_info *dev_info;
> +	struct appleib_hid_drv_info *drv_info;
> +	int idx;
> +	int rc =3D 0;
> +
> +	idx =3D srcu_read_lock(&ib_dev->lists_srcu);
> +
> +	list_for_each_entry_rcu(dev_info, &ib_dev->hid_devices, entry) {
> +		if (dev_info->device !=3D hdev)
> +			continue;
> +
> +		list_for_each_entry_rcu(drv_info, &dev_info->drivers, entry) {
> +			rc =3D forward(drv_info, hdev, args);
> +			if (rc)
> +				break;
> +		}
> +
> +		break;
> +	}
> +
> +	srcu_read_unlock(&ib_dev->lists_srcu, idx);
> +
> +	return rc;
> +}
> +
> +struct appleib_hid_event_args {
> +	struct hid_field *field;
> +	struct hid_usage *usage;
> +	__s32 value;
> +};
> +
> +static int appleib_hid_event_fwd(struct appleib_hid_drv_info *drv_info,
> +				 struct hid_device *hdev, void *args)
> +{
> +	struct appleib_hid_event_args *evt_args =3D args;
> +
> +	return call_driver_func(drv_info, event, int, hdev, evt_args->field,
> +				evt_args->usage, evt_args->value);
> +}
> +
> +static int appleib_hid_event(struct hid_device *hdev, struct hid_field *=
field,
> +			     struct hid_usage *usage, __s32 value)
> +{
> +	struct appleib_hid_event_args args =3D {
> +		.field =3D field,
> +		.usage =3D usage,
> +		.value =3D value,
> +	};
> +
> +	return appleib_forward_int_op(hdev, appleib_hid_event_fwd, &args);
> +}
> +
> +static __u8 *appleib_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> +				  unsigned int *rsize)
> +{
> +	/* Some fields have a size of 64 bits, which according to HID 1.11
> +	 * Section 8.4 is not valid ("An item field cannot span more than 4
> +	 * bytes in a report"). Furthermore, hid_field_extract() complains
> +	 * when encountering such a field. So turn them into two 32-bit fields
> +	 * instead.
> +	 */
> +
> +	if (*rsize =3D=3D 634 &&
> +	    /* Usage Page 0xff12 (vendor defined) */
> +	    rdesc[212] =3D=3D 0x06 && rdesc[213] =3D=3D 0x12 && rdesc[214] =3D=
=3D 0xff &&
> +	    /* Usage 0x51 */
> +	    rdesc[416] =3D=3D 0x09 && rdesc[417] =3D=3D 0x51 &&
> +	    /* report size 64 */
> +	    rdesc[432] =3D=3D 0x75 && rdesc[433] =3D=3D 64 &&
> +	    /* report count 1 */
> +	    rdesc[434] =3D=3D 0x95 && rdesc[435] =3D=3D 1) {
> +		rdesc[433] =3D 32;
> +		rdesc[435] =3D 2;
> +		hid_dbg(hdev, "Fixed up first 64-bit field\n");
> +	}
> +
> +	if (*rsize =3D=3D 634 &&
> +	    /* Usage Page 0xff12 (vendor defined) */
> +	    rdesc[212] =3D=3D 0x06 && rdesc[213] =3D=3D 0x12 && rdesc[214] =3D=
=3D 0xff &&
> +	    /* Usage 0x51 */
> +	    rdesc[611] =3D=3D 0x09 && rdesc[612] =3D=3D 0x51 &&
> +	    /* report size 64 */
> +	    rdesc[627] =3D=3D 0x75 && rdesc[628] =3D=3D 64 &&
> +	    /* report count 1 */
> +	    rdesc[629] =3D=3D 0x95 && rdesc[630] =3D=3D 1) {
> +		rdesc[628] =3D 32;
> +		rdesc[630] =3D 2;
> +		hid_dbg(hdev, "Fixed up second 64-bit field\n");
> +	}
> +
> +	return rdesc;
> +}
> +
> +static int appleib_input_configured_fwd(struct appleib_hid_drv_info *drv=
_info,
> +					struct hid_device *hdev, void *args)
> +{
> +	return call_driver_func(drv_info, input_configured, int, hdev,
> +				(struct hid_input *)args);
> +}
> +
> +static int appleib_input_configured(struct hid_device *hdev,
> +				    struct hid_input *hidinput)
> +{
> +	return appleib_forward_int_op(hdev, appleib_input_configured_fwd,
> +				      hidinput);
> +}
> +
> +#ifdef CONFIG_PM
> +static int appleib_hid_suspend_fwd(struct appleib_hid_drv_info *drv_info,
> +				   struct hid_device *hdev, void *args)
> +{
> +	return call_driver_func(drv_info, suspend, int, hdev,
> +				*(pm_message_t *)args);
> +}
> +
> +static int appleib_hid_suspend(struct hid_device *hdev, pm_message_t mes=
sage)
> +{
> +	return appleib_forward_int_op(hdev, appleib_hid_suspend_fwd, &message);
> +}
> +
> +static int appleib_hid_resume_fwd(struct appleib_hid_drv_info *drv_info,
> +				  struct hid_device *hdev, void *args)
> +{
> +	return call_driver_func(drv_info, resume, int, hdev);
> +}
> +
> +static int appleib_hid_resume(struct hid_device *hdev)
> +{
> +	return appleib_forward_int_op(hdev, appleib_hid_resume_fwd, NULL);
> +}
> +
> +static int appleib_hid_reset_resume_fwd(struct appleib_hid_drv_info *drv=
_info,
> +					struct hid_device *hdev, void *args)
> +{
> +	return call_driver_func(drv_info, reset_resume, int, hdev);
> +}
> +
> +static int appleib_hid_reset_resume(struct hid_device *hdev)
> +{
> +	return appleib_forward_int_op(hdev, appleib_hid_reset_resume_fwd, NULL);
> +}
> +#endif /* CONFIG_PM */
> +
> +/**
> + * Find the field in the report with the given usage.
> + * @report: the report to search
> + * @field_usage: the usage of the field to search for
> + */
> +struct hid_field *appleib_find_report_field(struct hid_report *report,
> +					    unsigned int field_usage)
> +{
> +	int f, u;
> +
> +	for (f =3D 0; f < report->maxfield; f++) {
> +		struct hid_field *field =3D report->field[f];
> +
> +		if (field->logical =3D=3D field_usage)
> +			return field;
> +
> +		for (u =3D 0; u < field->maxusage; u++) {
> +			if (field->usage[u].hid =3D=3D field_usage)
> +				return field;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(appleib_find_report_field);
> +
> +/**

Please use correct kernel-doc style rather than parts of it.

> + * Search all the reports of the device for the field with the given usa=
ge.
> + * @hdev: the device whose reports to search
> + * @application: the usage of application collection that the field must
> + *               belong to
> + * @field_usage: the usage of the field to search for
> + */
> +struct hid_field *appleib_find_hid_field(struct hid_device *hdev,
> +					 unsigned int application,
> +					 unsigned int field_usage)
> +{
> +	static const int report_types[] =3D { HID_INPUT_REPORT, HID_OUTPUT_REPO=
RT,
> +					    HID_FEATURE_REPORT };
> +	struct hid_report *report;
> +	struct hid_field *field;
> +	int t;
> +
> +	for (t =3D 0; t < ARRAY_SIZE(report_types); t++) {
> +		struct list_head *report_list =3D
> +			    &hdev->report_enum[report_types[t]].report_list;
> +		list_for_each_entry(report, report_list, list) {
> +			if (report->application !=3D application)
> +				continue;
> +
> +			field =3D appleib_find_report_field(report, field_usage);
> +			if (field)
> +				return field;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(appleib_find_hid_field);
> +
> +/**
> + * Return whether we're currently inside a hid_device_probe or not.
> + * @ib_dev: the appleib_device
> + */
> +bool appleib_in_hid_probe(struct appleib_device *ib_dev)
> +{
> +	return ib_dev->in_hid_probe;
> +}
> +EXPORT_SYMBOL_GPL(appleib_in_hid_probe);
> +
> +static struct appleib_hid_dev_info *
> +appleib_add_device(struct appleib_device *ib_dev, struct hid_device *hde=
v,
> +		   const struct hid_device_id *id)
> +{
> +	struct appleib_hid_dev_info *dev_info;
> +	struct appleib_hid_drv_info *drv_info;
> +
> +	/* allocate device-info for this device */
> +	dev_info =3D kzalloc(sizeof(*dev_info), GFP_KERNEL);
> +	if (!dev_info)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&dev_info->drivers);
> +	dev_info->device =3D hdev;
> +	dev_info->device_id =3D id;
> +
> +	/* notify all our sub drivers */
> +	mutex_lock(&ib_dev->update_lock);
> +
This is interesting. I'd like to see a comment here on what
this flag is going to do.=20

> +	ib_dev->in_hid_probe =3D true;
> +
> +	list_for_each_entry(drv_info, &ib_dev->hid_drivers, entry) {
> +		appleib_probe_driver(drv_info, dev_info);
> +	}
> +
> +	ib_dev->in_hid_probe =3D false;
> +
> +	/* remember this new device */
> +	list_add_tail_rcu(&dev_info->entry, &ib_dev->hid_devices);
> +
> +	mutex_unlock(&ib_dev->update_lock);
> +
> +	return dev_info;
> +}
> +
> +static void appleib_remove_device(struct appleib_device *ib_dev,
> +				  struct appleib_hid_dev_info *dev_info)
> +{
> +	list_del_rcu(&dev_info->entry);
> +	synchronize_srcu(&ib_dev->lists_srcu);
> +
> +	appleib_detach_drivers(ib_dev, dev_info);
> +
> +	kfree(dev_info);
> +}
> +
> +static int appleib_hid_probe(struct hid_device *hdev,
> +			     const struct hid_device_id *id)
> +{
> +	struct appleib_device *ib_dev;
> +	struct appleib_hid_dev_info *dev_info;
> +	struct usb_device *udev;
> +	int rc;
> +
> +	/* check usb config first */
> +	udev =3D hid_to_usb_dev(hdev);
> +
> +	if (udev->actconfig->desc.bConfigurationValue !=3D APPLETB_BASIC_CONFIG=
) {
> +		rc =3D usb_driver_set_configuration(udev, APPLETB_BASIC_CONFIG);
> +		return rc ? rc : -ENODEV;
> +	}
> +
> +	/* Assign the driver data */
> +	ib_dev =3D appleib_dev;
> +	hid_set_drvdata(hdev, ib_dev);
> +
> +	/* initialize the report info */
> +	rc =3D hid_parse(hdev);
> +	if (rc) {
> +		hid_err(hdev, "ib: hid parse failed (%d)\n", rc);
> +		goto error;
> +	}
> +
> +	/* alloc bufs etc so probe's can send requests; but connect later */
> +	rc =3D hid_hw_start(hdev, 0);
> +	if (rc) {
> +		hid_err(hdev, "ib: hw start failed (%d)\n", rc);
> +		goto error;
> +	}
> +
> +	/* add this hdev to our device list */
> +	dev_info =3D appleib_add_device(ib_dev, hdev, id);
> +	if (!dev_info) {
> +		rc =3D -ENOMEM;
> +		goto stop_hw;
> +	}
> +
> +	/* start the hid */
> +	rc =3D appleib_start_hid_events(dev_info);
> +	if (rc)
> +		goto remove_dev;
> +
> +	return 0;
> +
> +remove_dev:
> +	mutex_lock(&ib_dev->update_lock);
> +	appleib_remove_device(ib_dev, dev_info);
> +	mutex_unlock(&ib_dev->update_lock);
> +stop_hw:
> +	hid_hw_stop(hdev);
> +error:
> +	return rc;
> +}
> +
> +static void appleib_hid_remove(struct hid_device *hdev)
> +{
> +	struct appleib_device *ib_dev =3D hid_get_drvdata(hdev);
> +	struct appleib_hid_dev_info *dev_info;
> +
> +	mutex_lock(&ib_dev->update_lock);
> +
> +	list_for_each_entry(dev_info, &ib_dev->hid_devices, entry) {
> +		if (dev_info->device =3D=3D hdev) {
> +			appleib_stop_hid_events(dev_info);
> +			appleib_remove_device(ib_dev, dev_info);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&ib_dev->update_lock);
> +
> +	hid_hw_stop(hdev);
> +}
> +
> +static const struct hid_device_id appleib_hid_devices[] =3D {
> +	{ HID_USB_DEVICE(USB_ID_VENDOR_APPLE, USB_ID_PRODUCT_IBRIDGE) },
> +	{ },
> +};
> +
> +static struct hid_driver appleib_hid_driver =3D {
> +	.name =3D "apple-ibridge-hid",
> +	.id_table =3D appleib_hid_devices,
> +	.probe =3D appleib_hid_probe,
> +	.remove =3D appleib_hid_remove,
> +	.event =3D appleib_hid_event,
> +	.report_fixup =3D appleib_report_fixup,
> +	.input_configured =3D appleib_input_configured,
> +#ifdef CONFIG_PM
> +	.suspend =3D appleib_hid_suspend,
> +	.resume =3D appleib_hid_resume,
> +	.reset_resume =3D appleib_hid_reset_resume,
> +#endif
> +};
> +
> +static struct appleib_device *appleib_alloc_device(struct acpi_device *a=
cpi_dev)
> +{
> +	struct appleib_device *ib_dev;
> +	acpi_status sts;
> +	int rc;
> +
> +	/* allocate */

Drop comments that don't anything a quick glance at the code would tell you.

> +	ib_dev =3D kzalloc(sizeof(*ib_dev), GFP_KERNEL);
> +	if (!ib_dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* init structures */
> +	INIT_LIST_HEAD(&ib_dev->hid_drivers);
> +	INIT_LIST_HEAD(&ib_dev->hid_devices);
> +	mutex_init(&ib_dev->update_lock);
> +	init_srcu_struct(&ib_dev->lists_srcu);
> +
> +	ib_dev->acpi_dev =3D acpi_dev;
> +
> +	/* get iBridge acpi power control method */
> +	sts =3D acpi_get_handle(acpi_dev->handle, "SOCW", &ib_dev->asoc_socw);
> +	if (ACPI_FAILURE(sts)) {
> +		dev_err(LOG_DEV(ib_dev),
> +			"Error getting handle for ASOC.SOCW method: %s\n",
> +			acpi_format_exception(sts));
> +		rc =3D -ENXIO;
> +		goto free_mem;
> +	}
> +
> +	/* ensure iBridge is powered on */
> +	sts =3D acpi_execute_simple_method(ib_dev->asoc_socw, NULL, 1);
> +	if (ACPI_FAILURE(sts))
> +		dev_warn(LOG_DEV(ib_dev), "SOCW(1) failed: %s\n",
> +			 acpi_format_exception(sts));
> +
> +	return ib_dev;
> +
> +free_mem:
> +	kfree(ib_dev);
> +	return ERR_PTR(rc);
> +}
> +
> +static int appleib_probe(struct acpi_device *acpi)
> +{
> +	struct appleib_device *ib_dev;
> +	struct appleib_platform_data *pdata;
Platform_data has a lot of historical meaning in Linux.
Also you have things in here that are not platform related
at all, such as the dev pointer.  Hence I would rename it
as device_data or private or something like that.

> +	int i;
> +	int ret;
> +
> +	if (appleib_dev)
This singleton bothers me a bit. I'm really not sure why it
is necessary.  You can just put a pointer to this in
the pdata for the subdevs and I think that covers most of your
usecases.  It's generally a bad idea to limit things to one instance
of a device unless that actually major simplifications.
I'm not seeing them here.


> +		return -EBUSY;
> +
> +	ib_dev =3D appleib_alloc_device(acpi);
> +	if (IS_ERR_OR_NULL(ib_dev))
> +		return PTR_ERR(ib_dev);
> +
> +	ib_dev->subdevs =3D kmemdup(appleib_subdevs, sizeof(appleib_subdevs),
> +				  GFP_KERNEL);
Given this is fixed sized and always referenced via ib_dev->subdevs, just
put the array in there and memcpy into it.  That way you have one less
allocation and simpler code.

> +	if (!ib_dev->subdevs) {
> +		ret =3D -ENOMEM;
> +		goto free_dev;
> +	}
> +
> +	pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);

Might as well embed this in ib_dev as well.  That would let
you used container_of to avoid having to carry the ib_dev pointer
around in side pdata.

> +	if (!pdata) {
> +		ret =3D -ENOMEM;
> +		goto free_subdevs;
> +	}
> +
> +	pdata->ib_dev =3D ib_dev;
> +	pdata->log_dev =3D LOG_DEV(ib_dev);
> +	for (i =3D 0; i < ARRAY_SIZE(appleib_subdevs); i++) {
> +		ib_dev->subdevs[i].platform_data =3D pdata;
> +		ib_dev->subdevs[i].pdata_size =3D sizeof(*pdata);
> +	}
> +
> +	ret =3D mfd_add_devices(&acpi->dev, PLATFORM_DEVID_NONE,
> +			      ib_dev->subdevs, ARRAY_SIZE(appleib_subdevs),
> +			      NULL, 0, NULL);
> +	if (ret) {
> +		dev_err(LOG_DEV(ib_dev), "Error adding MFD devices: %d\n", ret);
> +		goto free_pdata;
> +	}
> +
> +	acpi->driver_data =3D ib_dev;
> +	appleib_dev =3D ib_dev;
> +
> +	ret =3D hid_register_driver(&appleib_hid_driver);
> +	if (ret) {
> +		dev_err(LOG_DEV(ib_dev), "Error registering hid driver: %d\n",
> +			ret);
> +		goto rem_mfd_devs;
> +	}
> +
> +	return 0;
> +
> +rem_mfd_devs:
> +	mfd_remove_devices(&acpi->dev);
> +free_pdata:
> +	kfree(pdata);
> +free_subdevs:
> +	kfree(ib_dev->subdevs);
> +free_dev:
> +	appleib_dev =3D NULL;
> +	acpi->driver_data =3D NULL;
Why at this point?  It's not set to anything until much later in the
probe flow.  May be worth thinking about devm_ managed allocations
to cleanup some of these allocations automatically and simplify
the error handling.

> +	kfree(ib_dev);
> +	return ret;
> +}
> +
> +static int appleib_remove(struct acpi_device *acpi)
> +{
> +	struct appleib_device *ib_dev =3D acpi_driver_data(acpi);
> +
> +	mfd_remove_devices(&acpi->dev);
> +	hid_unregister_driver(&appleib_hid_driver);
> +
> +	if (appleib_dev =3D=3D ib_dev)
=46rom a general reviewability point of view, it's nice to
keep the remove in the same order as the cleanup on
error in probe (and hence reverse of probe). That measn
this should be a little further down.

I'd also like to see a comment on how this condition can be
false.

> +		appleib_dev =3D NULL;
> +
> +	kfree(ib_dev->subdevs[0].platform_data);
> +	kfree(ib_dev->subdevs);
> +	kfree(ib_dev);

Is it worth considering devm in here to avoid the need to
clean all these up by hand?

> +
> +	return 0;
> +}
> +
> +static int appleib_suspend(struct device *dev)
> +{
> +	struct acpi_device *adev;
> +	struct appleib_device *ib_dev;
> +	int rc;
> +
> +	adev =3D to_acpi_device(dev);
> +	ib_dev =3D acpi_driver_data(adev);
Given this appears a few times, probably worth the more compact

	ib_dev =3D acpi_driver_data(to_acpi_device(dev));

Allowing you to drop the adev local variable that doesn't add
any info.

> +
> +	rc =3D acpi_execute_simple_method(ib_dev->asoc_socw, NULL, 0);
> +	if (ACPI_FAILURE(rc))
> +		dev_warn(LOG_DEV(ib_dev), "SOCW(0) failed: %s\n",

I can sort of see you might want to do the LOG_DEV for consistency
but here I'm fairly sure it's just dev which might be clearer.

> +			 acpi_format_exception(rc));
> +
> +	return 0;
> +}
> +
> +static int appleib_resume(struct device *dev)
> +{
> +	struct acpi_device *adev;
> +	struct appleib_device *ib_dev;
> +	int rc;
> +
> +	adev =3D to_acpi_device(dev);
> +	ib_dev =3D acpi_driver_data(adev);
> +
> +	rc =3D acpi_execute_simple_method(ib_dev->asoc_socw, NULL, 1);
> +	if (ACPI_FAILURE(rc))
> +		dev_warn(LOG_DEV(ib_dev), "SOCW(1) failed: %s\n",
> +			 acpi_format_exception(rc));
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops appleib_pm =3D {
> +	.suspend =3D appleib_suspend,
> +	.resume =3D appleib_resume,
> +	.restore =3D appleib_resume,
> +};
> +
> +static const struct acpi_device_id appleib_acpi_match[] =3D {
> +	{ "APP7777", 0 },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, appleib_acpi_match);
> +
> +static struct acpi_driver appleib_driver =3D {
> +	.name		=3D "apple-ibridge",
> +	.class		=3D "topcase", /* ? */
> +	.owner		=3D THIS_MODULE,
> +	.ids		=3D appleib_acpi_match,
> +	.ops		=3D {
> +		.add		=3D appleib_probe,
> +		.remove		=3D appleib_remove,
> +	},
> +	.drv		=3D {
> +		.pm		=3D &appleib_pm,
> +	},
> +};
> +
> +module_acpi_driver(appleib_driver)
> +
> +MODULE_AUTHOR("Ronald Tschal=C3=A4r");
> +MODULE_DESCRIPTION("Apple iBridge driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/apple-ibridge.h b/include/linux/mfd/apple-=
ibridge.h
> new file mode 100644
> index 000000000000..d321714767f7
> --- /dev/null
> +++ b/include/linux/mfd/apple-ibridge.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Apple iBridge Driver
> + *
> + * Copyright (c) 2018 Ronald Tschal=C3=A4r
> + */
> +
> +#ifndef __LINUX_MFD_APPLE_IBRDIGE_H
> +#define __LINUX_MFD_APPLE_IBRDIGE_H
> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +
> +#define PLAT_NAME_IB_TB		"apple-ib-tb"
> +#define PLAT_NAME_IB_ALS	"apple-ib-als"
> +
> +struct appleib_device;
> +
> +struct appleib_platform_data {
> +	struct appleib_device *ib_dev;
> +	struct device *log_dev;
> +};
> +
> +int appleib_register_hid_driver(struct appleib_device *ib_dev,
> +				struct hid_driver *driver, void *data);
> +int appleib_unregister_hid_driver(struct appleib_device *ib_dev,
> +				  struct hid_driver *driver);
> +
> +void *appleib_get_drvdata(struct appleib_device *ib_dev,
> +			  struct hid_driver *driver);
> +bool appleib_in_hid_probe(struct appleib_device *ib_dev);
> +
> +struct hid_field *appleib_find_report_field(struct hid_report *report,
> +					    unsigned int field_usage);
> +struct hid_field *appleib_find_hid_field(struct hid_device *hdev,
> +					 unsigned int application,
> +					 unsigned int field_usage);
> +
> +#endif

From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 2/2] INPUT/HID: add touch support for SiS touch driver
Date: Mon, 16 Feb 2015 16:10:30 +0100
Message-ID: <1424099430.6633.18.camel@linux-0dmf.site>
References: <8322374EB97AA24A95D0DDBFC8F1CA1DCB0825@SISMBEV01.sis.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50668 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062AbbBPPKx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 10:10:53 -0500
In-Reply-To: <8322374EB97AA24A95D0DDBFC8F1CA1DCB0825@SISMBEV01.sis.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "=?UTF-8?Q?=E6=9B=BE=E5=A9=B7=E8=91=B3?= (tammy_tseng)" <tammy_tseng@sis.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, tammy0524@gmail.com

On Thu, 2015-02-12 at 15:24 +0800, =E6=9B=BE=E5=A9=B7=E8=91=B3 (tammy_t=
seng) wrote:

> Sorry. Re-send the code diff again.
> Here is the hid touch driver for sis touch controller.
> Thanks.

This driver does very strange things. It looks like you are
simulating a disconnect() to the usbhid driver currently driving
the device. This is unacceptable. Please add the device to the
generic blacklist and implement a clean open/close.

	Regards
		Oliver

> Tammy
> -----
>=20
> linux-3.18.5/drivers/hid/Kconfig             |  14 ++
> linux-3.18.5/drivers/hid/hid-ids.h           |   1 +
> linux-3.18.5/drivers/hid/hid-multitouch.c    |  16 ++
> linux-3.18.5/drivers/hid/hid-sis_ctrl.c      | 360 ++++++++++++++++++=
+++++++++
> linux-3.18.5/drivers/hid/usbhid/hid-quirks.c |   1 +
> 5 files changed, 392 insertions(+)
>=20
>=20
> -----
> diff --git a/linux-3.18.5/drivers/hid/Kconfig b/linux-3.18.5/drivers/=
hid/Kconfig
> index f42df4d..2235cfe 100644
> --- a/linux-3.18.5/drivers/hid/Kconfig
> +++ b/linux-3.18.5/drivers/hid/Kconfig
> @@ -496,6 +496,20 @@ config HID_MULTITOUCH
>         To compile this driver as a module, choose M here: the
>         module will be called hid-multitouch.
>=20
> +config HID_SIS_CTRL
> +      bool "SiS Touch Device Controller"
> +      depends on HID_MULTITOUCH
> +      ---help---
> +      Support for SiS Touch devices update FW.
> +
> +config DEBUG_HID_SIS_UPDATE_FW
> +      bool "SiS Touch device debug message(update firmware)"
> +      depends on HID_SIS_CTRL
> +      default n
> +      ---help---
> +        Say Y here if you want to enable debug message(update firmwa=
re) for SiS Touch=20
> +          devices. Must enable config HID_SIS_UPDATE_FW first.
> +
> config HID_NTRIG
>       tristate "N-Trig touch screen"
>       depends on USB_HID
> diff --git a/linux-3.18.5/drivers/hid/hid-ids.h b/linux-3.18.5/driver=
s/hid/hid-ids.h
> index 0e28190..b9ca441 100644
> --- a/linux-3.18.5/drivers/hid/hid-ids.h
> +++ b/linux-3.18.5/drivers/hid/hid-ids.h
> @@ -809,6 +809,7 @@
> #define USB_VENDOR_ID_SIS_TOUCH                0x0457
> #define USB_DEVICE_ID_SIS9200_TOUCH  0x9200
> #define USB_DEVICE_ID_SIS817_TOUCH    0x0817
> +#define USB_DEVICE_ID_SISF817_TOUCH  0xF817
> #define USB_DEVICE_ID_SIS_TS          0x1013
> #define USB_DEVICE_ID_SIS1030_TOUCH  0x1030
>=20
> diff --git a/linux-3.18.5/drivers/hid/hid-multitouch.c b/linux-3.18.5=
/drivers/hid/hid-multitouch.c
> index 51e25b9..11d67bc 100644
> --- a/linux-3.18.5/drivers/hid/hid-multitouch.c
> +++ b/linux-3.18.5/drivers/hid/hid-multitouch.c
> @@ -54,6 +54,10 @@ MODULE_LICENSE("GPL");
>=20
>  #include "hid-ids.h"
>=20
> +#ifdef CONFIG_HID_SIS_CTRL
> +#include "hid-sis_ctrl.c"
> +#endif
> +
> /* quirks to control the device */
> #define MT_QUIRK_NOT_SEEN_MEANS_UP      (1 << 0)
> #define MT_QUIRK_SLOT_IS_CONTACTID   (1 << 1)
> @@ -951,6 +955,14 @@ static int mt_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>               }
>       }
>=20
> +#ifdef CONFIG_HID_SIS_CTRL
> +      if (hdev->vendor =3D=3D USB_VENDOR_ID_SIS_TOUCH) {
> +              ret =3D sis_setup_chardev(hdev);
> +              if (ret)
> +                      dev_err(&hdev->dev, "sis_setup_chardev fail\n"=
);
> +      }
> +#endif
> +
>       /* This allows the driver to correctly support devices
>        * that emit events over several HID messages.
>        */
> @@ -1043,6 +1055,10 @@ static void mt_remove(struct hid_device *hdev)=
 {
>       sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
>       hid_hw_stop(hdev);
> +#ifdef CONFIG_HID_SIS_CTRL
> +      if (hdev->vendor =3D=3D USB_VENDOR_ID_SIS_TOUCH)
> +              sis_deinit_chardev();
> +#endif
> }
>=20
>  /*
> diff --git a/linux-3.18.5/drivers/hid/hid-sis_ctrl.c b/linux-3.18.5/d=
rivers/hid/hid-sis_ctrl.c
> new file mode 100644
> index 0000000..3a7b3df
> --- /dev/null
> +++ b/linux-3.18.5/drivers/hid/hid-sis_ctrl.c
> @@ -0,0 +1,360 @@
> +/*
> + *  Character device driver for SIS multitouch panels control
> + *
> + *  Copyright (c) 2009 SIS, Ltd.
> + *
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or mod=
ify=20
> +it
> + * under the terms of the GNU General Public License as published by=
=20
> +the Free
> + * Software Foundation; either version 2 of the License, or (at your=
=20
> +option)
> + * any later version.
> + */
> +
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>
> +#include "usbhid/usbhid.h"
> +#include <linux/init.h>
> +
> +/*update FW*/
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
> +/*#include <asm/uaccess.h>*/   /*copy_from_user() & copy_to_user()*/
> +#include <linux/uaccess.h>
> +
> +#include "hid-ids.h"
> +
> +#define SIS817_DEVICE_NAME "sis_aegis_hid_touch_device"
> +#define SISF817_DEVICE_NAME "sis_aegis_hid_bridge_touch_device"
> +
> +#define CTRL 0
> +#define ENDP_01 1
> +#define ENDP_02 2
> +#define DIR_IN 0x1
> +
> +#define SIS_ERR_ALLOCATE_KERNEL_MEM        -12 /* Allocate memory fa=
il */
> +#define SIS_ERR_COPY_FROM_USER          -14 /* Copy data from user f=
ail */
> +#define SIS_ERR_COPY_FROM_KERNEL      -19 /* Copy data from kernel f=
ail */

You _must_ use the symbolic names. You cannot use numbers.

> +
> +static const int sis_char_devs_count =3D 1;           /* device coun=
t */
> +static int sis_char_major;
> +static struct cdev sis_char_cdev;
> +static struct class *sis_char_class;
> +
> +static struct hid_device *hid_dev_backup;        /*backup address*/
> +static struct urb *backup_urb;
> +
> +#ifdef CONFIG_DEBUG_HID_SIS_UPDATE_FW
> +      #define DBG_FW(fmt, arg...) printk(fmt, ##arg)
> +      static void sis_dbg_dump_array(u8 *ptr, u32 size)
> +      {
> +              u32 i;
> +
> +              for (i =3D 0; i < size; i++) {
> +                      DBG_FW("%02X ", ptr[i]);
> +                      if (((i+1)&0xF) =3D=3D 0)
> +                              DBG_FW("\n");
> +              }
> +              if (size & 0xF)
> +                      DBG_FW("\n");
> +      }
> +#else
> +      #define DBG_FW(...)
> +      #define sis_dbg_dump_array(...)
> +#endif   /*CONFIG_DEBUG_HID_SIS_UPDATE_FW*/
> +
> +/*20120306 Yuger ioctl for tool*/
> +static int sis_cdev_open(struct inode *inode, struct file *filp) {
> +      struct usbhid_device *usbhid;
> +
> +      DBG_FW("%s\n" , __func__);
> +      /*20110511, Yuger, kill current urb by method of usbhid_stop*/
> +      if (!hid_dev_backup) {

Why is this needed?

> +              pr_info("(stop)hid_dev_backup is not initialized yet")=
;
> +              return -1;
> +      }
> +
> +      usbhid =3D hid_dev_backup->driver_data;
> +
> +      pr_info("sys_sis_HID_stop\n");
> +
> +      /* printk( KERN_INFO "hid_dev_backup->vendor,
> +      * hid_dev_backup->product =3D %x %x\n", hid_dev_backup->vendor=
,
> +      * hid_dev_backup->product );*/
> +
> +      /*20110602, Yuger, fix bug: not contact usb cause kernel panic=
*/
> +      if (!usbhid) {
> +              pr_info("(stop)usbhid is not initialized yet");
> +              return -1;
> +      } else if (!usbhid->urbin) {
> +              pr_info("(stop)usbhid->urbin is not initialized yet");
> +              return -1;
> +      } else if (hid_dev_backup->vendor =3D=3D USB_VENDOR_ID_SIS_TOU=
CH) {
> +              usb_fill_int_urb(backup_urb,
> +                      usbhid->urbin->dev,
> +                      usbhid->urbin->pipe,
> +                      usbhid->urbin->transfer_buffer,
> +                      usbhid->urbin->transfer_buffer_length,
> +                      usbhid->urbin->complete,
> +                      usbhid->urbin->context,
> +                      usbhid->urbin->interval);
> +              clear_bit(HID_STARTED, &usbhid->iofl);
> +              set_bit(HID_DISCONNECTED, &usbhid->iofl);
> +
> +              usb_kill_urb(usbhid->urbin);
> +              usb_free_urb(usbhid->urbin);
> +              usbhid->urbin =3D NULL;
> +              return 0;
> +      }
> +
> +      pr_info("This is not a SiS device");
> +      return -801;
> +}
> +
> +static int sis_cdev_release(struct inode *inode, struct file *filp) =
{
> +      /*20110505, Yuger, rebuild the urb which is at the same urb ad=
dress,
> +      * then re-submit it*/
> +
> +      int ret;
> +      struct usbhid_device *usbhid;
> +      unsigned long flags;
> +
> +      DBG_FW("%s: ", __func__);
> +
> +      if (!hid_dev_backup) {
> +              pr_info("(stop)hid_dev_backup is not initialized yet")=
;
> +              return -1;
> +      }
> +
> +      usbhid =3D hid_dev_backup->driver_data;
> +
> +      pr_info("sys_sis_HID_start");
> +
> +      if (!usbhid) {
> +              pr_info("(start)usbhid is not initialized yet");
> +              return -1;
> +      }
> +
> +      if (!backup_urb) {
> +              pr_info("(start)backup_urb is not initialized yet");
> +              return -1;
> +      }
> +
> +      clear_bit(HID_DISCONNECTED, &usbhid->iofl);
> +      usbhid->urbin =3D usb_alloc_urb(0, GFP_KERNEL);
> +
> +      if (!backup_urb->interval) {
> +              pr_info("(start)backup_urb->interval does not exist");
> +              return -1;
> +      }
> +
> +      usb_fill_int_urb(usbhid->urbin, backup_urb->dev, backup_urb->p=
ipe,
> +      backup_urb->transfer_buffer, backup_urb->transfer_buffer_lengt=
h,
> +      backup_urb->complete, backup_urb->context, backup_urb->interva=
l);
> +      usbhid->urbin->transfer_dma =3D usbhid->inbuf_dma;
> +      usbhid->urbin->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> +
> +      set_bit(HID_STARTED, &usbhid->iofl);
> +
> +      /*method at hid_start_in*/
> +      spin_lock_irqsave(&usbhid->lock, flags);
> +      ret =3D usb_submit_urb(usbhid->urbin, GFP_ATOMIC);
> +      spin_unlock_irqrestore(&usbhid->lock, flags);
> +      /*yy*/
> +
> +      DBG_FW("ret =3D %d", ret);
> +
> +      return ret;
> +}
> +
> +/*SiS 817 only*/
> +static ssize_t sis_cdev_read(struct file *file, char __user *buf,
> +                              size_t count, loff_t *ppos) {
> +      int actual_length =3D 0;
> +      u8 *rep_data =3D NULL;
> +      u32 size, timeout;
> +      long rep_ret =3D 0;
> +      struct usb_interface *intf =3D
> +                      to_usb_interface(hid_dev_backup->dev.parent);
> +      struct usb_device *dev =3D interface_to_usbdev(intf);
> +
> +      DBG_FW("%s\n", __func__);
> +
> +      rep_data =3D kzalloc(count, GFP_KERNEL);
> +      if (!rep_data)
> +              return SIS_ERR_ALLOCATE_KERNEL_MEM;
> +
> +      if (copy_from_user(rep_data, (void *)buf, count)) {
> +              pr_err("copy_to_user fail\n");
> +              rep_ret =3D SIS_ERR_COPY_FROM_USER;
> +              goto end;
> +      }
> +      size =3D be32_to_cpup((u32 *)&rep_data[64]);
> +      timeout =3D be32_to_cpup((u32 *)&rep_data[68]);
> +
> +      rep_ret =3D usb_interrupt_msg(dev, backup_urb->pipe,
> +              rep_data, size, &actual_length, timeout);
> +
> +      DBG_FW("%s: rep_data =3D ", __func__);
> +      sis_dbg_dump_array(rep_data, 8);
> +
> +      if (rep_ret =3D=3D 0) {
> +              rep_ret =3D actual_length;
> +              if (copy_to_user((void *)buf, rep_data, rep_ret)) {
> +                      pr_err("copy_to_user fail\n");
> +                      rep_ret =3D SIS_ERR_COPY_FROM_KERNEL;
> +                      goto end;
> +              }
> +      }
> +      DBG_FW("%s: rep_ret =3D %ld\n", __func__, rep_ret);
> +end:
> +      /*free allocated data*/
> +      kfree(rep_data);
> +      return rep_ret;
> +}
> +
> +static ssize_t sis_cdev_write(struct file *file, const char __user *=
buf,
> +                      size_t count, loff_t *f_pos) {
> +      int actual_length =3D 0;
> +      u8 *rep_data =3D NULL;
> +      long rep_ret =3D 0;
> +      struct usb_interface *intf =3D
> +                      to_usb_interface(hid_dev_backup->dev.parent);
> +      struct usb_device *dev =3D interface_to_usbdev(intf);
> +      struct usbhid_device *usbhid =3D hid_dev_backup->driver_data;
> +      u32 size, timeout;
> +
> +      rep_data =3D kzalloc(count, GFP_KERNEL);
> +      if (!rep_data)
> +              return SIS_ERR_ALLOCATE_KERNEL_MEM;
> +
> +      if (copy_from_user(rep_data, (void *)buf, count)) {
> +              pr_err("copy_to_user fail\n");
> +              rep_ret =3D SIS_ERR_COPY_FROM_USER;
> +              goto end;
> +      }
> +
> +      size =3D be32_to_cpup((u32 *)&rep_data[64]);
> +      timeout =3D be32_to_cpup((u32 *)&rep_data[68]);
> +
> +      rep_ret =3D usb_interrupt_msg(dev, usbhid->urbout->pipe,
> +              rep_data, size, &actual_length, timeout);
> +
> +      DBG_FW("%s: rep_data =3D ", __func__);
> +      sis_dbg_dump_array(rep_data, size);
> +
> +      if (rep_ret =3D=3D 0) {
> +              rep_ret =3D actual_length;
> +              if (copy_to_user((void *)buf, rep_data, rep_ret)) {
> +                      pr_err("copy_to_user fail\n");
> +                      rep_ret =3D SIS_ERR_COPY_FROM_KERNEL;
> +                      goto end;
> +              }
> +      }
> +      DBG_FW("%s: rep_ret =3D %ld\n", __func__, rep_ret);
> +      DBG_FW("End of sys_sis_HID_IO\n");
> +end:
> +      /*free allocated data*/
> +      kfree(rep_data);
> +      return rep_ret;
> +}
> +
> +
> +/*for ioctl*/
> +static const struct file_operations sis_cdev_fops =3D {
> +      .owner    =3D THIS_MODULE,
> +      .read       =3D sis_cdev_read,
> +      .write       =3D sis_cdev_write,
> +      .open      =3D sis_cdev_open,
> +      .release =3D sis_cdev_release,
> +};
> +
> +/*for ioctl*/
> +static int sis_setup_chardev(struct hid_device *hdev) {
> +      dev_t dev =3D MKDEV(sis_char_major, 0);
> +      int ret =3D 0;
> +      struct device *class_dev =3D NULL;
> +      u8 *name =3D (hdev->product =3D=3D USB_DEVICE_ID_SISF817_TOUCH=
) ?
> +                      SISF817_DEVICE_NAME : SIS817_DEVICE_NAME;
> +
> +      dev_info(&hdev->dev, "sis_setup_chardev.\n");
> +
> +      backup_urb =3D usb_alloc_urb(0, GFP_KERNEL);    /*0721test*/
> +      if (!backup_urb) {
> +              dev_err(&hdev->dev, "cannot allocate backup_urb\n");
> +              return -ENOMEM;
> +      }
> +      hid_dev_backup =3D hdev;
> +      /*dynamic allocate driver handle*/
> +      ret =3D alloc_chrdev_region(&dev, 0, sis_char_devs_count, name=
);
> +      if (ret)
> +              goto err1;
> +
> +      sis_char_major =3D MAJOR(dev);
> +      cdev_init(&sis_char_cdev, &sis_cdev_fops);
> +      sis_char_cdev.owner =3D THIS_MODULE;
> +      ret =3D cdev_add(&sis_char_cdev, dev, sis_char_devs_count);
> +      if (ret)
> +              goto err2;
> +
> +      dev_info(&hdev->dev, "%s driver(major %d) installed.\n",
> +                                      name, sis_char_major);
> +
> +      /*register class*/
> +      sis_char_class =3D class_create(THIS_MODULE, name);
> +      if (IS_ERR(sis_char_class)) {
> +              ret =3D PTR_ERR(sis_char_class);
> +              goto err3;
> +      }
> +
> +      class_dev =3D device_create(sis_char_class, NULL, dev, NULL, n=
ame);
> +      if (IS_ERR(class_dev)) {
> +              ret =3D PTR_ERR(class_dev);
> +              goto err4;
> +      }
> +
> +      return 0;
> +err4:
> +      class_destroy(sis_char_class);
> +      sis_char_class =3D NULL;
> +err3:
> +      cdev_del(&sis_char_cdev);
> +      memset(&sis_char_cdev, 0, sizeof(struct cdev));
> +err2:
> +      sis_char_major =3D 0;
> +      unregister_chrdev_region(dev, sis_char_devs_count);
> +err1:
> +      usb_kill_urb(backup_urb);
> +      usb_free_urb(backup_urb);
> +      backup_urb =3D NULL;
> +      hid_dev_backup =3D NULL;
> +      return ret;
> +}
> +
> +/*for ioctl*/
> +static void sis_deinit_chardev(void)
> +{
> +      dev_t dev =3D MKDEV(sis_char_major, 0);
> +
> +      if (hid_dev_backup) {
> +              dev_info(&hid_dev_backup->dev, "sis_remove\n");
> +              device_destroy(sis_char_class, dev);
> +              class_destroy(sis_char_class);
> +              sis_char_class =3D NULL;
> +              cdev_del(&sis_char_cdev);
> +              memset(&sis_char_cdev, 0, sizeof(struct cdev));
> +              sis_char_major =3D 0;
> +              unregister_chrdev_region(dev, sis_char_devs_count);
> +              usb_kill_urb(backup_urb);
> +              usb_free_urb(backup_urb);
> +              backup_urb =3D NULL;
> +              hid_dev_backup =3D NULL;
> +      }
> +}
> diff --git a/linux-3.18.5/drivers/hid/usbhid/hid-quirks.c b/linux-3.1=
8.5/drivers/hid/usbhid/hid-quirks.c
> index 4477eb7..b534321 100644
> --- a/linux-3.18.5/drivers/hid/usbhid/hid-quirks.c
> +++ b/linux-3.18.5/drivers/hid/usbhid/hid-quirks.c
> @@ -97,6 +97,7 @@ static const struct hid_blacklist {
>       { USB_VENDOR_ID_SIGMATEL, USB_DEVICE_ID_SIGMATEL_STMP3780, HID_=
QUIRK_NOGET },
>       { USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS9200_TOUCH, HID_QUI=
RK_NOGET },
>       { USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS817_TOUCH, HID_QUIR=
K_NOGET },
> +      { USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SISF817_TOUCH,=20
> + HID_QUIRK_NOGET },
>       { USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS_TS, HID_QUIRK_NO_I=
NIT_REPORTS },
>       { USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS1030_TOUCH, HID_QUI=
RK_NOGET },
>       { USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIR=
K_NOGET },


--=20
Oliver Neukum <oneukum@suse.de>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

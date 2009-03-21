From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input/joystick: add driver fortius 1942
Date: Fri, 20 Mar 2009 22:46:25 -0700
Message-ID: <200903202246.25426.dmitry.torokhov@gmail.com>
References: <739e73230903161921u426f2c65gddbc089d25ba5d50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <739e73230903161921u426f2c65gddbc089d25ba5d50-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peta Blaha <blahapeta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Peta,

On Monday 16 March 2009 19:21:18 Peta Blaha wrote:
> Driver for Fortius 1942 device.
>

Thank you very much for your patch, overall it looks pretty nice.
It looks like your mailer ate whitespace; I also have some
requests for you with regard to the driver.

> Signed-off-by: Petr Blaha <blahapeta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Did you misspell your first name in the signed-off-by by
any chance?

> ---
>
> --- a/drivers/input/joystick/fortius_1942.c.orig 1970-01-01
> 01:00:00.000000000 +0100
> +++ b/drivers/input/joystick/fortius_1942.c 2009-03-17 03:17:01.00000=
0000
> +0100 @@ -0,0 +1,394 @@
> +/*
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-13=
07 USA
> + *
> + *
> + *
> + * Info.
> + * First unimpemented feature Heart Sensor.
> + * Use bit 12 and 14(beginning 0), maybe 13 also.Emmisions
> + * from computer affect measuring.
> + *
> + * Second is Active Brake
> + * Can be maybe used as force feedback. Problem is slowness in
> + * switching from state to state, its electric motor, it has delay c=
an
> + * be fragile.
> + * Try it by changing BRAKE_POS from 0 to 10.
> + *
> + * Thirth unimpemented is sending 0x01, when pedal magnet meets fram=
e
> sensor. + *
> + * Pedalling works fine. Your wheel can have other size tan mime. Fe=
el
> free + * to change constant in usb_tfor_irq, when counting value of
> gasolina. + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/usb/input.h>
> +#include <linux/time.h>
> +
> +
> +#define DRIVER_VERSION "v0.0.2"
> +#define DRIVER_DESC    "USB Tacx Fortius 1942 driver"
> +#define DRIVER_LICENSE "GPL"
> +#define DRIVER_AUTHOR  "Petr Blaha <blahapeta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>"
> +
> +
> +/*Don't put here lesser values*/
> +/*read*/
> +#define BIT_IN_DEVICE_1942 64
> +/*write*/
> +#define BIT_OUT_DEVICE_1942 12
> +/*read*/
> +#define BULK_IN_INTERFACE_1942 82
> +/*write*/
> +#define BULK_OUT_INTERFACE_1942 02
> +
> +
> +#define BRAKE_POS 2
> +
> +
> +/*11 states of brake,in beginning active brake helps, later add
> +difficulty to cycling.0x00 0x00 is neutral*/
> +#define ARRAYINT { {0x4d, 0xf3}, {0xa7, 0xf9}, {0x00, 0x00}, {0x59, =
0x06},
> \ +{0xb3, 0x0c}, {0x0c, 0x13}, {0x66, 0x19}, {0xbf, 0x1f}, {0x18, 0x2=
6},
> {0x72, \ +0x2c}, {0xcb, 0x32} }
> +
> +
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE(DRIVER_LICENSE);
> +
> + unsigned long difference =3D 0;

Make it static? Also there is no need to initialize to 0.
=20
> + /*time measure*/
> + struct timeval time, time_before;
> + /*guessed fastest speed a man can possibly ride-incitating full
> + throttle*/
> + unsigned int fastest_wheel_rotate =3D 1000;
> + /*actual state of path reached in one cycle*/
> + unsigned int ride =3D 0, old_ride =3D 0;

Same here. You really want to mark everything static unless
it is used from another module.
=20
> +
> +struct usb_tfor {
> + char name[128];
> + char phys[64];
> + struct usb_device *usbdev;
> + struct input_dev *input;
> +
> + struct urb *irq;
> + unsigned char *data;
> + dma_addr_t idata_dma;
> +
> + struct urb *out;
> + unsigned char *data_device;
> + dma_addr_t odata_dma;
> + /*brake position*/
> + unsigned int brake_pos;
> +};
> +
> +static void tfor_disconnect(struct usb_interface *intf)

Mark it as __devexit please.

> +{
> + struct usb_tfor *tfor =3D usb_get_intfdata(intf);
> +
> + usb_set_intfdata(intf, NULL);
> + if (tfor) {

Why do we check this? Can it ever be NULL and still
tfor_disconnect be called for this interface?

> +  /*urb*/
> +  usb_kill_urb(tfor->out);
> +  usb_kill_urb(tfor->irq);

You have implemented close method which is guaranteed to
be called if open succeeded. These is no need to kill
URBs here.

> +  /*device*/
> +  input_unregister_device(tfor->input);
> +  /*urb*/
> +  usb_free_urb(tfor->out);
> +  usb_free_urb(tfor->irq);
> +  /*buffer free*/
> +  usb_buffer_free(interface_to_usbdev(intf), 10, tfor->data_device, =
\
> +  tfor->odata_dma);
> +  usb_buffer_free(interface_to_usbdev(intf), 10, tfor->data, \
> +  tfor->idata_dma);
> +  /*free memory*/
> +  kfree(tfor);
> +   }
> +}
> +
> +static int usb_tfor_open(struct input_dev *dev)
> +{
> + struct usb_tfor *tfor =3D input_get_drvdata(dev);

Blank line after variable declarations please.

> + tfor->irq->dev =3D tfor->usbdev;

This kind of setup should be moved into _probe().

> + usb_submit_urb(tfor->irq, GFP_KERNEL);

> + tfor->out->dev =3D tfor->usbdev;

This one as well, so the only thing left in _open should
be calls to usb_submit_urb().

> + usb_submit_urb(tfor->out, GFP_KERNEL);
> +
> + return 0;
> +}
> +
> +static void usb_tfor_close(struct input_dev *dev)
> +{
> + struct usb_tfor *tfor =3D input_get_drvdata(dev);
> + usb_kill_urb(tfor->irq);
> + usb_kill_urb(tfor->out);
> +}
> +
> +static struct usb_device_id tfor_ids[] =3D {
> + { USB_DEVICE(0x3561, 0x1942), .driver_info =3D 0 },
> + { }
> +};
> +
> +static void usb_tfor_out(struct urb *urb)
> +{ struct usb_tfor *tfor =3D urb->context;
> + unsigned int brake_bits[11][2] =3D ARRAYINT;
> + int retval;
> + tfor->brake_pos =3D BRAKE_POS;
> + /*URB to device*/
> + /*constant*/
> + tfor->data_device[0] =3D 0x01;
> + /*constant*/
> + tfor->data_device[1] =3D 0x08;
> + /*constant*/
> + tfor->data_device[2] =3D 0x01;
> + /*constant*/
> + tfor->data_device[3] =3D 0x00;
> + /*brake_bits*/
> + tfor->data_device[4] =3D brake_bits[tfor->brake_pos][0];
> + /*brake_bits*/
> + tfor->data_device[5] =3D brake_bits[tfor->brake_pos][1];
> + /*0x01 is turn,when frame sensor meets pedal magnet,
> + i don't see reason for implementation, nor know how device knows it=
*/
> + tfor->data_device[6] =3D 0x00;
> + /*constant*/
> + tfor->data_device[7] =3D 0x00;
> + /*constant*/
> + tfor->data_device[8] =3D 0x02;
> + /*constant*/
> + tfor->data_device[9] =3D 0x52;
> + /*constant*/
> + tfor->data_device[10] =3D 0x10;
> + /*constant*/
> + tfor->data_device[11] =3D 0x04;
> +
> +
> + switch (urb->status) {
> + case 0:
> + /* success */
> + break;
> + case -ECONNRESET:
> + case -ENOENT:
> + case -ESHUTDOWN:
> + /* this urb is terminated, clean up */
> + dbg("%s - urb shutting down with status: %d", __func__, urb->status=
);
> + break;
> + default:
> +    dbg("%s - nonzero urb status received: %d", __func__, urb->statu=
s);
> + }
> + retval =3D usb_submit_urb(urb, GFP_ATOMIC);
> + if (retval)
> + err("%s - usb_submit_urb failed with result %d",
> +    __func__, retval);
> +}
> +
> +static void usb_tfor_irq(struct urb *urb)
> +{
> + struct usb_tfor *tfor =3D urb->context;
> + unsigned char *data =3D tfor->data;
> + struct input_dev *dev =3D tfor->input;
> + int status;
> + int gasolina;
> +
> + switch (urb->status) {
> + case 0:
> + /* success */
> +   break;
> + case -ECONNRESET:
> + case -ENOENT:
> + case -ESHUTDOWN:
> + /* =C2=B1this urb is terminated, clean up */
> + dbg("%s - urb shutting down with status: %d", __func__, \
> + urb->status);
> + return;
> + default:
> + dbg("%s - nonzero urb status received: %d", __func__, \
> + urb->status);
> + goto resubmit;
> + }
> +
> + /*Get actual time*/
> + do_gettimeofday(&time);
> + /*Ride counter in velociped is small,avoid mistake here*/
> + if ((data[28]*255+data[29]) < ride)
> + ride =3D 0;
> + /*We get new data, set new val. of ride counter &time counter*/
> + if ((data[28]*255+data[29]) > ride) {
> + old_ride =3D ride;
> + ride =3D (data[28]*255+data[29]);
> + difference =3D \
> + ((time.tv_usec-time_before.tv_usec)\
> + +(time.tv_sec-time_before.tv_sec)*1000000);
> + do_gettimeofday(&time_before);
> + if (difference =3D=3D 0)
> + dbg("Something is not good \n");
> + }
> + /*Prevent division by 0*/
> + if (difference !=3D 0)
> + /*"speed=3Dpath/time",change constant 1000
> +   to naturalize it for your speed*/
> + gasolina =3D (ride-old_ride)/(difference/1000);
> + else
> + gasolina =3D 0;

We should probably rename this variable to accel[eration].

> + input_report_abs(dev, ABS_GAS, gasolina);
> + input_report_key(dev, BTN_RIGHT,   data[13] & 0x01);
> + input_report_key(dev, BTN_BACK, data[13] & 0x02);
> + input_report_key(dev, BTN_FORWARD, data[13] & 0x04);
> + input_report_key(dev, BTN_LEFT, data[13] & 0x08);
> + input_report_abs(dev, ABS_WHEEL, (((data[18]+((data[19] & 0x0f)*225=
))-\
> + (689+170))*-1));
> +
> + /* event termination */
> + input_sync(dev);
> +
> +resubmit:
> + status =3D usb_submit_urb(urb, GFP_ATOMIC);
> + if (status)
> + err("can't resubmit intr, %s-%s/input0, status %d",
> + tfor->usbdev->bus->bus_name, tfor->usbdev->devpath, status);

We should not use bus_name directly, i think there is a helper
in driver core for that. Or you can use dev->phys instead.

> +
> +}
> +
> +static int tfor_probe(struct usb_interface *intf, const struct
> usb_device_id *id)

I think we can mark it __devinit.

> +{
> + struct usb_device *dev =3D interface_to_usbdev(intf);
> + struct usb_tfor *tfor;
> + struct input_dev *input_dev;
> + unsigned int err =3D -ENOMEM;
> +
> +
> + tfor =3D kzalloc(sizeof(struct usb_tfor), GFP_KERNEL);
> +
> + input_dev =3D input_allocate_device();
> + if (!tfor || !input_dev) {
> + err =3D -ENOMEM;
> + goto fail1;
> + }
> + /*initilization of time counter*/
> + do_gettimeofday(&time);
> + time_before.tv_usec =3D time.tv_usec;
> + time_before.tv_sec =3D time.tv_sec;
> +
> + tfor->data =3D usb_buffer_alloc(dev, BIT_IN_DEVICE_1942, GFP_KERNEL=
, \
> + &tfor->idata_dma);
> + if (!tfor->data) {
> + err =3D -ENOMEM;
> + goto fail1;
> + }
> +
> + tfor->data_device =3D usb_buffer_alloc(dev, BIT_OUT_DEVICE_1942, \
> + GFP_KERNEL, &tfor->odata_dma);
> + if (!tfor->data_device) {
> + err =3D -ENOMEM;
> + goto fail1;
> + }
> +
> + tfor->irq =3D usb_alloc_urb(0, GFP_KERNEL);
> + if (!tfor->irq) {
> + err =3D -ENOMEM;
> + goto fail2;
> + }
> +
> + tfor->out =3D usb_alloc_urb(0, GFP_KERNEL);
> + if (!tfor->irq) {
> + err =3D -ENOMEM;
> + goto fail3;
> + }
> +
> + tfor->usbdev =3D dev;
> + tfor->input =3D input_dev;
> +
> + usb_make_path(dev, tfor->phys, sizeof(tfor->phys));
> + strlcat(tfor->phys, "/input0", sizeof(tfor->phys));
> +
> + input_dev->name =3D "Tacx Fortius 1942";
> + input_dev->phys =3D tfor->phys;
> + usb_to_input_id(dev, &input_dev->id);
> + input_dev->dev.parent =3D &intf->dev;
> + input_set_drvdata(input_dev, tfor);
> + input_dev->open =3D usb_tfor_open;
> + input_dev->close =3D usb_tfor_close;
> + input_dev->evbit[0] =3D BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
> + /*handlebar*/
> + input_set_abs_params(input_dev, ABS_WHEEL, -170, 170, 0, 20);
> + /*plyn*/
> + input_set_abs_params(input_dev, ABS_GAS, 0, 40, 2, 0);
> + /*buttons*/
> + set_bit(BTN_LEFT, input_dev->keybit);
> + set_bit(BTN_RIGHT, input_dev->keybit);
> + set_bit(BTN_FORWARD, input_dev->keybit);
> + set_bit(BTN_BACK, input_dev->keybit);
> +
> + usb_fill_bulk_urb(tfor->irq, dev, usb_rcvbulkpipe(dev, \
> + BULK_IN_INTERFACE_1942), tfor->data, BIT_IN_DEVICE_1942, \
> + usb_tfor_irq, tfor);
> + tfor->irq->transfer_dma =3D tfor->idata_dma;
> + tfor->irq->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> +
> + /*
> + * urb sends data to machine
> + */
> +
> + usb_fill_bulk_urb(tfor->out, dev, usb_sndbulkpipe(dev, \
> + BULK_OUT_INTERFACE_1942), tfor->data_device, BIT_OUT_DEVICE_1942, \
> + usb_tfor_out, tfor);
> + tfor->out->transfer_dma =3D tfor->odata_dma;
> + tfor->out->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> +
> + err =3D input_register_device(tfor->input);
> + if (err)
> + goto fail2;
> +
> + usb_set_intfdata(intf, tfor);
> +
> + return 0;
> +
> + fail3: usb_buffer_free(dev, BIT_OUT_DEVICE_1942, tfor->data_device,=
 \
> + tfor->odata_dma);
> + fail2: usb_buffer_free(dev, BIT_IN_DEVICE_1942, tfor->data,
> tfor->idata_dma); + fail1: input_free_device(input_dev);
> + kfree(tfor);
> + return err;
> +}
> +
> +static struct usb_driver tfor_driver =3D {
> + .name =3D "fortius_1942",
> + .probe =3D tfor_probe,
> + .disconnect =3D tfor_disconnect,

__devexit_p() here please.

> + .id_table =3D tfor_ids,

It would be very nice if the driver supported suspend and resume.

> +};
> +
> +static int __init tfor_init(void)
> +{
> + int retval;
> + retval =3D usb_register(&tfor_driver);
> + if (retval)
> + goto out;
> + printk(KERN_INFO KBUILD_MODNAME ": " DRIVER_VERSION ":" \
> + DRIVER_DESC "\n");

Our boot is noisy enough, lets drop this message.

> +out:
> + return retval;
> +}
> +
> +static void __exit tfor_exit(void)
> +{
> + usb_deregister(&tfor_driver);
> +}
> +
> +module_init(tfor_init);
> +module_exit(tfor_exit);

Please CC me when you send updated version. Thanks!

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

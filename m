From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.3
Date: Fri, 8 Jan 2010 10:32:28 +0800
Message-ID: <45a44e481001071832q40d6f913w2ccf89c4c45a692a@mail.gmail.com>
References: <201001071623.o07GNOB4022157@mustang.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.223.194]:41312 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab0AHCc3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2010 21:32:29 -0500
In-Reply-To: <201001071623.o07GNOB4022157@mustang.cs.nmsu.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>
Cc: linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, pavel@ucw.cz, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, oliver@neukum.org, linux-input@vger.kernel.org, jkosina@suse.cz

On Fri, Jan 8, 2010 at 12:23 AM, Rick L. Vinyard Jr.
<rvinyard@cs.nmsu.edu> wrote:
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Translate the XBM format screen_base into the form=
at needed by the
> + =A0 =A0 =A0 =A0* G13. This format places the pixels in a vertical r=
ather than
> + =A0 =A0 =A0 =A0* horizontal format. Assuming a grid with 0,0 in the=
 upper left corner
> + =A0 =A0 =A0 =A0* and 159,42 in the lower right corner, the first by=
te contains the
> + =A0 =A0 =A0 =A0* pixels 0,0 through 0,7 and the second byte contain=
s the pixels 1,0
> + =A0 =A0 =A0 =A0* through 1,7. Within the byte, bit 0 represents 0,0=
; bit 1 0,1; etc.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* This loop operates in reverse to shift the lower b=
its into their
> + =A0 =A0 =A0 =A0* respective positions, shifting the lower rows into=
 the higher bits.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* The offset is calculated for every 8 rows and is a=
djusted by 32 since
> + =A0 =A0 =A0 =A0* that is what the G13 image message expects.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (row =3D G13FB_HEIGHT-1; row >=3D 0; row--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D 32 + row/8 * G13FB_WIDTH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u =3D data->fb_vbitmap + offset;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Iterate across the screen_base col=
umns to get the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* individual bits
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (col =3D 0; col < G13FB_LINE_LENGTH=
; col++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We will work with =
a temporary value since we don't
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* want to modify scr=
een_base as we shift each bit
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* downward.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D data->fb_bitma=
p[row * G13FB_LINE_LENGTH + col];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For each bit in th=
e pixel row we will shift it onto
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the appropriate by=
 by shift the g13 byte up by 1 and
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* simply doing a bit=
wise or of the low byte
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (bit =3D 0; bit < 8=
; bit++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*Shift=
 the g13 byte up by 1 for this new row*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u[bit] =
<<=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Brin=
g in the new pixel of temp */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u[bit] =
|=3D (temp & 0x01);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Sh=
ift temp down so the low pixel is ready
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fo=
r the next byte
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp >>=
=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The last byte repr=
esented 8 vertical pixels so we'll
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* jump ahead 8
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u +=3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }

I didn't read this portion carefully. I assume everything above is
being accessed bytewise and that there is no chance of any unaligned
access. I didn't see any endian code so can we also assume above is
also endian safe. Is there a way that you could use the standard fbmem
logo infrastructure in fbdev? If it is lacking in some way, maybe the
right thing to do is to improve that so that other devices like this
one could use it in future.


> +/*
> + * The "fb_node" attribute
> + */
> +static ssize_t g13_fb_node_show(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
device_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *b=
uf)
> +{
> + =A0 =A0 =A0 unsigned fb_node;
> + =A0 =A0 =A0 struct g13_data *data =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 fb_node =3D data->fb_info->node;
> +
> + =A0 =A0 =A0 return sprintf(buf, "%u\n", fb_node);
> +}
> +
> +static DEVICE_ATTR(fb_node, 0444, g13_fb_node_show, NULL);

I didn't quite understand the purpose of above and how it would be
used to the benefit of userspace.

> +
> +
> +/*
> + * The "fb_update_rate" attribute
> + */
> +static ssize_t g13_fb_update_rate_show(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct device_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0char *buf)
> +{
> + =A0 =A0 =A0 unsigned fb_update_rate;
> + =A0 =A0 =A0 struct g13_data *data =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 fb_update_rate =3D data->fb_update_rate;
> +
> + =A0 =A0 =A0 return sprintf(buf, "%u\n", fb_update_rate);
> +}
> +
> +static ssize_t g13_set_fb_update_rate(struct hid_device *hdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 unsigned fb_update_rate)
> +{
> + =A0 =A0 =A0 struct g13_data *data =3D hid_get_g13data(hdev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 if (fb_update_rate > G13FB_UPDATE_RATE_LIMIT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fb_update_rate =3D G13FB_UPDATE_R=
ATE_LIMIT;
> + =A0 =A0 =A0 else if (fb_update_rate =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fb_update_rate =3D 1;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fb_update_rate =3D fb_update_rate=
;
> +
> + =A0 =A0 =A0 data->fb_defio.delay =3D HZ / data->fb_update_rate;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static ssize_t g13_fb_update_rate_store(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct device_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 const char *buf, size_t count)
> +{
> + =A0 =A0 =A0 struct hid_device *hdev;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 unsigned u;
> + =A0 =A0 =A0 ssize_t set_result;
> +
> + =A0 =A0 =A0 /* Get the hid associated with the device */
> + =A0 =A0 =A0 hdev =3D container_of(dev, struct hid_device, dev);
> +
> + =A0 =A0 =A0 /* If we have an invalid pointer we'll return ENODATA *=
/
> + =A0 =A0 =A0 if (hdev =3D=3D NULL || &(hdev->dev) !=3D dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 i =3D sscanf(buf, "%u", &u);
> + =A0 =A0 =A0 if (i !=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "unrecognized input: %s=
", buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 set_result =3D g13_set_fb_update_rate(hdev, u);
> +
> + =A0 =A0 =A0 if (set_result < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return set_result;
> +
> + =A0 =A0 =A0 return count;
> +}
> +
> +static DEVICE_ATTR(fb_update_rate, 0666,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0g13_fb_update_rate_show,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0g13_fb_update_rate_store);
> +
> +

Okay, this update rate stuff and rate limit is interesting. I assume
you are using this fbdev interface with some kind of custom fbdev
client. Or are you using X or dfb with it? Thinking about it, I didn't
quite understand why there's a rate limit since if you set your defio
delay, then isn't that automatically limiting the rate? You might want
to document what these sysfs attrs do exactly and how you want it to
be used since it is exposed to userspace.

> +/*
> + * The "mled" attribute
> + * on or off for each of the four M led's (M1 M2 M3 MR)
> + */
> +static ssize_t g13_mled_show(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devic=
e_attribute *attr,
> + =A0 =A0 =A0 char *buf)
> +{
> + =A0 =A0 =A0 unsigned mled;
> + =A0 =A0 =A0 struct g13_data *data =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 mled =3D data->mled;
> +
> + =A0 =A0 =A0 return sprintf(buf, "%u\n", mled);
> +}
> +
> +static ssize_t g13_set_mled(struct hid_device *hdev, unsigned mled)
> +{
> + =A0 =A0 =A0 struct g13_data *data =3D hid_get_g13data(hdev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL || data->mled_report =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 data->mled_report->field[0]->value[0] =3D mled&0x0F;
> + =A0 =A0 =A0 data->mled_report->field[0]->value[1] =3D 0x00;
> + =A0 =A0 =A0 data->mled_report->field[0]->value[2] =3D 0x00;
> + =A0 =A0 =A0 data->mled_report->field[0]->value[3] =3D 0x00;
> +
> + =A0 =A0 =A0 usbhid_submit_report(hdev, data->mled_report, USB_DIR_O=
UT);
> +
> + =A0 =A0 =A0 data->mled =3D mled;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static ssize_t g13_mled_store(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devi=
ce_attribute *attr,
> + =A0 =A0 =A0 =A0const char *buf, size_t count)
> +{
> + =A0 =A0 =A0 struct hid_device *hdev;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 unsigned m[4];
> + =A0 =A0 =A0 unsigned mled;
> + =A0 =A0 =A0 ssize_t set_result;
> +
> + =A0 =A0 =A0 /* Get the hid associated with the device */
> + =A0 =A0 =A0 hdev =3D container_of(dev, struct hid_device, dev);
> +
> + =A0 =A0 =A0 /* If we have an invalid pointer we'll return ENODATA *=
/
> + =A0 =A0 =A0 if (hdev =3D=3D NULL || &(hdev->dev) !=3D dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 i =3D sscanf(buf, "%u %u %u %u", m, m+1, m+2, m+3);
> + =A0 =A0 =A0 if (!(i =3D=3D 4 || i =3D=3D 1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "unrecognized input: %s=
", buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (i =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mled =3D m[0];
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mled =3D (m[0] ? 1 : 0) | (m[1] ? 2 : 0=
) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (m[2] ?=
 4 : 0) | (m[3] ? 8 : 0);
> +
> + =A0 =A0 =A0 set_result =3D g13_set_mled(hdev, mled);
> +
> + =A0 =A0 =A0 if (set_result < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return set_result;
> +
> + =A0 =A0 =A0 return count;
> +}
> +
> +static DEVICE_ATTR(mled, 0666, g13_mled_show, g13_mled_store);

Have you considered the use of the LED class driver as an alternative
to introducing these sysfs led controls for the device?


> +
> +static int g13_input_setkeycode(struct input_dev *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int sca=
ncode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int key=
code)
> +{
> + =A0 =A0 =A0 int old_keycode;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 struct g13_data *data =3D input_get_g13data(dev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (scancode >=3D dev->keycodemax)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (!dev->keycodesize)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (dev->keycodesize < sizeof(keycode) &&
> + =A0 =A0 =A0 =A0 =A0 (keycode >> (dev->keycodesize * 8)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 write_lock(&data->lock);
> +
> + =A0 =A0 =A0 old_keycode =3D data->keycode[scancode];
> + =A0 =A0 =A0 data->keycode[scancode] =3D keycode;
> +
> + =A0 =A0 =A0 clear_bit(old_keycode, dev->keybit);
> + =A0 =A0 =A0 set_bit(keycode, dev->keybit);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < dev->keycodemax; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->keycode[i] =3D=3D old_keycode=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(old_keycode, de=
v->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break; /* Setting the b=
it twice is useless, so break */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 write_unlock(&data->lock);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int g13_input_getkeycode(struct input_dev *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int sca=
ncode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int *ke=
ycode)
> +{
> + =A0 =A0 =A0 struct g13_data *data =3D input_get_g13data(dev);
> +
> + =A0 =A0 =A0 if (!dev->keycodesize)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (scancode >=3D dev->keycodemax)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 read_lock(&data->lock);
> +
> + =A0 =A0 =A0 *keycode =3D data->keycode[scancode];
> +
> + =A0 =A0 =A0 read_unlock(&data->lock);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +
> +/*
> + * The "keymap" attribute
> + */
> +static ssize_t g13_keymap_index_show(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct device_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0char *buf)
> +{
> + =A0 =A0 =A0 struct g13_data *data =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 return sprintf(buf, "%u\n", data->curkeymap);
> +}
> +
> +static ssize_t g13_set_keymap_index(struct hid_device *hdev, unsigne=
d k)
> +{
> + =A0 =A0 =A0 struct g13_data *data =3D hid_get_g13data(hdev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 if (k > 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 data->curkeymap =3D k;
> +
> + =A0 =A0 =A0 if (data->keymap_switching)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 g13_set_mled(hdev, 1<<k);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static ssize_t g13_keymap_index_store(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct device_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const char *buf, size_t count)
> +{
> + =A0 =A0 =A0 struct hid_device *hdev;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 unsigned k;
> + =A0 =A0 =A0 ssize_t set_result;
> +
> + =A0 =A0 =A0 /* Get the hid associated with the device */
> + =A0 =A0 =A0 hdev =3D container_of(dev, struct hid_device, dev);
> +
> + =A0 =A0 =A0 /* If we have an invalid pointer we'll return ENODATA *=
/
> + =A0 =A0 =A0 if (hdev =3D=3D NULL || &(hdev->dev) !=3D dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 i =3D sscanf(buf, "%u", &k);
> + =A0 =A0 =A0 if (i !=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "unrecognized input: %s=
", buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 set_result =3D g13_set_keymap_index(hdev, k);
> +
> + =A0 =A0 =A0 if (set_result < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return set_result;
> +
> + =A0 =A0 =A0 return count;
> +}
> +
> +static DEVICE_ATTR(keymap_index, 0666,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0g13_keymap_index_show,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0g13_keymap_index_store);
> +
> +/*
> + * The "keycode" attribute
> + */
> +static ssize_t g13_keymap_show(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct d=
evice_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *bu=
f)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int offset =3D 0;
> + =A0 =A0 =A0 int result;
> +
> + =A0 =A0 =A0 struct g13_data *data =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < G13_KEYMAP_SIZE; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D sprintf(buf+offset,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"0x%=
03x 0x%04x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i, d=
ata->keycode[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset +=3D result;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return offset+1;
> +}
> +
> +static ssize_t g13_keymap_store(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
device_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const c=
har *buf, size_t count)
> +{
> + =A0 =A0 =A0 struct hid_device *hdev;
> + =A0 =A0 =A0 int scanned;
> + =A0 =A0 =A0 int consumed;
> + =A0 =A0 =A0 int scancd;
> + =A0 =A0 =A0 int keycd;
> + =A0 =A0 =A0 int set_result;
> + =A0 =A0 =A0 int set =3D 0;
> + =A0 =A0 =A0 int gkey;
> + =A0 =A0 =A0 int index;
> + =A0 =A0 =A0 int good;
> + =A0 =A0 =A0 struct g13_data *data;
> +
> + =A0 =A0 =A0 /* Get the hid associated with the device */
> + =A0 =A0 =A0 hdev =3D container_of(dev, struct hid_device, dev);
> +
> + =A0 =A0 =A0 /* If we have an invalid pointer we'll return ENODATA *=
/
> + =A0 =A0 =A0 if (hdev =3D=3D NULL || &(hdev->dev) !=3D dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 /* Now, let's get the data structure */
> + =A0 =A0 =A0 data =3D hid_get_g13data(hdev);
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 good =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Look for scancode keycode pair in he=
x */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 scanned =3D sscanf(buf, "%x %x%n", &sca=
ncd, &keycd, &consumed);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (scanned =3D=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf +=3D consumed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_result =3D g13_inpu=
t_setkeycode(data->input_dev, scancd, keycd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (set_result < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
set_result;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 good =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Look for Gkey keyc=
ode pair and assign to current
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* keymap
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scanned =3D sscanf(buf,=
 "G%d %x%n", &gkey, &keycd, &consumed);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (scanned =3D=3D 2 &&=
 gkey > 0 && gkey <=3D G13_KEYS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf +=3D=
 consumed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scancd =
=3D data->curkeymap * G13_KEYS + gkey - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_res=
ult =3D g13_input_setkeycode(data->input_dev, scancd, keycd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (set=
_result < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 return set_result;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 good =3D=
 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Lo=
ok for Gkey-index keycode pair and assign
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to=
 indexed keymap
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scanned=
 =3D sscanf(buf, "G%d-%d %x%n", &gkey, &index, &keycd, &consumed);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sca=
nned =3D=3D 3 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 gkey > 0 && gkey <=3D G13_KEYS &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 index >=3D 0 && index <=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 buf +=3D consumed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 scancd =3D index * G13_KEYS + gkey - 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 set_result =3D g13_input_setkeycode(data->input_dev, scancd, k=
eycd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (set_result < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 return set_result;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 set++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 good =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 } while (good);
> +
> + =A0 =A0 =A0 if (set =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "unrecognized keycode i=
nput: %s", buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return count;
> +}
> +
> +static DEVICE_ATTR(keymap, 0666, g13_keymap_show, g13_keymap_store);
> +
> +/*
> + * The "emit_msc_raw" attribute
> + */
> +static ssize_t g13_emit_msc_raw_show(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct device_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0char *buf)
> +{
> + =A0 =A0 =A0 struct g13_data *data =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 return sprintf(buf, "%u\n", data->emit_msc_raw);
> +}
> +
> +static ssize_t g13_set_emit_msc_raw(struct hid_device *hdev, unsigne=
d k)
> +{
> + =A0 =A0 =A0 struct g13_data *data =3D hid_get_g13data(hdev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 data->emit_msc_raw =3D k;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static ssize_t g13_emit_msc_raw_store(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct device_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const char *buf, size_t count)
> +{
> + =A0 =A0 =A0 struct hid_device *hdev;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 unsigned k;
> + =A0 =A0 =A0 ssize_t set_result;
> +
> + =A0 =A0 =A0 /* Get the hid associated with the device */
> + =A0 =A0 =A0 hdev =3D container_of(dev, struct hid_device, dev);
> +
> + =A0 =A0 =A0 /* If we have an invalid pointer we'll return ENODATA *=
/
> + =A0 =A0 =A0 if (hdev =3D=3D NULL || &(hdev->dev) !=3D dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 i =3D sscanf(buf, "%u", &k);
> + =A0 =A0 =A0 if (i !=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "unrecognized input: %s=
", buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 set_result =3D g13_set_emit_msc_raw(hdev, k);
> +
> + =A0 =A0 =A0 if (set_result < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return set_result;
> +
> + =A0 =A0 =A0 return count;
> +}
> +
> +static DEVICE_ATTR(emit_msc_raw, 0666,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0g13_emit_msc_raw_show,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0g13_emit_msc_raw_store);
> +
> +
> +/*
> + * The "keymap_switching" attribute
> + */
> +static ssize_t g13_keymap_switching_show(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0struct device_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0char *buf)
> +{
> + =A0 =A0 =A0 struct g13_data *data =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 return sprintf(buf, "%u\n", data->keymap_switching);
> +}
> +
> +static ssize_t g13_set_keymap_switching(struct hid_device *hdev, uns=
igned k)
> +{
> + =A0 =A0 =A0 struct g13_data *data =3D hid_get_g13data(hdev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 data->keymap_switching =3D k;
> +
> + =A0 =A0 =A0 if (data->keymap_switching)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 g13_set_mled(hdev, 1<<(data->curkeymap)=
);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static ssize_t g13_keymap_switching_store(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 struct device_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 const char *buf, size_t count)
> +{
> + =A0 =A0 =A0 struct hid_device *hdev;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 unsigned k;
> + =A0 =A0 =A0 ssize_t set_result;
> +
> + =A0 =A0 =A0 /* Get the hid associated with the device */
> + =A0 =A0 =A0 hdev =3D container_of(dev, struct hid_device, dev);
> +
> + =A0 =A0 =A0 /* If we have an invalid pointer we'll return ENODATA *=
/
> + =A0 =A0 =A0 if (hdev =3D=3D NULL || &(hdev->dev) !=3D dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 i =3D sscanf(buf, "%u", &k);
> + =A0 =A0 =A0 if (i !=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "unrecognized input: %s=
", buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 set_result =3D g13_set_keymap_switching(hdev, k);
> +
> + =A0 =A0 =A0 if (set_result < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return set_result;
> +
> + =A0 =A0 =A0 return count;
> +}
> +
> +static DEVICE_ATTR(keymap_switching, 0666,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0g13_keymap_switching_show,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0g13_keymap_switching_store);
> +
> +
> +static ssize_t g13_name_show(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devic=
e_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *buf)
> +{
> + =A0 =A0 =A0 struct g13_data *data =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 int result;
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 if (data->name =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] =3D 0x00;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 read_lock(&data->lock);
> + =A0 =A0 =A0 result =3D sprintf(buf, "%s", data->name);
> + =A0 =A0 =A0 read_unlock(&data->lock);
> +
> + =A0 =A0 =A0 return result;
> +}
> +
> +static ssize_t g13_name_store(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devi=
ce_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char =
*buf, size_t count)
> +{
> + =A0 =A0 =A0 struct g13_data *data =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 size_t limit =3D count;
> + =A0 =A0 =A0 char *end;
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 write_lock(&data->lock);
> +
> + =A0 =A0 =A0 if (data->name !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(data->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->name =3D NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 end =3D strpbrk(buf, "\n\r");
> + =A0 =A0 =A0 if (end !=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 limit =3D end - buf;
> +
> + =A0 =A0 =A0 if (end !=3D buf) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (limit > 100)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 limit =3D 100;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->name =3D kzalloc(limit+1, GFP_KER=
NEL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncpy(data->name, buf, limit);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 write_unlock(&data->lock);
> +
> + =A0 =A0 =A0 return count;
> +}
> +
> +static DEVICE_ATTR(name, 0666, g13_name_show, g13_name_store);
> +
> +/*
> + * The "rgb" attribute
> + * red green blue
> + * each with values 0 - 255 (black - full intensity)
> + */
> +static ssize_t g13_rgb_show(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_a=
ttribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf)
> +{
> + =A0 =A0 =A0 unsigned r, g, b;
> + =A0 =A0 =A0 struct g13_data *data =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 r =3D data->rgb[0];
> + =A0 =A0 =A0 g =3D data->rgb[1];
> + =A0 =A0 =A0 b =3D data->rgb[2];
> +
> + =A0 =A0 =A0 return sprintf(buf, "%u %u %u\n", r, g, b);
> +}
> +
> +static ssize_t g13_set_rgb(struct hid_device *hdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned r, unsi=
gned g, unsigned b)
> +{
> + =A0 =A0 =A0 struct g13_data *data =3D hid_get_g13data(hdev);
> +
> + =A0 =A0 =A0 if (data =3D=3D NULL || data->backlight_report =3D=3D N=
ULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 data->backlight_report->field[0]->value[0] =3D r;
> + =A0 =A0 =A0 data->backlight_report->field[0]->value[1] =3D g;
> + =A0 =A0 =A0 data->backlight_report->field[0]->value[2] =3D b;
> + =A0 =A0 =A0 data->backlight_report->field[0]->value[3] =3D 0x00;
> +
> + =A0 =A0 =A0 usbhid_submit_report(hdev, data->backlight_report, USB_=
DIR_OUT);
> +
> + =A0 =A0 =A0 data->rgb[0] =3D r;
> + =A0 =A0 =A0 data->rgb[1] =3D g;
> + =A0 =A0 =A0 data->rgb[2] =3D b;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static ssize_t g13_rgb_store(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devic=
e_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *=
buf, size_t count)
> +{
> + =A0 =A0 =A0 struct hid_device *hdev;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 unsigned r;
> + =A0 =A0 =A0 unsigned g;
> + =A0 =A0 =A0 unsigned b;
> + =A0 =A0 =A0 ssize_t set_result;
> +
> + =A0 =A0 =A0 /* Get the hid associated with the device */
> + =A0 =A0 =A0 hdev =3D container_of(dev, struct hid_device, dev);
> +
> + =A0 =A0 =A0 /* If we have an invalid pointer we'll return ENODATA *=
/
> + =A0 =A0 =A0 if (hdev =3D=3D NULL || &(hdev->dev) !=3D dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> +
> + =A0 =A0 =A0 i =3D sscanf(buf, "%u %u %u", &r, &g, &b);
> + =A0 =A0 =A0 if (i !=3D 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "unrecognized input: %s=
", buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 set_result =3D g13_set_rgb(hdev, r, g, b);
> +
> + =A0 =A0 =A0 if (set_result < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return set_result;
> +
> + =A0 =A0 =A0 return count;
> +}
> +
> +static DEVICE_ATTR(rgb, 0666, g13_rgb_show, g13_rgb_store);
> +
> +/*
> + * Create a group of attributes so that we can create and destroy th=
em all
> + * at once.
> + */
> +static struct attribute *g13_attrs[] =3D {
> + =A0 =A0 =A0 &dev_attr_name.attr,
> + =A0 =A0 =A0 &dev_attr_rgb.attr,
> + =A0 =A0 =A0 &dev_attr_mled.attr,
> + =A0 =A0 =A0 &dev_attr_keymap_index.attr,
> + =A0 =A0 =A0 &dev_attr_emit_msc_raw.attr,
> + =A0 =A0 =A0 &dev_attr_keymap_switching.attr,
> + =A0 =A0 =A0 &dev_attr_keymap.attr,
> + =A0 =A0 =A0 &dev_attr_fb_update_rate.attr,
> + =A0 =A0 =A0 &dev_attr_fb_node.attr,
> + =A0 =A0 =A0 NULL, =A0 =A0/* need to NULL terminate the list of attr=
ibutes */
> +};

Hmm, that's a lot of stuff that you're exposing to userspace. I didn't
read through the code carefully so I don't have a good understanding
of why all that is necessary, some of them (led at least), seem to me
like duplicates of existing userspace interfaces. I have to head out
now, sorry for the incremental feedback, but I hope it is useful.

Thanks,
jaya
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

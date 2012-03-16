From: Andre Guedes <andre.guedes@openbossa.org>
Subject: Re: [RFC 1/1] HID: User-space I/O driver support for HID subsystem
Date: Fri, 16 Mar 2012 14:00:42 -0300
Message-ID: <CACJA=fVLRuRvvOTkDmuxVckW7oqM_4vk+NCN5fP1WtkGMV-NDw@mail.gmail.com>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
	<1331909617-22106-2-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45077 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032130Ab2CPRAn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 13:00:43 -0400
Received: by vcqp1 with SMTP id p1so4449158vcq.19
        for <linux-input@vger.kernel.org>; Fri, 16 Mar 2012 10:00:42 -0700 (PDT)
In-Reply-To: <1331909617-22106-2-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chen.ganir@ti.com, claudio.takahasi@openbossa.org, jprvita@openbossa.org, linux-bluetooth@vger.kernel.org, Vijaykumar.Dadmode@csr.com

Hi David,

On Fri, Mar 16, 2012 at 11:53 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> This driver allows to write I/O drivers in user-space and feed the in=
put
> into the HID subsystem. It operates on the same level as USB-HID and
> Bluetooth-HID (HIDP). It does not provide support to write special HI=
D
> device drivers but rather provides support for user-space I/O devices=
 to
> feed their data into the kernel HID subsystem. The HID subsystem then
> loads the HID device drivers for the device and provides input-device=
s
> based on the user-space HID I/O device.
>
> This driver register a new char-device (/dev/uhid). A user-space proc=
ess
> has to open this file for each device that it wants to provide to the
> kernel. It can then use write/read to communicate with the UHID drive=
r.
> Both input and output data is sent with a uhid_event structure. The "=
type"
> field of the structure specifies what kind of event is sent. There is=
 a
> file in Documentation/ explaining the ABI.
>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> =A0Documentation/hid/uhid.txt | =A0 95 +++++++++
> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0| =A0 21 ++
> =A0drivers/hid/Makefile =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/hid/uhid.c =A0 =A0 =A0 =A0 | =A0502 ++++++++++++++++++++++=
++++++++++++++++++++++
> =A0include/linux/uhid.h =A0 =A0 =A0 | =A0 71 +++++++
> =A05 files changed, 690 insertions(+), 1 deletion(-)
> =A0create mode 100644 Documentation/hid/uhid.txt
> =A0create mode 100644 drivers/hid/uhid.c
> =A0create mode 100644 include/linux/uhid.h
>
> diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.txt
> new file mode 100644
> index 0000000..67b138d
> --- /dev/null
> +++ b/Documentation/hid/uhid.txt
> @@ -0,0 +1,95 @@
> + =A0 =A0 =A0UHID - User-space I/O driver support for HID subsystem
> + =A0 =A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The UHID driver provides an interface for user-space I/O drivers to =
feed their
> +data into the HID subsystem. The HID subsystem then parses the HID r=
eports and
> +loads the corresponding HID device driver which then provides the pa=
rsed data
> +via input-devices to user-space.
> +
> +This allows user-space to operate on the same level as USB-HID, Blue=
tooth-HID
> +and similar. It does not provide a way to write HID device drivers, =
though! Use
> +HIDRAW for this purpose.
> +
> +UHID dynamically allocates the minor/major number, meaning that you =
should rely
> +on udev to create the UHID device node. Typically this is created as=
 /dev/uhid.
> +
> +The UHID API
> +------------
> +
> +For each device that you want to register with the HID core, you nee=
d to open a
> +separate file-descriptor on /dev/uhid. All communication is done by =
read()'ing
> +or write()'ing "struct uhid_event" objects to the file. Non-blocking=
 operations
> +via O_NONBLOCK are supported.
> +
> +struct uhid_event {
> + =A0 =A0 =A0 =A0__u32 type;
> + =A0 =A0 =A0 =A0... payload ...
> +};
> +
> +write()
> +-------
> +write() allows you to modify the state of the device and feed input =
data into
> +the kernel. The following types are supported: UHID_CREATE, UHID_DES=
TROY and
> +UHID_INPUT.
> +
> + =A0UHID_CREATE:
> + =A0This creates the internal HID device. No I/O is possible until y=
ou send this
> + =A0event to the kernel. The payload is of type struct uhid_create_r=
eq and
> + =A0contains information about your device.
> +
> + =A0UHID_DESTROY:
> + =A0This destroys the internal HID device. No further I/O will be ac=
cepted. There
> + =A0may still be pending messages that you can receive with read() b=
ut no further
> + =A0UHID_INPUT events can be sent to the kernel.
> + =A0You can create a new device by sending UHID_CREATE again. There =
is no need to
> + =A0reopen the character device.
> +
> + =A0UHID_INPUT:
> + =A0You must send UHID_CREATE before sending input to the kernel! Th=
is event
> + =A0contains a data-payload. This is the raw data that you read from=
 your device.
> + =A0The kernel will parse the HID reports and react on it.
> +
> +read()
> +------
> +read() will return a queued ouput report. These output reports can b=
e of type
> +UHID_START, UHID_STOP, UHID_OPEN, UHID_CLOSE, UHID_OUTPUT or UHID_OU=
TPUT_EV. No
> +reaction is required to any of them but you should handle them accor=
ding to your
> +needs. Only UHID_OUTPUT and UHID_OUTPUT_EV have payloads.
> +
> + =A0UHID_START:
> + =A0This is sent when the HID device is started. Consider this as an=
 answer to
> + =A0UHID_CREATE. This is always the first event that is sent. No I/O=
 is possible
> + =A0before you read this.
> +
> + =A0UHID_STOP:
> + =A0This is sent when the HID device is stopped. Consider this as an=
 answer to
> + =A0UHID_DESTROY. No further I/O will be possible after receiving th=
is.
> + =A0If the kernel HID device driver closes the device manually (that=
 is, you
> + =A0didn't send UHID_DESTROY) then you should consider this device c=
losed and send
> + =A0an UHID_DESTROY event. You may want to reregister your device, t=
hough.
> +
> + =A0UHID_OPEN:
> + =A0This is sent when the HID device is opened. That is, the data th=
at the HID
> + =A0device provides is read by some other process. You may ignore th=
is event but
> + =A0it is useful for power-management. As long as you haven't receiv=
ed this event
> + =A0there is actually no other process that reads your data so there=
 is no need to
> + =A0send UHID_INPUT events to the kernel.
> +
> + =A0UHID_CLOSE:
> + =A0This is sent when there are no more processes which read the HID=
 data. It is
> + =A0the counterpart of UHID_OPEN and you may as well ignore this eve=
nt.
> +
> + =A0UHID_OUTPUT:
> + =A0This is sent if the HID device driver wants to send raw data to =
the I/O
> + =A0device. You should read the payload and forward it to the device=
=2E The payload
> + =A0is of type "struct uhid_data_req".
> + =A0This may be received even though you haven't received UHID_OPEN,=
 yet.
> +
> + =A0UHID_OUTPUT_EV:
> + =A0Same as UHID_OUTPUT but this contains a "struct input_event" as =
payload. This
> + =A0is called for force-feedback, LED or similar events which are re=
ceived through
> + =A0an input device by the HID subsystem. You should convert this in=
to raw reports
> + =A0and send them to your device similar to events of type UHID_OUTP=
UT.
> +
> +Document by:
> + =A0David Herrmann <dh.herrmann@googlemail.com>

What do you think about using ioctl() to handle creating, destroying
and configuring internal hid devices and leave read() and write() to
handle HID reports?

This way, at user-space, we wouldn't need to build uhid_event messages
for every HID report we get. We would just write() the HID report
right away.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 54cc92f..cabe771 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -55,6 +55,27 @@ config HIDRAW
>
> =A0 =A0 =A0 =A0If unsure, say Y.
>
> +config UHID
> + =A0 =A0 =A0 tristate "User-space I/O driver support for HID subsyst=
em"
> + =A0 =A0 =A0 depends on HID
> + =A0 =A0 =A0 default n
> + =A0 =A0 =A0 ---help---
> + =A0 =A0 =A0 Say Y here if you want to provide HID I/O drivers from =
user-space.
> + =A0 =A0 =A0 This allows to write I/O drivers in user-space and feed=
 the data from
> + =A0 =A0 =A0 the device into the kernel. The kernel parses the HID r=
eports, loads the
> + =A0 =A0 =A0 corresponding HID device driver or provides input devic=
es on top of your
> + =A0 =A0 =A0 user-space device.
> +
> + =A0 =A0 =A0 This driver cannot be used to parse HID-reports in user=
-space and write
> + =A0 =A0 =A0 special HID-drivers. You should use HIDRAW for that.
> + =A0 =A0 =A0 Instead, this driver allows to write the transport-laye=
r driver in
> + =A0 =A0 =A0 user-space like USB-HID and Bluetooth-HID do in kernel-=
space.
> +
> + =A0 =A0 =A0 If unsure, say N.
> +
> + =A0 =A0 =A0 To compile this driver as a module, choose M here: the
> + =A0 =A0 =A0 module will be called uhid.
> +
> =A0source "drivers/hid/usbhid/Kconfig"
>
> =A0menu "Special HID drivers"
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 22f1d16..cadb84f 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -8,6 +8,7 @@ ifdef CONFIG_DEBUG_FS
> =A0endif
>
> =A0obj-$(CONFIG_HID) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D hid.o
> +obj-$(CONFIG_UHID) =A0 =A0 =A0 =A0 =A0 =A0 +=3D uhid.o
>
> =A0hid-$(CONFIG_HIDRAW) =A0 =A0 =A0 =A0 =A0 +=3D hidraw.o
>
> @@ -88,4 +89,3 @@ obj-$(CONFIG_HID_WIIMOTE) =A0 =A0 +=3D hid-wiimote.=
o
> =A0obj-$(CONFIG_USB_HID) =A0 =A0 =A0 =A0 =A0+=3D usbhid/
> =A0obj-$(CONFIG_USB_MOUSE) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D usbhid=
/
> =A0obj-$(CONFIG_USB_KBD) =A0 =A0 =A0 =A0 =A0+=3D usbhid/
> -
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> new file mode 100644
> index 0000000..1bb16a7
> --- /dev/null
> +++ b/drivers/hid/uhid.c
> @@ -0,0 +1,502 @@
> +/*
> + * User-space I/O driver support for HID subsystem
> + * Copyright (c) 2012 David Herrmann
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License as published by=
 the Free
> + * Software Foundation; either version 2 of the License, or (at your=
 option)
> + * any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/hid.h>
> +#include <linux/input.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/poll.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/uhid.h>
> +#include <linux/wait.h>
> +
> +#define UHID_NAME =A0 =A0 =A0"uhid"
> +#define UHID_BUFSIZE =A0 32
> +
> +enum uhid_state {
> + =A0 =A0 =A0 UHID_NEW,
> + =A0 =A0 =A0 UHID_RUNNING,
> +};
> +
> +struct uhid_device {
> + =A0 =A0 =A0 struct mutex devlock;
> + =A0 =A0 =A0 enum uhid_state state;
> + =A0 =A0 =A0 struct device *parent;
> +
> + =A0 =A0 =A0 __u8 *rd_data;
> + =A0 =A0 =A0 uint rd_size;
> +
> + =A0 =A0 =A0 struct hid_device *hid;
> + =A0 =A0 =A0 struct uhid_event input_buf;
> +
> + =A0 =A0 =A0 wait_queue_head_t waitq;
> + =A0 =A0 =A0 spinlock_t qlock;
> + =A0 =A0 =A0 struct uhid_event assemble;
> + =A0 =A0 =A0 __u8 head;
> + =A0 =A0 =A0 __u8 tail;
> + =A0 =A0 =A0 struct uhid_event outq[UHID_BUFSIZE];
> +};
> +
> +static void uhid_queue(struct uhid_device *uhid, const struct uhid_e=
vent *ev)
> +{
> + =A0 =A0 =A0 __u8 newhead;
> +
> + =A0 =A0 =A0 newhead =3D (uhid->head + 1) % UHID_BUFSIZE;
> +
> + =A0 =A0 =A0 if (newhead !=3D uhid->tail) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&uhid->outq[uhid->head], ev, siz=
eof(struct uhid_event));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uhid->head =3D newhead;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up_interruptible(&uhid->waitq);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("Output queue is full\n");
> + =A0 =A0 =A0 }
> +}
> +
> +static int uhid_hid_start(struct hid_device *hid)
> +{
> + =A0 =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (uhid->state !=3D UHID_RUNNING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&uhid->qlock, flags);
> + =A0 =A0 =A0 memset(&uhid->assemble, 0, sizeof(uhid->assemble));
> + =A0 =A0 =A0 uhid->assemble.type =3D UHID_START;
> + =A0 =A0 =A0 uhid_queue(uhid, &uhid->assemble);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, flags);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void uhid_hid_stop(struct hid_device *hid)
> +{
> + =A0 =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (uhid->state !=3D UHID_RUNNING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&uhid->qlock, flags);
> + =A0 =A0 =A0 memset(&uhid->assemble, 0, sizeof(uhid->assemble));
> + =A0 =A0 =A0 uhid->assemble.type =3D UHID_STOP;
> + =A0 =A0 =A0 uhid_queue(uhid, &uhid->assemble);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, flags);
> +
> + =A0 =A0 =A0 hid->claimed =3D 0;
> +}
> +
> +static int uhid_hid_open(struct hid_device *hid)
> +{
> + =A0 =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (uhid->state !=3D UHID_RUNNING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&uhid->qlock, flags);
> + =A0 =A0 =A0 memset(&uhid->assemble, 0, sizeof(uhid->assemble));
> + =A0 =A0 =A0 uhid->assemble.type =3D UHID_OPEN;
> + =A0 =A0 =A0 uhid_queue(uhid, &uhid->assemble);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, flags);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void uhid_hid_close(struct hid_device *hid)
> +{
> + =A0 =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (uhid->state !=3D UHID_RUNNING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&uhid->qlock, flags);
> + =A0 =A0 =A0 memset(&uhid->assemble, 0, sizeof(uhid->assemble));
> + =A0 =A0 =A0 uhid->assemble.type =3D UHID_CLOSE;
> + =A0 =A0 =A0 uhid_queue(uhid, &uhid->assemble);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, flags);
> +}
> +
> +static int uhid_hid_power(struct hid_device *hid, int level)
> +{
> + =A0 =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
> +
> + =A0 =A0 =A0 /* TODO: Handle PM-hints. This isn't mandatory so we si=
mply return 0
> + =A0 =A0 =A0 =A0* here.
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 if (uhid->state !=3D UHID_RUNNING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int uhid_hid_input(struct input_dev *input, unsigned int type=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d int code, int value)
> +{
> + =A0 =A0 =A0 struct hid_device *hid =3D input_get_drvdata(input);
> + =A0 =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (uhid->state !=3D UHID_RUNNING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&uhid->qlock, flags);
> + =A0 =A0 =A0 memset(&uhid->assemble, 0, sizeof(uhid->assemble));
> +
> + =A0 =A0 =A0 uhid->assemble.type =3D UHID_OUTPUT_EV;
> + =A0 =A0 =A0 uhid->assemble.u.data_ev.type =3D type;
> + =A0 =A0 =A0 uhid->assemble.u.data_ev.code =3D code;
> + =A0 =A0 =A0 uhid->assemble.u.data_ev.value =3D value;
> +
> + =A0 =A0 =A0 uhid_queue(uhid, &uhid->assemble);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, flags);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int uhid_hid_parse(struct hid_device *hid)
> +{
> + =A0 =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
> +
> + =A0 =A0 =A0 if (uhid->state !=3D UHID_RUNNING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 return hid_parse_report(hid, uhid->rd_data, uhid->rd_si=
ze);
> +}
> +
> +static int uhid_hid_get_raw(struct hid_device *hid, unsigned char rn=
um,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __u8 *b=
uf, size_t count, unsigned char rtype)
> +{
> + =A0 =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
> +
> + =A0 =A0 =A0 if (uhid->state !=3D UHID_RUNNING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 /* TODO: we currently do not support this request. If w=
e want this we
> + =A0 =A0 =A0 =A0* would need some kind of stream-locking but it isn'=
t needed by the
> + =A0 =A0 =A0 =A0* main drivers, anyway.
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 return -EOPNOTSUPP;
> +}
> +
> +static int uhid_hid_output_raw(struct hid_device *hid, __u8 *buf, si=
ze_t count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d char report_type)
> +{
> + =A0 =A0 =A0 struct uhid_device *uhid =3D hid->driver_data;
> + =A0 =A0 =A0 __u8 rtype;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 switch (report_type) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_FEATURE_REPORT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtype =3D UHID_FEATURE_=
REPORT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_OUTPUT_REPORT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtype =3D UHID_OUTPUT_R=
EPORT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (count < 1 || count > UHID_DATA_MAX)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (uhid->state !=3D UHID_RUNNING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&uhid->qlock, flags);
> + =A0 =A0 =A0 memset(&uhid->assemble, 0, sizeof(uhid->assemble));
> +
> + =A0 =A0 =A0 uhid->assemble.type =3D UHID_OUTPUT;
> + =A0 =A0 =A0 uhid->assemble.u.data.size =3D count;
> + =A0 =A0 =A0 uhid->assemble.u.data.rtype =3D rtype;
> + =A0 =A0 =A0 memcpy(uhid->assemble.u.data.data, buf, count);
> +
> + =A0 =A0 =A0 uhid_queue(uhid, &uhid->assemble);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, flags);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct hid_ll_driver uhid_hid_driver =3D {
> + =A0 =A0 =A0 .start =3D uhid_hid_start,
> + =A0 =A0 =A0 .stop =3D uhid_hid_stop,
> + =A0 =A0 =A0 .open =3D uhid_hid_open,
> + =A0 =A0 =A0 .close =3D uhid_hid_close,
> + =A0 =A0 =A0 .power =3D uhid_hid_power,
> + =A0 =A0 =A0 .hidinput_input_event =3D uhid_hid_input,
> + =A0 =A0 =A0 .parse =3D uhid_hid_parse,
> +};
> +
> +static int uhid_dev_create(struct uhid_device *uhid,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const s=
truct uhid_event *ev)
> +{
> + =A0 =A0 =A0 struct hid_device *hid;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D mutex_lock_interruptible(&uhid->devlock);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 if (uhid->state !=3D UHID_NEW) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EALREADY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 uhid->rd_size =3D ev->u.create.rd_size;
> + =A0 =A0 =A0 uhid->rd_data =3D kzalloc(uhid->rd_size, GFP_KERNEL);
> + =A0 =A0 =A0 if (!uhid->rd_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (copy_from_user(uhid->rd_data, ev->u.create.rd_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uhid->r=
d_size)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EFAULT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 hid =3D hid_allocate_device();
> + =A0 =A0 =A0 if (IS_ERR(hid)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(hid);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 strncpy(hid->name, ev->u.create.name, 128);
> + =A0 =A0 =A0 hid->name[127] =3D 0;
> + =A0 =A0 =A0 hid->ll_driver =3D &uhid_hid_driver;
> + =A0 =A0 =A0 hid->hid_get_raw_report =3D uhid_hid_get_raw;
> + =A0 =A0 =A0 hid->hid_output_raw_report =3D uhid_hid_output_raw;
> + =A0 =A0 =A0 hid->bus =3D BUS_VIRTUAL;
> + =A0 =A0 =A0 hid->country =3D ev->u.create.country;
> + =A0 =A0 =A0 hid->vendor =3D ev->u.create.vendor;
> + =A0 =A0 =A0 hid->product =3D ev->u.create.product;
> + =A0 =A0 =A0 hid->version =3D ev->u.create.version;
> + =A0 =A0 =A0 hid->phys[0] =3D 0;
> + =A0 =A0 =A0 hid->uniq[0] =3D 0;
> + =A0 =A0 =A0 hid->driver_data =3D uhid;
> + =A0 =A0 =A0 hid->dev.parent =3D uhid->parent;
> +
> + =A0 =A0 =A0 ret =3D hid_add_device(hid);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot register HID device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_hid;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 uhid->hid =3D hid;
> + =A0 =A0 =A0 uhid->state =3D UHID_RUNNING;
> + =A0 =A0 =A0 mutex_unlock(&uhid->devlock);
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_hid:
> + =A0 =A0 =A0 hid_destroy_device(hid);
> +err_free:
> + =A0 =A0 =A0 kfree(uhid->rd_data);
> +unlock:
> + =A0 =A0 =A0 mutex_unlock(&uhid->devlock);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int uhid_dev_destroy(struct uhid_device *uhid)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D mutex_lock_interruptible(&uhid->devlock);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 if (uhid->state !=3D UHID_RUNNING) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 hid_destroy_device(uhid->hid);
> + =A0 =A0 =A0 kfree(uhid->rd_data);
> + =A0 =A0 =A0 uhid->state =3D UHID_NEW;
> +
> +unlock:
> + =A0 =A0 =A0 mutex_unlock(&uhid->devlock);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int uhid_dev_input(struct uhid_device *uhid, struct uhid_even=
t *ev)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D mutex_lock_interruptible(&uhid->devlock);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 if (uhid->state !=3D UHID_RUNNING) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.dat=
a.data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ev->u.d=
ata.size, 0);
> +
> +unlock:
> + =A0 =A0 =A0 mutex_unlock(&uhid->devlock);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int uhid_char_open(struct inode *inode, struct file *file)
> +{
> + =A0 =A0 =A0 struct uhid_device *uhid;
> +
> + =A0 =A0 =A0 uhid =3D kzalloc(sizeof(*uhid), GFP_KERNEL);
> + =A0 =A0 =A0 if (!uhid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 mutex_init(&uhid->devlock);
> + =A0 =A0 =A0 spin_lock_init(&uhid->qlock);
> + =A0 =A0 =A0 init_waitqueue_head(&uhid->waitq);
> + =A0 =A0 =A0 uhid->state =3D UHID_NEW;
> + =A0 =A0 =A0 uhid->parent =3D NULL;
> +
> + =A0 =A0 =A0 file->private_data =3D uhid;
> + =A0 =A0 =A0 nonseekable_open(inode, file);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int uhid_char_release(struct inode *inode, struct file *file)
> +{
> + =A0 =A0 =A0 struct uhid_device *uhid =3D file->private_data;
> +
> + =A0 =A0 =A0 uhid_dev_destroy(uhid);
> + =A0 =A0 =A0 kfree(uhid);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static ssize_t uhid_char_read(struct file *file, char __user *buffer=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t =
count, loff_t *ppos)
> +{
> + =A0 =A0 =A0 struct uhid_device *uhid =3D file->private_data;
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 size_t len;
> +
> + =A0 =A0 =A0 /* we need at least the "type" member of uhid_event */
> + =A0 =A0 =A0 if (count < sizeof(__u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> +try_again:
> + =A0 =A0 =A0 if (file->f_flags & O_NONBLOCK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uhid->head =3D=3D uhid->tail)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D wait_event_interruptible(uhid->=
waitq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 uhid->head !=3D uhid->tail);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&uhid->qlock, flags);
> +
> + =A0 =A0 =A0 if (uhid->head !=3D uhid->tail) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D min_t(size_t, count, sizeof(str=
uct uhid_event));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (copy_to_user(buffer, &uhid->outq[uh=
id->tail], len))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EFAULT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uhid->tail =3D (uhid->t=
ail + 1) % UHID_BUFSIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, fl=
ags);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&uhid->qlock, fl=
ags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto try_again;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret ? ret : len;
> +}
> +
> +static ssize_t uhid_char_write(struct file *file, const char __user =
*buffer,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t =
count, loff_t *ppos)
> +{
> + =A0 =A0 =A0 struct uhid_device *uhid =3D file->private_data;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 /* we need at least the "type" member of uhid_event */
> + =A0 =A0 =A0 if (count < sizeof(__u32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 memset(&uhid->input_buf, 0, sizeof(uhid->input_buf));
> + =A0 =A0 =A0 if (copy_from_user(&uhid->input_buf, buffer, count))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> +
> + =A0 =A0 =A0 switch (uhid->input_buf.type) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case UHID_CREATE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D uhid_dev_create=
(uhid, &uhid->input_buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case UHID_DESTROY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D uhid_dev_destro=
y(uhid);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case UHID_INPUT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D uhid_dev_input(=
uhid, &uhid->input_buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret ? ret : count;
> +}
> +
> +static unsigned int uhid_char_poll(struct file *file, poll_table *wa=
it)
> +{
> + =A0 =A0 =A0 struct uhid_device *uhid =3D file->private_data;
> +
> + =A0 =A0 =A0 poll_wait(file, &uhid->waitq, wait);
> +
> + =A0 =A0 =A0 if (uhid->head !=3D uhid->tail)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return POLLIN | POLLRDNORM;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct file_operations uhid_fops =3D {
> + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 .open =A0 =A0 =A0 =A0 =A0 =3D uhid_char_open,
> + =A0 =A0 =A0 .release =A0 =A0 =A0 =A0=3D uhid_char_release,
> + =A0 =A0 =A0 .read =A0 =A0 =A0 =A0 =A0 =3D uhid_char_read,
> + =A0 =A0 =A0 .write =A0 =A0 =A0 =A0 =A0=3D uhid_char_write,
> + =A0 =A0 =A0 .poll =A0 =A0 =A0 =A0 =A0 =3D uhid_char_poll,
> + =A0 =A0 =A0 .llseek =A0 =A0 =A0 =A0 =3D no_llseek,
> +};
> +
> +static struct miscdevice uhid_misc =3D {
> + =A0 =A0 =A0 .fops =A0 =A0 =A0 =A0 =A0 =3D &uhid_fops,
> + =A0 =A0 =A0 .minor =A0 =A0 =A0 =A0 =A0=3D MISC_DYNAMIC_MINOR,
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D UHID_NAME,
> +};
> +
> +static int __init uhid_init(void)
> +{
> + =A0 =A0 =A0 return misc_register(&uhid_misc);
> +}
> +
> +static void __exit uhid_exit(void)
> +{
> + =A0 =A0 =A0 misc_deregister(&uhid_misc);
> +}
> +
> +module_init(uhid_init);
> +module_exit(uhid_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("David Herrmann <dh.herrmann@gmail.com>");
> +MODULE_DESCRIPTION("User-space I/O driver support for HID subsystem"=
);
> diff --git a/include/linux/uhid.h b/include/linux/uhid.h
> new file mode 100644
> index 0000000..1a7df0d
> --- /dev/null
> +++ b/include/linux/uhid.h
> @@ -0,0 +1,71 @@
> +#ifndef __UHID_H_
> +#define __UHID_H_
> +
> +/*
> + * User-space I/O driver support for HID subsystem
> + * Copyright (c) 2012 David Herrmann
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License as published by=
 the Free
> + * Software Foundation; either version 2 of the License, or (at your=
 option)
> + * any later version.
> + */
> +
> +#include <linux/input.h>
> +#include <linux/types.h>
> +
> +enum uhid_event_type {
> + =A0 =A0 =A0 UHID_CREATE,
> + =A0 =A0 =A0 UHID_DESTROY,
> + =A0 =A0 =A0 UHID_START,
> + =A0 =A0 =A0 UHID_STOP,
> + =A0 =A0 =A0 UHID_OPEN,
> + =A0 =A0 =A0 UHID_CLOSE,
> + =A0 =A0 =A0 UHID_OUTPUT,
> + =A0 =A0 =A0 UHID_OUTPUT_EV,
> + =A0 =A0 =A0 UHID_INPUT,
> +};
> +
> +struct uhid_create_req {
> + =A0 =A0 =A0 __u8 __user name[128];
> + =A0 =A0 =A0 __u8 __user *rd_data;
> + =A0 =A0 =A0 __u16 rd_size;
> +
> + =A0 =A0 =A0 __u16 vendor;
> + =A0 =A0 =A0 __u16 product;
> + =A0 =A0 =A0 __u16 version;
> + =A0 =A0 =A0 __u8 country;
> +};
> +
> +#define UHID_DATA_MAX 4096
> +
> +enum uhid_report_type {
> + =A0 =A0 =A0 UHID_FEATURE_REPORT,
> + =A0 =A0 =A0 UHID_OUTPUT_REPORT,
> +};
> +
> +struct uhid_data_req {
> + =A0 =A0 =A0 __u8 data[UHID_DATA_MAX];
> + =A0 =A0 =A0 __u16 size;
> + =A0 =A0 =A0 __u8 rtype;
> +};
> +
> +struct uhid_data_ev_req {
> + =A0 =A0 =A0 __u16 type;
> + =A0 =A0 =A0 __u16 code;
> + =A0 =A0 =A0 __s32 value;
> +};
> +
> +struct uhid_event {
> + =A0 =A0 =A0 __u32 type;
> +
> + =A0 =A0 =A0 union {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct uhid_create_req create;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct uhid_data_req data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct input_event data_ev;
> + =A0 =A0 =A0 } u;
> +};
> +
> +#endif /* __UHID_H_ */
> --
> 1.7.9.4

BR,

Andre
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

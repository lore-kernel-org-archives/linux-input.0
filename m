From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: wacom serial tablet support
Date: Thu, 28 Feb 2013 18:02:12 -0800
Message-ID: <CAF8JNhJKpzkA_S3ebaZa3jDcT1wSbZf59Fqp9-s_KAux7pZviQ@mail.gmail.com>
References: <878v6axv7t.fsf@sliver.cipht.net>
	<20130227052335.GA24420@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:63936 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab3CACCQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Feb 2013 21:02:16 -0500
Received: by mail-lb0-f176.google.com with SMTP id s4so1851415lbc.7
        for <linux-input@vger.kernel.org>; Thu, 28 Feb 2013 18:02:13 -0800 (PST)
In-Reply-To: <20130227052335.GA24420@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Julian Squires <julian@cipht.net>, Chris Bagwell <chris@cnpbagwell.com>, Jason Gerecke <killertofu@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Tuesday, February 26, 2013, Dmitry Torokhov wrote:
>
> Hi Julian,
>
> On Tue, Feb 26, 2013 at 10:07:20PM -0500, Julian Squires wrote:
> >
> > Hi,
> >
> > Closing in on two years ago I wrote a kernel driver for Wacom protocol
> > IV serial tablet support.  It's been used successfully by at least a
> > dozen users over that time, and I would like to take steps to get it
> > into the mainline kernel.  After the magic scissors is my first attempt
> > at a patch for your approval.  Please let me know what I can do to
> > improve this and get it merged.
> >
> > Thanks.
>
> The driver looks quite reasonable, however that would be the 4th Wacom
> driver in the tree... I wonder if it is time to split out transport
> parts from core wacom functionality so that it can be shared by USB, I2C
> and serio devices.

Dmitry raised a very good point. We were considering to unify Wacom
drivers. With recent HID patches submitted by Benjamin and Henrik, I
feel it makes more sense to consider integrate Wacom into HID
subsystem. However, unless someone in the community has time to work
on it now, it will take sometime for us to priority our workflow.

As for Julian's patch, serial models are more than 10 years old. Last
serial devices (Intuos2 series) were released in 2001. We stopped
producing serial devices in 2004 (Intuos3 released then). Whether we
should add EOL models to upstream is beyond my decision. But, my team
won't have resources to maintain this driver, that is for sure.

If by whatever reason we can not merge this patch upstream, I am
willing to help Julian merge this patch to linuxwacom.sf.net project.
I hate to let good work go to waste. This patch could fit into one of
our legacy support branches, if Julian is interested in working with
linuxwacom project.

Ping

>
>
> Thanks.
>
> >
> > -- >8 --
> >
> > Subject: [PATCH] Add Wacom serial tablet (protocol IV) support
> >
> > Signed-off-by: Julian Squires <julian@cipht.net>
> > ---
> >  drivers/input/tablet/Kconfig    |   12 +
> >  drivers/input/tablet/Makefile   |    1 +
> >  drivers/input/tablet/wacom_iv.c |  494 +++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/serio.h      |    1 +
> >  4 files changed, 508 insertions(+)
> >  create mode 100644 drivers/input/tablet/wacom_iv.c
> >
> > diff --git a/drivers/input/tablet/Kconfig b/drivers/input/tablet/Kconfig
> > index bed7cbf..8ea7ef5 100644
> > --- a/drivers/input/tablet/Kconfig
> > +++ b/drivers/input/tablet/Kconfig
> > @@ -89,4 +89,16 @@ config TABLET_USB_WACOM
> >         To compile this driver as a module, choose M here: the
> >         module will be called wacom.
> >
> > +config TABLET_SERIAL_WACOM_IV
> > +     tristate "Wacom protocol IV tablet support (serial)"
> > +     depends on SERIO
> > +     help
> > +       Say Y here if you have a serial Wacom Digitizer II,
> > +       PenPartner, or Graphire tablet.  Make sure to say Y to
> > +       "Mouse support" (CONFIG_INPUT_MOUSEDEV) and/or "Event
> > +       interface support" (CONFIG_INPUT_EVDEV) as well.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called wacom_iv.
> > +
> >  endif
> > diff --git a/drivers/input/tablet/Makefile b/drivers/input/tablet/Makefile
> > index 3f6c252..b10e29f 100644
> > --- a/drivers/input/tablet/Makefile
> > +++ b/drivers/input/tablet/Makefile
> > @@ -11,3 +11,4 @@ obj-$(CONFIG_TABLET_USB_GTCO)       += gtco.o
> >  obj-$(CONFIG_TABLET_USB_HANWANG) += hanwang.o
> >  obj-$(CONFIG_TABLET_USB_KBTAB)       += kbtab.o
> >  obj-$(CONFIG_TABLET_USB_WACOM)       += wacom.o
> > +obj-$(CONFIG_TABLET_SERIAL_WACOM_IV) += wacom_iv.o
> > diff --git a/drivers/input/tablet/wacom_iv.c b/drivers/input/tablet/wacom_iv.c
> > new file mode 100644
> > index 0000000..897ce83
> > --- /dev/null
> > +++ b/drivers/input/tablet/wacom_iv.c
> > @@ -0,0 +1,494 @@
> > +/*
> > + * Wacom protocol 4 serial tablet driver
> > + *
> > + * Many thanks to Bill Seremetis, without whom PenPartner support
> > + * would not have been possible.
> > + *
> > + * Thanks to Patrick Mahoney.
> > + *
> > + * Sections I have been unable to test personally due to lack of
> > + * available hardware are marked UNTESTED.  Much of what is marked
> > + * UNTESTED comes from reading the wcmSerial code in linuxwacom 0.9.0.
> > + * If you have a tablet that corresponds to an UNTESTED section,
> > + * please email me your results.
> > + *
> > + * To do:
> > + *  - support pad buttons;
> > + *  - support (protocol 4-style) tilt;
> > + *  - support suppress;
> > + *  - support Graphire relative wheel.
> > + *
> > + * This driver was developed with reference to much code written by others,
> > + * particularly:
> > + *  - elo, gunze drivers by Vojtech Pavlik <vojtech@ucw.cz>;
> > + *  - wacom_w8001 driver by Jaya Kumar <jayakumar.lkml@gmail.com>;
> > + *  - the USB wacom input driver, credited to many people
> > + *    (see drivers/input/tablet/wacom.h);
> > + *  - new and old versions of linuxwacom / xf86-input-wacom credited to
> > + *    Frederic Lepied, France. <Lepied@XFree86.org> and
> > + *    Ping Cheng, Wacom. <pingc@wacom.com>;
> > + *  - and xf86wacom.c (a presumably ancient version of the linuxwacom code), by
> > + *    Frederic Lepied and Raph Levien <raph@gtk.org>.
> > + */
> > +
> > +#include <linux/string.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/input.h>
> > +#include <linux/serio.h>
> > +#include <linux/slab.h>
> > +#include <linux/completion.h>
> > +
> > +#define DRIVER_AUTHOR        "Julian Squires <julian@cipht.net>"
> > +#define DEVICE_NAME  "Wacom protocol 4 serial tablet"
> > +#define DRIVER_DESC  DEVICE_NAME " driver"
> > +
> > +MODULE_AUTHOR(DRIVER_AUTHOR);
> > +MODULE_DESCRIPTION(DRIVER_DESC);
> > +MODULE_LICENSE("GPL");
> > +
> > +#define REQUEST_MODEL_AND_ROM_VERSION        "~#"
> > +#define REQUEST_MAX_COORDINATES              "~C\r"
> > +#define REQUEST_CONFIGURATION_STRING "~R\r"
> > +#define REQUEST_RESET_TO_PROTOCOL_IV "\r#"
> > +/* Note: sending "\r$\r" causes at least the Digitizer II to send
> > + * packets in ASCII instead of binary.  "\r#" seems to undo that. */
> > +
> > +#define COMMAND_START_SENDING_PACKETS                "ST\r"
> > +#define COMMAND_STOP_SENDING_PACKETS         "SP\r"
> > +#define COMMAND_MULTI_MODE_INPUT             "MU1\r"
> > +#define COMMAND_ORIGIN_IN_UPPER_LEFT         "OC1\r"
> > +#define COMMAND_ENABLE_ALL_MACRO_BUTTONS     "~M0\r"
> > +#define COMMAND_DISABLE_GROUP_1_MACRO_BUTTONS        "~M1\r"
> > +#define COMMAND_TRANSMIT_AT_MAX_RATE         "IT0\r"
> > +#define COMMAND_DISABLE_INCREMENTAL_MODE     "IN0\r"
> > +#define COMMAND_ENABLE_CONTINUOUS_MODE               "SR\r"
> > +#define COMMAND_ENABLE_PRESSURE_MODE         "PH1\r"
> > +#define COMMAND_Z_FILTER                     "ZF1\r"
> > +
> > +/* Note that this is a protocol 4 packet without tilt information. */
> > +#define PACKET_LENGTH 7
> > +
> > +/* device IDs from wacom_wac.h */
> > +#define STYLUS_DEVICE_ID     0x02
> > +#define TOUCH_DEVICE_ID         0x03
> > +#define CURSOR_DEVICE_ID        0x06
> > +#define ERASER_DEVICE_ID        0x0A
> > +#define PAD_DEVICE_ID           0x0F
> > +
> > +#define PAD_SERIAL 0xF0
> > +
> > +enum { STYLUS = 1, ERASER, PAD, CURSOR, TOUCH };
> > +struct { int device_id; int input_id; } tools[] = {
> > +     { 0, 0 },
> > +     { STYLUS_DEVICE_ID, BTN_TOOL_PEN },
> > +     { ERASER_DEVICE_ID, BTN_TOOL_RUBBER },
> > +     { PAD_DEVICE_ID, 0 },
> > +     { CURSOR_DEVICE_ID, BTN_TOOL_MOUSE },
> > +     { TOUCH_DEVICE_ID, BTN_TOOL_FINGER }
> > +};
> > +
> > +struct wacom {
> > +     struct input_dev *dev;
> > +     struct completion cmd_done;
> > +     int extra_z_bits, tool;
> > +     int idx;
> > +     unsigned char data[32];
> > +     char phys[32];
> > +};
> > +
> > +
> > +enum {
> > +     MODEL_CINTIQ            = 0x504C, /* PL */
> > +     MODEL_CINTIQ2           = 0x4454, /* DT */
> > +     MODEL_DIGITIZER_II      = 0x5544, /* UD */
> > +     MODEL_GRAPHIRE          = 0x4554, /* ET */
> > +     MODEL_INTUOS            = 0x4744, /* GD */
> > +     MODEL_INTUOS2           = 0x5844, /* XD */
> > +     MODEL_PENPARTNER        = 0x4354, /* CT */
> > +     MODEL_UNKNOWN           = 0
> > +};
> > +
> > +static void handle_model_response(struct wacom *wacom)
> > +{
> > +     int major_v, minor_v, max_z;
> > +     char *p;
> > +
> > +     major_v = minor_v = 0;
> > +     p = strrchr(wacom->data, 'V');
> > +     if (p)
> > +             sscanf(p+1, "%u.%u", &major_v, &minor_v);
> > +
> > +     switch (wacom->data[2] << 8 | wacom->data[3]) {
> > +     case MODEL_INTUOS:      /* UNTESTED */
> > +     case MODEL_INTUOS2:
> > +             dev_info(&wacom->dev->dev,
> > +                      "Intuos tablets are not supported by this driver.\n");
> > +             p = "Intuos";
> > +             wacom->dev->id.version = MODEL_INTUOS;
> > +             break;
> > +     case MODEL_CINTIQ:      /* UNTESTED */
> > +     case MODEL_CINTIQ2:
> > +             p = "Cintiq";
> > +             wacom->dev->id.version = MODEL_CINTIQ;
> > +             switch (wacom->data[5]<<8 | wacom->data[6]) {
> > +             case 0x3731: /* PL-710 */
> > +                     /* wcmSerial sets res to 2540x2540 in this case. */
> > +                     /* fall through */
> > +             case 0x3535: /* PL-550 */
> > +             case 0x3830: /* PL-800 */
> > +                     wacom->extra_z_bits = 2;
> > +             }
> > +             break;
> > +     case MODEL_PENPARTNER:
> > +             p = "Penpartner";
> > +             wacom->dev->id.version = MODEL_PENPARTNER;
> > +             /* wcmSerial sets res 1000x1000 in this case. */
> > +             break;
> > +     case MODEL_GRAPHIRE:
> > +             p = "Graphire";
> > +             wacom->dev->id.version = MODEL_GRAPHIRE;
> > +             /* Apparently Graphire models do not answer coordinate
> > +                requests; see also wacom_setup(). */
> > +             input_set_abs_params(wacom->dev, ABS_X, 0, 5103, 0, 0);
> > +             input_set_abs_params(wacom->dev, ABS_Y, 0, 3711, 0, 0);
> > +             input_abs_set_res(wacom->dev, ABS_X, 1016);
> > +             input_abs_set_res(wacom->dev, ABS_Y, 1016);
> > +             wacom->extra_z_bits = 2;
> > +             break;
> > +     case MODEL_DIGITIZER_II:
> > +             p = "Digitizer II";
> > +             wacom->dev->id.version = MODEL_DIGITIZER_II;
> > +             if (major_v == 1 && minor_v <= 2)
> > +                     wacom->extra_z_bits = 0; /* UNTESTED */
> > +             break;
> > +     default:                /* UNTESTED */
> > +             dev_dbg(&wacom->dev->dev,
> > +                     "Didn't understand Wacom model string: %s\n",
> > +                     wacom->data);
> > +             p = "Unknown Protocol IV";
> > +             wacom->dev->id.version = MODEL_UNKNOWN;
> > +             break;
> > +     }
> > +     max_z = (1<<(7+wacom->extra_z_bits))-1;
> > +     dev_info(&wacom->dev->dev, "Wacom tablet: %s, version %u.%u\n", p,
> > +              major_v, minor_v);
> > +     dev_dbg(&wacom->dev->dev, "Max pressure: %d.\n", max_z);
> > +     input_set_abs_params(wacom->dev, ABS_PRESSURE, 0, max_z, 0, 0);
> > +}
> > +
> > +
> > +static void handle_configuration_response(struct wacom *wacom)
> > +{
> > +     int x, y, skip;
> > +
> > +     dev_dbg(&wacom->dev->dev, "Configuration string: %s\n", wacom->data);
> > +     sscanf(wacom->data, "~R%x,%u,%u,%u,%u", &skip, &skip, &skip, &x, &y);
> > +     input_abs_set_res(wacom->dev, ABS_X, x);
> > +     input_abs_set_res(wacom->dev, ABS_Y, y);
> > +}
> > +
> > +static void handle_coordinates_response(struct wacom *wacom)
> > +{
> > +     int x, y;
> > +
> > +     dev_dbg(&wacom->dev->dev, "Coordinates string: %s\n", wacom->data);
> > +     sscanf(wacom->data, "~C%u,%u", &x, &y);
> > +     input_set_abs_params(wacom->dev, ABS_X, 0, x, 0, 0);
> > +     input_set_abs_params(wacom->dev, ABS_Y, 0, y, 0, 0);
> > +}
> > +
> > +static void handle_response(struct wacom *wacom)
> > +{
> > +     if (wacom->data[0] != '~' || wacom->idx < 2) {
> > +             dev_dbg(&wacom->dev->dev,
> > +                     "got a garbled response of length %d.\n",
> > +                     wacom->idx);
> > +             wacom->idx = 0;
> > +             return;
> > +     }
> > +
> > +     wacom->data[wacom->idx-1] = 0;
> > +     wacom->idx = 0;
> > +
> > +     switch (wacom->data[1]) {
> > +     case '#':
> > +             handle_model_response(wacom);
> > +             break;
> > +     case 'R':
> > +             handle_configuration_response(wacom);
> > +             break;
> > +     case 'C':
> > +             handle_coordinates_response(wacom);
> > +             break;
> > +     default:
> > +             dev_dbg(&wacom->dev->dev, "got an unexpected response: %s\n",
> > +                     wacom->data);
> > +             break;
> > +     }
> > +
> > +     complete(&wacom->cmd_done);
> > +}
> > +
> > +static void handle_packet(struct wacom *wacom)
> > +{
> > +     int in_proximity_p, stylus_p, button, x, y, z;
> > +     int tool;
> > +
> > +     in_proximity_p = wacom->data[0] & 0x40;
> > +     stylus_p = wacom->data[0] & 0x20;
> > +     button = (wacom->data[3] & 0x78) >> 3;
> > +     x = (wacom->data[0] & 3) << 14 | wacom->data[1]<<7 | wacom->data[2];
> > +     y = (wacom->data[3] & 3) << 14 | wacom->data[4]<<7 | wacom->data[5];
> > +     z = wacom->data[6] & 0x7f;
> > +     if (wacom->extra_z_bits >= 1)
> > +             z = z << 1 | (wacom->data[3] & 0x4) >> 2;
> > +     if (wacom->extra_z_bits > 1)
> > +             z = z << 1 | (wacom->data[0] & 0x4);
> > +     z = z ^ (0x40 << wacom->extra_z_bits);
> > +
> > +     /* NOTE: According to old wcmSerial code, button&8 is the
> > --
> > 1.7.10.4
>
> --
> Dmitry

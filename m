From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3] HID: Add full support for Logitech Unifying receivers
Date: Thu, 1 Sep 2011 14:43:32 +0200
Message-ID: <CAN+gG=HZsREeuc0h53juGg3L6kseuEUeiBWe8ZCaNLaVpth1Qw@mail.gmail.com>
References: <1314259880-7854-1-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40938 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757370Ab1IAMne convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Sep 2011 08:43:34 -0400
In-Reply-To: <1314259880-7854-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, rtitmuss@logitech.com, ogay@logitech.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>

Hi guys,

just a little up to this patch, and a more technical question:

On Thu, Aug 25, 2011 at 10:11, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> From: Nestor Lopez Casado <nlopezcasad@logitech.com>
>
> With this driver, all the devices paired to a single Unifying
> receiver are exposed to user processes in separated /input/dev
> nodes.
>
> Keyboards with different layouts can be treated differently,
> Multiplayer games on single PC (like home theater PC) can
> differentiate input coming from different kbds paired to the
> same receiver.
>
> Up to now, when Logitech Unifying receivers are connected to a
> Linux based system, a single keyboard and a single mouse are
> presented to the HID Layer, even if the Unifying receiver can
> pair up to six compatible devices. The Unifying receiver by default
> multiplexes all incoming events (from multiple keyboards/mice)
> into these two.
>
> Signed-off-by: Nestor Lopez Casado <nlopezcasad@logitech.com>
> Signed-off-by: Benjamin Tissoires <btissoires@logitech.com>
> ---
>
> =A0Hi guys,
>
> =A0this is the third version of the unifying receiver. I made the cha=
nges requested
> =A0by Dmitry:
> =A0- switch to kfifo
> =A0- introduce __func__ in all debugs/errors messages
> =A0- in logi_dj_ll_input_event, do not use the report of the device, =
but a copy
> =A0(is it the right way to do it to avoid the DMA problem?)
> =A0- switch to BUS_USB for the created devices
> =A0- small other cosmetic changes
>
> =A0One side note:
> =A0We really thing using BUS_USB is not the right way to do it when w=
e will have
> =A0more drivers:
> =A0 by keeping it, we will have no choice but to provide the VIP/PID =
of the
> =A0receiver to the created devices. We then will have to handle a man=
ual parsing
> =A0of the wireless id to know which driver to use. This will result i=
n having
> =A0all the Logitech's drivers loaded when someone plug an unifying re=
ceiver.
> =A0 if we switch to a new BUS_DJ, we could then rely on the automatic=
 user-space
> =A0loading of the drivers to load only the right drivers.
>
> =A0BTW, as long as Logitech does not provide those drivers (I hope th=
ey will come
> =A0out soon), there is no point using BUS_DJ. So it's fine not using =
it right now.
>
> =A0Thanks,
> =A0Benjamin
>
> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A09 +
> =A0drivers/hid/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/hid/hid-core.c =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A0drivers/hid/hid-logitech-dj.c | =A0893 +++++++++++++++++++++++++++=
++++++++++++++
> =A0drivers/hid/hid-logitech-dj.h | =A0123 ++++++
> =A06 files changed, 1030 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/hid/hid-logitech-dj.c
> =A0create mode 100644 drivers/hid/hid-logitech-dj.h
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 36ca465..0eb7f04 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -231,6 +231,15 @@ config HID_LOGITECH
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0Support for Logitech devices that are not fully compli=
ant with HID standard.
>
> +config HID_LOGITECH_DJ
> + =A0 =A0 =A0 tristate "Logitech Unifying receivers full support"
> + =A0 =A0 =A0 depends on HID_LOGITECH
> + =A0 =A0 =A0 default m
> + =A0 =A0 =A0 ---help---
> + =A0 =A0 =A0 Say Y if you want support for Logitech Unifying receive=
rs and devices.
> + =A0 =A0 =A0 Unifying receivers are capable of pairing up to 6 Logit=
ech compliant
> + =A0 =A0 =A0 devices to the same receiver.
> +
> =A0config LOGITECH_FF
> =A0 =A0 =A0 =A0bool "Logitech force feedback support"
> =A0 =A0 =A0 =A0depends on HID_LOGITECH
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index a24cee4..3aba5e7 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_HID_KEYTOUCH) =A0 =A0+=3D hid-keytouch=
=2Eo
> =A0obj-$(CONFIG_HID_KYE) =A0 =A0 =A0 =A0 =A0+=3D hid-kye.o
> =A0obj-$(CONFIG_HID_LCPOWER) =A0 =A0 =A0 +=3D hid-lcpower.o
> =A0obj-$(CONFIG_HID_LOGITECH) =A0 =A0 +=3D hid-logitech.o
> +obj-$(CONFIG_HID_LOGITECH_DJ) =A0+=3D hid-logitech-dj.o
> =A0obj-$(CONFIG_HID_MAGICMOUSE) =A0 =A0+=3D hid-magicmouse.o
> =A0obj-$(CONFIG_HID_MICROSOFT) =A0 =A0+=3D hid-microsoft.o
> =A0obj-$(CONFIG_HID_MONTEREY) =A0 =A0 +=3D hid-monterey.o
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index b0e618b..ebe4fdd 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1423,6 +1423,8 @@ static const struct hid_device_id hid_have_spec=
ial_driver[] =3D {
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_LOGITECH_DFP_WHEEL) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_LOGITECH_G25_WHEEL) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_LOGITECH_G27_WHEEL) },
> + =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_=
LOGITECH_UNIFYING_RECEIVER) },
> + =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_=
LOGITECH_UNIFYING_RECEIVER_2) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_LOGITECH_WII_WHEEL) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_LOGITECH_RUMBLEPAD2) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_SPACETRAVELLER) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index a756ee6..c42764b 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -440,6 +440,8 @@
> =A0#define USB_DEVICE_ID_S510_RECEIVER_2 =A00xc517
> =A0#define USB_DEVICE_ID_LOGITECH_CORDLESS_DESKTOP_LX500 =A00xc512
> =A0#define USB_DEVICE_ID_MX3000_RECEIVER =A00xc513
> +#define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER =A0 =A0 =A0 0xc52b
> +#define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2 =A0 =A0 0xc532
> =A0#define USB_DEVICE_ID_SPACETRAVELLER =A0 0xc623
> =A0#define USB_DEVICE_ID_SPACENAVIGATOR =A0 0xc626
> =A0#define USB_DEVICE_ID_DINOVO_DESKTOP =A0 0xc704
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech=
-dj.c
> new file mode 100644
> index 0000000..896328d
> --- /dev/null
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -0,0 +1,893 @@
> +/*
> + * =A0HID driver for Logitech Unifying receivers
> + *
> + * =A0Copyright (c) 2011 Logitech (c)
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-13=
07 USA
> + *
> + * Should you need to contact me, the author, you can do so by e-mai=
l send
> + * your message to Nestor Lopez Casado <xnlopez at gmail com>
> + *
> + */
> +
> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>
> +#include "usbhid/usbhid.h"
> +#include "hid-ids.h"
> +#include "hid-logitech-dj.h"
> +
> +/* Keyboard descriptor (1) */
> +static const char kbd_descriptor[] =3D {
> + =A0 =A0 =A0 0x05, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* USAGE_PAGE (gene=
ric Desktop) =A0 =A0 */
> + =A0 =A0 =A0 0x09, 0x06, =A0 =A0 =A0 =A0 =A0 =A0 /* USAGE (Keyboard)=
 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0xA1, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* COLLECTION (Appl=
ication) =A0 =A0 */
> + =A0 =A0 =A0 0x85, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* REPORT_ID (1) =A0=
 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x95, 0x08, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 REPORT_COUNT=
 (8) =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x75, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 REPORT_SIZE =
(1) =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x15, 0x00, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 LOGICAL_MINI=
MUM (0) =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x25, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 LOGICAL_MAXI=
MUM (1) =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x05, 0x07, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 USAGE_PAGE (=
Keyboard) =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x19, 0xE0, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 USAGE_MINIMU=
M (Left Control) =A0 */
> + =A0 =A0 =A0 0x29, 0xE7, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 USAGE_MAXIMU=
M (Right GUI) =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x81, 0x02, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 INPUT (Data,=
Var,Abs) =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x95, 0x05, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 REPORT COUNT=
 (5) =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x05, 0x08, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 USAGE PAGE (=
LED page) =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x19, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 USAGE MINIMU=
M (1) =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x29, 0x05, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 USAGE MAXIMU=
M (5) =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x91, 0x02, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 OUTPUT (Data=
, Variable, Absolute) =A0*/
> + =A0 =A0 =A0 0x95, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 REPORT COUNT=
 (1) =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x75, 0x03, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 REPORT SIZE =
(3) =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x91, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 OUTPUT (Cons=
tant) =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x95, 0x06, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 REPORT_COUNT=
 (6) =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x75, 0x08, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 REPORT_SIZE =
(8) =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x15, 0x00, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 LOGICAL_MINI=
MUM (0) =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x26, 0xFF, 0x00, =A0 =A0 =A0 /* =A0 LOGICAL_MAXIMUM (2=
55) =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x05, 0x07, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 USAGE_PAGE (=
Keyboard) =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x19, 0x00, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 USAGE_MINIMU=
M (no event) =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x2A, 0xFF, 0x00, =A0 =A0 =A0 /* =A0 USAGE_MAXIMUM (res=
erved) =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x81, 0x00, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 INPUT (Data,=
Ary,Abs) =A0 =A0 =A0 */
> + =A0 =A0 =A0 0xC0
> +};
> +
> +/* Mouse descriptor (2) =A0 =A0 */
> +static const char mse_descriptor[] =3D {
> + =A0 =A0 =A0 0x05, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0USAGE_PAGE (G=
eneric Desktop) =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x09, 0x02, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0USAGE (Mouse)=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0xA1, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0COLLECTION (A=
pplication) =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x85, 0x02, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0REPORT_ID=
 =3D 2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x09, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0USAGE (po=
inter) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0xA1, 0x00, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0COLLECTIO=
N (physical) =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x05, 0x09, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0USAGE=
_PAGE (buttons) =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x19, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0USAGE=
_MIN (1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x29, 0x10, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0USAGE=
_MAX (16) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x15, 0x00, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0LOGIC=
AL_MIN (0) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x25, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0LOGIC=
AL_MAX (1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x95, 0x10, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0REPOR=
T_COUNT (16) =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x75, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0REPOR=
T_SIZE (1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x81, 0x02, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0INPUT=
 (data var abs) =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x05, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0USAGE=
_PAGE (generic desktop) =A0 =A0*/
> + =A0 =A0 =A0 0x16, 0x01, 0xF8, =A0 =A0 =A0 /* =A0 =A0 =A0LOGICAL_MIN=
 (-2047) =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x26, 0xFF, 0x07, =A0 =A0 =A0 /* =A0 =A0 =A0LOGICAL_MAX=
 (2047) =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x75, 0x0C, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0REPOR=
T_SIZE (12) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x95, 0x02, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0REPOR=
T_COUNT (2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x09, 0x30, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0USAGE=
 (X) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x09, 0x31, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0USAGE=
 (Y) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x81, 0x06, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0INPUT=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x15, 0x81, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0LOGIC=
AL_MIN (-127) =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x25, 0x7F, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0LOGIC=
AL_MAX (127) =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x75, 0x08, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0REPOR=
T_SIZE (8) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x95, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0REPOR=
T_COUNT (1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x09, 0x38, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0USAGE=
 (wheel) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x81, 0x06, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0INPUT=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x05, 0x0C, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0USAGE=
_PAGE(consumer) =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x0A, 0x38, 0x02, =A0 =A0 =A0 /* =A0 =A0 =A0USAGE(AC Pa=
n) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x95, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0REPOR=
T_COUNT (1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x81, 0x06, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0INPUT=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0xC0, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0END=
_COLLECTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0xC0, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =A0END_COL=
LECTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +};
> +
> +/* Consumer Control descriptor (3) */
> +static const char consumer_descriptor[] =3D {
> + =A0 =A0 =A0 0x05, 0x0C, =A0 =A0 =A0 =A0 =A0 =A0 /* USAGE_PAGE (Cons=
umer Devices) =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x09, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* USAGE (Consumer =
Control) =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0xA1, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* COLLECTION (Appl=
ication) =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x85, 0x03, =A0 =A0 =A0 =A0 =A0 =A0 /* REPORT_ID =3D 3 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x75, 0x10, =A0 =A0 =A0 =A0 =A0 =A0 /* REPORT_SIZE (16)=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x95, 0x02, =A0 =A0 =A0 =A0 =A0 =A0 /* REPORT_COUNT (2)=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x15, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* LOGICAL_MIN (1) =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x26, 0x8C, 0x02, =A0 =A0 =A0 /* LOGICAL_MAX (652) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x19, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* USAGE_MIN (1) =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x2A, 0x8C, 0x02, =A0 =A0 =A0 /* USAGE_MAX (652) =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x81, 0x00, =A0 =A0 =A0 =A0 =A0 =A0 /* INPUT (Data Ary =
Abs) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0xC0, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* END_COLLEC=
TION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +}; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> +
> +/* System control descriptor (4) */
> +static const char syscontrol_descriptor[] =3D {
> + =A0 =A0 =A0 0x05, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 USAGE_PAGE (=
Generic Desktop) =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x09, 0x80, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 USAGE (Syste=
m Control) =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0xA1, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 COLLECTION (=
Application) =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x85, 0x04, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 REPORT_ID =3D=
 4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x75, 0x02, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 REPORT_SIZE =
(2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x95, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 REPORT_COUNT=
 (1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x15, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 LOGICAL_MIN =
(1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x25, 0x03, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 LOGICAL_MAX =
(3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x09, 0x82, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 USAGE (Syste=
m Sleep) =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x09, 0x81, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 USAGE (Syste=
m Power Down) =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x09, 0x83, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 USAGE (Syste=
m Wake Up) =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x81, 0x60, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 INPUT (Data =
Ary Abs NPrf Null) =A0 =A0*/
> + =A0 =A0 =A0 0x75, 0x06, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 REPORT_SIZE =
(6) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x81, 0x03, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 INPUT (Cnst =
Var Abs) =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0xC0, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 END_CO=
LLECTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +};
> +
> +/* Media descriptor (8) */
> +static const char media_descriptor[] =3D {
> + =A0 =A0 =A0 0x06, 0xbc, 0xff, =A0 =A0 =A0 /* Usage Page 0xffbc =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x09, 0x88, =A0 =A0 =A0 =A0 =A0 =A0 /* Usage 0x0088 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0xa1, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* BeginCollection =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x85, 0x08, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 Report ID 8 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x19, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 Usage Min 0x=
0001 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x29, 0xff, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 Usage Max 0x=
00ff =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x15, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 Logical Min =
1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x26, 0xff, 0x00, =A0 =A0 =A0 /* =A0 Logical Max 255 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x75, 0x08, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 Report Size =
8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0x95, 0x01, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 Report Count=
 1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 0x81, 0x00, =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 Input =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 0xc0, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* EndCollect=
ion =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> +}; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> +
> +/* Maximum size of all defined hid reports in bytes (including repor=
t id) */
> +#define MAX_REPORT_SIZE 8
> +
> +/* Number of possible hid report types that can be created by this d=
river.
> + *
> + * Right now, RF report types have the same report types (or report =
id's)
> + * than the hid report created from those RF reports. In the future
> + * this doesnt have to be true.
> + *
> + * For instance, RF report type 0x01 which has a size of 8 bytes, co=
rresponds
> + * to hid report id 0x01, this is standard keyboard. Same thing appl=
ies to mice
> + * reports and consumer control, etc. If a new RF report is created,=
 it doesn't
> + * has to have the same report id as its corresponding hid report, s=
o an
> + * translation may have to take place for future report types.
> + */
> +#define NUMBER_OF_HID_REPORTS 32
> +static const u8 hid_reportid_size_map[NUMBER_OF_HID_REPORTS] =3D {
> + =A0 =A0 =A0 [1] =3D 8, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Standard k=
eyboard */
> + =A0 =A0 =A0 [2] =3D 8, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Standard m=
ouse */
> + =A0 =A0 =A0 [3] =3D 5, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Consumer c=
ontrol */
> + =A0 =A0 =A0 [4] =3D 2, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* System con=
trol */
> + =A0 =A0 =A0 [8] =3D 2, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Media Cent=
er */
> +};
> +
> +
> +#define LOGITECH_DJ_INTERFACE_NUMBER 0x02
> +
> +static struct hid_ll_driver logi_dj_ll_driver;
> +
> +static int logi_dj_output_hidraw_report(struct hid_device *hid, u8 *=
 buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 size_t count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 unsigned char report_type);
> +
> +static void logi_dj_recv_destroy_djhid_device(struct dj_receiver_dev=
 *djrcv_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 struct dj_report *dj_report)
> +{
> + =A0 =A0 =A0 /* Called in delayed work context */
> + =A0 =A0 =A0 struct dj_device *dj_dev;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&djrcv_dev->lock, flags);
> + =A0 =A0 =A0 dj_dev =3D djrcv_dev->paired_dj_devices[dj_report->devi=
ce_index];
> + =A0 =A0 =A0 djrcv_dev->paired_dj_devices[dj_report->device_index] =3D=
 NULL;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&djrcv_dev->lock, flags);
> +
> + =A0 =A0 =A0 if (dj_dev !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_destroy_device(dj_dev->hdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(dj_dev);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&djrcv_dev->hdev->dev, "%s: can=
't destroy a NULL device\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 }
> +}
> +
> +static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *dj=
rcv_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 struct dj_report *dj_report)
> +{
> + =A0 =A0 =A0 /* Called in delayed work context */
> + =A0 =A0 =A0 struct hid_device *djrcv_hdev =3D djrcv_dev->hdev;
> + =A0 =A0 =A0 struct usb_interface *intf =3D to_usb_interface(djrcv_h=
dev->dev.parent);
> + =A0 =A0 =A0 struct usb_device *usbdev =3D interface_to_usbdev(intf)=
;
> + =A0 =A0 =A0 struct hid_device *dj_hiddev;
> + =A0 =A0 =A0 struct dj_device *dj_dev;
> + =A0 =A0 =A0 unsigned char tmpstr[20];
> +
> + =A0 =A0 =A0 if (dj_report->report_params[DEVICE_PAIRED_PARAM_SPFUNC=
TION] &
> + =A0 =A0 =A0 =A0 =A0 SPFUNCTION_DEVICE_LIST_EMPTY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: device list is empty\n", _=
_func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dj_hiddev =3D hid_allocate_device();
> + =A0 =A0 =A0 if (IS_ERR(dj_hiddev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&djrcv_hdev->dev, "%s: hid_allo=
cate_device failed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dj_hiddev->ll_driver =3D &logi_dj_ll_driver;
> + =A0 =A0 =A0 dj_hiddev->hid_output_raw_report =3D logi_dj_output_hid=
raw_report;
> +
> + =A0 =A0 =A0 dj_hiddev->dev.parent =3D &djrcv_hdev->dev;
> + =A0 =A0 =A0 dj_hiddev->bus =3D BUS_USB;
> + =A0 =A0 =A0 dj_hiddev->vendor =3D le16_to_cpu(usbdev->descriptor.id=
Vendor);
> + =A0 =A0 =A0 dj_hiddev->product =3D le16_to_cpu(usbdev->descriptor.i=
dProduct);
> + =A0 =A0 =A0 snprintf(dj_hiddev->name, sizeof(dj_hiddev->name),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Logitech Unifying Device. Wireless PID=
:%02x%02x",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dj_report->report_params[DEVICE_PAIRED_=
PARAM_EQUAD_ID_MSB],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dj_report->report_params[DEVICE_PAIRED_=
PARAM_EQUAD_ID_LSB]);
> +
> + =A0 =A0 =A0 usb_make_path(usbdev, dj_hiddev->phys, sizeof(dj_hiddev=
->phys));
> + =A0 =A0 =A0 snprintf(tmpstr, sizeof(tmpstr), ":%d", dj_report->devi=
ce_index);
> + =A0 =A0 =A0 strlcat(dj_hiddev->phys, tmpstr, sizeof(dj_hiddev->phys=
));
> +
> + =A0 =A0 =A0 dj_dev =3D kzalloc(sizeof(struct dj_device), GFP_KERNEL=
);
> +
> + =A0 =A0 =A0 if (!dj_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&djrcv_hdev->dev, "%s: failed a=
llocating dj_device\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto dj_device_allocate_fail;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dj_dev->reports_supported =3D le32_to_cpu(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dj_report->report_params[DEVICE_PAIRED_=
RF_REPORT_TYPE]);
> + =A0 =A0 =A0 dj_dev->hdev =3D dj_hiddev;
> + =A0 =A0 =A0 dj_dev->dj_receiver_dev =3D djrcv_dev;
> + =A0 =A0 =A0 dj_dev->device_index =3D dj_report->device_index;
> + =A0 =A0 =A0 dj_hiddev->driver_data =3D dj_dev;
> +
> + =A0 =A0 =A0 djrcv_dev->paired_dj_devices[dj_report->device_index] =3D=
 dj_dev;
> +
> + =A0 =A0 =A0 if (hid_add_device(dj_hiddev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&djrcv_hdev->dev, "%s: failed a=
dding dj_device\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto hid_add_device_fail;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return;
> +
> +hid_add_device_fail:
> + =A0 =A0 =A0 djrcv_dev->paired_dj_devices[dj_report->device_index] =3D=
 NULL;
> + =A0 =A0 =A0 kfree(dj_dev);
> +dj_device_allocate_fail:
> + =A0 =A0 =A0 hid_destroy_device(dj_hiddev);
> +}
> +
> +static void delayedwork_callback(struct work_struct *work)
> +{
> + =A0 =A0 =A0 struct dj_receiver_dev *djrcv_dev =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(work, struct dj_receiver_d=
ev, work);
> +
> + =A0 =A0 =A0 struct dj_report dj_report;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int count;
> +
> + =A0 =A0 =A0 dbg_hid("%s\n", __func__);
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&djrcv_dev->lock, flags);
> +
> + =A0 =A0 =A0 count =3D kfifo_out(&djrcv_dev->notif_fifo, &dj_report,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(=
struct dj_report));
> +
> + =A0 =A0 =A0 if (count !=3D sizeof(struct dj_report)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&djrcv_dev->hdev->dev, "%s: wor=
kitem triggered without "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "notifications availabl=
e\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&djrcv_dev->lock=
, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!kfifo_is_empty(&djrcv_dev->notif_fifo)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (schedule_work(&djrcv_dev->work) =3D=
=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: did not sc=
hedule the work item, was "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "alread=
y queued\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&djrcv_dev->lock, flags);
> +
> + =A0 =A0 =A0 switch (dj_report.report_type) {
> + =A0 =A0 =A0 case REPORT_TYPE_NOTIF_DEVICE_PAIRED:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 logi_dj_recv_add_djhid_device(djrcv_dev=
, &dj_report);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case REPORT_TYPE_NOTIF_DEVICE_UNPAIRED:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 logi_dj_recv_destroy_djhid_device(djrcv=
_dev, &dj_report);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: unexpected report type\n",=
 __func__);
> + =A0 =A0 =A0 }
> +}
> +
> +static void logi_dj_recv_queue_notification(struct dj_receiver_dev *=
djrcv_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0struct dj_report *dj_report)
> +{
> + =A0 =A0 =A0 /* We are called from atomic context (tasklet && djrcv-=
>lock held) */
> +
> + =A0 =A0 =A0 kfifo_in(&djrcv_dev->notif_fifo, dj_report, sizeof(stru=
ct dj_report));
> +
> + =A0 =A0 =A0 if (schedule_work(&djrcv_dev->work) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: did not schedule the work =
item, was already "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "queued\n", __func__);
> + =A0 =A0 =A0 }
> +}
> +
> +static void logi_dj_recv_forward_null_report(struct dj_receiver_dev =
*djrcv_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0struct dj_report *dj_report)
> +{
> + =A0 =A0 =A0 /* We are called from atomic context (tasklet && djrcv-=
>lock held) */
> + =A0 =A0 =A0 unsigned int i;
> + =A0 =A0 =A0 u8 reportbuffer[MAX_REPORT_SIZE];
> + =A0 =A0 =A0 struct dj_device *djdev;
> +
> + =A0 =A0 =A0 djdev =3D djrcv_dev->paired_dj_devices[dj_report->devic=
e_index];
> +
> + =A0 =A0 =A0 if (!djdev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("djrcv_dev->paired_dj_devices[d=
j_report->device_index]"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " is NULL, index %d\n",=
 dj_report->device_index);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 memset(reportbuffer, 0, sizeof(reportbuffer));
> +
> + =A0 =A0 =A0 for (i =3D 0; i < NUMBER_OF_HID_REPORTS; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (djdev->reports_supported & (1 << i)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reportbuffer[0] =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hid_input_report(dj=
dev->hdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0HID_INPUT_REPORT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0reportbuffer,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0hid_reportid_size_map[i], 1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid=
("hid_input_report error sending null "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "report\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +static void logi_dj_recv_forward_report(struct dj_receiver_dev *djrc=
v_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct dj_report *dj_report)
> +{
> + =A0 =A0 =A0 /* We are called from atomic context (tasklet && djrcv-=
>lock held) */
> + =A0 =A0 =A0 struct dj_device *dj_device;
> +
> + =A0 =A0 =A0 dj_device =3D djrcv_dev->paired_dj_devices[dj_report->d=
evice_index];
> +
> + =A0 =A0 =A0 if (dj_device =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("djrcv_dev->paired_dj_devices[d=
j_report->device_index]"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " is NULL, index %d\n",=
 dj_report->device_index);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if ((dj_report->report_type > ARRAY_SIZE(hid_reportid_s=
ize_map) - 1) ||
> + =A0 =A0 =A0 =A0 =A0 (hid_reportid_size_map[dj_report->report_type] =
=3D=3D 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("invalid report type:%x\n", dj_=
report->report_type);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (hid_input_report(dj_device->hdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_INPUT_REPORT, &dj_r=
eport->report_type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_reportid_size_map[d=
j_report->report_type], 1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("hid_input_report error\n");
> + =A0 =A0 =A0 }
> +}
> +
> +
> +static int logi_dj_recv_send_report(struct dj_receiver_dev *djrcv_de=
v,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct dj_report *dj_report)
> +{
> + =A0 =A0 =A0 struct hid_device *hdev =3D djrcv_dev->hdev;
> + =A0 =A0 =A0 int sent_bytes;
> +
> + =A0 =A0 =A0 if (!hdev->hid_output_raw_report) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev, "%s:"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "hid_output_raw_report =
is null\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sent_bytes =3D hdev->hid_output_raw_report(hdev, (u8 *)=
 dj_report,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(struct dj_report),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_OUTPUT_REPORT);
> +
> + =A0 =A0 =A0 return (sent_bytes < 0) ? sent_bytes : 0;
> +}
> +
> +static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev =
*djrcv_dev)
> +{
> + =A0 =A0 =A0 struct dj_report dj_report;
> +
> + =A0 =A0 =A0 memset(&dj_report, 0, sizeof(dj_report));
> + =A0 =A0 =A0 dj_report.report_id =3D REPORT_ID_DJ_SHORT;
> + =A0 =A0 =A0 dj_report.device_index =3D 0xFF;
> + =A0 =A0 =A0 dj_report.report_type =3D REPORT_TYPE_CMD_GET_PAIRED_DE=
VICES;
> + =A0 =A0 =A0 return logi_dj_recv_send_report(djrcv_dev, &dj_report);
> +}
> +
> +static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *dj=
rcv_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 unsigned timeout)
> +{
> + =A0 =A0 =A0 struct dj_report dj_report;
> +
> + =A0 =A0 =A0 memset(&dj_report, 0, sizeof(dj_report));
> + =A0 =A0 =A0 dj_report.report_id =3D REPORT_ID_DJ_SHORT;
> + =A0 =A0 =A0 dj_report.device_index =3D 0xFF;
> + =A0 =A0 =A0 dj_report.report_type =3D REPORT_TYPE_CMD_SWITCH;
> + =A0 =A0 =A0 dj_report.report_params[CMD_SWITCH_PARAM_DEVBITFIELD] =3D=
 0x1F;
> + =A0 =A0 =A0 dj_report.report_params[CMD_SWITCH_PARAM_TIMEOUT_SECOND=
S] =3D (u8)timeout;
> + =A0 =A0 =A0 return logi_dj_recv_send_report(djrcv_dev, &dj_report);
> +}
> +
> +
> +static int logi_dj_ll_open(struct hid_device *hid)
> +{
> + =A0 =A0 =A0 dbg_hid("%s:%s\n", __func__, hid->phys);
> + =A0 =A0 =A0 return 0;
> +
> +}
> +
> +static void logi_dj_ll_close(struct hid_device *hid)
> +{
> + =A0 =A0 =A0 dbg_hid("%s:%s\n", __func__, hid->phys);
> +}
> +
> +static int logi_dj_output_hidraw_report(struct hid_device *hid, u8 *=
 buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 size_t count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 unsigned char report_type)
> +{
> + =A0 =A0 =A0 /* Called by hid raw to send data */
> + =A0 =A0 =A0 dbg_hid("%s\n", __func__);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int logi_dj_ll_parse(struct hid_device *hid)
> +{
> + =A0 =A0 =A0 struct dj_device *djdev =3D hid->driver_data;
> + =A0 =A0 =A0 int retval;
> +
> + =A0 =A0 =A0 dbg_hid("%s\n", __func__);
> +
> + =A0 =A0 =A0 djdev->hdev->version =3D 0x0111;
> + =A0 =A0 =A0 djdev->hdev->country =3D 0x00;
> +
> + =A0 =A0 =A0 if (djdev->reports_supported & STD_KEYBOARD) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a kbd descriptor, =
reports_supported: %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, djdev->report=
s_supported);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D hid_parse_report(hid,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (u8 *) kbd_descriptor,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 sizeof(kbd_descriptor));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a =
kbd descriptor, hid_parse failed"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " error=
: %d\n", __func__, retval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (djdev->reports_supported & STD_MOUSE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a mouse descriptor=
, reports_supported: "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%x\n", __func__, djdev=
->reports_supported);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D hid_parse_report(hid,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (u8 *) mse_descriptor,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 sizeof(mse_descriptor));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a =
mouse descriptor, hid_parse "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed=
 error: %d\n", __func__, retval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (djdev->reports_supported & MULTIMEDIA) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a multimedia repor=
t descriptor: %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, djdev->report=
s_supported);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D hid_parse_report(hid,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (u8 *) consumer_descriptor,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 sizeof(consumer_descriptor));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a =
consumer_descriptor, hid_parse "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed=
 error: %d\n", __func__, retval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (djdev->reports_supported & POWER_KEYS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a power keys repor=
t descriptor: %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, djdev->report=
s_supported);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D hid_parse_report(hid,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (u8 *) syscontrol_descriptor,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 sizeof(syscontrol_descriptor));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a =
syscontrol_descriptor, "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "hid_pa=
rse failed error: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func_=
_, retval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (djdev->reports_supported & MEDIA_CENTER) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a media center rep=
ort descriptor: %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, djdev->report=
s_supported);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D hid_parse_report(hid,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (u8 *) media_descriptor,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 sizeof(media_descriptor));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a =
media_descriptor, hid_parse "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed=
 error: %d\n", __func__, retval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (djdev->reports_supported & KBD_LEDS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: need to send kbd leds repo=
rt descriptor: %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, djdev->report=
s_supported);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int logi_dj_ll_input_event(struct input_dev *dev, unsigned in=
t type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uns=
igned int code, int value)
> +{
> + =A0 =A0 =A0 /* Sent by the input layer to handle leds and Force Fee=
dback */
> + =A0 =A0 =A0 struct hid_device *dj_hiddev =3D input_get_drvdata(dev)=
;
> + =A0 =A0 =A0 struct dj_device *dj_dev =3D dj_hiddev->driver_data;
> +
> + =A0 =A0 =A0 struct dj_receiver_dev *djrcv_dev =3D
> + =A0 =A0 =A0 =A0 =A0 dev_get_drvdata(dj_hiddev->dev.parent);
> + =A0 =A0 =A0 struct hid_device *dj_rcv_hiddev =3D djrcv_dev->hdev;
> + =A0 =A0 =A0 struct hid_report_enum *output_report_enum;
> +
> + =A0 =A0 =A0 struct hid_field *field;
> + =A0 =A0 =A0 struct hid_report report;
> + =A0 =A0 =A0 unsigned char data[8];
> + =A0 =A0 =A0 int offset;
> +
> + =A0 =A0 =A0 dbg_hid("%s: %s, type:%d | code:%d | value:%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, dev->phys, type, code, value)=
;
> +
> + =A0 =A0 =A0 if (type !=3D EV_LED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +
> + =A0 =A0 =A0 offset =3D hidinput_find_field(dj_hiddev, type, code, &=
field);
> +
> + =A0 =A0 =A0 if (offset =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&dev->dev, "event field not fo=
und\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 hid_set_field(field, offset, value);
> + =A0 =A0 =A0 hid_output_report(field->report, &data[0]);
> +
> + =A0 =A0 =A0 output_report_enum =3D &dj_rcv_hiddev->report_enum[HID_=
OUTPUT_REPORT];
> + =A0 =A0 =A0 report =3D *output_report_enum->report_id_hash[REPORT_I=
D_DJ_SHORT];
> + =A0 =A0 =A0 hid_set_field(report.field[0], 0, dj_dev->device_index)=
;
> + =A0 =A0 =A0 hid_set_field(report.field[0], 1, REPORT_TYPE_LEDS);
> + =A0 =A0 =A0 hid_set_field(report.field[0], 2, data[1]);
> +
> + =A0 =A0 =A0 usbhid_submit_report(dj_rcv_hiddev, &report, USB_DIR_OU=
T);

This is not working when the receiver is paired to a keyboard. When
the session launches, Gnome try to send leds commands to the keyboard
and this results in an oops.

Using a  pointer to the struct hid_report solves the crash.

However, Dmitry, you told us about a DMA stack problem. Can you give
us a better way to handle that?

Thanks,
Benjamin


> +
> + =A0 =A0 =A0 return 0;
> +
> +}
> +
> +static int logi_dj_ll_start(struct hid_device *hid)
> +{
> + =A0 =A0 =A0 dbg_hid("%s\n", __func__);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void logi_dj_ll_stop(struct hid_device *hid)
> +{
> + =A0 =A0 =A0 dbg_hid("%s\n", __func__);
> +}
> +
> +
> +static struct hid_ll_driver logi_dj_ll_driver =3D {
> + =A0 =A0 =A0 .parse =3D logi_dj_ll_parse,
> + =A0 =A0 =A0 .start =3D logi_dj_ll_start,
> + =A0 =A0 =A0 .stop =3D logi_dj_ll_stop,
> + =A0 =A0 =A0 .open =3D logi_dj_ll_open,
> + =A0 =A0 =A0 .close =3D logi_dj_ll_close,
> + =A0 =A0 =A0 .hidinput_input_event =3D logi_dj_ll_input_event,
> +};
> +
> +
> +static int logi_dj_raw_event(struct hid_device *hdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct hid_r=
eport *report, u8 *data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int size)
> +{
> + =A0 =A0 =A0 struct dj_receiver_dev *djrcv_dev =3D hid_get_drvdata(h=
dev);
> + =A0 =A0 =A0 struct dj_report *dj_report =3D (struct dj_report *) da=
ta;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 bool report_processed =3D false;
> +
> + =A0 =A0 =A0 dbg_hid("%s, size:%d\n", __func__, size);
> +
> + =A0 =A0 =A0 /* Here we receive all data coming from iface 2, there =
are 4 cases:
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* 1) Data should continue its normal processing i.e.=
 data does not
> + =A0 =A0 =A0 =A0* come from the DJ collection, in which case we do n=
othing and
> + =A0 =A0 =A0 =A0* return 0, so hid-core can continue normal processi=
ng (will forward
> + =A0 =A0 =A0 =A0* to associated hidraw device)
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* 2) Data is from DJ collection, and is intended for=
 this driver i. e.
> + =A0 =A0 =A0 =A0* data contains arrival, departure, etc notification=
s, in which case
> + =A0 =A0 =A0 =A0* we queue them for delayed processing by the work q=
ueue. We return 1
> + =A0 =A0 =A0 =A0* to hid-core as no further processing is required f=
rom it.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* 3) Data is from DJ collection, and informs a conne=
ction change,
> + =A0 =A0 =A0 =A0* if the change means rf link loss, then we must sen=
d a null report
> + =A0 =A0 =A0 =A0* to the upper layer to discard potentially pressed =
keys that may be
> + =A0 =A0 =A0 =A0* repeated forever by the input layer. Return 1 to h=
id-core as no
> + =A0 =A0 =A0 =A0* further processing is required.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* 4) Data is from DJ collection and is an actual inp=
ut event from
> + =A0 =A0 =A0 =A0* a paired DJ device in which case we forward it to =
the correct hid
> + =A0 =A0 =A0 =A0* device (via hid_input_report() ) and return 1 so h=
id-core does not do
> + =A0 =A0 =A0 =A0* anything else with it.
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&djrcv_dev->lock, flags);
> + =A0 =A0 =A0 if (dj_report->report_id =3D=3D REPORT_ID_DJ_SHORT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (dj_report->report_type) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case REPORT_TYPE_NOTIF_DEVICE_PAIRED:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case REPORT_TYPE_NOTIF_DEVICE_UNPAIRED:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 logi_dj_recv_queue_noti=
fication(djrcv_dev, dj_report);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case REPORT_TYPE_NOTIF_CONNECTION_STATU=
S:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dj_report->report_p=
arams[CONNECTION_STATUS_PARAM_STATUS] =3D=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 STATUS_LINKLOSS=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 logi_dj=
_recv_forward_null_report(djrcv_dev, dj_report);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 logi_dj_recv_forward_re=
port(djrcv_dev, dj_report);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 report_processed =3D true;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock_irqrestore(&djrcv_dev->lock, flags);
> +
> + =A0 =A0 =A0 return report_processed;
> +}
> +
> +static int logi_dj_probe(struct hid_device *hdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct hid_dev=
ice_id *id)
> +{
> + =A0 =A0 =A0 struct usb_interface *intf =3D to_usb_interface(hdev->d=
ev.parent);
> + =A0 =A0 =A0 struct dj_receiver_dev *djrcv_dev;
> + =A0 =A0 =A0 int retval;
> +
> + =A0 =A0 =A0 if (is_dj_device((struct dj_device *)hdev->driver_data)=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 dbg_hid("%s called for ifnum %d\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 intf->cur_altsetting->desc.bInterfaceNu=
mber);
> +
> + =A0 =A0 =A0 /* Ignore interfaces 0 and 1, they will not carry any d=
ata, dont create
> + =A0 =A0 =A0 =A0* any hid_device for them */
> + =A0 =A0 =A0 if (intf->cur_altsetting->desc.bInterfaceNumber !=3D
> + =A0 =A0 =A0 =A0 =A0 LOGITECH_DJ_INTERFACE_NUMBER) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: ignoring ifnum %d\n", __fu=
nc__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 intf->cur_altsetting->d=
esc.bInterfaceNumber);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Treat interface 2 */
> +
> + =A0 =A0 =A0 djrcv_dev =3D kzalloc(sizeof(struct dj_receiver_dev), G=
=46P_KERNEL);
> + =A0 =A0 =A0 if (!djrcv_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s:failed allocating d=
j_receiver_dev\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 djrcv_dev->hdev =3D hdev;
> + =A0 =A0 =A0 INIT_WORK(&djrcv_dev->work, delayedwork_callback);
> + =A0 =A0 =A0 spin_lock_init(&djrcv_dev->lock);
> + =A0 =A0 =A0 if (kfifo_alloc(&djrcv_dev->notif_fifo,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DJ_MAX_NUMBER_NOTIFICAT=
IONS * sizeof(struct dj_report),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s:failed allocating n=
otif_fifo\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(djrcv_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 hid_set_drvdata(hdev, djrcv_dev);
> +
> + =A0 =A0 =A0 /* Call =A0to usbhid to fetch the HID descriptors of in=
terface 2 and
> + =A0 =A0 =A0 =A0* subsequently call to the hid/hid-core to parse the=
 fetched
> + =A0 =A0 =A0 =A0* descriptors, this will in turn create the hidraw a=
nd hiddev nodes
> + =A0 =A0 =A0 =A0* for interface 2 of the receiver */
> + =A0 =A0 =A0 retval =3D hid_parse(hdev);
> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s:parse of interface =
2 failed\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto hid_parse_fail;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Starts the usb device and connects to upper interfac=
es hiddev and
> + =A0 =A0 =A0 =A0* hidraw */
> + =A0 =A0 =A0 retval =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s:hid_hw_start return=
ed error\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto hid_hw_start_fail;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 retval =3D logi_dj_recv_switch_to_dj_mode(djrcv_dev, 0)=
;
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s:logi_dj_recv_switch=
_to_dj_mode returned error:%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, retval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto switch_to_dj_mode_fail;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* This is enabling the polling urb on the IN endpoint =
*/
> + =A0 =A0 =A0 retval =3D hdev->ll_driver->open(hdev);
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev, "%s:hdev->ll_driver=
->open returned "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "error:%d\n", __func__,=
 retval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto llopen_failed;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 retval =3D logi_dj_recv_query_paired_devices(djrcv_dev)=
;
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev, "%s:logi_dj_recv_qu=
ery_paired_devices "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "error:%d\n", __func__,=
 retval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto logi_dj_recv_query_paired_devices_=
failed;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return retval;
> +
> +logi_dj_recv_query_paired_devices_failed:
> + =A0 =A0 =A0 hdev->ll_driver->close(hdev);
> +
> +llopen_failed:
> +switch_to_dj_mode_fail:
> + =A0 =A0 =A0 hid_hw_stop(hdev);
> +
> +hid_hw_start_fail:
> +hid_parse_fail:
> + =A0 =A0 =A0 kfifo_free(&djrcv_dev->notif_fifo);
> + =A0 =A0 =A0 kfree(djrcv_dev);
> + =A0 =A0 =A0 hid_set_drvdata(hdev, NULL);
> + =A0 =A0 =A0 return retval;
> +
> +}
> +
> +static void logi_dj_remove(struct hid_device *hdev)
> +{
> + =A0 =A0 =A0 struct dj_receiver_dev *djrcv_dev =3D hid_get_drvdata(h=
dev);
> + =A0 =A0 =A0 struct dj_device *dj_dev;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 dbg_hid("%s\n", __func__);
> +
> + =A0 =A0 =A0 cancel_work_sync(&djrcv_dev->work);
> +
> + =A0 =A0 =A0 hdev->ll_driver->close(hdev);
> + =A0 =A0 =A0 hid_hw_stop(hdev);
> +
> + =A0 =A0 =A0 /* I suppose that at this point the only context that c=
an access
> + =A0 =A0 =A0 =A0* the djrecv_data is this thread as the work item is=
 guaranteed to
> + =A0 =A0 =A0 =A0* have finished and no more raw_event callbacks shou=
ld arrive after
> + =A0 =A0 =A0 =A0* the remove callback was triggered so no locks are =
put around the
> + =A0 =A0 =A0 =A0* code below */
> + =A0 =A0 =A0 for (i =3D 0; i < DJ_MAX_PAIRED_DEVICES; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dj_dev =3D djrcv_dev->paired_dj_devices=
[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dj_dev !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_destroy_device(dj_d=
ev->hdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(dj_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 djrcv_dev->paired_dj_de=
vices[i] =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 kfifo_free(&djrcv_dev->notif_fifo);
> + =A0 =A0 =A0 kfree(djrcv_dev);
> + =A0 =A0 =A0 hid_set_drvdata(hdev, NULL);
> +}
> +
> +static int logi_djdevice_probe(struct hid_device *hdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct hid_dev=
ice_id *id)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 struct dj_device *dj_dev =3D hdev->driver_data;
> +
> + =A0 =A0 =A0 if (!is_dj_device(dj_dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 ret =3D hid_parse(hdev);
> + =A0 =A0 =A0 if (!ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D hid_hw_start(hdev, HID_CONNECT_=
DEFAULT);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static const struct hid_device_id logi_dj_receivers[] =3D {
> + =A0 =A0 =A0 {HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVE=
R)},
> + =A0 =A0 =A0 {HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVE=
R_2)},
> + =A0 =A0 =A0 {}
> +};
> +
> +MODULE_DEVICE_TABLE(hid, logi_dj_receivers);
> +
> +static struct hid_driver logi_djreceiver_driver =3D {
> + =A0 =A0 =A0 .name =3D "logitech-djreceiver",
> + =A0 =A0 =A0 .id_table =3D logi_dj_receivers,
> + =A0 =A0 =A0 .probe =3D logi_dj_probe,
> + =A0 =A0 =A0 .remove =3D logi_dj_remove,
> + =A0 =A0 =A0 .raw_event =3D logi_dj_raw_event
> +};
> +
> +
> +static const struct hid_device_id logi_dj_devices[] =3D {
> + =A0 =A0 =A0 {HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVE=
R)},
> + =A0 =A0 =A0 {HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVE=
R_2)},
> + =A0 =A0 =A0 {}
> +};
> +
> +static struct hid_driver logi_djdevice_driver =3D {
> + =A0 =A0 =A0 .name =3D "logitech-djdevice",
> + =A0 =A0 =A0 .id_table =3D logi_dj_devices,
> + =A0 =A0 =A0 .probe =3D logi_djdevice_probe,
> +};
> +
> +
> +static int __init logi_dj_init(void)
> +{
> + =A0 =A0 =A0 int retval;
> +
> + =A0 =A0 =A0 dbg_hid("Logitech-DJ:%s\n", __func__);
> +
> + =A0 =A0 =A0 retval =3D hid_register_driver(&logi_djreceiver_driver)=
;
> + =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> +
> + =A0 =A0 =A0 retval =3D hid_register_driver(&logi_djdevice_driver);
> + =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_unregister_driver(&logi_djreceiver_=
driver);
> +
> + =A0 =A0 =A0 return retval;
> +
> +}
> +
> +static void __exit logi_dj_exit(void)
> +{
> + =A0 =A0 =A0 dbg_hid("Logitech-DJ:%s\n", __func__);
> +
> + =A0 =A0 =A0 hid_unregister_driver(&logi_djdevice_driver);
> + =A0 =A0 =A0 hid_unregister_driver(&logi_djreceiver_driver);
> +
> +}
> +
> +module_init(logi_dj_init);
> +module_exit(logi_dj_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Logitech");
> +MODULE_AUTHOR("Nestor Lopez Casado");
> diff --git a/drivers/hid/hid-logitech-dj.h b/drivers/hid/hid-logitech=
-dj.h
> new file mode 100644
> index 0000000..8dcdccd
> --- /dev/null
> +++ b/drivers/hid/hid-logitech-dj.h
> @@ -0,0 +1,123 @@
> +#ifndef __HID_LOGITECH_DJ_H
> +#define __HID_LOGITECH_DJ_H
> +
> +/*
> + * =A0HID driver for Logitech Unifying receivers
> + *
> + * =A0Copyright (c) 2011 Logitech (c)
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-13=
07 USA
> + *
> + * Should you need to contact me, the author, you can do so by e-mai=
l send
> + * your message to Nestor Lopez Casado <xnlopez at gmail com>
> + *
> + */
> +
> +#include <linux/kfifo.h>
> +
> +#define DJ_MAX_PAIRED_DEVICES =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06
> +#define DJ_MAX_NUMBER_NOTIFICATIONS =A0 =A0 =A0 =A0 =A0 =A08
> +
> +#define DJREPORT_SHORT_LENGTH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A015
> +#define DJREPORT_LONG_LENGTH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 32
> +
> +#define REPORT_ID_DJ_SHORT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0=
x20
> +#define REPORT_ID_DJ_LONG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x21
> +
> +#define REPORT_TYPE_RFREPORT_FIRST =A0 =A0 =A0 =A0 =A0 =A0 0x01
> +#define REPORT_TYPE_RFREPORT_LAST =A0 =A0 =A0 =A0 =A0 =A0 =A00x1F
> +
> +/* Command Switch to DJ mode */
> +#define REPORT_TYPE_CMD_SWITCH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x80
> +#define CMD_SWITCH_PARAM_DEVBITFIELD =A0 =A0 =A0 =A0 =A0 0x00
> +#define CMD_SWITCH_PARAM_TIMEOUT_SECONDS =A0 =A0 =A0 0x01
> +#define TIMEOUT_NO_KEEPALIVE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
0
> +
> +/* Command to Get the list of Paired devices */
> +#define REPORT_TYPE_CMD_GET_PAIRED_DEVICES =A0 =A0 0x81
> +
> +/* Device Paired Notification */
> +#define REPORT_TYPE_NOTIF_DEVICE_PAIRED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x41
> +#define SPFUNCTION_MORE_NOTIF_EXPECTED =A0 =A0 =A0 =A0 0x01
> +#define SPFUNCTION_DEVICE_LIST_EMPTY =A0 =A0 =A0 =A0 =A0 0x02
> +#define DEVICE_PAIRED_PARAM_SPFUNCTION =A0 =A0 =A0 =A0 0x00
> +#define DEVICE_PAIRED_PARAM_EQUAD_ID_LSB =A0 =A0 =A0 0x01
> +#define DEVICE_PAIRED_PARAM_EQUAD_ID_MSB =A0 =A0 =A0 0x02
> +#define DEVICE_PAIRED_RF_REPORT_TYPE =A0 =A0 =A0 =A0 =A0 0x03
> +
> +/* Device Un-Paired Notification */
> +#define REPORT_TYPE_NOTIF_DEVICE_UNPAIRED =A0 =A0 =A00x40
> +
> +
> +/* Connection Status Notification */
> +#define REPORT_TYPE_NOTIF_CONNECTION_STATUS =A0 =A00x42
> +#define CONNECTION_STATUS_PARAM_STATUS =A0 =A0 =A0 =A0 0x00
> +#define STATUS_LINKLOSS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A00x01
> +
> +/* Error Notification */
> +#define REPORT_TYPE_NOTIF_ERROR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x7F
> +#define NOTIF_ERROR_PARAM_ETYPE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x00
> +#define ETYPE_KEEPALIVE_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x01
> +
> +/* supported DJ HID && RF report types */
> +#define REPORT_TYPE_KEYBOARD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
1
> +#define REPORT_TYPE_MOUSE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x02
> +#define REPORT_TYPE_CONSUMER_CONTROL =A0 =A0 =A0 =A0 =A0 0x03
> +#define REPORT_TYPE_SYSTEM_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 0x04
> +#define REPORT_TYPE_MEDIA_CENTER =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x08
> +#define REPORT_TYPE_LEDS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x0E
> +
> +/* RF Report types bitfield */
> +#define STD_KEYBOARD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x00000002
> +#define STD_MOUSE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x00000004
> +#define MULTIMEDIA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x00000008
> +#define POWER_KEYS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x00000010
> +#define MEDIA_CENTER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x00000100
> +#define KBD_LEDS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 0x00004000
> +
> +struct dj_report {
> + =A0 =A0 =A0 u8 report_id;
> + =A0 =A0 =A0 u8 device_index;
> + =A0 =A0 =A0 u8 report_type;
> + =A0 =A0 =A0 u8 report_params[DJREPORT_SHORT_LENGTH - 3];
> +};
> +
> +struct dj_receiver_dev {
> + =A0 =A0 =A0 struct hid_device *hdev;
> + =A0 =A0 =A0 struct dj_device *paired_dj_devices[DJ_MAX_PAIRED_DEVIC=
ES];
> + =A0 =A0 =A0 struct work_struct work;
> + =A0 =A0 =A0 struct kfifo notif_fifo;
> + =A0 =A0 =A0 spinlock_t lock;
> +};
> +
> +struct dj_device {
> + =A0 =A0 =A0 struct hid_device *hdev;
> + =A0 =A0 =A0 struct dj_receiver_dev *dj_receiver_dev;
> + =A0 =A0 =A0 u32 reports_supported;
> + =A0 =A0 =A0 u8 device_index;
> +};
> +
> +/**
> + * is_dj_device - know if the given dj_device is not the receiver.
> + * @dj_dev: the dj device to test
> + *
> + * This macro tests if a struct dj_device pointer is a device create=
d
> + * by the bus enumarator.
> + */
> +#define is_dj_device(dj_dev) \
> + =A0 =A0 =A0 (&(dj_dev)->dj_receiver_dev->hdev->dev =3D=3D (dj_dev)-=
>hdev->dev.parent)
> +
> +#endif
> --
> 1.7.4.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

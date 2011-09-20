From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: Race with Bluetooth hid drivers?
Date: Tue, 20 Sep 2011 11:00:48 +0200
Message-ID: <CANq1E4TCT=jbWJPERaiARzRgnKf6Ep3oiiNQ2Jofn1QnVEvbOQ@mail.gmail.com>
References: <1316482533.2468.6.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44272 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777Ab1ITJAt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 05:00:49 -0400
Received: by wyg34 with SMTP id 34so276610wyg.19
        for <linux-input@vger.kernel.org>; Tue, 20 Sep 2011 02:00:48 -0700 (PDT)
In-Reply-To: <1316482533.2468.6.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

Hi Bastien

On Tue, Sep 20, 2011 at 3:35 AM, Bastien Nocera <hadess@hadess.net> wro=
te:
> Heya,
>
> I'm pretty certain that's already been discussed, but can't seem to f=
ind
> the thread in question, or whether somebody sent patches for the issu=
e.
>
> The problem I see is that the input device is advertised really early=
 in
> its creation, and seems to be missing information when udev (and laye=
rs
> above it in the stack) probes it.
>
> Using Linux 3.1.0 rc6
>
> Turning on a Bluetooth Wacom tablet I see the following udev events:
> UDEV =A0[1890.604848] add =A0 =A0 =A0/devices/pci0000:00/0000:00:1a.0=
/usb1/1-1/1-1.1/1-1.1:1.0/bluetooth/hci0/hci0:42/input10 (input)
> UDEV_LOG=3D3
> ACTION=3Dadd
> DEVPATH=3D/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/b=
luetooth/hci0/hci0:42/input10
> SUBSYSTEM=3Dinput
> PRODUCT=3D5/56a/81/100
> NAME=3D"WACOM Pen Tablet"
> PHYS=3D"00:13:EF:F1:42:B7"
> UNIQ=3D"00:13:C2:03:3D:D6"
> PROP=3D0
> EV=3D17
> KEY=3D70000 0 0 0 0
> REL=3D103
> MSC=3D10
> MODALIAS=3Dinput:b0005v056Ap0081e0100-e0,1,2,4,k110,111,112,r0,1,8,am=
4,lsfw
> SEQNUM=3D2391
> ID_INPUT=3D1
> ID_INPUT_MOUSE=3D1
> ID_PATH=3Dpci-0000:00:1a.0-usb-0:1.1:1.0
> ID_PATH_TAG=3Dpci-0000_00_1a_0-usb-0_1_1_1_0
> ID_FOR_SEAT=3Dinput-pci-0000_00_1a_0-usb-0_1_1_1_0
> TAGS=3D:seat:
>
> If I do a udev database dump I see:
> P: /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/bluetoot=
h/hci0/hci0:42/input10
> E: UDEV_LOG=3D3
> E: DEVPATH=3D/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.=
0/bluetooth/hci0/hci0:42/input10
> E: PRODUCT=3D5/56a/81/100
> E: NAME=3D"WACOM Pen Tablet"
> E: PHYS=3D"00:13:EF:F1:42:B7"
> E: UNIQ=3D"00:13:C2:03:3D:D6"
> E: PROP=3D0
> E: EV=3D1f
> E: KEY=3D1c63 70003 0 0 0 0
> E: REL=3D103
> E: ABS=3D3000003
> E: MSC=3D11
> E: MODALIAS=3Dinput:b0005v056Ap0081e0100-e0,1,2,3,4,k100,101,110,111,=
112,140,141,145,146,14A,14B,14C,r0,1,8,a0,1,18,19,m0,4,lsfw
> E: SUBSYSTEM=3Dinput
> E: ID_INPUT=3D1
> E: ID_INPUT_MOUSE=3D1
> E: ID_PATH=3Dpci-0000:00:1a.0-usb-0:1.1:1.0
> E: ID_PATH_TAG=3Dpci-0000_00_1a_0-usb-0_1_1_1_0
> E: ID_FOR_SEAT=3Dinput-pci-0000_00_1a_0-usb-0_1_1_1_0
> E: TAGS=3D:seat:
>
> See the different KEY=3D value, and the presence of the ABS=3D key. I=
f the
> tablet was probed at this point it would have the ID_INPUT_TABLET=3D1
> property (as running input_id by hand shows).
>
> Any ideas?

The hid-wacom.c driver should probably use the input_mapped() callback
instead of setting the input flags in wacom_probe(). input_mapped() is
called for every descriptor field so there must at least be one valid
field to make it work. I don't have the device so I can't test it, but
try something like this:

=46rom 2f91a998b1bca4b654903e41394fae19dfed1a3c Mon Sep 17 00:00:00 200=
1
=46rom: David Herrmann <dh.herrmann@googlemail.com>
Date: Tue, 20 Sep 2011 10:54:06 +0200
Subject: [PATCH] HID: wacom: Set input bits before registration

We shouldn't change the event flags of input devices after they get reg=
istered.
Otherwise, udev will not get notified of these flags and cannot setup t=
he
devices properly.
This fixes the probing to set the input event flags on the input_mapped=
 callback
instead of the probe function.

Reported-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wacom.c |   76 +++++++++++++++++++++++++--------------=
-------
 1 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 0688832..bc00ef0 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -304,11 +304,49 @@ static int wacom_raw_event(struct hid_device
*hdev, struct hid_report *report,
 	return 1;
 }

+static int wacom_input_mapped(struct hid_device *hdev, struct hid_inpu=
t *hi,
+	struct hid_field *field, struct hid_usage *usage, unsigned long **bit=
,
+								int *max)
+{
+	struct input_dev *input =3D hi->input;
+
+	/* Basics */
+	input->evbit[0] |=3D BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_REL);
+
+	__set_bit(REL_WHEEL, input->relbit);
+
+	__set_bit(BTN_TOOL_PEN, input->keybit);
+	__set_bit(BTN_TOUCH, input->keybit);
+	__set_bit(BTN_STYLUS, input->keybit);
+	__set_bit(BTN_STYLUS2, input->keybit);
+	__set_bit(BTN_LEFT, input->keybit);
+	__set_bit(BTN_RIGHT, input->keybit);
+	__set_bit(BTN_MIDDLE, input->keybit);
+
+	/* Pad */
+	input->evbit[0] |=3D BIT(EV_MSC);
+
+	__set_bit(MSC_SERIAL, input->mscbit);
+
+	__set_bit(BTN_0, input->keybit);
+	__set_bit(BTN_1, input->keybit);
+	__set_bit(BTN_TOOL_FINGER, input->keybit);
+
+	/* Distance, rubber and mouse */
+	__set_bit(BTN_TOOL_RUBBER, input->keybit);
+	__set_bit(BTN_TOOL_MOUSE, input->keybit);
+
+	input_set_abs_params(input, ABS_X, 0, 16704, 4, 0);
+	input_set_abs_params(input, ABS_Y, 0, 12064, 4, 0);
+	input_set_abs_params(input, ABS_PRESSURE, 0, 511, 0, 0);
+	input_set_abs_params(input, ABS_DISTANCE, 0, 32, 0, 0);
+
+	return 0;
+}
+
 static int wacom_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
-	struct hid_input *hidinput;
-	struct input_dev *input;
 	struct wacom_data *wdata;
 	int ret;

@@ -380,39 +418,6 @@ static int wacom_probe(struct hid_device *hdev,

 move_on:
 #endif
-	hidinput =3D list_entry(hdev->inputs.next, struct hid_input, list);
-	input =3D hidinput->input;
-
-	/* Basics */
-	input->evbit[0] |=3D BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_REL);
-
-	__set_bit(REL_WHEEL, input->relbit);
-
-	__set_bit(BTN_TOOL_PEN, input->keybit);
-	__set_bit(BTN_TOUCH, input->keybit);
-	__set_bit(BTN_STYLUS, input->keybit);
-	__set_bit(BTN_STYLUS2, input->keybit);
-	__set_bit(BTN_LEFT, input->keybit);
-	__set_bit(BTN_RIGHT, input->keybit);
-	__set_bit(BTN_MIDDLE, input->keybit);
-
-	/* Pad */
-	input->evbit[0] |=3D BIT(EV_MSC);
-
-	__set_bit(MSC_SERIAL, input->mscbit);
-
-	__set_bit(BTN_0, input->keybit);
-	__set_bit(BTN_1, input->keybit);
-	__set_bit(BTN_TOOL_FINGER, input->keybit);
-
-	/* Distance, rubber and mouse */
-	__set_bit(BTN_TOOL_RUBBER, input->keybit);
-	__set_bit(BTN_TOOL_MOUSE, input->keybit);
-
-	input_set_abs_params(input, ABS_X, 0, 16704, 4, 0);
-	input_set_abs_params(input, ABS_Y, 0, 12064, 4, 0);
-	input_set_abs_params(input, ABS_PRESSURE, 0, 511, 0, 0);
-	input_set_abs_params(input, ABS_DISTANCE, 0, 32, 0, 0);

 	return 0;

@@ -448,6 +453,7 @@ static struct hid_driver wacom_driver =3D {
 	.probe =3D wacom_probe,
 	.remove =3D wacom_remove,
 	.raw_event =3D wacom_raw_event,
+	.input_mapped =3D wacom_input_mapped,
 };

 static int __init wacom_init(void)
--=20
1.7.6.1

This calls input_mapped for every hid-desc field so this is kind of an
overhead but should be enough for a first quick fix. If it works we
could modify it further.
Looking at the other hid drivers that use these quirks, we could
probably need some kind of callback that is called only once for each
input device that is registered instead of once for every field. On
the other hand, the input_mapped callback works quite well for this,
even though it is called multiple times.

Reagards
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

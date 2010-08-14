From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in JooJoo tablet
Date: Fri, 13 Aug 2010 22:33:14 -0400
Message-ID: <m362zd6hzp.fsf_-_@pullcord.laptop.org>
References: <m339wl2ug6.fsf@pullcord.laptop.org>
	<m3hbiz8m11.fsf@pullcord.laptop.org>
	<alpine.LNX.2.00.1008130113530.2702@pobox.suse.cz>
	<C6B3DDC8-79F3-47FC-BC26-244C49998852@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55166 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756795Ab0HNCfQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Aug 2010 22:35:16 -0400
In-Reply-To: <C6B3DDC8-79F3-47FC-BC26-244C49998852@enac.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?St=C3=A9phane?=
	Chatty"'s message of "Fri, 13 Aug 2010 12:47:50 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?St=C3=A9phane?= Chatty <chatty@enac.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, tito@bankiz.org

Hi,

Jiri wrote:
   > has this patch been really tested?
   >
   > I am almost certain that we need to have the device ID to be added=
 to
   > hid_blacklist[] in drivers/hid/hid-core.c as well. Otherwise the
   > hid-egalax driver wouldn't bind to the device automatically in a
   > proper way.

Thanks for noticing that; you're right, it's necessary.  I only tested
CONFIG_HID_EGALAX=3Dy, which doesn't seem to require the blacklist entr=
y.
I've tested that using the blacklist with =3Dm works now.

St=C3=A9phane wrote:
   > My suggestions:
   >   - accept the patch, after adding a few comments in the code abou=
t
   > this device requiring future care for its 'serial' protocol.
   >   - start thinking about what changes are required in hid-input an=
d/
   > or hid-core for a more generic management of multitouch devices.

I've added a comment, feel free to reword it if you'd like to.  Thanks
for the excellent research!


=46rom: Chris Ball <cjb@laptop.org>
Subject: [PATCH] USB HID: Add ID for eGalax Multitouch used in JooJoo t=
ablet
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

The JooJoo tablet (http://thejoojoo.com/) contains an "eGalax Inc. USB
TouchController", and this patch hooks it up to the egalax-touch driver=
=2E
Without the patch we don't get any cursor motion, since it comes throug=
h
Z/RX rather than X/Y.

(The egalax-touch driver does not yet generate a correct event sequence
for the "serial" protocol used by this device, though -- see the note
added to the code, which comes from research by St=C3=A9phane Chatty.)

Cc: Jiri Kosina <jkosina@suse.cz>
Cc: St=C3=A9phane Chatty <chatty@enac.fr>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/hid/hid-core.c   |    1 +
 drivers/hid/hid-egalax.c |    9 +++++++++
 drivers/hid/hid-ids.h    |    1 +
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e635199..0c52899 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1299,6 +1299,7 @@ static const struct hid_device_id hid_blacklist[]=
 =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE) =
},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTIT=
OUCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTIT=
OUCH1) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM0=
84) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EZKEY, USB_DEVICE_ID_BTC_8193) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PS=
X_ADAPTOR) },
diff --git a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
index f44bdc0..a852e31 100644
--- a/drivers/hid/hid-egalax.c
+++ b/drivers/hid/hid-egalax.c
@@ -159,6 +159,13 @@ static int egalax_event(struct hid_device *hid, st=
ruct hid_field *field,
 {
 	struct egalax_data *td =3D hid_get_drvdata(hid);
=20
+	/* Note, eGalax has two product lines: the first is resistive and
+	 * uses a standard parallel multitouch protocol (product ID =3D=3D
+	 * 48xx).  The second is capacitive and uses an unusual "serial"
+	 * protocol with a different message for each multitouch finger
+	 * (product ID =3D=3D 72xx).  We do not yet generate a correct event
+	 * sequence for the capacitive/serial protocol.
+	 */
 	if (hid->claimed & HID_CLAIMED_INPUT) {
 		struct input_dev *input =3D field->hidinput->input;
=20
@@ -246,6 +253,8 @@ static void egalax_remove(struct hid_device *hdev)
 static const struct hid_device_id egalax_devices[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, egalax_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d3fc13a..85c6d13 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -188,6 +188,7 @@
 #define USB_VENDOR_ID_DWAV		0x0eef
 #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH	0x480d
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1	0x720c
=20
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
--=20
1.6.2.5
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

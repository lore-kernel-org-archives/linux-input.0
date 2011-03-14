From: "Keith Packard" <keithp@keithp.com>
Subject: [PATCH] hid: Ortek W/L rdesc has incorrect Logical Maximum
	for keyboard (resend)
Date: Sun, 13 Mar 2011 23:56:16 -0700
Message-ID: <yunbp1enqb3.fsf@aiko.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1903553980661767864=="
Return-path: <stable-bounces@linux.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: Jiri Kosina <jkosnia@suse.cz>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--===============1903553980661767864==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable


The Ortek WKB-2000 had the same rdesc bug -- the Logical Maximum value
was reported as '1' instead of the correct value (146), preventing
most of the keyboard keys from working. This patch simply shares
precisely the same quirk code for this other device.

Signed-off-by: Keith Packard <keithp@keithp.com>
=2D--
 drivers/hid/hid-core.c  |    1 +
 drivers/hid/hid-ids.h   |    1 +
 drivers/hid/hid-ortek.c |    3 ++-
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d678cf3..233bbf2 100644
=2D-- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1401,6 +1401,7 @@ static const struct hid_device_id hid_have_special_dr=
iver[] =3D {
	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_17)=
 },
	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_18)=
 },
	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WL) },
	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REM=
OTE) },
	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH)=
 },
	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_PIXART_IMAGING_INC_OP=
TICAL_TOUCH_SCREEN) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 92a0d61..b478b25 100644
=2D-- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -467,6 +467,7 @@

 #define USB_VENDOR_ID_ORTEK		0x05a4
 #define USB_DEVICE_ID_ORTEK_WKB2000	0x2000
+#define USB_DEVICE_ID_ORTEK_WL		0x1700

 #define USB_VENDOR_ID_PANJIT		0x134c

diff --git a/drivers/hid/hid-ortek.c b/drivers/hid/hid-ortek.c
index e90edfc..74011af 100644
=2D-- a/drivers/hid/hid-ortek.c
+++ b/drivers/hid/hid-ortek.c
@@ -23,7 +23,7 @@ static __u8 *ortek_report_fixup(struct hid_device *hdev, =
__u8 *rdesc,
		unsigned int *rsize)
 {
	if (*rsize >=3D 56 && rdesc[54] =3D=3D 0x25 && rdesc[55] =3D=3D 0x01) {
=2D		hid_info(hdev, "Fixing up Ortek WKB-2000 report descriptor\n");
+		hid_info(hdev, "Fixing up Ortek WKB-2000 or W/L report descriptor\n");
		rdesc[55] =3D 0x92;
	}
	return rdesc;
@@ -31,6 +31,7 @@ static __u8 *ortek_report_fixup(struct hid_device *hdev, =
__u8 *rdesc,

 static const struct hid_device_id ortek_devices[] =3D {
	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WL) },
	{ }
 };
 MODULE_DEVICE_TABLE(hid, ortek_devices);

=2D-=20
keith.packard@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFNfbwQQp8BWwlsTdMRApT2AJ4lq/0SJNcccL4nNB6q5oO+mATCUgCgtJY0
T6fRkbtIYZe+I20YEIUk5IY=
=aZrt
-----END PGP SIGNATURE-----
--=-=-=--


--===============1903553980661767864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable

--===============1903553980661767864==--

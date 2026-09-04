Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644DB3EEAE2
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 03:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788493740; cv=none; b=m8lJEpADTln3KqKgAtEdeXhT3PL5UDeXtfydCd58plDWgdP+bq/hiufKM/aAt4OSpSZGlx9OPyAMoUYLWtzxhEwA4ujdPaxeGQMSnk7svU+k7jiulNL5hg3bMHTevTNy3SdpbO48jwusUHZ4j5GXdcAuKZXMNCclqv9t+387gIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788493740; c=relaxed/simple;
	bh=bdaLjUejnR+karHD5h1xhdMgoSd9IW2BrQBMbUbDsqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a+qP6DmSQfd8vFLTNjdEdSrc7y18H6IPG4J/6KHkq+UYAsni9mnVdLiF2YfFygJ1OzrygpHx2VdHUzdNQlKYFRak8tpxNepjuly0fwR5QSLPO+oV3552YerGRfKCQbnBPIe673ASqfaDd0FOjlQ73usjqiD6TF26wWfMxaZOt1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=YWeSZX2R; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=G5lZoWKp; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="YWeSZX2R";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="G5lZoWKp"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=YWeSZX2ReVeut3Hl0nOW1du9TB+lXIEyrgvCh/jJc9WTsVg3TwPLHrODPWI/0c+sfG7lJtPebNUoyih32HW+1rq4RZO1xQck7BWjAbvjPfgWwGyL0sxWrHGoRE1mdlplDyfo2biF6xrpsXdmB3Jlvt0wbxF0+7o6O+wiy5MsyQ/+UmjnhmTrELO66LX3UnHcE7VDqpJip+xXV3Z6mU+yubKpiVq3MzD3zXRSIJkN0j4lY4VGriI2fhl61bq/QeBzOQjtTEKnuGKrSj1IgtbL671aGNkMVS6bpadLbet+wCx0y13aUp1dyTT7R4hyR6XP3jMVk56EEb5uq6l8L82Pnw==; s=purelymail3; d=rcpassos.me; v=1; bh=bdaLjUejnR+karHD5h1xhdMgoSd9IW2BrQBMbUbDsqQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=G5lZoWKpAJTCz3mVduB8K2+76mU7GLk0+SlJfTi+p2Pvp4j78tt6kBOkZUJ/Ewp3A05U+PhvLYpBHtusjiUT4385wlbfvnMLtXIRIm5H7DE/beOAydb1CsGAsYptySVlMpHfdFw+CpXDJxoXMyFpavBqOSeyTUeDHUURdhO2oasaj8bfpPV9cP3v+sbnSYrURuBISbqhQRyX52TPb7+XRwRDlMmU6IHYLz4e3Tdb78s9YRDMphvaiWGO9rBuaUUTfBrGu7PKFnMSHcm331fkHqeQdvYDEmTLv0b7FgJZb+9OB7BmoS8wp356pDtc6MZ3TQgs8xqQ7aBk9XuFnEpYXg==; s=purelymail3; d=purelymail.com; v=1; bh=bdaLjUejnR+karHD5h1xhdMgoSd9IW2BrQBMbUbDsqQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2055192531;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 04 Sep 2026 03:48:42 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: lains@riseup.net,
	hadess@hadess.net,
	jikos@kernel.org,
	bentiss@kernel.org,
	erikhakan@gmail.com
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH] HID: logitech-hidpp: fix hi-res scroll for Bolt-connected MX Master
Date: Fri,  4 Sep 2026 00:48:29 -0300
Message-ID: <20260904034843.1340846-1-rafael@rcpassos.me>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The new added support for Logitech HID++ caused this mouse to
scroll too far for each tic when using the USB dongle (Bolt).
Previously, this mouse was handled as hid_generic over the Bold
connection, and logitech-hidpp when over Bluetooth.

Cause:
Over the Bolt receiver, the mouse reports  are forwarded over the generic
interface 1, instead of the new HID++ child device. The generic hid does
now know about the hi-res scrolling used by the HID++.
In my tests, I discovered this mouse has a multiplier factor of 15. This
multiplier is only handled by the logitech-hidpp driver. When piped to
hid_generic, the "hi-res" value was piped to a "low-res" field, making
the scroll unbearable.

The fix routes the wheel using the HID++, so the ticks are scaled by the
multiplier and correctly reported as a hi-res event.

I also had to move the hidpp_is_bolt_child function up, to use it in the
hidpp_connect_event function, where the gate for
hidpp_initialize_hires_scroll function lives.

Tested with:
- Logitech MX Master 3S (mouse) via Bolt receiver and Bluetooth.

Fixes: 022eb347ff3a ("HID: logitech: add Bolt receiver support for Logitech=
 HID++ devices")
Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---

Hi,
I decided to send this patch as soon as I made it work, to try to make
it into this fix cycle.

I do not have other devices to test this with.
It would *be great* to have other users testing this.

Lastly, I decided to make all the changes in a single patch.=20
But I can break it up if asked.

Thanks,
Rafael


 drivers/hid/hid-logitech-hidpp.c | 47 ++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hi=
dpp.c
index 1504de32b1c84..960543bfd5ea1 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3900,6 +3900,19 @@ static int hidpp10_consumer_keys_raw_event(struct hi=
dpp_device *hidpp,
 =09return 1;
 }
=20
+static bool hidpp_is_bolt_child(struct hid_device *hdev)
+{
+=09struct device *parent =3D hdev->dev.parent;
+=09struct hid_device *receiver_hdev;
+
+=09if (!parent)
+=09=09return false;
+
+=09receiver_hdev =3D to_hid_device(parent);
+=09return receiver_hdev->vendor =3D=3D USB_VENDOR_ID_LOGITECH &&
+=09       receiver_hdev->product =3D=3D USB_DEVICE_ID_LOGITECH_BOLT_RECEIV=
ER;
+}
+
 /* -----------------------------------------------------------------------=
--- */
 /* High-resolution scroll wheels                                          =
    */
 /* -----------------------------------------------------------------------=
--- */
@@ -3910,7 +3923,9 @@ static int hi_res_scroll_enable(struct hidpp_device *=
hidpp)
 =09u8 multiplier =3D 1;
=20
 =09if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
-=09=09ret =3D hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
+=09=09bool use_hidpp =3D hidpp_is_bolt_child(hidpp->hid_dev);
+
+=09=09ret =3D hidpp_hrw_set_wheel_mode(hidpp, false, true, use_hidpp);
 =09=09if (ret =3D=3D 0)
 =09=09=09ret =3D hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
 =09} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL=
) {
@@ -3998,6 +4013,19 @@ static int hidpp20_hires_wheel_raw_event(struct hidp=
p_device *hidpp,
 =09=09return 1;
 =09}
=20
+=09/* wheel movement event: 16-bit signed delta in HID++ ticks */
+=09if ((data[3] & 0xf0) =3D=3D 0x00 && size >=3D 7 && hidpp->input &&
+=09    hidpp->vertical_wheel_counter.wheel_multiplier) {
+=09=09s16 delta =3D get_unaligned_be16(&data[5]);
+
+=09=09if (delta) {
+=09=09=09hidpp_scroll_counter_handle_scroll(hidpp->input,
+=09=09=09=09&hidpp->vertical_wheel_counter, delta);
+=09=09=09input_sync(hidpp->input);
+=09=09}
+=09=09return 1;
+=09}
+
 =09return 0;
 }
=20
@@ -4405,19 +4433,6 @@ static int hidpp_initialize_battery(struct hidpp_dev=
ice *hidpp)
 =09return ret;
 }
=20
-static bool hidpp_is_bolt_child(struct hid_device *hdev)
-{
-=09struct device *parent =3D hdev->dev.parent;
-=09struct hid_device *receiver_hdev;
-
-=09if (!parent)
-=09=09return false;
-
-=09receiver_hdev =3D to_hid_device(parent);
-=09return receiver_hdev->vendor =3D=3D USB_VENDOR_ID_LOGITECH &&
-=09       receiver_hdev->product =3D=3D USB_DEVICE_ID_LOGITECH_BOLT_RECEIV=
ER;
-}
-
 static int hidpp_bolt_init(struct hidpp_device *hidpp)
 {
 =09struct hid_device *hdev =3D hidpp->hid_dev;
@@ -4579,7 +4594,9 @@ static void hidpp_connect_event(struct work_struct *w=
ork)
 =09}
=20
 =09hidpp_initialize_battery(hidpp);
-=09if (!hid_is_usb(hidpp->hid_dev))
+
+=09if (!hid_is_usb(hidpp->hid_dev) ||
+=09    hidpp_is_bolt_child(hidpp->hid_dev))
 =09=09hidpp_initialize_hires_scroll(hidpp);
=20
 =09/* forward current battery state */
--=20
2.55.0


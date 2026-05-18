Received: from mail-244117.protonmail.ch (mail-244117.protonmail.ch [109.224.244.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C8B381AFA
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132546; cv=none; b=sBBm2yz7qg0yoi0tHSsdxBVkWX2J9nwGegtPwzKR0Al92ZQ6GCPA/tgjwdeMax9I9BCsay+ja+hPZtlxcP4DL0oLL850hdIcl+9rQVupjNt9EF7uWtNoXML53LpvlUWubaOtZSR+eUWl9nOUEpA+bf1CVm+fEmQqzlrUridZti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132546; c=relaxed/simple;
	bh=oPztJkd8FzhTRwGdQypynhl22SBdb7nOUc1ipN+vw6Y=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PdJ/vXSsvwWqaXaEuh4lQS9CtFo17qCKUunHAZjb+ILK6qGHPaWFDlSlWBYE6BDrc137fx5M3JnoZo69TY97QHYkohpFOv370d6MPs5JFfeeixHBscAthCXOydDsdvIxukCvN/Fo6V5tv98LEB04lUxg6rbS+7rsZXpkGainrNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=saurla.com; spf=pass smtp.mailfrom=saurla.com; dkim=pass (2048-bit key) header.d=saurla.com header.i=@saurla.com header.b=b3LuN9f5; arc=none smtp.client-ip=109.224.244.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=saurla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=saurla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=saurla.com header.i=@saurla.com header.b="b3LuN9f5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saurla.com;
	s=protonmail; t=1779132533; x=1779391733;
	bh=LVMCMI0T0xJKkT33yJuE8nlFRpuKorumBbx3Quv8aNs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=b3LuN9f5vm/Mdb9YfZhnfrT0lFVVjnb8H7jyeyoebLn1+Y2uVJ4rB/xsoNU0/sFz1
	 YUAIJDJ4O/PrsADqP1GVBJ9Pp6SW9igyzmSof2FWIm4O92o8gQgNomIdYKrOnuy/sZ
	 gMXcnKCyp937BmgckauAWLFQvgCaNQ5teWs3K8s5ESiyskyqdZbB3c1zsCVC8gHwPk
	 NpN5dpds73d4/enNDFBhR0MPDVEsfCCUzsFk57pYHEJagI5QFi/9Z7sxRj6FHFUmSg
	 /p6ByPLnttl+K6nlfr0m14uPGlOm8m7G8wc4APjzoK2ErEd4BdkKMRkzKBJ2FOnh/2
	 KNGTVaqK75oTQ==
Date: Mon, 18 May 2026 19:28:50 +0000
To: linux-input@vger.kernel.org
From: Lauri Saurus <saurla@saurla.com>
Cc: =?utf-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>, Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org, Lauri Saurus <saurla@saurla.com>
Subject: [PATCH] HID: logitech-hidpp: sync wheel multiplier on wheel mode changes
Message-ID: <20260518192649.245691-1-saurla@saurla.com>
Feedback-ID: 198286868:user:proton
X-Pm-Message-ID: 41a61927e2554be06af0d9b54e52015d4c556dfa
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The hid-logitech-hidpp driver enables high resolution scrolling on
device connect for capable HID++ 2.0 devices. Driver also reads the
wheel capability and caches the returned high resolution wheel scroll
multiplier, that is used for scroll scaling when handling wheel scroll
events.

Wheel mode can also be set externally through HID++ requests, which
can leave the cached multiplier stale and cause incorrect scroll
scaling. If external SetWheelMode HID++ request sets the mode to
low resolution, the cached multiplier is not updated accordingly. This
causes extremely slow scrolling since driver expects multiple wheel
scroll events per detent but is only getting one.

The fix listens for HID++ SetWheelMode request responses and updates
the wheel scroll multiplier based on the set high resolution scroll
mode. The fix has been tested with Logitech G502X lightspeed mouse.

Signed-off-by: Lauri Saurus <saurla@saurla.com>
---
 drivers/hid/hid-logitech-hidpp.c | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hi=
dpp.c
index ccbf28869a96..e80c4aa6115b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -207,6 +207,9 @@ struct hidpp_device {
=20
 =09u8 wireless_feature_index;
=20
+=09int hires_wheel_multiplier;
+=09u8 hires_wheel_feature_index;
+
 =09bool connected_once;
 };
=20
@@ -3710,6 +3713,7 @@ static int hi_res_scroll_enable(struct hidpp_device *=
hidpp)
 =09=09multiplier =3D 1;
 =09}
=20
+=09hidpp->hires_wheel_multiplier =3D multiplier;
 =09hidpp->vertical_wheel_counter.wheel_multiplier =3D multiplier;
 =09hid_dbg(hidpp->hid_dev, "wheel multiplier =3D %d\n", multiplier);
 =09return 0;
@@ -3720,6 +3724,7 @@ static int hidpp_initialize_hires_scroll(struct hidpp=
_device *hidpp)
 =09int ret;
 =09unsigned long capabilities;
=20
+=09hidpp->hires_wheel_feature_index =3D 0xff;
 =09capabilities =3D hidpp->capabilities;
=20
 =09if (hidpp->protocol_major >=3D 2) {
@@ -3729,6 +3734,7 @@ static int hidpp_initialize_hires_scroll(struct hidpp=
_device *hidpp)
 =09=09=09=09=09     &feature_index);
 =09=09if (!ret) {
 =09=09=09hidpp->capabilities |=3D HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL;
+=09=09=09hidpp->hires_wheel_feature_index =3D feature_index;
 =09=09=09hid_dbg(hidpp->hid_dev, "Detected HID++ 2.0 hi-res scroll wheel\n=
");
 =09=09=09return 0;
 =09=09}
@@ -3751,6 +3757,31 @@ static int hidpp_initialize_hires_scroll(struct hidp=
p_device *hidpp)
 =09return 0;
 }
=20
+static int hidpp20_hires_wheel_raw_event(struct hidpp_device *hidpp,
+=09=09=09=09=09=09u8 *data, int size)
+{
+=09if (hidpp->hires_wheel_feature_index =3D=3D 0xff)
+=09=09return 0;
+
+=09if (size < 5)
+=09=09return 0;
+
+=09if (data[0] !=3D REPORT_ID_HIDPP_LONG ||
+=09    data[2] !=3D hidpp->hires_wheel_feature_index)
+=09=09return 0;
+
+=09if ((data[3] & 0xf0) =3D=3D CMD_HIRES_WHEEL_SET_WHEEL_MODE) {
+=09=09u8 mode =3D data[4];
+=09=09bool hires =3D (mode & 0x02) !=3D 0;
+=09=09int new_multiplier =3D (hires && hidpp->hires_wheel_multiplier > 0)
+=09=09=09? hidpp->hires_wheel_multiplier : 1;
+=09=09hidpp->vertical_wheel_counter.wheel_multiplier =3D new_multiplier;
+=09=09return 1;
+=09}
+
+=09return 0;
+}
+
 /* -----------------------------------------------------------------------=
--- */
 /* Generic HID++ devices                                                  =
    */
 /* -----------------------------------------------------------------------=
--- */
@@ -3947,6 +3978,12 @@ static int hidpp_raw_hidpp_event(struct hidpp_device=
 *hidpp, u8 *data,
 =09=09=09return ret;
 =09}
=20
+=09if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
+=09=09ret =3D hidpp20_hires_wheel_raw_event(hidpp, data, size);
+=09=09if (ret !=3D 0)
+=09=09=09return ret;
+=09}
+
 =09return 0;
 }
=20
--=20
2.54.0



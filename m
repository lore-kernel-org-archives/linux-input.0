Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5043191D0
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151341; cv=none; b=iRn+PJoS1OZhKzwsFTlZt5f/lACH74x54QGXYlK26YrEH5dZcsiXrg6HYdvDynm2asIVlbpqq/qlEC7k92MRQ92lqZIhSYO/ssDouhOba0UeccAI019Gw+MU8l2656am6EkCdM20qzpbG/3FmzSvJ8rvDPphYDaxcqlXtj4CjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151341; c=relaxed/simple;
	bh=8XdamDKPS4QvvrW8b/AUId6qa0ul9NfcHXEUbXJDCsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYHb6Zt8OWDGL3Qf/UsON2emaQneb51nuHkRp2Rc3hT2S4knGidlMvzSCqFUHp9IVDILfoEHFDQZy2dsbPNkJGWsWVWSiz7gmOvWYN006VyxdUMm0uyFNfWoapyRbvpCQNIPWJv2drUXW5M1psGPHNvpgAtEUcNFb+uWTbvMmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=XePHyJr2; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=r3ByEH64; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="XePHyJr2";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="r3ByEH64"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=XePHyJr2whx4fEWrgYVwJXmEOq326yKM7k8Uqg704hMSFGgmoxZ3WLe15U7IJPBZDO7leeOmrd6w/cyakuL79aai+10nJjq9zge3DWOZk6UpzRcOPOUb9GfEsqnz1ugAlMnq8/ThgJZpsrnj51jOZOHZDL+ld5U1iZqJXPE5/ym51niiJHUoCO+Gtazc+3gT8DRNb6O7Lo3y2d9ZPIkpT9ZBoDaS4zboXVZtY5Mjwn+XwxZwnH7beJt7AtXmZARAKiGU2bdCj63TPZRl1C75VeZfe6OuJYtTzNpaEmJFmUeTCXQb8LuzvS4BES+ozmBjUiqUbqfD093/X650GtzMNw==; s=purelymail2; d=rcpassos.me; v=1; bh=8XdamDKPS4QvvrW8b/AUId6qa0ul9NfcHXEUbXJDCsI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=r3ByEH64aeQ1LFPOf+h2sGpA4BTQRjEqUYVOnlipNU+nKDX0ujmyHRoWtXrFOCg95DTNLaRsaHyTi5j5/TldgdDd66UkIKo5llxi/z//vELJlXLoz0h3moEXVn2YWxAFycl4SXR9ANSSHJ1n9ZM38VLlos3KL6ahtT5XZPpbl657nsrVKUIhDKgr3agls8heJ6AWiXFDWsVIHAujwqN5J5bphi1bclnKLo0LuJvNOrbkDbdpmBM+mQfhudnbfFcD7xNmgGF4r95reXcYf8fOglJqNmuWVaXprwgePT4gvl6zjpkkOWbZjAMv+BMTZRUA+3RQM65aIQtaTKAzQzrKCA==; s=purelymail2; d=purelymail.com; v=1; bh=8XdamDKPS4QvvrW8b/AUId6qa0ul9NfcHXEUbXJDCsI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -189651813;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Jul 2026 21:35:27 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: rafael@rcpassos.me
Cc: bentiss@kernel.org,
	david@readahead.eu,
	jikos@kernel.org,
	jkoolstra@xs4all.nl,
	linux-input@vger.kernel.org
Subject: [TEST] Patch used for testing the wiimote_probe_cleanup
Date: Wed, 15 Jul 2026 18:35:13 -0300
Message-ID: <20260715213513.3929001-1-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715212501.3920033-4-rafael@rcpassos.me>
References: <20260715212501.3920033-4-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

[DO NOT APPLY THIS PATCH] :)
This is the patch I used to simulate each possible failure case
in the probing function.
I can say going it was worth it, as I was originally not gating
ida_free, and the struct would corrupt.

Below are the logs from my last run with this.
I added a space between each iteration, to help reading:

[   76.680204] wiimote 0005:057E:0330.0006: Probing wiimote iteration 1
[   76.680216] __wiimote_probe_cleanup: wdata NULL
[   76.680224] wiimote 0005:057E:0330.0006: probe with driver wiimote faile=
d with error -12

[   81.745168] wiimote 0005:057E:0330.0007: Probing wiimote iteration 2
[   81.745312] wiimote 0005:057E:0330.0007: probe with driver wiimote faile=
d with error -12

[   86.869452] wiimote 0005:057E:0330.0008: Probing wiimote iteration 3
[   86.869935] wiimote 0005:057E:0330.0008: unknown main item tag 0x0
[   86.869983] wiimote 0005:057E:0330.0008: probe with driver wiimote faile=
d with error -12

[   92.001194] wiimote 0005:057E:0330.0009: Probing wiimote iteration 4
[   92.001684] wiimote 0005:057E:0330.0009: unknown main item tag 0x0
[   92.001905] wiimote 0005:057E:0330.0009: hidraw5: BLUETOOTH HID v0.01 Ga=
mepad [Nintendo RVL-CNT-01-TR] on 64:bc:58:9a:b9:28
[   92.002075] __wiimote_probe_cleanup: hid_hw_stop cleanup
[   92.002105] wiimote 0005:057E:0330.0009: probe with driver wiimote faile=
d with error -12

[   97.129059] wiimote 0005:057E:0330.000A: Probing wiimote iteration 5
[   97.129528] wiimote 0005:057E:0330.000A: unknown main item tag 0x0
[   97.129757] wiimote 0005:057E:0330.000A: hidraw5: BLUETOOTH HID v0.01 Ga=
mepad [Nintendo RVL-CNT-01-TR] on 64:bc:58:9a:b9:28
[   97.129774] __wiimote_probe_cleanup: hid_hw_close cleanup
[   97.129934] __wiimote_probe_cleanup: hid_hw_stop cleanup
[   97.129962] wiimote 0005:057E:0330.000A: probe with driver wiimote faile=
d with error -12

[  102.265442] wiimote 0005:057E:0330.000B: Probing wiimote iteration 6
[  102.265925] wiimote 0005:057E:0330.000B: unknown main item tag 0x0
[  102.266521] wiimote 0005:057E:0330.000B: hidraw5: BLUETOOTH HID v0.01 Ga=
mepad [Nintendo RVL-CNT-01-TR] on 64:bc:58:9a:b9:28
[  102.266538] __wiimote_probe_cleanup: hid_hw_close cleanup
[  102.266814] __wiimote_probe_cleanup: hid_hw_stop cleanup
[  102.266844] wiimote 0005:057E:0330.000B: probe with driver wiimote faile=
d with error -12

[  107.405172] wiimote 0005:057E:0330.000C: Probing wiimote iteration 7
[  107.405602] wiimote 0005:057E:0330.000C: unknown main item tag 0x0
[  107.405776] wiimote 0005:057E:0330.000C: hidraw5: BLUETOOTH HID v0.01 Ga=
mepad [Nintendo RVL-CNT-01-TR] on 64:bc:58:9a:b9:28
[  107.405794] __wiimote_probe_cleanup: hid_hw_close cleanup
[  107.405953] __wiimote_probe_cleanup: hid_hw_stop cleanup
[  107.405981] wiimote 0005:057E:0330.000C: probe with driver wiimote faile=
d with error -12

[  112.525411] wiimote 0005:057E:0330.000D: Probing wiimote iteration 8
[  112.525883] wiimote 0005:057E:0330.000D: unknown main item tag 0x0
[  112.526323] wiimote 0005:057E:0330.000D: hidraw5: BLUETOOTH HID v0.01 Ga=
mepad [Nintendo RVL-CNT-01-TR] on 64:bc:58:9a:b9:28
[  112.526362] __wiimote_probe_cleanup: hid_hw_close cleanup
[  112.526511] __wiimote_probe_cleanup: hid_hw_stop cleanup
[  112.526535] wiimote 0005:057E:0330.000D: probe with driver wiimote faile=
d with error -12

[  117.673238] wiimote 0005:057E:0330.000E: Probing wiimote iteration 9
[  117.673700] wiimote 0005:057E:0330.000E: unknown main item tag 0x0
[  117.673885] wiimote 0005:057E:0330.000E: hidraw5: BLUETOOTH HID v0.01 Ga=
mepad [Nintendo RVL-CNT-01-TR] on 64:bc:58:9a:b9:28
[  117.673909] __wiimote_probe_cleanup: ida cleanup
[  117.673929] __wiimote_probe_cleanup: hid_hw_close cleanup
[  117.674081] __wiimote_probe_cleanup: hid_hw_stop cleanup
[  117.674105] wiimote 0005:057E:0330.000E: probe with driver wiimote faile=
d with error -12

[  122.805206] wiimote 0005:057E:0330.000F: Probing wiimote iteration 10
[  122.805669] wiimote 0005:057E:0330.000F: unknown main item tag 0x0
[  122.805895] wiimote 0005:057E:0330.000F: hidraw5: BLUETOOTH HID v0.01 Ga=
mepad [Nintendo RVL-CNT-01-TR] on 64:bc:58:9a:b9:28
[  122.805934] wiimote 0005:057E:0330.000F: New device registered (Wiimote =
1)
[  122.805940] __wiimote_probe_cleanup: wdata NULL
[  122.841287] wiimote 0005:057E:0330.000F: detected device: Nintendo Wii R=
emote Plus (Gen 2) (1)
[  122.841759] input: Nintendo Wii Remote Accelerometer as /devices/virtual=
/misc/uhid/0005:057E:0330.000F/input/input33
[  122.844724] input: Nintendo Wii Remote IR as /devices/virtual/misc/uhid/=
0005:057E:0330.000F/input/input34
[  122.845091] input: Nintendo Wii Remote as /devices/virtual/misc/uhid/000=
5:057E:0330.000F/input/input32
[  122.965128] wiimote 0005:057E:0330.000F: detected extension: Nintendo Wi=
i Motion Plus
[  122.965276] input: Nintendo Wii Remote Motion Plus as /devices/virtual/m=
isc/uhid/0005:057E:0330.000F/input/input35
[  127.877355] wiimote 0005:057E:0330.000F: Device removed

[  130.497046] wiimote 0005:057E:0330.0010: Probing wiimote iteration 11
[  130.497524] wiimote 0005:057E:0330.0010: unknown main item tag 0x0
[  130.497838] wiimote 0005:057E:0330.0010: hidraw5: BLUETOOTH HID v0.01 Ga=
mepad [Nintendo RVL-CNT-01-TR] on 64:bc:58:9a:b9:28
[  130.497869] wiimote 0005:057E:0330.0010: New device registered (Wiimote =
1)
[  130.497874] __wiimote_probe_cleanup: wdata NULL
[  130.533040] wiimote 0005:057E:0330.0010: detected device: Nintendo Wii R=
emote Plus (Gen 2) (1)
[  130.533424] input: Nintendo Wii Remote Accelerometer as /devices/virtual=
/misc/uhid/0005:057E:0330.0010/input/input37
[  130.533579] input: Nintendo Wii Remote IR as /devices/virtual/misc/uhid/=
0005:057E:0330.0010/input/input38
[  130.533699] input: Nintendo Wii Remote as /devices/virtual/misc/uhid/000=
5:057E:0330.0010/input/input36
[  130.641239] wiimote 0005:057E:0330.0010: detected extension: Nintendo Wi=
i Motion Plus
[  130.641385] input: Nintendo Wii Remote Motion Plus as /devices/virtual/m=
isc/uhid/0005:057E:0330.0010/input/input39
[  134.317450] wiimote 0005:057E:0330.0010: Device removed


Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 drivers/hid/hid-wiimote-core.c | 45 ++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.=
c
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1779,52 +1779,77 @@ static DEFINE_IDA(wiimote_ida);
=20
 static void __wiimote_probe_cleanup(struct wiimote_data *wdata)
 {
-=09if (!wdata)
+=09if (!wdata) {
+=09=09printk(KERN_INFO "%s: wdata NULL\n", __func__);
 =09=09return;
+=09}
=20
-=09if (wdata->player_id)
+=09if (wdata->player_id){
+=09=09printk(KERN_INFO "%s: ida cleanup\n", __func__);
 =09=09ida_free(&wiimote_ida, wdata->player_id);
+=09}
=20
 =09// safe, debugfs checks IS_ERR_OR_NULL
 =09wiidebug_deinit(wdata);
 =09// safe, checks dev for NULL
 =09device_remove_file(&wdata->hdev->dev, &dev_attr_devtype);
 =09device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
-=09if (wdata->probe_state & WIIMOTE_PROBE_HW_OPENED)
+=09if (wdata->probe_state & WIIMOTE_PROBE_HW_OPENED){
+=09=09printk(KERN_INFO "%s: hid_hw_close cleanup\n", __func__);
 =09=09hid_hw_close(wdata->hdev);
-=09if (wdata->probe_state & WIIMOTE_PROBE_HW_STARTED)
+=09}
+=09if (wdata->probe_state & WIIMOTE_PROBE_HW_STARTED){
 =09=09hid_hw_stop(wdata->hdev);
+=09=09printk(KERN_INFO "%s: hid_hw_stop cleanup\n", __func__);
+=09}
 =09kfree(wdata);
 }
=20
 DEFINE_FREE(wiimote_probe_cleanup, struct wiimote_data *,
 =09__wiimote_probe_cleanup(_T))
=20
+static int debug_connect_iterate =3D 0;
+
 static int wiimote_hid_probe(struct hid_device *hdev,
 =09=09=09=09const struct hid_device_id *id)
 {
 =09int ret;
+=09debug_connect_iterate++;
+
+=09hid_info(hdev, "Probing wiimote iteration %d\n", debug_connect_iterate)=
;
=20
 =09hdev->quirks |=3D HID_QUIRK_NO_INIT_REPORTS;
=20
-=09struct wiimote_data *wdata __free(wiimote_probe_cleanup) =3D wiimote_cr=
eate(hdev);
+=09struct wiimote_data *wdata __free(wiimote_probe_cleanup) =3D NULL;
+=09if (debug_connect_iterate =3D=3D 1)
+=09=09return -ENOMEM;
+
+        wdata =3D wiimote_create(hdev);
 =09if (!wdata) {
 =09=09hid_err(hdev, "Can't alloc device\n");
 =09=09return -ENOMEM;
 =09}
=20
+=09if (debug_connect_iterate =3D=3D 2)
+=09=09return -ENOMEM;
+
 =09ret =3D hid_parse(hdev);
 =09if (ret) {
 =09=09hid_err(hdev, "HID parse failed\n");
 =09=09return ret;
 =09}
=20
+=09if (debug_connect_iterate =3D=3D 3)
+=09=09return -ENOMEM;
+
 =09ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
 =09if (ret) {
 =09=09hid_err(hdev, "HW start failed\n");
 =09=09return ret;
 =09}
 =09wdata->probe_state |=3D WIIMOTE_PROBE_HW_STARTED;
+=09if (debug_connect_iterate =3D=3D 4)
+=09=09return -ENOMEM;
=20
 =09ret =3D hid_hw_open(hdev);
 =09if (ret) {
@@ -1832,22 +1857,30 @@ static int wiimote_hid_probe(struct hid_device *hde=
v,
 =09=09return ret;
 =09}
 =09wdata->probe_state |=3D WIIMOTE_PROBE_HW_OPENED;
+=09if (debug_connect_iterate =3D=3D 5)
+=09=09return -ENOMEM;
=20
 =09ret =3D device_create_file(&hdev->dev, &dev_attr_extension);
 =09if (ret) {
 =09=09hid_err(hdev, "cannot create sysfs attribute\n");
 =09=09return ret;
 =09}
+=09if (debug_connect_iterate =3D=3D 6)
+=09=09return -ENOMEM;
=20
 =09ret =3D device_create_file(&hdev->dev, &dev_attr_devtype);
 =09if (ret) {
 =09=09hid_err(hdev, "cannot create sysfs attribute\n");
 =09=09return ret;
 =09}
+=09if (debug_connect_iterate =3D=3D 7)
+=09=09return -ENOMEM;
=20
 =09ret =3D wiidebug_init(wdata);
 =09if (ret)
 =09=09return ret;
+=09if (debug_connect_iterate =3D=3D 8)
+=09=09return -ENOMEM;
=20
 =09int player_id =3D ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
 =09if (player_id < 1) {
@@ -1856,6 +1889,8 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 =09=09return ret;
 =09}
 =09wdata->player_id =3D player_id;
+=09if (debug_connect_iterate =3D=3D 9)
+=09=09return -ENOMEM;
=20
=20
 =09hid_info(hdev, "New device registered (Wiimote %d)\n", player_id);
--=20
2.53.0


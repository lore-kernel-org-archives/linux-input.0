Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572856;
	b=GqJiqx+gRGuGAbrHiDsJcdDN6gmPt5zLVFAHB/eWZyxVa4rDPMZsQJ6dt2joKpoEqZuG
	 qKpdvRS1bI01M0cxCikUGZwM3gdBsJQDa7ufk7w5+1FbP+O8lUpn+tU79rQGkxsp/utlz
	 F9vT8W81v5Qhst7XRwiSyzDTmmO4foSDEvrUxJZhpYREEncgzKWdy/prlENAR96SNAg35
	 Q6sqWbvDZORQpHU6Fc9JEAwHU6ANod7TAxjBY7vMIpn4/zpTgiMfvRCyVViVXn063Q6Iz
	 8mWLf1UjclEZRHmWabDOm2colKsTQlFGdBV2kj8HKQPnUPpKyQqepeLz11l3dAr/Bsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572856;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Pdfq1SwYpORYmsHq2kMlXIBTfvuU5U4Y7VxLR1LdLNo=;
	b=rlXqHXCXrywJLYlEPP6fZK+mlMCArRUhcP8pTJ1Hz2JNblQy1m2aVlvCRSw47ls1SMpq
	 x7IKapCZIq/83SuXz4CXvRnSdHHVQu01euocMlr8Wvclc5lnA6Md9YCDRg/K4FQrpWAH5
	 SRxlF8iLpV3Z6HFi7OIl7tseLJvNIKI48FwCoV9ZGKIUcu9SMNBI7rRhvPkmBAg7/5DBT
	 A7CLQ0GB2YpSD3SNPKq79CDIZMKiXGYtbqgonFVS99aGAxn2z0d53RmeNbwtZXR9rJnVz
	 aHV2QDaU9m2zNyzchX62rsvVmtuKmaPJSnH7bHG/tHRH+VmwubWApo/FeTjVtBVXWxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=hA3qNRWd;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128C606A321
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 12:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5128C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=hA3qNRWd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1794572853; x=1794832053;
	bh=Pdfq1SwYpORYmsHq2kMlXIBTfvuU5U4Y7VxLR1LdLNo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hA3qNRWdLB4cUw7oy9Gk1p0GTKC+W/jw2+Q/VcWhXJjJ81Lnq8ulVeTdznrBHAv1w
	 LkGh64OCiqDMIi/bwUA5tPIlOcQjBNTx0c/t5eZcWl69BP2xwzKT0WQ5OXuEixuYGa
	 Aiu/15TlgoDJacOp7n+1FA1tj0ulfd5ZuHeOIKwkTLk0DJeYqaBssTRxAEz9kZcmT/
	 run3BGemwX98nmrI3CFFOMwzI42XwqRVKuZMeFm0Czwn+tu5W3gGBJUqlPLRgeLMJa
	 7vtzO6Iovs2jORA/9rOj+Xf3jXIdCbJXy5H6DLZrmRdzTwfGATDy5jHzbvh64dHq43
	 hBrh0nx+mEqiQ==
Date: Fri, 13 Nov 2026 12:27:30 +0000
To: roderick.colenbrander@sony.com
From: Macauley Lim <macauley.lim@pm.me>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, Macauley Lim <macauley.lim@pm.me>
Subject: [RFC PATCH] HID: playstation: Ignore Bluetooth input reports with interleaved microphone data
Message-ID: <20261113122528.1348736-1-macauley.lim@pm.me>
Feedback-ID: 31200587:user:proton
X-Pm-Message-ID: 839a09d3409076332dacbbde62f66e882c91c889
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When userspace streams audio to a DualSense over Bluetooth through
hidraw, the controller interleaves microphone data into its 0x31
input reports. They share the report ID and size of normal gamepad
reports but not their layout, so the driver reports bogus stick and
button state while audio is active.

Reports carrying microphone data have bit 1 of data[1] set; gamepad
reports have it clear. Skip them after the CRC check. Behaviour is
unchanged when no audio is streamed.

Signed-off-by: Macauley Lim <macauley.lim@pm.me>
---

Hi Roderick,

I have been working on streaming audio to a DualSense over Bluetooth
from a userspace daemon through hidraw, as you suggested in
<https://lore.kernel.org/lkml/CAEc3jaAm4gws8drVKvQGYHoAT4fb5i7sSPJ0LFiSGHaV=
AzKZnA@mail.gmail.com/>.

When the microphone is on, the controller interleaves mic data into its
0x31 input reports, and the driver parses it as gamepad state, which
causes random sticks and buttons to be reported.

On my hardware, the reports carrying mic data have bit 1 of data[1] set
and normal gamepad reports don't. This patch drops them. In my testing
the gamepad keeps working normally through hid-playstation while
userspace streams audio.

Is that bit documented, and is dropping the reports the right approach
given that Sony is looking at Bluetooth audio
<https://lore.kernel.org/lkml/CAEc3jaBkyPgnWjkZX6XjT6YKn4sAmHpOrtwp_+UMruS-=
hwUz_Q@mail.gmail.com/>?

Thanks,
Macauley

 drivers/hid/hid-playstation.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index f9dc9378c..31d965d3a 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -82,6 +82,8 @@ struct ps_led_info {
 #define DS_INPUT_REPORT_USB_SIZE=09=0964
 #define DS_INPUT_REPORT_BT=09=09=090x31
 #define DS_INPUT_REPORT_BT_SIZE=09=09=0978
+/* Set in data[1] of a BT input report that carries interleaved microphone=
 data. */
+#define DS_INPUT_REPORT_BT_AUDIO=09=09BIT(1)
 #define DS_OUTPUT_REPORT_USB=09=09=090x02
 #define DS_OUTPUT_REPORT_USB_SIZE=09=0963
 #define DS_OUTPUT_REPORT_BT=09=09=090x31
@@ -1463,6 +1465,15 @@ static int dualsense_parse_report(struct ps_device *=
ps_dev, struct hid_report *r
 =09=09=09return -EILSEQ;
 =09=09}
=20
+=09=09/*
+=09=09 * While a userspace driver streams audio, the controller
+=09=09 * interleaves microphone data into its input reports. It does
+=09=09 * not use the gamepad layout, so skip it rather than report
+=09=09 * bogus stick and button state.
+=09=09 */
+=09=09if (data[1] & DS_INPUT_REPORT_BT_AUDIO)
+=09=09=09return 0;
+
 =09=09ds_report =3D (struct dualsense_input_report *)&data[2];
 =09} else {
 =09=09hid_err(hdev, "Unhandled reportID=3D%d\n", report->id);
--=20
2.53.0



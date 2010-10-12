From: =?UTF-8?B?RnJhbsOnb2lzIEphb3Vlbg==?= <francois.jaouen@laposte.net>
Subject: Re: [PATCH] Add Cando touch screen 15.6-inch product id with Signed-off-by
Date: Tue, 12 Oct 2010 21:02:43 +0200
Message-ID: <4CB4B0D3.5010104@laposte.net>
References: <1286642783.5459.36.camel@francois-laptop> <1286697999.1643.4.camel@francois-laptop> <alpine.LNX.2.00.1010121424280.6879@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp28.orange.fr ([80.12.242.100]:7701 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758055Ab0JLTCq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 15:02:46 -0400
In-Reply-To: <alpine.LNX.2.00.1010121424280.6879@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, "francois.jaouen@softeam.fr" <francois.jaouen@softeam.fr>

  Le 12/10/2010 14:25, Jiri Kosina a =C3=A9crit :
> On Sun, 10 Oct 2010, fran=C3=A7ois Jaouen wrote:
>
>> This add the product id of the touch screen found on ACER Aspire 573=
8PZ.
>> Works with hid-cando driver.
>> Added Signed-off-by tag.
> Hi Francois,
>
> thanks for the patch. However, it is damaged (line-wrapped). Could yo=
u
> please instruct your mail client not to damage it, and resend?
> (in the worst case, please send it as attachment).
>
> Thanks,
Hi Jiri

I'm confused about the patch format. Hope this one will be better.

This add the product id of the touch screen found on ACER Aspire 5738PZ=
=2E
Works with hid-cando driver.
Signed-off-by: Francois Jaouen<francois.jaouen@laposte.net>

---

  drivers/hid/hid-cando.c |    2 ++
  drivers/hid/hid-core.c  |    1 +
  drivers/hid/hid-ids.h   |    3 ++-
  3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-cando.c b/drivers/hid/hid-cando.c
index 4267a6f..ab231cd 100644
--- a/drivers/hid/hid-cando.c
+++ b/drivers/hid/hid-cando.c
@@ -237,6 +237,8 @@ static const struct hid_device_id cando_devices[] =3D=
 {
  			USB_DEVICE_ID_CANDO_MULTI_TOUCH) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
  			USB_DEVICE_ID_CANDO_MULTI_TOUCH_11_6) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
+			USB_DEVICE_ID_CANDO_MULTI_TOUCH_15_6) },
  	{ }
  };
  MODULE_DEVICE_TABLE(hid, cando_devices);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3f72924..a0dea3d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1292,6 +1292,7 @@ static const struct hid_device_id hid_blacklist[]=
 =3D {
  	{ HID_USB_DEVICE(USB_VENDOR_ID_BTC, USB_DEVICE_ID_BTC_EMPREX_REMOTE_=
2) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_MULTI_TOUC=
H) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_MULTI_TOUC=
H_11_6) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CANDO_MULTI_TOUCH=
_15_6) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION=
) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION=
_SOLAR) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_TACTIC=
AL_PAD) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 765a4f5..3d46d9f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -133,7 +133,8 @@

  #define USB_VENDOR_ID_CANDO		0x2087
  #define USB_DEVICE_ID_CANDO_MULTI_TOUCH	0x0a01
-#define USB_DEVICE_ID_CANDO_MULTI_TOUCH_11_6 0x0b03
+#define USB_DEVICE_ID_CANDO_MULTI_TOUCH_11_6	0x0b03
+#define USB_DEVICE_ID_CANDO_MULTI_TOUCH_15_6	0x0f01

  #define USB_VENDOR_ID_CH		0x068e
  #define USB_DEVICE_ID_CH_PRO_PEDALS	0x00f2
--=20
1.7.0.4



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

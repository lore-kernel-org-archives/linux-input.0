From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: add USB_HID dependency
Date: Fri, 28 Jul 2017 07:07:51 -0700
Message-ID: <6C9C978F-447D-42A5-9245-894577F2944D@gmail.com>
References: <20170728131826.180483-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32922 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbdG1OH5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Jul 2017 10:07:57 -0400
In-Reply-To: <20170728131826.180483-1-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>
Cc: Jason Gerecke <jason.gerecke@wacom.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On July 28, 2017 6:18:00 AM PDT, Arnd Bergmann <arnd@arndb=2Ede> wrote:
>The driver has gained a compile-time dependency that we should
>express in Kconfig to avoid this link error:
>

Would conditional compilation be an acceptable alternative to adding a dep=
endency? The USB_HID code is only used to check if the driver is working wi=
th a USB device=2E With USB_HID disabled, there's no need for the check so =
there's no need for the dependency=2E

>drivers/hid/wacom_sys=2Eo: In function `wacom_parse_and_register':
>wacom_sys=2Ec:(=2Etext+0x2eec): undefined reference to `usb_hid_driver'
>
>Fixes: 09dc28acaec7 ("HID: wacom: Improve generic name generation")
>Signed-off-by: Arnd Bergmann <arnd@arndb=2Ede>
>---
> drivers/hid/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>index 3cd60f460b61=2E=2E0a3117cc29e7 100644
>--- a/drivers/hid/Kconfig
>+++ b/drivers/hid/Kconfig
>@@ -924,7 +924,7 @@ config HID_UDRAW_PS3
>=20
> config HID_WACOM
> 	tristate "Wacom Intuos/Graphire tablet support (USB)"
>-	depends on HID
>+	depends on USB_HID
> 	select POWER_SUPPLY
> 	select NEW_LEDS
> 	select LEDS_CLASS


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

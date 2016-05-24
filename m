From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Subject: ELAN i2c touchpad fail on warm reboot
Date: Tue, 24 May 2016 18:20:13 -0400
Message-ID: <CA+A7VXUK7vP1Bor7hyY7Rg+pKE_d2j9ozXbnHksLLxMutv77Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34629 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbcEXWUx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2016 18:20:53 -0400
Received: by mail-yw0-f174.google.com with SMTP id c127so30531906ywb.1
        for <linux-input@vger.kernel.org>; Tue, 24 May 2016 15:20:53 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Duson Lin <dusonlin@emc.com.tw>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, chiu@endlessm.com, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>, linux@endlessm.com

ELAN touchpads connected via i2c do not work correctly on a warm
reboot from a system that does not fully support them into linux
mainline. This is a somewhat esoteric bug, but it affects factory
production lines where a machine first boots some kind of flashing
tool / installer (which does not have proper support for this
touchpad) and then reboots into the installed system to run a factory
test procedure.

To reproduce it one needs a modified kernel where the touchpad is
driven by i2c_hid, so removing the ACPI HW id from
drivers/input/mouse/elan_i2c_core.c and removing the
USB_VENDOR_ID_ELAN entries from hid_ignore_list[] in
drivers/hid/hid-core.c should be enough. Then doing a warm reboot from
this modified kernel into mainline prevents the touchpad from working
at all, and dmesg gets flooded with these messages:

elan_i2c i2c-ELAN1000:00: invalid report id data (1)

Any ideas are welcome, and I can provide more data / run tests if neede=
d.

This has been seen on the Asus E202SA, N552VW and X456UF.

Thanks and regards,

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

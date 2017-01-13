From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - make F03 a tristate symbol
Date: Fri, 13 Jan 2017 13:15:13 -0800
Message-ID: <D8CE35BE-2576-4F01-955A-BA118114BF2F@gmail.com>
References: <20170110121718.2992211-1-arnd@arndb.de> <20170113062203.GD22630@dtor-ws> <3051252.9A92ba0o10@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3051252.9A92ba0o10@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On January 13, 2017 1:06:12 PM PST, Arnd Bergmann <arnd@arndb=2Ede> wrote:
>On Thursday, January 12, 2017 10:22:03 PM CET Dmitry Torokhov wrote:
>> As it was explained townthread we can't [currently] make functions
>> modules, in the meantime I have
>d7ddad0acc4add42567f7879b116a0b9eea31860
>> that should fix this issue (and I just sent pull request for it)=2E
>
>On today's linux-next (which includes d7ddad0acc4ad), I was still
>getting this warning :
>
>warning: (HID_RMI) selects RMI4_F03 which has unmet direct dependencies
>(!UML && INPUT && RMI4_CORE && (SERIO=3Dy || RMI4_CORE=3DSERIO))

Ah, yes, that's new hid RMI code=2E=2E


>
>This is my fixup, though I'm not too happy with that version=2E
>   =20
>Signed-off-by: Arnd Bergmann <arnd@arndb=2Ede>
>
>diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>index 1aeb80e52424=2E=2E3927259a5d5d 100644
>--- a/drivers/hid/Kconfig
>+++ b/drivers/hid/Kconfig
>@@ -785,7 +785,8 @@ config HID_SUNPLUS
> config HID_RMI
> 	tristate "Synaptics RMI4 device support"
> 	depends on HID
>-	select RMI4_CORE
>+	depends on SERIO && RMI4_CORE
>+	depends on SERIO=3Dy || RMI4_CORE=3DSERIO

Shouldn't this be simply

select SERIO # needed for F03

?

> 	select RMI4_F03
> 	select RMI4_F11
> 	select RMI4_F12


Thanks=2E

--=20
Dmitry

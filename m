From: "Przemo Firszt" <przemo@firszt.eu>
Subject: Re: [PATCH -next] hid: fix WACOM Kconfig warning
Date: Thu, 29 Mar 2012 17:21:53 +0100
Message-ID: <9da9c271a7fa887aaa66821a49534a53.squirrel@webmail.firszt.eu>
References: <20120329144217.6cacd2f040fa9abb9190ae1e@canb.auug.org.au>
    <4F748B5B.9010104@xenotime.net>
Reply-To: przemo@firszt.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:35121 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751845Ab2C2QV7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 12:21:59 -0400
In-Reply-To: <4F748B5B.9010104@xenotime.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org


Dnia 29 Marca 2012, 5:18 pm, Cz, Randy Dunlap napisa=B3(a):
> From: Randy Dunlap <rdunlap@xenotime.net>
>
> Fix hid Kconfig warning:
>
> drivers/hid/Kconfig:595:error: recursive dependency detected!
> drivers/hid/Kconfig:595:	symbol HID_WACOM depends on HID_WACOM
>
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  drivers/hid/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
>
> --- linux-next-20120329.orig/drivers/hid/Kconfig
> +++ linux-next-20120329/drivers/hid/Kconfig
> @@ -595,7 +595,6 @@ config THRUSTMASTER_FF
>  config HID_WACOM
>  	tristate "Wacom Bluetooth devices support"
>  	depends on BT_HIDP
> -	depends on HID_WACOM
>  	select POWER_SUPPLY
>  	---help---
>  	Support for Wacom Graphire Bluetooth and Intuos4 WL tablets.
> --
Thanks!

http://article.gmane.org/gmane.linux.kernel.input/24250

--=20
Regards,
Przemo Firszt

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

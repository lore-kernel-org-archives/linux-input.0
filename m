From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] USB: quirks: Fix another ELAN touchscreen
Date: Mon, 23 Nov 2015 15:52:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511231551330.20111@pobox.suse.cz>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40557 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbbKWOw0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2015 09:52:26 -0500
In-Reply-To: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Adrien_Verg=E9?= <adrienverge@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Macpaul Lin <macpaul@gmail.com>, Vincent Palatin <vpalatin@chromium.org>, Logan Gunthorpe <logang@deltatee.com>, Hans de Goede <hdegoede@redhat.com>, Yao-Wen Mao <yaowen@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Sat, 21 Nov 2015, Adrien Verg=C3=A9 wrote:

> Like other buggy models that had their fixes [1], the touchscreen wit=
h
> id 04f3:21b8 from ELAN Microelectronics needs the device-qualifier
> quirk. Otherwise, it fails to respond, blocks the boot for a random
> amount of time and pollutes dmesg with:
>=20
> [ 2887.373196] usb 1-5: new full-speed USB device number 41 using xhc=
i_hcd
> [ 2889.502000] usb 1-5: unable to read config index 0 descriptor/star=
t: -71
> [ 2889.502005] usb 1-5: can't read configurations, error -71
> [ 2889.654571] usb 1-5: new full-speed USB device number 42 using xhc=
i_hcd
> [ 2891.783438] usb 1-5: unable to read config index 0 descriptor/star=
t: -71
> [ 2891.783443] usb 1-5: can't read configurations, error -71

The drivers/hid part is

	Acked-by: Jiri Kosina <jkosina@suse.cz>

Makes one wonder however whether we shouldn't be applying ALWAYS_POLL t=
o=20
all ELAN devices by default anyway.

> [1]: See commits c68929f, 876af5d, d749947, a32c99e and dc703ec.
>=20
> Tested-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>

You need signoff here as well so that the patch can be applied.

Thanks,

--=20
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

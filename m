From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC PATCH 1/2] Input: add msi-wmi driver to support hotkeys in
 =?utf-8?q?MSI=C2=A0Windtop?= AE1900-WT
Date: Thu, 3 Dec 2009 17:49:07 +0100
Message-ID: <200912031749.08734.trenn@suse.de>
References: <20091202192603.3e1de98a@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:60740 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328AbZLCQtG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2009 11:49:06 -0500
In-Reply-To: <20091202192603.3e1de98a@destiny.ordissimo>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wednesday 02 December 2009 19:26:03 Anisse Astier wrote:
>=20
> Signed-off-by: Anisse Astier <anisse@astier.eu>
> ---
> Hi,
>=20
> This driver (intiated by=20
> http://sysmic.org/dotclear2/index.php?post/2009/06/02/83-msi-wmi-supp=
ort) is
> aimed at supporting WMI based hotkeys on MSI=C2=A0Windtop all-in-one =
AE1900-WT.
I've already submitted a driver together with some other fixes a month =
ago.

My driver not only registers an input device for backlight/volume up, d=
own,
but also registers a backlight driver for software based backlight swit=
ching.

Not sure whether Len already submitted it to he's test branch, I hope s=
o:
http://patchwork.kernel.org/patch/55944/

Would be great if you can give it a try.

Thanks,

    Thomas

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

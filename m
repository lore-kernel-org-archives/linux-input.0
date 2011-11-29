From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Add generic GPIO-tilt driver
Date: Tue, 29 Nov 2011 10:23:26 -0800
Message-ID: <20111129182326.GF4241@core.coreip.homeip.net>
References: <201111291324.34045.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59237 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966Ab1K2SXc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Nov 2011 13:23:32 -0500
Received: by iage36 with SMTP id e36so10964903iag.19
        for <linux-input@vger.kernel.org>; Tue, 29 Nov 2011 10:23:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201111291324.34045.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-input@vger.kernel.org

On Tue, Nov 29, 2011 at 01:24:33PM +0100, Heiko St=FCbner wrote:
> There exist tilt switches that simply report their tilt-state via som=
e gpios.
>=20
> The number and orientation of their axes can vary depending on the sw=
itch
> used and the build of the device. Also two or more one-axis switches
> could be combined to provide multi-dimensional orientation.
>=20
> One example of a device using such a switch is the family of Qisda
> ebook readers, where the switch provides information about the
> landscape / portrait orientation of the device. The example in
> Documentation/input/gpio-tilt.txt documents exactly this one-axis dev=
ice.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes since v2: use module_platform_driver

Could you please separate this change? I applied previous version to my
tree and I am not sure when module_driver changes will hit mainline...

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

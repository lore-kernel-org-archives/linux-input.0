From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Add driver for synaptics keybard with broken
 rdesc
Date: Tue, 27 Jan 2015 11:17:30 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501271116210.10817@pobox.suse.cz>
References: <1422039810-26327-1-git-send-email-linux@simon-woerner.de> <1422039810-26327-2-git-send-email-linux@simon-woerner.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44365 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560AbbA0KRc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 05:17:32 -0500
In-Reply-To: <1422039810-26327-2-git-send-email-linux@simon-woerner.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Simon_W=F6rner?= <linux@simon-woerner.de>
Cc: linux-input@vger.kernel.org, =?ISO-8859-15?Q?Simon_W=F6rner?= <mail@simon-woerner.de>

On Fri, 23 Jan 2015, Simon W=C3=B6rner wrote:

> From: Simon W=C3=B6rner <mail@simon-woerner.de>
>=20

Changelog is missing here.

> Signed-off-by: Simon W=C3=B6rner <mail@simon-woerner.de>
> ---
>  drivers/hid/Kconfig         |   6 ++
>  drivers/hid/Makefile        |   1 +
>  drivers/hid/hid-ids.h       |   1 +
>  drivers/hid/hid-synaptics.c | 190 ++++++++++++++++++++++++++++++++++=
++++++++++
>  4 files changed, 198 insertions(+)
>  create mode 100644 drivers/hid/hid-synaptics.c
[ ... snip ... ]
> +static int synaptics_probe(struct hid_device *hdev,
> +		const struct hid_device_id *id)
> +{
> +	int ret;
> +
> +	ret =3D hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "parse failed\n");
> +		goto err_free;
> +	}
> +
> +	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret) {
> +		hid_err(hdev, "hw start failed\n");
> +		goto err_free;
> +	}
> +
> +	if (ret < 0)
> +		goto err_stop;
> +
> +	return 0;
> +err_stop:
> +	hid_hw_stop(hdev);
> +err_free:

Any particular reason you call this label err_free?

Otherwise it loosk good. Please resend with these two minor things=20
clarified/fixed, and I'll apply it.

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

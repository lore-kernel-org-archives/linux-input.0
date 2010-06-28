From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH 1/2] ir-core: centralize sysfs raw decoder enabling/disabling
Date: Mon, 28 Jun 2010 13:56:16 -0300
Message-ID: <4C28D430.9010305@redhat.com>
References: <20100613202718.6044.29599.stgit@localhost.localdomain> <20100613202930.6044.97940.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9471 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab0F1Q4d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 12:56:33 -0400
In-Reply-To: <20100613202930.6044.97940.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?RGF2aWQgSMOkcmRlbWFu?= <david@hardeman.nu>
Cc: jarod@wilsonet.com, jarod@redhat.com, linux-media@vger.kernel.org, linux-input@vger.kernel.org

Em 13-06-2010 17:29, David H=C3=A4rdeman escreveu:
> With the current logic, each raw decoder needs to add a copy of the e=
xact
> same sysfs code. This is both unnecessary and also means that (re)loa=
ding
> an IR driver after raw decoder modules have been loaded won't work as
> expected.
>=20
> This patch moves that logic into ir-raw-event and adds a single sysfs
> file per device.
>=20
> Reading that file returns something like:
>=20
> 	"rc5 [rc6] nec jvc [sony]"
>=20
> (with enabled protocols in [] brackets)
>=20
> Writing either "+protocol" or "-protocol" to that file will
> enable or disable the according protocol decoder.
>=20
> An additional benefit is that the disabling of a decoder will be
> remembered across module removal/insertion so a previously
> disabled decoder won't suddenly be activated again. The default
> setting is to enable all decoders.
>=20
> This is also necessary for the next patch which moves even more decod=
er
> state into the central raw decoding structs.
>=20
> Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>

> +	if (!strncasecmp(tmp, "unknown", 7)) {
> +		tmp +=3D 7;
> +		mask =3D IR_TYPE_UNKNOWN;
> +	} else if (!strncasecmp(tmp, "rc5", 3)) {
> +		tmp +=3D 3;
> +		mask =3D IR_TYPE_RC5;
> +	} else if (!strncasecmp(tmp, "nec", 3)) {
> +		tmp +=3D 3;
> +		mask =3D IR_TYPE_NEC;
> +	} else if (!strncasecmp(tmp, "rc6", 3)) {
> +		tmp +=3D 3;
> +		mask =3D IR_TYPE_RC6;
> +	} else if (!strncasecmp(tmp, "jvc", 3)) {
> +		tmp +=3D 3;
> +		mask =3D IR_TYPE_JVC;
> +	} else if (!strncasecmp(tmp, "sony", 4)) {
> +		tmp +=3D 4;
> +		mask =3D IR_TYPE_SONY;
> +	} else {
>  		IR_dprintk(1, "Unknown protocol\n");
>  		return -EINVAL;
>  	}

Those "magic" sizes at the strcasecmp are ugly. Also, you didn't send
a patch for the ir-keytable userspace tool (part of v4l-utils.git tree)=
=2E

Also, this allows some undocumented (and problematic) ways to set proto=
cols.=20
=46or example, if someone writes: something like "rc5necjvcsony"
(on this exact order and without spaces), it will accept it as just "so=
ny",
without complaining.

As I found some time during the weekend to add support for the new /pro=
tocols way at
the userspace tool, I'll be applying this patch as-is, plus a few patch=
es after it=20
fixing the problems I found and adding some additional features that wi=
ll be needed,
in order to make userspace stuff easier, like supporting multiple proto=
cols specs
without needing to close/open the sysfs node for each protocol.

Btw, we should start writing some docs about the sysfs interface at the=
 media
specs (at Documentation/DocBoook).

Cheers,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

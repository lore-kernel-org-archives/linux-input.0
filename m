From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 15/15] V4L/DVB: input: Add support for
 EVIO[CS]GKEYCODEBIG
Date: Sat, 24 Apr 2010 11:09:34 +0200
Message-ID: <20100424090934.GB2668@hardeman.nu>
References: <cover.1270142346.git.mchehab@redhat.com>
 <20100401145631.7a708a06@pedra>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:47331 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab0DXJJi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Apr 2010 05:09:38 -0400
Content-Disposition: inline
In-Reply-To: <20100401145631.7a708a06@pedra>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: linux-input@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>

On Thu, Apr 01, 2010 at 02:56:31PM -0300, Mauro Carvalho Chehab wrote:
> Several devices use a high number of bits for scancodes. One importan=
t
> group is the Remote Controllers. Some new protocols like RC-6 define =
a
> scancode space of 64 bits.
>=20
> The current EVIO[CS]GKEYCODE ioctls allow replace the scancode/keycod=
e
> translation tables, but it is limited to up to 32 bits for scancode.
>=20
> Also, if userspace wants to clean the existing table, replacing it by
> a new one, it needs to run a loop calling the old ioctls, over the
> entire sparsed scancode userspace.
>=20
> To solve those problems, this patch introduces two new ioctls:
> 	EVIOCGKEYCODEBIG - reads a scancode from the translation table;
> 	EVIOSGKEYCODEBIG - writes a scancode into the translation table.
=2E..
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 663208a..6445fc9 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -34,7 +34,7 @@ struct input_event {
>   * Protocol version.
>   */
> =20
> -#define EV_VERSION		0x010000
> +#define EV_VERSION		0x010001
> =20
>  /*
>   * IOCTLs (0x00 - 0x7f)
> @@ -56,12 +56,22 @@ struct input_absinfo {
>  	__s32 resolution;
>  };
> =20
> +struct keycode_table_entry {
> +	__u32 keycode;		/* e.g. KEY_A */
> +	__u32 index;            /* Index for the given scan/key table, on E=
VIOCGKEYCODEBIG */
> +	__u32 len;		/* Length of the scancode */
> +	__u32 reserved[2];	/* Reserved for future usage */
> +	char *scancode;		/* scancode, in machine-endian */
> +};

Wouldn't changing the scancode member from a pointer to a flexible arra=
y=20
member (C99 feature, which I assume is ok since other C99 features are=20
already in use in the kernel code) remove the need for any compat32=20
code?

struct keycode_table_entry {
	__u32 keycode;
	__u32 index;
	__u32 len;
	__u32 reserved[2];
	char scancode[];
};

--=20
David H=E4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

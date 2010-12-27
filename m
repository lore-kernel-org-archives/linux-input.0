From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 1/3] HID: picolcd: fix misuse of logical operation in
 place of bitop
Date: Mon, 27 Dec 2010 22:47:58 +0100
Message-ID: <20101227224758.79f0f3c5@neptune.home>
References: <1293463663-21198-1-git-send-email-dsterba@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1293463663-21198-1-git-send-email-dsterba@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: David Sterba <dsterba@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Thanks for spotting,

Acked-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

On Mon, 27 December 2010 David Sterba <dsterba@suse.cz> wrote:
> CC: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> CC: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: David Sterba <dsterba@suse.cz>
> ---
>  drivers/hid/hid-picolcd.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
> index bc2e077..0aff3cd 100644
> --- a/drivers/hid/hid-picolcd.c
> +++ b/drivers/hid/hid-picolcd.c
> @@ -1544,7 +1544,7 @@ static ssize_t picolcd_debug_eeprom_read(struct=
 file *f, char __user *u,
> =20
>  	/* prepare buffer with info about what we want to read (addr & len)=
 */
>  	raw_data[0] =3D *off & 0xff;
> -	raw_data[1] =3D (*off >> 8) && 0xff;
> +	raw_data[1] =3D (*off >> 8) & 0xff;
>  	raw_data[2] =3D s < 20 ? s : 20;
>  	if (*off + raw_data[2] > 0xff)
>  		raw_data[2] =3D 0x100 - *off;
> @@ -1583,7 +1583,7 @@ static ssize_t picolcd_debug_eeprom_write(struc=
t file *f, const char __user *u,
> =20
>  	memset(raw_data, 0, sizeof(raw_data));
>  	raw_data[0] =3D *off & 0xff;
> -	raw_data[1] =3D (*off >> 8) && 0xff;
> +	raw_data[1] =3D (*off >> 8) & 0xff;
>  	raw_data[2] =3D s < 20 ? s : 20;
>  	if (*off + raw_data[2] > 0xff)
>  		raw_data[2] =3D 0x100 - *off;

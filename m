From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH] Actual code fixing Sixaxis
Date: Tue, 27 Apr 2010 11:41:26 +0200
Message-ID: <20100427114126.4b32ade4.ospite@studenti.unina.it>
References: <1272318628.3269.44.camel@zony.bied.prout.be>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__27_Apr_2010_11_41_27_+0200_Gi4s6M0JDfSkx/.D"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1272318628.3269.44.camel-RYtM5sHUr3p6PoLMcel1OJkigfUh6rMo@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org
List-Id: linux-input@vger.kernel.org

--Signature=_Tue__27_Apr_2010_11_41_27_+0200_Gi4s6M0JDfSkx/.D
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Apr 2010 22:50:28 +0100
Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Add change descriptor bit(works on any usb/bt device)
>  Make use of physical minimum and maximum while reporting values to users=
pace
>  Add mini howto comment next to replace hid code
>  Assume physical maximum is always signed allowing inverting axes by givi=
ng max < min
>  Swap a few bits in Sixaxis report as they have wrong(hid-wise) endianess
>  Sixaxis specific changes

Hi Marcin,

You might want to send separate patches for hid-core and hid-sony
changes next time. Plus, composing a cover letter that briefly explains
the what and why of your approach could make people more interested as
well. A catchy title like "Overriding HID descriptors" would flash more
than a mere reference to Sixaxis.

About sixaxis, this approach of HID descriptor overriding looks neat,
elegant and way better of what we have now, I am just wondering if it
allows leds/rumble/charging-management support or if a hid driver would
still be needed for those.

Thanks for your work on this, I'll test it once I sort out the
sixaxis cable association problem.
A very brief review follows inlined (mostly syntax remarks).

Regards,
   Antonio

>   and the most important bit modified HID descriptor:
>  05 01 09 04 A1 01 09 04 A1 02 85 01 75 08 95 01 80 05 09 75 01 95 04
>  14 25 01 09 0C 09 0A 09 09 09 0B 81 02 05 01 09 01 A1 02 75 01 14 25
>  01 95 04 09 90 09 92 09 91 09 93 81 02 C0 05 09 95 09 09 08 09 07 09
>  06 09 05 09 04 09 02 09 01 09 03 09 0D 81 02 75 01 95 0F 80 14 26 FF
>  00 35 80 45 7F 05 01 09 01 75 08 95 02 A0 09 30 09 31 81 02 C0 09 05
>  A0 09 32 09 33 81 02 C0 75 08 95 04 80 75 08 95 0C 09 46 34 44 81 02
>  75 08 95 0F 80 75 10 95 01 16 80 01 26 7F 02 45 80 35 7F 09 33 81 02
>  35 80 45 7F 09 34 81 02 95 02 14 26 00 04 36 01 FE 46 00 02 09 35 09
>  36 81 02 14 26 FF 00 34 46 FF 00 75 08 95 30 91 02 75 08 95 30 B1 02
>  C0 A1 02 85 02 75 08 95 30 B1 02 C0 A1 02 85 EE 75 08 95 30 B1 02 C0
>  A1 02 85 EF 75 08 95 30 B1 02 C0 C0
>   convert it into binary using eg. hex2bin.sh and save to
>    /lib/firmware/hid/0003:054C:0268:0111.bin
>=20
> The two attachments are descriptor as .h file and in my own smart(I have =
a compiler written in Haskel form/to this format and it could possibly be r=
eleased under GPL).=20
> The descriptor is functional but it could be made better... the accelerom=
eters work fine.=20
> PS. as soon as BT(standard) will start working it will be sufficient to p=
rovide fixed HID description.
>

Commit messages are usually wrapped to 72/80 chars.
Annotations and stuff not strictly meant for the commit message
usually go between the --- separator and the diffstat output.

>  Signed-off-by: Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/hid/hid-core.c |   67 ++++++++++++++++++++++++++++++++++++++++++=
+----
>  drivers/hid/hid-sony.c |   19 +++++++++++++
>  2 files changed, 80 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 2e2aa75..bb40a19 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -27,6 +27,7 @@
>  #include <linux/wait.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched.h>
> +#include <linux/firmware.h>
> =20
>  #include <linux/hid.h>
>  #include <linux/hiddev.h>
> @@ -333,10 +334,8 @@ static int hid_parser_global(struct hid_parser *pars=
er, struct hid_item *item)
>  		return 0;
> =20
>  	case HID_GLOBAL_ITEM_TAG_PHYSICAL_MAXIMUM:
> -		if (parser->global.physical_minimum < 0)
> -			parser->global.physical_maximum =3D item_sdata(item);
> -		else
> -			parser->global.physical_maximum =3D item_udata(item);
> +	/* always signed value, if it is less then minimum we need to invert ax=
is */
> +		parser->global.physical_maximum =3D item_sdata(item);
>  		return 0;

maybe you can indent this comment by one more level and put it on two
lines if it's too long.

> =20
>  	case HID_GLOBAL_ITEM_TAG_UNIT_EXPONENT:
> @@ -642,6 +641,10 @@ int hid_parse_report(struct hid_device *device, __u8=
 *start,
>  	struct hid_item item;
>  	__u8 *end;
>  	int ret;
> +	const struct firmware *fw;
> +	int fw_fail;
> +	const char *file;
> +
>  	static int (*dispatch_type[])(struct hid_parser *parser,
>  				      struct hid_item *item) =3D {
>  		hid_parser_main,
> @@ -652,10 +655,39 @@ int hid_parse_report(struct hid_device *device, __u=
8 *start,
> =20
>  	if (device->driver->report_fixup)
>  		device->driver->report_fixup(device, start, size);
> +	/* Now try to load a hid descriptor from a file firmware
> +	if succesful ignoring this fixup thing */
> +   /*
> +  Mini howto: fixing the descriptor:
> +  1) dump it from /debug/hid/!!device!!/rdesc
> +  2) copy 1st line &edit it
> +  3) convert to bin eg. cat descriptor.txt | hex2bin.sh > descriptor.bin
> +
> +----hex2bin.sh
> +#!/bin/bash
> +echo -n -e $(tr -d '[:space:]' | sed 's/../\\x&/g')
> +4) place in /lib/firmware/hid/... where the location is provided by kern=
.log
> +*/

Watch out indentation here too, and if this feature needs some more
explanation you might want to consider adding a file under
Documentation/ and refer to that in the comment.

> +	file =3D kasprintf(GFP_KERNEL, "hid/%04X:%04X:%04X:%04X.bin",
> +			device->bus, device->vendor, device->product, device->version);
> +

maybe the name 'file' might me something like 'newdesc_file', but you
choose here, take it just as a loose suggestion.

> +	fw_fail =3D request_firmware(&fw, file, &device->dev);
> +
> +	if (fw_fail)
> +		pr_info("To relace HID descriptor place it in /lib/firmaware/%s\n", fi=
le);
> +	else{

space after the else and IIRC when the else block needs parentheses the
convention is to put them to the if block as well, even if it is only
one line.

> +		start =3D fw->data;
> +		size =3D fw->size;
> +		pr_info("HID descriptor relaced with /lib/firmaware/%s\n", file);
> +	}
> +	kfree(file);
> =20
>  	device->rdesc =3D kmalloc(size, GFP_KERNEL);
> -	if (device->rdesc =3D=3D NULL)
> +	if (device->rdesc =3D=3D NULL) {
> +		if (!fw_fail)
> +			release_firmware(fw);
>  		return -ENOMEM;
> +	}
>  	memcpy(device->rdesc, start, size);
>  	device->rsize =3D size;
> =20
> @@ -692,6 +724,8 @@ int hid_parse_report(struct hid_device *device, __u8 =
*start,
>  				dbg_hid("unbalanced delimiter at end of report description\n");
>  				goto err;
>  			}
> +			if (!fw_fail)
> +				release_firmware(fw);
>  			vfree(parser);
>  			return 0;
>  		}
> @@ -699,6 +733,8 @@ int hid_parse_report(struct hid_device *device, __u8 =
*start,
> =20
>  	dbg_hid("item fetching failed at offset %d\n", (int)(end - start));
>  err:
> +	if (!fw_fail)
> +		release_firmware(fw);
>  	vfree(parser);
>  	return ret;
>  }
> @@ -878,6 +914,25 @@ static void hid_process_event(struct hid_device *hid=
, struct hid_field *field,
>  }
> =20
>  /*
> + * Translate values from logical to physical, exponent is still missing.
> + */
> +static __s32 convert_to_physical(__s32 x, struct hid_field *field)
> +{
> +	__s32 min =3D field->logical_minimum;
> +	__s32 max =3D field->logical_maximum;
> +	__s32 pmin =3D field->physical_minimum;
> +	__s32 pmax =3D field->physical_maximum;
> +/*	__s32 uexp =3D field->unit_exponent; need to find a way how to use it=
 */
> +
> +	if ((pmin =3D=3D pmax) /* would give pmin and covers the case =3D=3D0 */
> +	 || (pmin =3D=3D min && pmax =3D=3D max) /* would do nothing */
> +	 || (min =3D=3D max)) /* would be div by 0 */
> +		return x;
> +	else
> +		return (pmax - pmin)*(x - min) / (max - min) + pmin;

spaces around the '*'?

> +}
> +
> +/*
>   * Analyse a received field, and fetch the data from it. The field
>   * content is stored for next report processing (we do differential
>   * reporting to the layer).
> @@ -911,7 +966,7 @@ static void hid_input_field(struct hid_device *hid, s=
truct hid_field *field,
>  	for (n =3D 0; n < count; n++) {
> =20
>  		if (HID_MAIN_ITEM_VARIABLE & field->flags) {
> -			hid_process_event(hid, field, &field->usage[n], value[n], interrupt);
> +			hid_process_event(hid, field, &field->usage[n], convert_to_physical(v=
alue[n], field), interrupt);
>  			continue;
>  		}
> =20
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 7502a4b..3e094e4 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -45,6 +45,24 @@ static void sony_report_fixup(struct hid_device *hdev,=
 __u8 *rdesc,
>  }
> =20
>  /*
> + * There is a few bits that has to be shifted around to make this report=
 more compatibile with
> + * HID standard descriptions, and we want it to be parsable by standard =
driver
> + */
> +static int sony_raw_event(struct hid_device *hdev, struct hid_report *re=
port, __u8 *rd, int size)
> +{
> + /* for sixaxis connected via usb. */
> +	if (rd[0] =3D=3D 0x01 && size =3D=3D 49) {
> +		swap(rd[41], rd[42]);
> +		swap(rd[43], rd[44]);
> +		swap(rd[45], rd[46]);
> +		swap(rd[47], rd[48]);
> +	}
> +
> +return 0;
> +}
> +
> +
> +/*
>   * Sending HID_REQ_GET_REPORT changes the operation mode of the ps3 cont=
roller
>   * to "operational".  Without this, the ps3 controller will not report a=
ny
>   * events.
> @@ -151,6 +169,7 @@ static struct hid_driver sony_driver =3D {
>  	.probe =3D sony_probe,
>  	.remove =3D sony_remove,
>  	.report_fixup =3D sony_report_fixup,
> +	.raw_event =3D sony_raw_event,
>  };
> =20
>  static int __init sony_init(void)
> --=20
> 1.7.0.5
>=20
>=20


--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Tue__27_Apr_2010_11_41_27_+0200_Gi4s6M0JDfSkx/.D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvWsUcACgkQ5xr2akVTsAHFxwCgrzkLTsfXKYxulbCACAk1GmUo
5HsAnRfThAtFJwD4aYxabN93+sAckfoL
=6HMz
-----END PGP SIGNATURE-----

--Signature=_Tue__27_Apr_2010_11_41_27_+0200_Gi4s6M0JDfSkx/.D--

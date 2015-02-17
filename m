From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/4] HID: Identify Logitech gaming wheels in compatibility
 modes accordingly to Logitech specifications
Date: Tue, 17 Feb 2015 13:12:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502171311160.2279@pobox.suse.cz>
References: <1423240486-6714-1-git-send-email-madcatxster@devoid-pointer.net> <1423240486-6714-2-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423240486-6714-2-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org, elias.vds@gmail.com
List-Id: linux-input@vger.kernel.org

On Fri, 6 Feb 2015, Michal Mal=C3=BD wrote:

> Identify Logitech gaming wheels in compatibility modes accordingly to=
 Logitech
> specifications.
>=20
> Logitech specification contains a general method of identifying vario=
us
> models of their gaming wheels while they are in "compatibility" mode.
> This patch implements the method instead of checking against known
> values of bcdDevice. Handling of the mode switch upon initialization =
is
> also adjusted so that the driver does not have to go through the enti=
re
> initialization routine because the wheels are set to perform a USB
> detach before they reappear in "native" mode.
>=20
> Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>=20
[ ... snip ...=20
> +u16 lg4ff_identify_multimode_wheel(struct hid_device *hid, const u16=
 reported_product_id, const u16 bcdDevice)

This should be static.

> +{
> +	const struct lg4ff_wheel_ident_checklist *checklist;
> +	int i, from_idx, to_idx;
> +
> +	switch (reported_product_id) {
> +	case USB_DEVICE_ID_LOGITECH_WHEEL:
> +	case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
> +		checklist =3D &lg4ff_main_checklist;
> +		from_idx =3D 0;
> +		to_idx =3D checklist->count - 1;
> +		break;
> +	case USB_DEVICE_ID_LOGITECH_G25_WHEEL:
> +		checklist =3D &lg4ff_main_checklist;
> +		from_idx =3D 0;
> +		to_idx =3D checklist->count - 2; /* End identity check at G25 */
> +		break;
> +	case USB_DEVICE_ID_LOGITECH_G27_WHEEL:
> +		checklist =3D &lg4ff_main_checklist;
> +		from_idx =3D 1; /* Start identity check at G27 */
> +		to_idx =3D checklist->count - 3; /* End identity check at G27 */
> +		break;
> +	case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
> +		checklist =3D &lg4ff_main_checklist;
> +		from_idx =3D 0;
> +		to_idx =3D checklist->count - 4; /* End identity check at DFGT */
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	for (i =3D from_idx; i <=3D to_idx; i++) {
> +		const u16 mask =3D checklist->models[i]->mask;
> +		const u16 result =3D checklist->models[i]->result;
> +		const u16 real_product_id =3D checklist->models[i]->real_product_i=
d;
> +
> +		if ((bcdDevice & mask) =3D=3D result) {
> +			dbg_hid("Found wheel with real PID %X whose reported PID is %X\n"=
, real_product_id, reported_product_id);
> +			return real_product_id;
> +		}
> +	}
> +
> +	/* No match found. This is an unknown wheel model, do not touch it =
*/
> +	dbg_hid("Wheel with bcdDevice %X was not recognized as multimode wh=
eel, leaving in its current mode\n", bcdDevice);
> +	return 0;
> +}
> +
> +int lg4ff_handle_multimode_wheel(struct hid_device *hid, u16 *real_p=
roduct_id, const u16 bcdDevice)

And this as well.

Otherwise the patchset looks good, please resend with these major thing=
s=20
fixed and I'll apply it.

Thanks,

--=20
Jiri Kosina
SUSE Labs

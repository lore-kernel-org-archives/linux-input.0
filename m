From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 6/7] HID: picoLCD: disable version check during probe
Date: Wed, 15 Aug 2012 10:15:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208151015220.7026@pobox.suse.cz>
References: <20120730213656.0a9f6d30@neptune.home> <20120730213859.063173c1@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120730213859.063173c1@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 30 Jul 2012, Bruno Pr=C3=A9mont wrote:

> Commit 4ea5454203d991ec85264f64f89ca8855fce69b0
> [HID: Fix race condition between driver core and ll-driver] introduce=
d
> new locking around proce/remove functions that prevent any report/rep=
ly
> from hardware to reach driver until it returned from probe.
>=20
> As such, the ask-reply way to checking picoLCD firmware version durin=
g
> probe is bound to timeout and let probe fail.
>=20
> Disabling the check lets driver sucessfully probe again.
>=20
> Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> ---
>  drivers/hid/hid-picolcd_core.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd=
_core.c
> index 2d7ef68..42d0791 100644
> --- a/drivers/hid/hid-picolcd_core.c
> +++ b/drivers/hid/hid-picolcd_core.c
> @@ -478,13 +478,13 @@ static int picolcd_probe_lcd(struct hid_device =
*hdev, struct picolcd_data *data)
>  {
>  	int error;
> =20
> -	error =3D picolcd_check_version(hdev);
> +/*	error =3D picolcd_check_version(hdev);
>  	if (error)
>  		return error;
> =20
>  	if (data->version[0] !=3D 0 && data->version[1] !=3D 3)
>  		hid_info(hdev, "Device with untested firmware revision, please sub=
mit /sys/kernel/debug/hid/%s/rdesc for this device.\n",
> -			 dev_name(&hdev->dev));
> +			 dev_name(&hdev->dev)); */

Please just remove it altogether, I don't see a reason to keep the=20
commented-out code in the in-tree driver.

Once the locking mess is sorted out, we can re-introduce it again as=20
necessary.

Thanks.

--=20
Jiri Kosina
SUSE Labs

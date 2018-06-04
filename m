From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH] HID: core: allow concurrent registration of drivers
Date: Mon, 4 Jun 2018 20:37:30 +0000
Message-ID: <4635b69c79704cc3beee5f97d9e739f2@ausx13mpc120.AMER.DELL.COM>
References: <20180531114929.30545-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180531114929.30545-1-benjamin.tissoires@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: benjamin.tissoires@redhat.com, jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Benjamin,

I had to make a minor change since I didn't see
>  #define HID_STAT_DUP_DETECTED	BIT(2)
In Linus's tree.

I tested with master today though and it seems to be working now with your =
patch across
several boot attempts.

Tested-by: Mario Limonciello <mario.limonciello@dell.com>

Thanks,

> -----Original Message-----
> From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> Sent: Thursday, May 31, 2018 6:49 AM
> To: Jiri Kosina; Limonciello, Mario
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Benjamin T=
issoires
> Subject: [PATCH] HID: core: allow concurrent registration of drivers
>=20
> Detected on the Dell XPS 9365.
> The laptop has 2 devices that benefit from the hid-generic auto-unbinding=
.
> When those 2 devices are presented to the userspace, udev loads both
> wacom and hid-multitouch. When this happens, the code in
> __hid_bus_reprobe_drivers() is called concurrently and the second device
> gets reprobed twice.
> An other bug in the power_supply subsystem prevent to remove the wacom
> driver if it just finished its initialization, which basically kills
> the wacom node.
>=20
> Fixes c17a7476e4c4 ("HID: core: rewrite the hid-generic automatic unbind"=
)
>=20
> Cc: stable@vger.kernel.org # v4.17
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>=20
> Hi Mario,
>=20
> can you please test this on your faulty XPS?
> I think it'll fix the issue, but I can not reproduce, so better wait for
> your confirmation.
>=20
> Jiri, ideally I would love to see this in v4.17 final, but Mario seems
> to be on PTO until next week. I guess we'll just push this in v4.17.1
> then. Also, if you can double check that it makes sense, that would be
> nice :)
>=20
> Cheers,
> Benjamin
>=20
>  drivers/hid/hid-core.c | 5 ++++-
>  include/linux/hid.h    | 3 ++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 2f7367b1de00..7afed0c0f9e5 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1960,6 +1960,8 @@ static int hid_device_probe(struct device *dev)
>  	}
>  	hdev->io_started =3D false;
>=20
> +	clear_bit(ffs(HID_STAT_REPROBED), &hdev->status);
> +
>  	if (!hdev->driver) {
>  		id =3D hid_match_device(hdev, hdrv);
>  		if (id =3D=3D NULL) {
> @@ -2223,7 +2225,8 @@ static int __hid_bus_reprobe_drivers(struct device =
*dev,
> void *data)
>  	struct hid_device *hdev =3D to_hid_device(dev);
>=20
>  	if (hdev->driver =3D=3D hdrv &&
> -	    !hdrv->match(hdev, hid_ignore_special_drivers))
> +	    !hdrv->match(hdev, hid_ignore_special_drivers) &&
> +	    !test_and_set_bit(ffs(HID_STAT_REPROBED), &hdev->status))
>  		return device_reprobe(dev);
>=20
>  	return 0;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index ee2510019033..aee281522c6d 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -517,6 +517,7 @@ struct hid_output_fifo {
>  #define HID_STAT_ADDED		BIT(0)
>  #define HID_STAT_PARSED		BIT(1)
>  #define HID_STAT_DUP_DETECTED	BIT(2)
> +#define HID_STAT_REPROBED	BIT(3)
>=20
>  struct hid_input {
>  	struct list_head list;
> @@ -585,7 +586,7 @@ struct hid_device {
> 		/* device report descriptor */
>  	bool battery_avoid_query;
>  #endif
>=20
> -	unsigned int status;						/* see
> STAT flags above */
> +	unsigned long status;						/* see
> STAT flags above */
>  	unsigned claimed;						/*
> Claimed by hidinput, hiddev? */
>  	unsigned quirks;						/* Various
> quirks the device can pull on us */
>  	bool io_started;						/* If IO has started
> */
> --
> 2.14.3

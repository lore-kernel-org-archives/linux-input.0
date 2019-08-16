From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 2/2] HID: wacom: do not call hid_set_drvdata(hdev, NULL)
Date: Fri, 16 Aug 2019 15:03:51 -0700
Message-ID: <CANRwn3QQcGVGx2KjoU0sG70gSjzwjDKUuL_8q-oYFHRYrn4qGQ@mail.gmail.com>
References: <20190812162740.15898-1-benjamin.tissoires@redhat.com> <20190812162740.15898-3-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812162740.15898-3-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, Linux Input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 12, 2019 at 9:29 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> This is a common pattern in the HID drivers to reset the drvdata.
> However, this is actually already handled by driver core, so there
> is no need to do it manually.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


> ---
>  drivers/hid/wacom_sys.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 53bddb50aeba..69ccfdd51a6f 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2718,14 +2718,12 @@ static int wacom_probe(struct hid_device *hdev,
>         wacom_wac->features =3D *((struct wacom_features *)id->driver_dat=
a);
>         features =3D &wacom_wac->features;
>
> -       if (features->check_for_hid_type && features->hid_type !=3D hdev-=
>type) {
> -               error =3D -ENODEV;
> -               goto fail;
> -       }
> +       if (features->check_for_hid_type && features->hid_type !=3D hdev-=
>type)
> +               return -ENODEV;
>
>         error =3D kfifo_alloc(&wacom_wac->pen_fifo, WACOM_PKGLEN_MAX, GFP=
_KERNEL);
>         if (error)
> -               goto fail;
> +               return error;
>
>         wacom_wac->hid_data.inputmode =3D -1;
>         wacom_wac->mode_report =3D -1;
> @@ -2743,12 +2741,12 @@ static int wacom_probe(struct hid_device *hdev,
>         error =3D hid_parse(hdev);
>         if (error) {
>                 hid_err(hdev, "parse failed\n");
> -               goto fail;
> +               return error;
>         }
>
>         error =3D wacom_parse_and_register(wacom, false);
>         if (error)
> -               goto fail;
> +               return error;
>
>         if (hdev->bus =3D=3D BUS_BLUETOOTH) {
>                 error =3D device_create_file(&hdev->dev, &dev_attr_speed)=
;
> @@ -2759,10 +2757,6 @@ static int wacom_probe(struct hid_device *hdev,
>         }
>
>         return 0;
> -
> -fail:
> -       hid_set_drvdata(hdev, NULL);
> -       return error;
>  }
>
>  static void wacom_remove(struct hid_device *hdev)
> @@ -2791,8 +2785,6 @@ static void wacom_remove(struct hid_device *hdev)
>                 wacom_release_resources(wacom);
>
>         kfifo_free(&wacom_wac->pen_fifo);
> -
> -       hid_set_drvdata(hdev, NULL);
>  }
>
>  #ifdef CONFIG_PM
> --
> 2.19.2
>

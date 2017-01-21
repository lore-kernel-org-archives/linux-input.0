From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 4/4] HID: wacom: do not shout an error on LED control
Date: Fri, 20 Jan 2017 18:31:23 -0800
Message-ID: <CANRwn3TMAFvzHiOutdA3Dd07WCwi8KXMXGLNW7=5PA3mya17Xw@mail.gmail.com>
References: <20170120152014.19775-1-benjamin.tissoires@redhat.com> <20170120152014.19775-5-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170120152014.19775-5-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-kernel@vger.kernel.org, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

I'm not super comfortable with hiding this error. If the tablet reacts
appropriately, I wouldn't think we'd get an EPIPE. Although its not
fatal, it still might be a symptom of something deeper...

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....



On Fri, Jan 20, 2017 at 7:20 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> At plug, the tablet seems to output a -EPIPE when first accessing the
> LED. The weird part is that the command is taken into account by the
> tablet, but we shout an error in the dmesg.
>
> Cut off the error so that users are happier.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/wacom_sys.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 6acb422..6acf3a3 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -803,8 +803,12 @@ static int wacom_led_control(struct wacom *wacom)
>                 buf[4] =3D wacom->led.img_lum;
>         }
>
> -       retval =3D wacom_set_report(wacom->hdev, HID_FEATURE_REPORT, buf,=
 buf_size,
> -                                 WAC_CMD_RETRIES);
> +       /*
> +        * we do not use wacom_set_report because -EPIPE happens but is
> +        * not fatal, so do not shout something at the user.
> +        */
> +       retval =3D hid_hw_raw_request(wacom->hdev, buf[0], buf, buf_size,
> +                                   HID_FEATURE_REPORT, HID_REQ_SET_REPOR=
T);
>         kfree(buf);
>
>         return retval;
> --
> 2.9.3
>

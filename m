From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 2/2] HID: wacom: add support of the Pen of the Bamboo Pad
Date: Mon, 5 Jan 2015 17:49:23 -0800
Message-ID: <CANRwn3QkYkcZdugx+7AybX=f-QucU0ezp_SFftL0Pc8RPkjn9A@mail.gmail.com>
References: <1420493533-11639-1-git-send-email-benjamin.tissoires@redhat.com>
	<1420493533-11639-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420493533-11639-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, josep.sanchez.ferreres@est.fib.upc.edu, Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 5, 2015 at 1:32 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Bamboo Pads are using the generic processing but their report descrip=
tors
> differ from the ISDv* line. The pen fields are marked with the .physi=
cal
> as Digitizer_Pen, which makes also sense.
>
> Add this field to the checks and enable for free Bamboo Pads.
>
> Reported-by: Josep Sanchez Ferreres <josep.sanchez.ferreres@est.fib.u=
pc.edu>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>
> Hi Jason,
>
> I still did not managed to put in shape the regression tests for the =
Wacom
> recordings we have. I do not think this will impact the current suppo=
rted
> devices (none that I have present the HID_DG_PEN application/logical/=
physical
> tag).
>
> It would be good still if you could have a look and validate the patc=
h series.
>
> Cheers,
> Benjamin
>

None of the units I've collected descriptors for appear to have a
HD_DG_PEN physical collection, so I also don't see any potential for
regression. For both patches:

Reviewed-by: Jason Gerecke <killertofu@gmail.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

>  drivers/hid/wacom_wac.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 7436f2b..7afd929 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -74,6 +74,7 @@
>
>  #define WACOM_PEN_FIELD(f)     (((f)->logical =3D=3D HID_DG_STYLUS) =
|| \
>                                  ((f)->physical =3D=3D HID_DG_STYLUS)=
 || \
> +                                ((f)->physical =3D=3D HID_DG_PEN) ||=
 \
>                                  ((f)->application =3D=3D HID_DG_PEN)=
)
>  #define WACOM_FINGER_FIELD(f)  (((f)->logical =3D=3D HID_DG_FINGER) =
|| \
>                                  ((f)->physical =3D=3D HID_DG_FINGER)=
 || \
> --
> 2.1.0
>

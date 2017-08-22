From: Kirill Esipov <yesipov@gmail.com>
Subject: Re: HID: core: assign usbhid to handle EETI PID=0x0001 HID device
Date: Tue, 22 Aug 2017 19:13:21 +0300
Message-ID: <CAJcpCzHtBSEjgvbm-YV+Uy27OkHct3COY-ysWw=PzJV01hBZHQ@mail.gmail.com>
References: <20170811074201.2747-1-jam.chen.egalax@gmail.com> <71e49c0b-959b-4d55-b1d3-6aafe85f8652@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <71e49c0b-959b-4d55-b1d3-6aafe85f8652@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: JamChen <jam.chen.egalax@gmail.com>, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zboszor@pr.hu
List-Id: linux-input@vger.kernel.org

Hi

On 08/11/2017 10:42 AM, JamChen wrote:
> From: Jam Chen <jam.chen.egalax@gmail.com>
>
> The vendor used the same PID(0x0001) for multiple touch IC controllers.
> The newer ICs can support HID class and report the multitouch collection
> in the descriptor. So they were handled by the hid-multitouch driver.
> But some customized firmwares don't support multitouch protocol even if
> driver have got the Win8 blob data.
>
> Actually, those ICs only support the single touch function, and report
> the mouse protocol by default. We can assign usbhid to handle them all.
>
> Signed-off-by: Jam Chen <jam.chen.egalax@gmail.com>
> ---
>   drivers/hid/hid-core.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9017dcc14502..df4696022488 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -828,6 +828,10 @@ static int hid_scan_report(struct hid_device *hid)
>   */
>   hid->group =3D HID_GROUP_RMI;
>   break;
> + case USB_VENDOR_ID_DWAV:
> + if (hid->product =3D=3D USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER)
> + hid->group =3D HID_GROUP_GENERIC;
> + break;
>   }
>
>   /* fall back to generic driver in case specific driver doesn't exist */
>
>

I've tested this patch and got the same problem as Zolt=C3=A1n B=C3=B6sz=C3=
=B6rm=C3=A9nyi did:
- on finger touch: pointer doesn't change its position;
- on finger move: pointer is moving and it's behavior looks like
touchscreen is working as touchpad;

My test environments:
linux kernel 4.1.18 (armv7 ti am335x)
weston - 1.9.0
libinput - 1.1.4
libevdev - 1.2.99.901

Also I've tested this patch
https://patchwork.kernel.org/patch/9876649/ - and it works fine.



--=20
Kirill Esipov

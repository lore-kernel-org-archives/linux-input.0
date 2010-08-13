From: Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND] USB HID: Protect against disconnect/NULL-dereference
 race
Date: Fri, 13 Aug 2010 14:25:52 +0530
Message-ID: <AANLkTim_Jj0w22AM0O=PoF01DHFe+VMvjmvi4nqVnqNx@mail.gmail.com>
References: <m3y6ee62gp.fsf@pullcord.laptop.org>
	<m3lj8b8m6b.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <m3lj8b8m6b.fsf-0VGQAjvlmrQzNDMTQreKSUB+6BGkLq7r@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi ,

i am also using HIDDEV interface . and i also got hiddev_ioctl NULL
dereference problem .

Below  patch fixes my problem .

Regards
Amit Nagal







On Fri, Aug 13, 2010 at 4:37 AM, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org> wrote:
> One of our users reports consistently hitting a NULL dereference that
> resolves to the "hid_to_usb_dev(hid);" call in hiddev_ioctl(), when
> disconnecting a Lego WeDo USB HID device from an OLPC XO running
> Scratch software. =A0There's a FIXME comment and a guard against the
> dereference, but that happens farther down the function than the
> initial dereference does.
>
> This patch moves the call to be below the guard, and the user reports
> that it fixes the problem for him. =A0OLPC bug report:
> http://dev.laptop.org/ticket/10174
>
> Signed-off-by: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
> ---
> =A0drivers/hid/usbhid/hiddev.c | =A0 =A06 ++++--
> =A01 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.=
c
> index c24d2fa..7ec009a 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -593,7 +593,7 @@ static long hiddev_ioctl(struct file *file, unsig=
ned int cmd, unsigned long arg)
> =A0 =A0 =A0 =A0struct hiddev_list *list =3D file->private_data;
> =A0 =A0 =A0 =A0struct hiddev *hiddev =3D list->hiddev;
> =A0 =A0 =A0 =A0struct hid_device *hid =3D hiddev->hid;
> - =A0 =A0 =A0 struct usb_device *dev =3D hid_to_usb_dev(hid);
> + =A0 =A0 =A0 struct usb_device *dev;
> =A0 =A0 =A0 =A0struct hiddev_collection_info cinfo;
> =A0 =A0 =A0 =A0struct hiddev_report_info rinfo;
> =A0 =A0 =A0 =A0struct hiddev_field_info finfo;
> @@ -607,9 +607,11 @@ static long hiddev_ioctl(struct file *file, unsi=
gned int cmd, unsigned long arg)
> =A0 =A0 =A0 =A0/* Called without BKL by compat methods so no BKL take=
n */
>
> =A0 =A0 =A0 =A0/* FIXME: Who or what stop this racing with a disconne=
ct ?? */
> - =A0 =A0 =A0 if (!hiddev->exist)
> + =A0 =A0 =A0 if (!hiddev->exist || !hid)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
>
> + =A0 =A0 =A0 dev =3D hid_to_usb_dev(hid);
> +
> =A0 =A0 =A0 =A0switch (cmd) {
>
> =A0 =A0 =A0 =A0case HIDIOCGVERSION:
> --
> 1.7.0.1
>
> --
> Chris Ball =A0 <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

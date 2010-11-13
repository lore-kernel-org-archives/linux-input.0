From: Eric Biederman <ebiederm@aristanetworks.com>
Subject: Re: [PATCH 2/2] HID: roccat: using new sysfs_create_bin_group() in
 kone driver
Date: Fri, 12 Nov 2010 16:21:45 -0800
Message-ID: <AANLkTik4qPyBtKgJwHVnhkTASNORoKrWms6gk8NirYeU@mail.gmail.com>
References: <1289585921.2629.13.camel@neuromancer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1289585921.2629.13.camel@neuromancer>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Achatz <stefan_achatz@web.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, "Serge E. Hallyn" <serue@us.ibm.com>, Tejun Heo <tj@kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Thery <benjamin.thery@bull.net>
List-Id: linux-input@vger.kernel.org

On Fri, Nov 12, 2010 at 10:18 AM, Stefan Achatz <stefan_achatz@web.de> =
wrote:
> hid-roccat-kone now uses new group functions for creating binary
> sysfs attributes.

Looking at this, I have a problem with the way this works.
You are still doing this the hard and racy way.

sysfs attributes that are only added when we initialize the hardware an=
d
are only removed when we remove the driver should use the device layer
functions to create their attributes.

This achieves two things.  The code is easier to write because there
is less of it.
The notification to user space happens after the attributes appear so
that you don't
have strange hotplug races.

If there a chance you can look at implementing this in the simpler
race free way?

Eric


>
> Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
> ---
> =A0drivers/hid/hid-roccat-kone.c | =A0 53 ++++++++++++---------------=
-------------
> =A01 files changed, 16 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-k=
one.c
> index f776957..43f1693 100644
> --- a/drivers/hid/hid-roccat-kone.c
> +++ b/drivers/hid/hid-roccat-kone.c
> @@ -710,6 +710,20 @@ static struct bin_attribute kone_profile5_attr =3D=
 {
> =A0 =A0 =A0 =A0.write =3D kone_sysfs_write_profile5
> =A0};
>
> +static struct attribute *kone_bin_attributes[] =3D {
> + =A0 =A0 =A0 &kone_settings_attr.attr,
> + =A0 =A0 =A0 &kone_profile1_attr.attr,
> + =A0 =A0 =A0 &kone_profile2_attr.attr,
> + =A0 =A0 =A0 &kone_profile3_attr.attr,
> + =A0 =A0 =A0 &kone_profile4_attr.attr,
> + =A0 =A0 =A0 &kone_profile5_attr.attr,
> + =A0 =A0 =A0 NULL
> +};
> +
> +static struct attribute_group kone_bin_attribute_group =3D {
> + =A0 =A0 =A0 .attrs =3D kone_bin_attributes
> +};
> +
> =A0static int kone_create_sysfs_attributes(struct usb_interface *intf=
)
> =A0{
> =A0 =A0 =A0 =A0int retval;
> @@ -718,42 +732,12 @@ static int kone_create_sysfs_attributes(struct =
usb_interface *intf)
> =A0 =A0 =A0 =A0if (retval)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_1;
>
> - =A0 =A0 =A0 retval =3D sysfs_create_bin_file(&intf->dev.kobj, &kone=
_settings_attr);
> + =A0 =A0 =A0 retval =3D sysfs_create_bin_group(&intf->dev.kobj, &kon=
e_bin_attribute_group);
> =A0 =A0 =A0 =A0if (retval)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_2;
>
> - =A0 =A0 =A0 retval =3D sysfs_create_bin_file(&intf->dev.kobj, &kone=
_profile1_attr);
> - =A0 =A0 =A0 if (retval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_3;
> -
> - =A0 =A0 =A0 retval =3D sysfs_create_bin_file(&intf->dev.kobj, &kone=
_profile2_attr);
> - =A0 =A0 =A0 if (retval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_4;
> -
> - =A0 =A0 =A0 retval =3D sysfs_create_bin_file(&intf->dev.kobj, &kone=
_profile3_attr);
> - =A0 =A0 =A0 if (retval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_5;
> -
> - =A0 =A0 =A0 retval =3D sysfs_create_bin_file(&intf->dev.kobj, &kone=
_profile4_attr);
> - =A0 =A0 =A0 if (retval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_6;
> -
> - =A0 =A0 =A0 retval =3D sysfs_create_bin_file(&intf->dev.kobj, &kone=
_profile5_attr);
> - =A0 =A0 =A0 if (retval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_7;
> -
> =A0 =A0 =A0 =A0return 0;
>
> -exit_7:
> - =A0 =A0 =A0 sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile4_a=
ttr);
> -exit_6:
> - =A0 =A0 =A0 sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile3_a=
ttr);
> -exit_5:
> - =A0 =A0 =A0 sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile2_a=
ttr);
> -exit_4:
> - =A0 =A0 =A0 sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile1_a=
ttr);
> -exit_3:
> - =A0 =A0 =A0 sysfs_remove_bin_file(&intf->dev.kobj, &kone_settings_a=
ttr);
> =A0exit_2:
> =A0 =A0 =A0 =A0sysfs_remove_group(&intf->dev.kobj, &kone_attribute_gr=
oup);
> =A0exit_1:
> @@ -762,12 +746,7 @@ exit_1:
>
> =A0static void kone_remove_sysfs_attributes(struct usb_interface *int=
f)
> =A0{
> - =A0 =A0 =A0 sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile5_a=
ttr);
> - =A0 =A0 =A0 sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile4_a=
ttr);
> - =A0 =A0 =A0 sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile3_a=
ttr);
> - =A0 =A0 =A0 sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile2_a=
ttr);
> - =A0 =A0 =A0 sysfs_remove_bin_file(&intf->dev.kobj, &kone_profile1_a=
ttr);
> - =A0 =A0 =A0 sysfs_remove_bin_file(&intf->dev.kobj, &kone_settings_a=
ttr);
> + =A0 =A0 =A0 sysfs_remove_group(&intf->dev.kobj, &kone_bin_attribute=
_group);
> =A0 =A0 =A0 =A0sysfs_remove_group(&intf->dev.kobj, &kone_attribute_gr=
oup);
> =A0}
>
> --
> 1.7.2.3
>
>
>
>

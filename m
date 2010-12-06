From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 2/4] Enabled Acer Launch Manager mode
Date: Mon, 06 Dec 2010 01:20:27 -0700
Message-ID: <4CFD377B0200002300025043@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: corentin.chary@gmail.com
Cc: dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, mjg@redhat.com, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, jdelvare@suse.de, trenn@suse.de, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Corentin,=20

=E6=96=BC =E4=B8=80=EF=BC=8C2010-12-06 =E6=96=BC 08:17 +0100=EF=BC=8CCo=
rentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
> >>
> >> Just noticed - this function (and others similar to this in your
> >> subsequent patces) mixes acpi-style return values (acpi_status) wi=
th
> >> Linux ones (-ERRXXX). You need to pick one standard (I'd advocate =
Linux
> >> style) and stick with it.
> >>
> >
> > Thank's for your review and suggestion, I choice use acpi-style bec=
ause
> > it don't need change too much and old functions in acer-wmi also fo=
llow
> > acpi-style.
> > I replaced the -EINVAL with AE_ERROR, the following is new patch. I=
f it's OK,
> > I will modify patch 2/4 and patch 3/4 then re-send patchset again.
> >
> >
>=20
> But if you use acpi-style errors won't be able to go back to the user=
 (errno)
> and userspace programs won't be able to display appropriate errors (o=
n modprobe,
> manipulating sysfs files, etc...). I didn't read the code, so it may
> not be an issue here,

Yes, those functions are internal used in acer-wmi, and acer_wmi_init
function will transfer all ACPI error to Linux style then send to
userland.
So, yes, there have no any issue even mix 2 different style return
value.

> but you should check that meaningful error codes are sent back to use=
rspace.
>=20

I still replaced the -EINVAL with AE_ERROR because those 2 functions
declare return a acpi_status.


Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

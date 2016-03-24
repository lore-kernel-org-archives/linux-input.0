From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/2] hid: corsair: Driver simplification and new
 supported device
Date: Thu, 24 Mar 2016 15:37:51 +0100
Message-ID: <20160324143750.GA7602@mail.corp.redhat.com>
References: <cover.1458744569.git.clement.vuchener@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52198 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349AbcCXOh4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Mar 2016 10:37:56 -0400
Content-Disposition: inline
In-Reply-To: <cover.1458744569.git.clement.vuchener@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?PT9VVEYtOD9xP0NsPUMzPUE5bWVudD0yMFZ1Y2hlbmVyPz0=?= <clement.vuchener@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Cl=C3=A9ment,

On Mar 23 2016 or thereabouts, =3D?UTF-8?q?Cl=3DC3=3DA9ment=3D20Vuchene=
r?=3D wrote:
> I tried to add support for the K40 some time ago, but the vendor spec=
ific USB protocol became over-complicated because of a lot of small dif=
ferences between the K90 and the K40. Also, since I wrote the first ver=
sion of this driver, I learned that USB control transfers could be done=
 from user-space without the need to detach the kernel driver (please t=
ell me if I am wrong).
>=20
> So, I decided to move all USB related features in user-space (as far =
as I know, I was the only user, but if someone is looking for a replace=
ment, I wrote a small tool available here: https://github.com/cvuchener=
/corsair-usb-config). This simplification only leaves the usage code re=
mapping part and the driver no longer depends on USB and LED subsystems=
=2E This should make the driver easier to maintain or to add new suppor=
ted devices.
>=20
> After the removal of USB related functions in first patch, the additi=
on of K40 support in the second patch is simply a matter of adding the =
device in the id list.

I would say you can not do this this way. Even if you believe you are t=
he
only user of the API, there might be someone who uses it, and you will =
end
up breaking his keyboard.

Jiri will correct me, but the proper way to follow is to mark the API a=
s
deprecated, make sure your driver uses the deprecated API only for the
K40, and then add the K90 in the driver, without implementing the API.

After a few months (years?) with your API marked as deprecated, you the=
n
will be able to remove it. This is one of the many reasons we wrote
libratbag in pure user-space, to avoid having to maintain complex API i=
n
the kernel forever.

Cheers,
Benjamin

>=20
> Cl=C3=A9ment Vuchener (2):
>   HID: corsair: Remove all features using the USB protocol
>   HID: corsair: Add K40 support
>=20
>  Documentation/ABI/testing/sysfs-driver-hid-corsair |  15 -
>  drivers/hid/Kconfig                                |   2 +-
>  drivers/hid/hid-core.c                             |   1 +
>  drivers/hid/hid-corsair.c                          | 498 +----------=
----------
>  drivers/hid/hid-ids.h                              |   1 +
>  5 files changed, 5 insertions(+), 512 deletions(-)
>  delete mode 100644 Documentation/ABI/testing/sysfs-driver-hid-corsai=
r
>=20
> --=20
> 2.5.5
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Sat, 21 Mar 2015 13:21:52 -0400
Message-ID: <878ueq6zbj.fsf@gmail.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <54E62893.1060806@dell.com> <20150220184717.GC20060@dtor-glaptop> <201502202024.20741@pali> <54E79167.6070701@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:34067 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbbCURWB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2015 13:22:01 -0400
In-Reply-To: <54E79167.6070701@dell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>, Pali =?utf-8?Q?Roh?= =?utf-8?Q?=C3=A1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Mario,

It's great to hear from someone with knowledge of the inner workings of
Dell's firmware.


Mario Limonciello <mario_limonciello@dell.com> writes:

> Hi Pali & Dmitry,
>
> On 02/20/2015 01:24 PM, Pali Roh=C3=A1r wrote:
>> On Friday 20 February 2015 19:47:17 Dmitry Torokhov wrote:

snip

>> Dell Latitude Exx40 models (with ALPS touchpads) have similar
>> problems. Linux psmouse.ko/alps.c driver receive invalid packets
>> which cause lot of problems... ALPS people told me those packets
>> which was found on i8042 bus are really invalid ALPS packets and
>> do not come from ALPS touchpad. Unless there is invisible bug in
>> ALPS touchpad firmware (which was not discovered yet), problem is
>> either in Dell EmeddedController where is connected ALPS touchpad
>> or in Dell BIOS/UEFI (which I believe can modify any such data).
>=20
> A colleague has shared to me some information about the issue on 6x40
> laptops as well.  There was a recent EC change (released within last 2
> weeks or so) that helps to fix problems with i8042 traffic. It was
> intended to fix keyboard repeating, but it may also fix the touchpad
> data.  Can you please confirm if the new BIOS/EC update fixes the
> problem?
>

As you likely know, the same issue is also known [1,2,3] to occur on the
Latitude 7440. I own a Latitude 7440 which now runs the A14 BIOS. This
revision indeed fixes the keyboard repeat issue although the touchpad
issues remain.

In particular the driver loses sync on resume from S3 and occassionally
during normal operation (particularly during multitouch events it
seems). I've also noticed it sometimes occurs when I start using an X
session that has been idle for long enough that the panel is
blanked. For reasons I've not yet had a chance to identify, switching
away from my X session to a VT and back to X appears to reset the driver
and stop the errant events.

Cheers,

=2D Ben


[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D8740
[2] https://bugzilla.redhat.com/show_bug.cgi?id=3D1145954
[3] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1258837


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJVDaiwAAoJEHPt6ejPuu8BJ6kH/jSvqfUqQL7d8f1wWmga2M+8
e8D6qOoDsEGDboWOQ7ghMpsiGxofaBgtHswom6Yd5F3EbA0T/djX4Q9bH3B78SUJ
OIOpfqbTmhCjCJf01E1RavDL3n6oNIUrzCJG8BSImLWkxAaNV8ytqCiUeJO6/2Hf
ZqJqyHuS2cV5AiJtf8lq2cHFJtkMXcHubUZEr4fzn211KRNMJuNOzYOlHsoOyGKt
m5MWJ79kVvOh2e6xPuE9n/4bVW+aLgkvqsTxVjzGGvVx/BYletXlji6QkJUKRYzR
j88/k7XJJyBiyYuCbchul6zKOhFODAdkDb+9LvEHOvdru2eBy+GE6veiRLfawzw=
=f7St
-----END PGP SIGNATURE-----
--=-=-=--

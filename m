From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH v4 0/8] Input: elantech: add support for newer hardware
Date: Wed, 31 Aug 2011 17:43:59 +0800
Message-ID: <874o0xdig0.fsf@emc.com.tw>
References: <1314606539-24722-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314606539-24722-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Seth Forshee <seth.forshee@canonical.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?utf-8?Q?=C3=89r?= =?utf-8?Q?ic?= Piel <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

What do you think about the series?
Do you think these patches all right for upstream?
Or do you have any other concerns about the chages?
Please let me know and I will fix it.
Thnak you.

jj

On Mon, 29 Aug 2011 16:28:51 +0800, JJ Ding <jj_ding@emc.com.tw> wrote:
> Hi Lists,
>=20
> This is a series of patches to add support for newer generations of E=
LAN
> touchpad.
>=20
> Patches #1~#6 are essentially fixes and cleanups that pave the way fo=
r
> patch #7 and patch #8, which really adds code for v3 and v4 hardware.
>=20
> Any comments, suggestoins are welcome.
>=20
> Note:
> Please review patch #8, which adds support for the latest touchpads f=
rom ELAN.
> This is a true multi-touch capable touchpad that can track up to 5 fi=
ngers.
> Support is implemented using MT-B protocol. I used synaptics and mult=
itouch X
> driver to test this driver, both worked fine.
>=20
> Thank you very much.
>=20
> Changes since v1:
> - drop EC workaround patch.
> - add patch #2, make ST and MT have the same range, as Dmitry suggest=
ed.
> - add patch #4, remove ETP_EDGE_FUZZ_V2, as =C3=89ric suggested.
> - rename all packet checking functions so they are consistent.
> - some code cleanup, and don't report ABS_[XY] when fingers =3D=3D 0,=
 as Seth suggested.
> - add document for v3 debounce, and now check debounce in elantech_pa=
cket_check_v3.
>=20
> Changes since v2:
> - fix v3 hardware packet checking (reported by Seth and fix by Dmitry=
=2E)
>=20
> Changes since v3:
> - fix a tiny style problem (useless space on end-of-line, reported by=
 Seth)
> - v3 hardware can track 2 fingers well, so do not set INPUT_PROP_SEMI=
_MT on v3
>   (As suggested earlier by =C3=89ric.)
> - add patch #8, which adds support for v4 hardware.
>=20
> JJ Ding (8):
>   Input: elantech - correct x, y value range for v2 hardware
>   Input: elantech - get rid of ETP_2FT_* in elantech.h
>   Input: elantech - use firmware provided x, y ranges
>   Input: elantech - remove ETP_EDGE_FUZZ_V2
>   Input: elantech - packet checking for v2 hardware
>   Input: elantech - clean up elantech_init
>   Input: elantech - add v3 hardware support
>   Input: elantech - add v4 hardware support
>=20
>  Documentation/input/elantech.txt |  295 +++++++++++++++++-
>  drivers/input/mouse/elantech.c   |  614 ++++++++++++++++++++++++++++=
++++-----
>  drivers/input/mouse/elantech.h   |   56 +++-
>  3 files changed, 849 insertions(+), 116 deletions(-)
>=20
> --=20
> 1.7.4.1
>=20

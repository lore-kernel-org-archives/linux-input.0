From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v2 0/7] Input: elantech: add support for newer hardware
Date: Wed, 24 Aug 2011 15:56:33 +0800
Message-ID: <CAGS+omAj-jo02O0MXZb_JF7+SfyQmmmAr7MA3_hYfead6gszyg@mail.gmail.com>
References: <1314164303-30382-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f198.google.com ([209.85.210.198]:47076 "EHLO
	mail-iy0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab1HXIEU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Aug 2011 04:04:20 -0400
Received: by iyn35 with SMTP id 35so2531399iyn.1
        for <linux-input@vger.kernel.org>; Wed, 24 Aug 2011 01:04:18 -0700 (PDT)
In-Reply-To: <1314164303-30382-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On Wed, Aug 24, 2011 at 1:38 PM, JJ Ding <jj_ding@emc.com.tw> wrote:
> Hi Lists,
>
> This is a series of patches to add support for newer generation of EL=
AN
> touchpad.
>
> Patches #1~#6 are essentially fixes and cleanups that pave the way fo=
r
> patch #7, which really adds code for v3 hardware.
>
> Any comments, suggestoins are welcome.
>
> Thank you.
>
> Changes since v1:
> - drop EC workaround patch.
> - add patch #2, make ST and MT have the same range, as Dmitry suggest=
ed.
> - add patch #4, remove ETP_EDGE_FUZZ_V2, as =C9ric suggested.
> - rename all packet checking functions so they are consistent.
> - some code cleanup, and don't report ABS_[XY] when fingers =3D=3D 0,=
 as Seth suggested.
> - add document for v3 debounce, and now check debounce in elantech_pa=
cket_check_v3.
>
> JJ Ding (7):
> =A0Input: elantech - correct x, y value range for v2 hardware
> =A0Input: elantech - get rid of ETP_2FT_XXXX in elantech.h
> =A0Input: elantech - use firmware provided x, y ranges
> =A0Input: elantech - remove ETP_EDGE_FUZZ_V2
> =A0Input: elantech - packet checking for v2 hardware
> =A0Input: elantech - clean up elantech_init
> =A0Input: elantech - add v3 hardware support
>
> =A0Documentation/input/elantech.txt | =A0125 +++++++++++--
> =A0drivers/input/mouse/elantech.c =A0 | =A0387 ++++++++++++++++++++++=
+++++++++-------
> =A0drivers/input/mouse/elantech.h =A0 | =A0 35 ++--
> =A03 files changed, 444 insertions(+), 103 deletions(-)
>
> --
> 1.7.4.1
>
>

Hi JJ,

Thank you for the updating the patch set.
=46or all 7 patches:
=A0 Acked-by: Daniel Kurtz <djkurtz@chromium.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

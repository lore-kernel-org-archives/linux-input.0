From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Change BTN_TOOL_FINGER flag when hover event
 trigger
Date: Mon, 16 May 2016 10:53:42 -0700
Message-ID: <20160516175342.GD12752@dtor-ws>
References: <C2DEC699-8A1A-484D-83F2-637F5EF94C7B@emc.com.tw>
 <006901d1acea$8207d090$861771b0$@emc.com.tw>
 <00be01d1af65$ec37c290$c4a747b0$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34279 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbcEPRxp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2016 13:53:45 -0400
Content-Disposition: inline
In-Reply-To: <00be01d1af65$ec37c290$c4a747b0$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zac.hsieh@emc.com.tw, =?utf-8?B?6buD5LiW6bWsIOe2k+eQhg==?= <phoenix@emc.com.tw>, 'Charles Mooney' <charliemooney@google.com>, 'Agnes Cheng' <agnescheng@google.com>

Hi Kt,

On Mon, May 16, 2016 at 07:27:25PM +0800, =E5=BB=96=E5=B4=87=E6=A6=AE w=
rote:
>=20
> Only ABS_DISTANCE is not enough for upper OS to distingiush hover eve=
nt be
> triggered from object from faraway to and close touchpad surface or f=
rom
> object prepare to leave the touchpad surface. Add BTN_TOOL_FINGER fla=
g to
> help it.
>=20
>                  object_from_faraway    object_inside_hover_area
> object_touch_surface
> BTN_TOUCH                 0                          0             1
> BTN_TOOL_FINGER           0                          1              1
> ABS_DISTANCE               0                           1             =
0
>=20
> Signed-off by: Duson Lin <dusonlin@emc.com.tw>

I was wondering if we could do without modifying all the drivers that
are using input_mt_report_pointer_emulation(), by figuring out if we
should be emitting BTN_TOOL_FINGER right there:

"If device supports ABS_DISTANCE and does not support ABS_MT_DISTANCE a=
nd
ABS_DISTANCE !=3D 0 is reported in current frame and there are no other
contacts then report BTN_TOOL_FINGER."

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

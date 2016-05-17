From: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Subject: RE: [PATCH] Input: Change BTN_TOOL_FINGER flag when hover event trigger
Date: Tue, 17 May 2016 22:20:40 +0800
Message-ID: <00c901d1b047$4a2d3ba0$de87b2e0$@emc.com.tw>
References: <C2DEC699-8A1A-484D-83F2-637F5EF94C7B@emc.com.tw> <006901d1acea$8207d090$861771b0$@emc.com.tw> <00be01d1af65$ec37c290$c4a747b0$@emc.com.tw> <20160516175342.GD12752@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:33369 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbcEQOUq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2016 10:20:46 -0400
In-Reply-To: <20160516175342.GD12752@dtor-ws>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zac.hsieh@emc.com.tw, =?UTF-8?B?J+m7g+S4lum1rCDntpPnkIYn?= <phoenix@emc.com.tw>, 'Charles Mooney' <charliemooney@google.com>, 'Agnes Cheng' <agnescheng@google.com>, 'jeff' <jeff.chuang@emc.com.tw>

Hi Dmitry,

I want to confirm my thought for your idea to avoid misunderstanding.
I think you want to encapsulate " BTN_TOOL_FINGER" in the [input_mt_rep=
ort_pointer_emulation] if hover happen.
Vendor driver only report "ABS_DISTANCE" and let [input_mt_report_point=
er_emulation] emit BTN_TOOL_FINGER report without change function param=
eter.

Please let me know if my misunderstand about your idea.

Thanks  KT

-----Original Message-----
=46rom: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]=20
Sent: Tuesday, May 17, 2016 1:54 AM
To: =E5=BB=96=E5=B4=87=E6=A6=AE
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; zac.hsie=
h@emc.com.tw; =E9=BB=83=E4=B8=96=E9=B5=AC =E7=B6=93=E7=90=86; 'Charles =
Mooney'; 'Agnes Cheng'
Subject: Re: [PATCH] Input: Change BTN_TOOL_FINGER flag when hover even=
t trigger

Hi Kt,

On Mon, May 16, 2016 at 07:27:25PM +0800, =E5=BB=96=E5=B4=87=E6=A6=AE w=
rote:
>=20
> Only ABS_DISTANCE is not enough for upper OS to distingiush hover=20
> event be triggered from object from faraway to and close touchpad=20
> surface or from object prepare to leave the touchpad surface. Add=20
> BTN_TOOL_FINGER flag to help it.
>=20
>                  object_from_faraway    object_inside_hover_area
> object_touch_surface
> BTN_TOUCH                 0                          0             1
> BTN_TOOL_FINGER           0                          1              1
> ABS_DISTANCE               0                           1             =
0
>=20
> Signed-off by: Duson Lin <dusonlin@emc.com.tw>

I was wondering if we could do without modifying all the drivers that a=
re using input_mt_report_pointer_emulation(), by figuring out if we sho=
uld be emitting BTN_TOOL_FINGER right there:

"If device supports ABS_DISTANCE and does not support ABS_MT_DISTANCE a=
nd ABS_DISTANCE !=3D 0 is reported in current frame and there are no ot=
her contacts then report BTN_TOOL_FINGER."

Thanks.

--
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

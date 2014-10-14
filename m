From: =?UTF-8?B?RUxBTiDlionlmInpp78=?= <scott.liu@emc.com.tw>
Subject: RE: Elan TS driver patch
Date: Tue, 14 Oct 2014 10:30:05 +0800
Message-ID: <001801cfe756$c3e54520$4bafcf60$@emc.com.tw>
References: <005301cfe221$abcd2460$03676d20$@emc.com.tw>	<20141007160358.GA16469@dtor-ws>	<006001cfe294$13720370$3a560a50$@emc.com.tw>	<20141010221137.GD38320@dtor-ws>	<24A1508F-93CB-4139-BF22-4BD7A118E005@emc.com.tw> <CANLzEktRicHTvAbDWe6E73EUdknJQT8TmTeHtmK=kUz46HPFtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:56768 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbaJNCaJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Oct 2014 22:30:09 -0400
In-Reply-To: <CANLzEktRicHTvAbDWe6E73EUdknJQT8TmTeHtmK=kUz46HPFtA@mail.gmail.com>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Benson Leung' <bleung@chromium.org>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 'Charles Mooney' <charliemooney@google.com>, "'Jeff.Chuang'" <Jeff.chuang@emc.com.tw>, =?UTF-8?B?J+aigeWNmue/lCc=?= <paul.liang@emc.com.tw>, 'Duson Lin' <dusonlin@emc.com.tw>

Hi Benson, Dmitry:
	The device part name is "eKTH3500".
	How do you feel?

Thanks.
--
Scott

-----Original Message-----
=46rom: bleung@google.com [mailto:bleung@google.com] On Behalf Of Benso=
n Leung
Sent: Tuesday, October 14, 2014 2:47 AM
To: Scott
Cc: Dmitry Torokhov; linux-input@vger.kernel.org; Charles Mooney; Jeff.=
Chuang; =E6=A2=81=E5=8D=9A=E7=BF=94; Duson Lin
Subject: Re: Elan TS driver patch

Hi Scott,

On Sun, Oct 12, 2014 at 8:22 AM, Scott <scott.liu@emc.com.tw> wrote:
>         I would call this driver name as =E2=80=9CElan Large-Size Tou=
chscreen=E2=80=9D.
>         We (Elan) have two types of TS series internally, Large-size(=
 > 10=E2=80=9D ~ 20") and small-size ( <=3D 10=E2=80=9D)
>         and this driver patch is for large size. thanks.

While this may be an accurate description of the touchscreen family, Dm=
itry is looking for a part number that can identify the class of device=
s. For example, Duson identified the touchpad part as "eKTH3000"

Is there a similar part number for the large size touchscreen?

--
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

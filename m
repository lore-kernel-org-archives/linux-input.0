From: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Subject: RE: [PATCH] Input: elan_i2c - +200 ms delay before setting to ABS mode
Date: Wed, 22 Jun 2016 20:00:56 +0800
Message-ID: <009501d1cc7d$bbcd0950$33671bf0$@emc.com.tw>
References: <1465306449-28256-1-git-send-email-chiu@endlessm.com>	<20160620174251.GC22426@dtor-ws>	<008601d1cbba$124c2230$36e46690$@emc.com.tw> <CAD8Lp44NHiSfPjzYkPCm1jX1Jb2E071WY4_OdCpJv0H7ivEoSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD8Lp44NHiSfPjzYkPCm1jX1Jb2E071WY4_OdCpJv0H7ivEoSg@mail.gmail.com>
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
To: 'Daniel Drake' <drake@endlessm.com>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Chris Chiu' <chiu@endlessm.com>, 'Charlie Mooney' <charliemooney@chromium.org>, 'Michele Curti' <michele.curti@gmail.com>, 'Krzysztof Kozlowski' <k.kozlowski@samsung.com>, 'Benson Leung' <bleung@chromium.org>, linux-input@vger.kernel.org, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Upstreaming Team' <linux@endlessm.com>, =?UTF-8?B?J+m7g+S4lum1rCDntpPnkIYn?= <phoenix@emc.com.tw>
List-Id: linux-input@vger.kernel.org

-----Original Message-----
=46rom: Daniel Drake [mailto:drake@endlessm.com]=20
Sent: Tuesday, June 21, 2016 10:42 PM
To: =E5=BB=96=E5=B4=87=E6=A6=AE
Cc: Dmitry Torokhov; Chris Chiu; Charlie Mooney; Michele Curti; Krzyszt=
of Kozlowski; Benson Leung; linux-input@vger.kernel.org; Linux Kernel; =
Linux Upstreaming Team; =E9=BB=83=E4=B8=96=E9=B5=AC =E7=B6=93=E7=90=86
Subject: Re: [PATCH] Input: elan_i2c - +200 ms delay before setting to =
ABS mode

On Tue, Jun 21, 2016 at 6:40 AM, =E5=BB=96=E5=B4=87=E6=A6=AE <kt.liao@e=
mc.com.tw> wrote:
> KT, is this feasible?
> [KT] After internal discussion, we don't agree this patch.
>     It's a work-around to fix firmware bug for specific touchpad and=20
> not tested by other device.

=46or better or worse, Linux often takes on the responsibility of worki=
ng around firmware bugs. This is a real issue that affects multiple Asu=
s laptops; you'll have no touchpad input upon reboot from any OS that d=
rives the touchpad in "generic hid" mode (e.g. older version of Linux, =
some embedded OS, etc).

If the sleep is really that controversial, we could make it specific to=
 the ELAN1000 model that is the one in question here?

[KT]:We can consider to control specific module, our FW engineer is che=
cking it and confirm which part number for ASUS should adopt work-aroun=
d.
we will reply you once we confirm.

Thanks
Daniel

From: =?utf-8?q?J=C3=BCrgen_Beisert?= <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Fri, 10 Jan 2014 09:55:45 +0100
Message-ID: <201401100955.45885.jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <52CEA4AA.8050503@free-electrons.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52CEA4AA.8050503-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Alexandre,

On Thursday 09 January 2014 14:31:22 Alexandre Belloni wrote:
> Sorry to chime in only now but it seems that this series is breaking =
the
> touchscreen calibration on 3.13 (and -rc7 is out so it might be too
> late).
>
> At first, I though I became a terrible clicker ;) but I found some
> evidences:
>
> xinput_calibrator is complaining about misclicks, debug output:
> DEBUG: Adding click 0 (X=3D105, Y=3D59)
> DEBUG: Not adding click 1 (X=3D100, Y=3D59): within 7 pixels of previ=
ous click
> DEBUG: Adding click 1 (X=3D696, Y=3D58)
> DEBUG: Not adding click 2 (X=3D700, Y=3D55): within 7 pixels of previ=
ous click
> DEBUG: Adding click 2 (X=3D103, Y=3D422)
> DEBUG: Mis-click detected, click 3 (X=3D438, Y=3D415) not aligned wit=
h click 1 (X=3D696, Y=3D58) or click 2 (X=3D103, Y=3D422) (threshold=3D=
15)
> DEBUG: Adding click 0 (X=3D424, Y=3D411)
>
> Do you see the confusion ? At some point one of the coordinates is no=
t
> updated. Successful calibration with 3.12.6 gives:
> DEBUG: Adding click 0 (X=3D126, Y=3D405)
> DEBUG: Adding click 1 (X=3D684, Y=3D399)
> DEBUG: Adding click 2 (X=3D128, Y=3D77)
> DEBUG: Adding click 3 (X=3D683, Y=3D77)
>
>
> With ts_calibrate:
> xres =3D 800, yres =3D 480
> Took 1 samples...
> Top left : X =3D  435 Y =3D 3572
> Took 2 samples...
> Top right : X =3D 2094 Y =3D 3553
> Took 2 samples...
> Bot right : X =3D 2939 Y =3D 2077
> Took 2 samples...
> Bot left : X =3D 2060 Y =3D  644
> Took 2 samples...
> Center : X =3D 1279 Y =3D 1346
>
> We experience the same thing, when changing position on an axis, we g=
et
> an average between the previous and the new position (probably becaus=
e
> we got 2 samples):
>  - Top Left is ok
>  - Top right is almost ok: X should be around 3500/3700
>  - Bot right is starting to get really wrong: X is getting better (it
>    should still be around 3500/3700) but Y should be quite lower
>  - Bot left: Y is ok but X should be lower
>  - Center is completely wrong, both values should be around 2000
>
> Last test with evtest which is always difficult because it outputs a =
lot
> of debug. Two separate touchs, bottom left and then top right (note t=
hat
> this is with fsl,ave-ctrl =3D <8>;):
>
> Event: time 1389210862.451000, type 3 (Absolute), code 0 (X), value 2=
183
> Event: time 1389210862.451000, type 3 (Absolute), code 1 (Y), value 7=
20
> Event: time 1389210862.451000, type 3 (Absolute), code 24 (Pressure),=
 value 6
> Event: time 1389210862.451000, type 1 (Key), code 330 (Touch), value =
1=20
> Event: time 1389210862.451000, -------------- Report Sync -----------=
-
> Event: time 1389210862.477721, type 3 (Absolute), code 0 (X), value 4=
48
> Event: time 1389210862.477721, type 3 (Absolute), code 1 (Y), value 6=
67
> Event: time 1389210862.477721, type 3 (Absolute), code 24 (Pressure),=
 value 595
> Event: time 1389210862.477721, -------------- Report Sync -----------=
-=20
> Event: time 1389210862.504718, type 3 (Absolute), code 0 (X), value 4=
34
> Event: time 1389210862.504718, type 3 (Absolute), code 1 (Y), value 7=
04
> Event: time 1389210862.504718, type 3 (Absolute), code 24 (Pressure),=
 value 580
> Event: time 1389210862.504718, -------------- Report Sync -----------=
-=20
> Event: time 1389210862.536688, type 1 (Key), code 330 (Touch), value =
0
> Event: time 1389210862.536688, -------------- Report Sync -----------=
-
> Event: time 1389210863.359697, type 3 (Absolute), code 0 (X), value 4=
32
> Event: time 1389210863.359697, type 3 (Absolute), code 1 (Y), value 7=
26
> Event: time 1389210863.359697, type 3 (Absolute), code 24 (Pressure),=
 value 210
> Event: time 1389210863.359697, type 1 (Key), code 330 (Touch), value =
1=20
> Event: time 1389210863.359697, -------------- Report Sync -----------=
-
> Event: time 1389210863.391687, type 1 (Key), code 330 (Touch), value =
0
> Event: time 1389210863.391687, -------------- Report Sync -----------=
-
>
> We get 3 reports for bottom left, then pen up, then one report for to=
p
> right that is almost exactly the same a bottom left !
>
> Output from 3.12:
> Event: time 1389210022.146809, type 3 (Absolute), code 0 (X), value 2=
86
> Event: time 1389210022.146809, type 3 (Absolute), code 1 (Y), value 5=
04
> Event: time 1389210022.146809, type 3 (Absolute), code 24 (Pressure),=
 value 3045
> Event: time 1389210022.146809, type 1 (Key), code 330 (Touch), value =
1=20
> Event: time 1389210022.146809, -------------- Report Sync -----------=
-
> Event: time 1389210022.166830, type 3 (Absolute), code 0 (X), value 2=
56
> Event: time 1389210022.166830, type 3 (Absolute), code 1 (Y), value 4=
89
> Event: time 1389210022.166830, type 3 (Absolute), code 24 (Pressure),=
 value 3033
> Event: time 1389210022.166830, -------------- Report Sync -----------=
-=20
> Event: time 1389210022.186812, type 3 (Absolute), code 24 (Pressure),=
 value 0
> Event: time 1389210022.186812, type 1 (Key), code 330 (Touch), value =
0=20
> Event: time 1389210022.186812, -------------- Report Sync -----------=
-
> Event: time 1389210025.196808, type 3 (Absolute), code 0 (X), value 3=
812
> Event: time 1389210025.196808, type 3 (Absolute), code 1 (Y), value 3=
637
> Event: time 1389210025.196808, type 3 (Absolute), code 24 (Pressure),=
 value 4032
> Event: time 1389210025.196808, type 1 (Key), code 330 (Touch), value =
1=20
> Event: time 1389210025.196808, -------------- Report Sync -----------=
-
> Event: time 1389210025.216819, type 3 (Absolute), code 24 (Pressure),=
 value 0
> Event: time 1389210025.216819, type 1 (Key), code 330 (Touch), value =
0=20
> Event: time 1389210025.216819, -------------- Report Sync -----------=
-
>
>
> While this is not necessarily an issue with ts_calibrate (it is possi=
ble
> to click longer so it collects more samples), I don't see that workin=
g
> with xinput_calibrator.
>
> While I don't have much experience with the TS part of the code but I
> can investigate if you don't have any idea.

You are right. I have seen the same behaviour here a few times. Current=
ly I'm
short in time to dig deeper into this issue, but I will try to do so.

Juergen

--=20
Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Juergen Beisert =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
Linux Solutions for Science and Industry =C2=A0 =C2=A0 =C2=A0| http://w=
ww.pengutronix.de/  |

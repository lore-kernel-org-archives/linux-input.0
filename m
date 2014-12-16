From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 1/2] Input: add regulator haptic driver
Date: Mon, 15 Dec 2014 17:42:27 -0800
Message-ID: <20141216014227.GA18491@dtor-ws>
References: <1418380349-32588-1-git-send-email-jaewon02.kim@samsung.com>
 <1418380349-32588-2-git-send-email-jaewon02.kim@samsung.com>
 <20141213195611.GE22702@dtor-ws>
 <548F8645.3070002@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <548F8645.3070002@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Hyunhee Kim <hyunhee.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

On Tue, Dec 16, 2014 at 10:09:25AM +0900, Jaewon Kim wrote:
> Hi Dmitry,
>=20
> 2014=EB=85=84 12=EC=9B=94 14=EC=9D=BC 04:56=EC=97=90 Dmitry Torokhov =
=EC=9D=B4(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> >Hi Jaewon,
> >
> >On Fri, Dec 12, 2014 at 07:32:28PM +0900, Jaewon Kim wrote:
=2E..
> >>+static int __maybe_unused regulator_haptic_suspend(struct device *=
dev)
> >>+{
> >>+	struct platform_device *pdev =3D to_platform_device(dev);
> >>+	struct regulator_haptic *haptic =3D platform_get_drvdata(pdev);
> >>+
> >>+	mutex_lock(&haptic->mutex);
> >>+	if (haptic->enabled) {
> >>+		regulator_haptic_enable(haptic, false);
> >>+		haptic->suspend_state =3D true;
> >Why do we only set suspend_state if an effect was playing? I think w=
e
> >should always indicate that the device is suspended so that we do no=
t
> >try to start playing another effect - while it is true that normally
> >effects are played by request from userspace which should be frozen =
by
> >now, it is theoretically possible to trigger an effect from kernel a=
s
> >well.
>=20
> This variable name seems to make you confuse.
> I used this variable to restore the old state.
>=20
> When kernel is entering suspend state while the motor is vibrating,
> I store vibrating state for vibrate again after escape suspend state.
>=20
>=20
> I will change variable name to "suspend_restore".
> And prevent to start playing effect  when kernel entering suspend sta=
te.

You do not need to save if haptic was playing or not - on resume, if
haptic->magnitude !=3D 0 you need to restart playing, otherwise leave i=
t
off.

Thanks.

--=20
Dmitry

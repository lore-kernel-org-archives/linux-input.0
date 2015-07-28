From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V3 1/3] mfd: da9062: Support for the DA9063 OnKey in the
 DA9062 core
Date: Tue, 28 Jul 2015 09:42:07 +0100
Message-ID: <20150728084207.GO14943@x1>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <983c3fe61ca732985f70c7d77bdb146860daf467.1437668261.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <983c3fe61ca732985f70c7d77bdb146860daf467.1437668261.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, Samuel Ortiz <sameo@linux.intel.com>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On Thu, 23 Jul 2015, S Twiss wrote:

> From: S Twiss <stwiss.opensource@diasemi.com>
>=20
> Add MFD core driver support for a OnKey component
>=20
> - MFD core adds the resource da9062_onkey_resources[] for the OnKey
> - An appropriate value has been added into mfd_cell da9062_devs[] to
>   support component .name =3D "da9062-onkey" and
>   .of_compatible  =3D "dlg,da9062-onkey"
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
>=20
> ---
> Changes in V3:
>  - Added Ack from Lee Jones
> Changes in V2:
>  - No change
>=20
> This patch applies against linux-next and next-20150708=20
>=20
>=20
>  drivers/mfd/da9062-core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

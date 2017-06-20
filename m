From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 2/2] Input: pm8941-pwrkey: Introduce reboot mode support
Date: Tue, 20 Jun 2017 16:27:07 +0200
Message-ID: <20170620142707.wbfma6jbe5rmuw4d@earth>
References: <20170527065130.3456-1-bjorn.andersson@linaro.org>
 <20170527065130.3456-2-bjorn.andersson@linaro.org>
 <20170530025324.GD32841@dtor-ws>
 <20170530044711.GP12920@tuxbook>
 <20170608163243.j4dfpa6swoz27ofd@earth>
 <20170612233203.GT12920@tuxbook>
 <20170615162657.dgjsriesdzlqwzux@earth>
 <20170615183342.GX12920@tuxbook>
 <CAL_JsqJAErTqmfYXPReWpOsCnOi8b8u+Uk8mgB-BT3sksC8rFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aopeqpabdxkkrkdt"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59433 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdFTO1R (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 10:27:17 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqJAErTqmfYXPReWpOsCnOi8b8u+Uk8mgB-BT3sksC8rFw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, John Stultz <john.stultz@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--aopeqpabdxkkrkdt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 15, 2017 at 04:38:34PM -0500, Rob Herring wrote:
> On Thu, Jun 15, 2017 at 1:33 PM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > On Thu 15 Jun 09:26 PDT 2017, Sebastian Reichel wrote:
> >
> >> Hi,
> >>
> >> On Mon, Jun 12, 2017 at 04:32:03PM -0700, Bjorn Andersson wrote:
> > [..]
> >> > As such if we split the non-input related handling into another driv=
er
> >> > we would need to make the input driver create a subdevice during pro=
be -
> >> > or create a new pon-driver with a new compatible that internally spa=
wns
> >> > the pwrkey driver. Neither seems desirable to me...
> >>
> >> The pon-driver would have been the proper solution, but with the
> >> binding already being defined that's no longer a nice option :(
> >>
> >
> > We have a binding for the "qcom,pm8941-pwrkey", but as long as we
> > maintain the compatibility in the input driver with this we could come
> > up with a new binding for the "pon" block.
>=20
> Yes. My only objection was having the pon node with child devices
> purely because that is how Linux splits the driver.


So maybe 'compatible =3D "qcom,pm8041-pon", "qcom,pm8941-pwrkey";'
with pm8941-pwrkey being marked as deprecated in the binding?

> >> > The features of the PON block not yet shown on LKML are status regis=
ters
> >> > to indicate the reason for powering up the PMIC and a watchdog (whic=
h I
> >> > don't believe is used or exposed today).
> >>
> >> So we have a block, which has watchdog, powerdown, reboot, boot-reason,
> >> reboot-mode and power key. To me that does not look like it should be
> >> one driver.
> >>
> >
> > Unfortunately I do agree with this.
>=20
> As do I. But that is a separate decision from DT bindings.

not much of a discussion if everyone agrees? :)

> > It would make sense to describe the pon in a single DT-node and have a
> > pon-driver spawning off individual driver for each functionality. That
> > way we get a clean representation in DT and we get clean implementation
> > of each component...
>=20
> My objection here is we should not just create child nodes to align
> with current Linux driver needs.

Ack.

> That said, child nodes do sometimes make sense. If, for example,
> the key function was not fixed and you needed to configure what
> key function is used, then probably a child node makes sense.

Ack.

> It's always possible to add child nodes later without breaking
> compatibility. It's hard to remove them.

I don't think so. Adding a child node means, that we want to do
something based on the existance of this child node. So something,
that worked without the child node before no longer works
afterwards.

OTOH removing a child node means, that the child node is not needed
and stuff will work without it =3D> system still works.

-- Sebastian

--aopeqpabdxkkrkdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllJMLkACgkQ2O7X88g7
+ppTRBAAgp1/8zw9YUg6zgPCPUivy2EzODgsf/aYbrlU6+2UoBMghVwi+lvq3ZsE
MaLcO8Bhz9C5VQoaQcNwn3qnCRqySUnjM8//e4Prmu72OCfRYWoUek4vhn4MLP04
5+CUtOfkMJf97iZJJzuW1wcMoV21Sb3wmJfMzpNHLQ4EtH30TOTE0Id072lfpsSN
ceTaWJyq+aG0fTYqIYm6LNm9SQ+gCCdgeyuesVJ5qk6TcWfgJE7V2Y0u3oz6A6cM
cK0qG08WWYqiQmlLdS/+Qzr7HoX5SsMew54JC22NWWhxuAiVYOggtdbonfKdMM5J
CZr6cCUcrPSnSLjNxwrth0U3wDEKBCIRMpzPyhivhO/szRztuVmJ0S3XOOpRQ57j
DUIwCqe5TVyKKN/pz0afIMahICLNGcoVpJFFV/HYdTKo0jt2OA5YEG+lTHdu4Xke
+Yp68C6AGd7+lH3URlviTnP8SDAXLs44Uk1RNL5Swk/1pT9DHxeENJY/OVmWUvEW
qp+xzXCMxugxTF5P/+4PW+xhVZm0n0H4qY50pY6olpO0lcBT+QZfBv3BkAU2LLzB
ujBh9QvUz4h1qcCysO2r3v+5YUwKsu1zFjc+zKLPI+zljCDcCuphRktqnNfdTTSU
778bthqE5D9s5FOSJGMQbV+wcuQOtEBV5/0LeA6s8cC5BKxtapE=
=Wbm4
-----END PGP SIGNATURE-----

--aopeqpabdxkkrkdt--

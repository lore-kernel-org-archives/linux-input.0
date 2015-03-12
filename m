From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v6 09/22] mfd: ab8500: Use power_supply_*() API
 for accessing function attrs
Date: Thu, 12 Mar 2015 09:50:18 +0000
Message-ID: <20150312095017.GE3314@x1>
References: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
 <1426146260-30081-10-git-send-email-k.kozlowski@samsung.com>
 <20150312090156.GB3314@x1>
 <1426152267.31959.1.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426152267.31959.1.camel@AMDC1943>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 12 Mar 2015, Krzysztof Kozlowski wrote:
> On czw, 2015-03-12 at 09:01 +0000, Lee Jones wrote:
> > On Thu, 12 Mar 2015, Krzysztof Kozlowski wrote:
> >=20
> > > Replace direct calls to power supply function attributes with wra=
ppers.
> > > Wrappers provide safe access in case of unregistering the power
> > > supply (e.g. by removing the driver). Replace:
> > >  - get_property -> power_supply_get_property
> > >=20
> > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Reviewed-by: Sebastian Reichel <sre@kernel.org>
> > > ---
> > >  drivers/mfd/ab8500-sysctrl.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > Has the infrastructure for these been merged yet?
> >=20
> > I.e. Can I just take them?
>=20
> Previous patches were not merged yet so you cannot take it. This whol=
e
> patchset can be applied incrementally but cherry picking won't work.

So I only usually receive patches I've already Acked when a) the bulk
of the set has been merged and I can apply the remaining lingerers, or
b) the whole set is due to be applied through the MFD tree.

Receiving 2 patches of a 22 patch set, which I have already Acked and
that I can't pick is unwelcome noise.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

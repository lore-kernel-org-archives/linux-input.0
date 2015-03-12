From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v6 09/22] mfd: ab8500: Use power_supply_*() API
 for accessing function attrs
Date: Thu, 12 Mar 2015 12:03:51 +0000
Message-ID: <20150312120351.GA3383@x1>
References: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
 <1426146260-30081-10-git-send-email-k.kozlowski@samsung.com>
 <20150312090156.GB3314@x1>
 <1426152267.31959.1.camel@AMDC1943>
 <20150312095017.GE3314@x1>
 <1426156597.6371.5.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34596 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbbCLMD6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Mar 2015 08:03:58 -0400
Received: by wiwl15 with SMTP id l15so3324360wiw.1
        for <linux-input@vger.kernel.org>; Thu, 12 Mar 2015 05:03:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426156597.6371.5.camel@AMDC1943>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

On Thu, 12 Mar 2015, Krzysztof Kozlowski wrote:

> On czw, 2015-03-12 at 09:50 +0000, Lee Jones wrote:
> > On Thu, 12 Mar 2015, Krzysztof Kozlowski wrote:
> > > On czw, 2015-03-12 at 09:01 +0000, Lee Jones wrote:
> > > > On Thu, 12 Mar 2015, Krzysztof Kozlowski wrote:
> > > >=20
> > > > > Replace direct calls to power supply function attributes with=
 wrappers.
> > > > > Wrappers provide safe access in case of unregistering the pow=
er
> > > > > supply (e.g. by removing the driver). Replace:
> > > > >  - get_property -> power_supply_get_property
> > > > >=20
> > > > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > > > Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> > > > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > > > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.=
com>
> > > > > Reviewed-by: Sebastian Reichel <sre@kernel.org>
> > > > > ---
> > > > >  drivers/mfd/ab8500-sysctrl.c | 7 ++++---
> > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >=20
> > > > Has the infrastructure for these been merged yet?
> > > >=20
> > > > I.e. Can I just take them?
> > >=20
> > > Previous patches were not merged yet so you cannot take it. This =
whole
> > > patchset can be applied incrementally but cherry picking won't wo=
rk.
> >=20
> > So I only usually receive patches I've already Acked when a) the bu=
lk
> > of the set has been merged and I can apply the remaining lingerers,=
 or
> > b) the whole set is due to be applied through the MFD tree.
> >=20
> > Receiving 2 patches of a 22 patch set, which I have already Acked a=
nd
> > that I can't pick is unwelcome noise.
>=20
> Sorry for the noise, it should not happen.
>=20
> That is strange, how did you receive this patch? I resent this only t=
o
> certain recipients because previous mail got lost in spam filters (to=
o
> many recipients).
>=20
> I did not put other maintainers (like you) this time on cc-list.
> git-send-email also did not cc-ed you (your email is not listed in
> send-email log).
>=20
> How this email managed to get to you? :)

That's a good question.  It just arrived in my Inbox.

Anyway, not to worry.

Let me know when the other patches have been merged, so I can apply
these.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

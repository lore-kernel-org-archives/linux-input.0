From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] TWL6040: fix build error
Date: Thu, 10 May 2012 22:58:06 -0400
Message-ID: <20120511025806.GB24512@windriver.com>
References: <1336675473-24774-1-git-send-email-levinsasha928@gmail.com>
 <CAP=VYLqwAO8x4aWw7_pH1LH_SPO9Td2ec9oOmKPL-_5LOEQw3g@mail.gmail.com>
 <CA+1xoqf+Fjt=vMxnFz37t+mH5MBfc7iTZ0OF2fQdryyWk5TSKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:48008 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182Ab2EKC6M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 May 2012 22:58:12 -0400
Content-Disposition: inline
In-Reply-To: <CA+1xoqf+Fjt=vMxnFz37t+mH5MBfc7iTZ0OF2fQdryyWk5TSKA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: dmitry.torokhov@gmail.com, peter.ujfalusi@ti.com, broonie@opensource.wolfsonicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

[Re: [PATCH] TWL6040: fix build error] On 11/05/2012 (Fri 04:50) Sasha =
Levin wrote:

> On Fri, May 11, 2012 at 12:49 AM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > On Thu, May 10, 2012 at 2:44 PM, Sasha Levin <levinsasha928@gmail.c=
om> wrote:
> >> Fixes build error due to missing of_property_read_u32.
> >
> > Yes, I saw the same on x86-64 allyesconfig -- which means that in a=
ddition to
> > this missing header, it needs to have a Kconfig dependency that lim=
its
> > it to just being enabled on the platforms where it physically is po=
ssible to
> > have the hardware. =A0I'm guessing limiting to ARM would be a good =
start?
>=20
> I'm not sure how the actual hardware looks or even what it does, i
> just wanted to make sure that it doesn't break my x86 build. Which is
> why I'd rather not modify anything further than what I did in this
> patch.

Of course -- I was in the same boat.  I wasn't expecting you in
particular to add the Kconfig dependency, but rather instead I was
hoping someone who knows the platform details would make a proper one.

Paul.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

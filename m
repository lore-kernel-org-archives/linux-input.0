From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v6 13/22] HID: Change power supply ownership from driver to
 core
Date: Thu, 12 Mar 2015 08:47:31 +0100
Message-ID: <1426146451.29613.3.camel@AMDC1943>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
 <1425976046-20973-14-git-send-email-k.kozlowski@samsung.com>
 <20150310141444.GC11992@earth>
 <alpine.LNX.2.00.1503111207450.24876@pobox.suse.cz>
 <20150311184643.GA2380@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:64937 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbbCLHre (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Mar 2015 03:47:34 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NL300EGE9TXWG50@mailout2.w1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 12 Mar 2015 07:51:33 +0000 (GMT)
In-reply-to: <20150311184643.GA2380@earth>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On =C5=9Bro, 2015-03-11 at 19:46 +0100, Sebastian Reichel wrote:
> Hi Jiri,
>=20
> On Wed, Mar 11, 2015 at 12:08:09PM -0400, Jiri Kosina wrote:
> > On Tue, 10 Mar 2015, Sebastian Reichel wrote:
> > > On Tue, Mar 10, 2015 at 09:27:17AM +0100, Krzysztof Kozlowski wro=
te:
> > > > Change the ownership of power_supply structure from each driver
> > > > implementing the class to the power supply core.
> [...]
> > > >  [...]
> > > >  drivers/hid/hid-input.c                   |  51 ++++---
> > > >  drivers/hid/hid-sony.c                    |  43 +++---
> > > >  drivers/hid/hid-wiimote-modules.c         |  41 ++---
> > > >  drivers/hid/hid-wiimote.h                 |   3 +-
> > > >  drivers/hid/wacom.h                       |   8 +-
> > > >  drivers/hid/wacom_sys.c                   |  71 ++++-----
> > > >  [...]
> > > >  82 files changed, 2296 insertions(+), 1839 deletions(-)
> > >=20
> > > I would like to merge this patch via power-supply tree. Can you
> > > please provide your Acked-By?
> >=20
> > I don't see the patch neither on linux-input@ nor LKML. Could you p=
lease=20
> > bounce it my way so that I can review it?
>=20
> Krzysztof, can you take care of resending the patch? It looks like
> it got detected as SPAM by most vger.kernel.org mailinglists.
>=20
> It seems to have been received by LKML, though:
>=20
> https://lkml.org/lkml/2015/3/10/99 (currently broken?)
>=20
> Google Cache:
> https://webcache.googleusercontent.com/search?q=3Dcache:-FhPl4Qzm4wJ:=
https://lkml.org/lkml/2015/3/10/99+&cd=3D2&hl=3Dde&ct=3Dclnk
>=20

Sure, I just sent it. However the 13/22 patch is quite big so maybe it
will be always marked as spam. The 13th patch can be found also here:
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git/commit/4=
5a8ed8f5fe6fa7e60ad7d4a6a4b34ed671c4139

Best regards,
Krzysztof

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

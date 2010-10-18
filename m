From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Mon, 18 Oct 2010 01:20:48 -0700
Message-ID: <20101018082048.GC8655@core.coreip.homeip.net>
References: <4CBC6D61020000230002205F@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35163 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab0JRIUz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 04:20:55 -0400
Content-Disposition: inline
In-Reply-To: <4CBC6D61020000230002205F@novprvlin0050.provo.novell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: corentin.chary@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Sun, Oct 17, 2010 at 10:53:05PM -0600, Joey Lee wrote:
> Hi Dmitry,=20
>=20
> =E6=96=BC =E6=97=A5=EF=BC=8C2010-10-17 =E6=96=BC 21:07 -0700=EF=BC=8C=
Dmitry Torokhov =E6=8F=90=E5=88=B0=EF=BC=9A
> >=20
> > I believe that we simply need to tell EC to keep its hands off RF
> > switch. As long as key is properly reported through input layer rfk=
ill
> > should be able to control the RF equipment, either via rfkill-input
> > in-kernel shortcut or userspace daemon (when it is ready).
> >=20
>=20
> I agree EC don't need touch the RF switch by default, I will contact
> with them to discuss.
>=20
> But,=20
> Currently, the Acer BIOS already shipped to world wide, and BIOS guys
> give me tThat's why I contribute launch-manager mode patch to here.
>=20

I understand that certain BIOSes do, by default, toggle the switch. I
also believe that we want to disable this. The question that still is
not answered why we need the module option? Why don't we _always_
tell EC to keep its hands off RF switch?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

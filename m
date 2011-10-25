From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCHv4 4/6] input/cma3000_d0x: Add CMA3000 spi support
Date: Tue, 25 Oct 2011 10:29:29 +0200
Message-ID: <20111025082929.GC4605@ponder.secretlab.ca>
References: <1319487676-27181-1-git-send-email-ricardo.ribalda@gmail.com>
 <1319487676-27181-5-git-send-email-ricardo.ribalda@gmail.com>
 <20111024213635.GB4394@ponder.secretlab.ca>
 <CAPybu_3pF6u10JMmcbho1e7=8EPHMq8LQ1+uHpyVMOmbRMUsHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50137 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab1JYI3d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Oct 2011 04:29:33 -0400
Content-Disposition: inline
In-Reply-To: <CAPybu_3pF6u10JMmcbho1e7=8EPHMq8LQ1+uHpyVMOmbRMUsHA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, jic23@cam.ac.uk, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Oct 25, 2011 at 09:24:48AM +0200, Ricardo Ribalda Delgado wrote=
:
> Hello Grant
>=20
>   Thanks for your comments. I am fixing the  --- problem in all the p=
atches.
>=20
> >
> > Mark Brown had posted a generic indirect register read/write librar=
y
> > that I believe is getting merged. =A0Maybe this driver should be us=
ing
> > it?
>=20
> It is not on linux-next, and also it cannot be used directly, in orde=
r
> to read you have to do set reg=3D (reg << 2) | 2; And AFAIK it is not
> supported by the regmap
>=20
> >
> > Drop the .bus line. =A0The core code does this bit for you.
>=20
> Done
>=20
> >> +module_init(cma3000_spi_init);
> >> +module_exit(cma3000_spi_exit);
> >
> > move module_init() directly below the function it registers.
>=20
> Also done, but I believe the other is more elegant :)

:-p

g.

> >
> >> +
> >> +MODULE_DESCRIPTION("CMA3000-D0x Accelerometer SPI Driver");
> >> +MODULE_LICENSE("GPL");
> >> +MODULE_AUTHOR("Ricardo Ribalda <ricardo.ribalda@gmail.com>");
> >> --
> >> 1.7.7
> >>
> >
>=20
>=20
>=20
> --=20
> Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: psmouse - change log messages from psmouse.c to
 psmouse
Date: Mon, 10 Oct 2011 18:22:47 -0700
Message-ID: <20111011012247.GB11832@core.coreip.homeip.net>
References: <1317273295-4931-1-git-send-email-jj_ding@emc.com.tw>
 <4E83FF81.700@cn.fujitsu.com>
 <20111007063926.GA32142@core.coreip.homeip.net>
 <CAGS+omACkwB1GSxcFHiuvi43Q5dzx_m-K_85VHOJSKc3YUXSnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39550 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab1JKBWx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 21:22:53 -0400
Received: by gyg10 with SMTP id 10so5958977gyg.19
        for <linux-input@vger.kernel.org>; Mon, 10 Oct 2011 18:22:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGS+omACkwB1GSxcFHiuvi43Q5dzx_m-K_85VHOJSKc3YUXSnA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, JJ Ding <dgdunix@gmail.com>

Hi Daniel,

On Fri, Oct 07, 2011 at 06:07:28PM +0800, Daniel Kurtz wrote:
> Hi Dmitry,
>=20
> On Fri, Oct 7, 2011 at 2:39 PM, Dmitry Torokhov
> >
> > -static int synaptics_validate_byte(unsigned char packet[], int idx=
, unsigned char pkt_type)
>=20
> Why pass idx if we already have psmouse?
>=20
> static int synaptics_validate_byte(struct psmouse *psmouse, unsigned
> char pkt_type)

We are checking specific byte... If you look down we call the function
in a cycle over entire packet to fugure whether we need to do strict or
relaxed checking.

=2E..

> >
> > =A0 =A0 =A0 =A0if (synaptics_query_hardware(psmouse)) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to query Syna=
ptics hardware.\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "Unable to query=
 Synaptics hardware.\n");
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "unable to query de=
vice.\n");
>=20
> We can get rid of some more redundant "Synaptics"...
>=20

Good idea, I'll update the messages.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

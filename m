From: "DusonLin" <dusonlin@emc.com.tw>
Subject: RE: [PATCH v2] elan_i2c - Don't require known iap version
Date: Tue, 22 Sep 2015 07:47:26 +0800
Message-ID: <022801d0f4c7$e20a00c0$a61e0240$@emc.com.tw>
References: <1442583495-4593-1-git-send-email-drake@endlessm.com> <20150919171047.GA7081@dtor-ws> <CAD8Lp44muN-edhKxs4Vn+eC-aoEgtmkboz9zywDtp65SH4yfpQ@mail.gmail.com> <20150921161740.GB17389@dtor-ws> <20150921162123.GC17389@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:34180 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756192AbbIUXrd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2015 19:47:33 -0400
In-Reply-To: <20150921162123.GC17389@dtor-ws>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Daniel Drake' <drake@endlessm.com>
Cc: =?iso-8859-1?Q?'Jo=E3o_Paulo_Rechi_Vita'?= <jprvita@gmail.com>, linux-input@vger.kernel.org

Hi Dmitry,

Sure, not only 0x0E but also others, I will send you a patch.

Thank you,
Duson

-----Original Message-----
=46rom: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]=20
Sent: Tuesday, September 22, 2015 12:21 AM
To: Daniel Drake
Cc: DusonLin; Jo=E3o Paulo Rechi Vita; linux-input@vger.kernel.org
Subject: Re: [PATCH v2] elan_i2c - Don't require known iap version

On Mon, Sep 21, 2015 at 09:17:40AM -0700, Dmitry Torokhov wrote:
> On Mon, Sep 21, 2015 at 08:28:17AM -0600, Daniel Drake wrote:
> > On Sat, Sep 19, 2015 at 11:10 AM, Dmitry Torokhov=20
> > <dmitry.torokhov@gmail.com> wrote:
> > > I do not like the fact that the fact that the version of IAP is=20
> > > unknown is not known to the driver until we try to flash the=20
> > > firmware. I'd rather we check it upfront and warn user.
> > >
> > > How about the version of the patch below?
> >=20
> > That looks fine and I also confirmed that the new patch is working =
as
described.
>=20
> Great, I am applying this then.

Duson, by the way, what is the FW parameters for iap 0x0e? Could you se=
nd me
a patch?

Thanks!

--
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

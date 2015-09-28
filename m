From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: drivers/joystick: use parallel port device
 model
Date: Mon, 28 Sep 2015 16:23:18 -0700
Message-ID: <20150928232318.GB32307@dtor-ws>
References: <1438698351-24604-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150813162602.GA15693@dtor-ws>
 <20150814065541.GA25515@sudip-pc>
 <201509281840.51662@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35362 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbbI1XXW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 19:23:22 -0400
Content-Disposition: inline
In-Reply-To: <201509281840.51662@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, gregkh@linuxfoundation.org

On Mon, Sep 28, 2015 at 06:40:51PM +0200, Pali Roh=E1r wrote:
> On Friday 14 August 2015 08:55:42 Sudip Mukherjee wrote:
> > > > Pali Roh=E1r has the hardware and he is ready to test it.
> > >=20
> > > Pali, could you give the v2 version of the patch a spin
> > > (https://patchwork.kernel.org/patch/6940321/)?
> >=20
> > Adding Pali to the cc list.
> >=20
> > Hi Pali,
> > Are you still away from your desktop with the joystick? or can it b=
e
> > tested?
> >=20
> > regards
> > sudip
>=20
> Hi all!
>=20
> I'm back with testing on desktop.
>=20
> Now I applied above patch on top of 4.2 kernel and patched db9.ko mod=
ule=20
> works fine with my joystick. xserver-xorg-input-joystick still recogn=
ize=20
> it and works fine as pointer device.
>=20
> If you are curious I have connected this model to parallel port:
> https://www.c64-wiki.com/index.php/Quickshot#Quickshot_II_1983
>=20
> It is identified as "Multisystem joystick", loaded with modprobe conf=
ig:
> options db9 dev=3D0,1
>=20
> So now you can add my:
>=20
> Tested-By: Pali Roh=E1r <pali.rohar@gmail.com>

Applied, thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

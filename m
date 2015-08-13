From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: drivers/joystick: use parallel port device
 model
Date: Thu, 13 Aug 2015 09:26:02 -0700
Message-ID: <20150813162602.GA15693@dtor-ws>
References: <1438698351-24604-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150808103515.GC1301@sudip-pc>
 <20150813134614.GA29298@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35109 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbbHMQ0G (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2015 12:26:06 -0400
Content-Disposition: inline
In-Reply-To: <20150813134614.GA29298@sudip-pc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, gregkh@linuxfoundation.org

On Thu, Aug 13, 2015 at 07:16:14PM +0530, Sudip Mukherjee wrote:
> On Sat, Aug 08, 2015 at 04:05:15PM +0530, Sudip Mukherjee wrote:
> > On Tue, Aug 04, 2015 at 07:55:51PM +0530, Sudip Mukherjee wrote:
> > > Modify db9 driver to use the new Parallel Port device model.
> > >=20
> > > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > > ---
> > >=20
> > > v2: an extra check was removed. db9_base could not be removed. Al=
ready
> > > mailed you the reasons, reference is at:
> > > https://lkml.org/lkml/2015/8/3/403
> >=20
> > Hi Dmitry,
> > I was telling you on the other thread that to remove db9_base we wi=
ll
> > need to modify the parport code and then it has to be tested by eve=
ryone
> > again and that will also change the old behaviour of parport. The v=
2 to
> > which I am replying now is still having that db9_base.
> >=20
> > Please see the following patch, this is the minimum change required=
 to
> > update db9 driver. Personally I donot like this approach as in this
> > method if a parallel port is hotplugged after this driver is loaded=
 then
> > it will not work. Please let me know your views on the posted v2 an=
d
> > also on the following proposal.
>=20
> Hi Dmitry,
> Did you have a chance to look at this?

Right, so I agree that we should allow for hotplug and so the v2 is in
that sense is better than v3.

I still would prefer for the core to keep track of relationship between
devices and drivers, but if you would prefer to postpone implementing i=
t
that woudl be fine.

> Pali Roh=E1r has the hardware and he is ready to test it.

Pali, could you give the v2 version of the patch a spin
(https://patchwork.kernel.org/patch/6940321/)?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

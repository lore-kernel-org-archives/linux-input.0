From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v2] Input: drivers/joystick: use parallel port device
 model
Date: Mon, 17 Aug 2015 12:59:34 +0530
Message-ID: <20150817072934.GA12361@sudip-pc>
References: <1438698351-24604-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150808103515.GC1301@sudip-pc>
 <20150813134614.GA29298@sudip-pc>
 <20150813162602.GA15693@dtor-ws>
 <20150814065541.GA25515@sudip-pc>
 <20150814070555.GA6877@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36010 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbbHQH3p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Aug 2015 03:29:45 -0400
Content-Disposition: inline
In-Reply-To: <20150814070555.GA6877@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, gregkh@linuxfoundation.org

On Fri, Aug 14, 2015 at 09:05:55AM +0200, Pali Roh=E1r wrote:
> On Friday 14 August 2015 12:25:42 Sudip Mukherjee wrote:
> > On Thu, Aug 13, 2015 at 09:26:02AM -0700, Dmitry Torokhov wrote:
> > > On Thu, Aug 13, 2015 at 07:16:14PM +0530, Sudip Mukherjee wrote:
> > > > Pali Roh=E1r has the hardware and he is ready to test it.
> > >=20
> > > Pali, could you give the v2 version of the patch a spin
> > > (https://patchwork.kernel.org/patch/6940321/)?
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
> Yes, I'm still away from desktop with joystick... First I need to kno=
w
> against which kernel version can be that patch tested? I remember tha=
t
> v1 applied correctly against ubuntu's default 3.13 (which is installe=
d
> on that desktop) but driver did not compiled.

Sorry for the delay in replying. The change in parallel port code was
merged in 4.2, so you can test it againt 4.2-rc*.

regards
sudip
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

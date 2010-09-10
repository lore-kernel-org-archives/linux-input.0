From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH 0/8 V5] Many fixes for in-kernel decoding and for the ENE
 driver
Date: Fri, 10 Sep 2010 09:03:52 -0400
Message-ID: <20100910130352.GB13554@redhat.com>
References: <1283808373-27876-1-git-send-email-maximlevitsky@gmail.com>
 <4C8805FA.3060102@infradead.org>
 <20100908224227.GL22323@redhat.com>
 <AANLkTikBVSYpD_+qomCad-OvXg6CRam4b01wSBV-pNw8@mail.gmail.com>
 <20100910020129.GA26845@redhat.com>
 <8a996e53b4af7b2c4702e6a3c8700fd8.squirrel@www.hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21562 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753619Ab0IJNEI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Sep 2010 09:04:08 -0400
Content-Disposition: inline
In-Reply-To: <8a996e53b4af7b2c4702e6a3c8700fd8.squirrel@www.hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: Jarod Wilson <jarod@wilsonet.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Maxim Levitsky <maximlevitsky@gmail.com>, lirc-list@lists.sourceforge.net, linux-input@vger.kernel.org, linux-media@vger.kernel.org

On Fri, Sep 10, 2010 at 10:08:24AM +0200, David H=E4rdeman wrote:
> On Fri, September 10, 2010 04:01, Jarod Wilson wrote:
> > Wuff. None of the three builds is at all stable on my laptop, but I=
 can't
> > actually point the finger at any of the three patchsets, since I'm =
getting
> > spontaneous lockups doing nothing at all before even plugging in a
> > receiver. I did however get occasional periods of a non-panicking (=
not
> > starting X seems to help a lot). Initial results:
>=20
> If you get lockups without even plugging in a receiver, does that mea=
n
> that the rc-core driver hasn't even been loaded at that point?

Correct, no rc-core bits loaded at all at this point.

--=20
Jarod Wilson
jarod@redhat.com

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

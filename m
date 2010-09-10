From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 0/8 V5] Many fixes for in-kernel decoding and for the
     ENE driver
Date: Fri, 10 Sep 2010 10:08:24 +0200 (CEST)
Message-ID: <8a996e53b4af7b2c4702e6a3c8700fd8.squirrel@www.hardeman.nu>
References: <1283808373-27876-1-git-send-email-maximlevitsky@gmail.com>
    <4C8805FA.3060102@infradead.org> <20100908224227.GL22323@redhat.com>
    <AANLkTikBVSYpD_+qomCad-OvXg6CRam4b01wSBV-pNw8@mail.gmail.com>
    <20100910020129.GA26845@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:39169 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab0IJII1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Sep 2010 04:08:27 -0400
In-Reply-To: <20100910020129.GA26845@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: Jarod Wilson <jarod@wilsonet.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Maxim Levitsky <maximlevitsky@gmail.com>, lirc-list@lists.sourceforge.net, linux-input@vger.kernel.org, linux-media@vger.kernel.org

On Fri, September 10, 2010 04:01, Jarod Wilson wrote:
> Wuff. None of the three builds is at all stable on my laptop, but I c=
an't
> actually point the finger at any of the three patchsets, since I'm ge=
tting
> spontaneous lockups doing nothing at all before even plugging in a
> receiver. I did however get occasional periods of a non-panicking (no=
t
> starting X seems to help a lot). Initial results:

If you get lockups without even plugging in a receiver, does that mean
that the rc-core driver hasn't even been loaded at that point?

--=20
David H=E4rdeman

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

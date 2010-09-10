From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH 5/8] IR: extend MCE keymap.
Date: Fri, 10 Sep 2010 09:18:29 -0400
Message-ID: <20100910131829.GD13554@redhat.com>
References: <1283808373-27876-1-git-send-email-maximlevitsky@gmail.com>
 <1283808373-27876-6-git-send-email-maximlevitsky@gmail.com>
 <AANLkTi=EFZys7NnxixmQL3hqqGfin_VOV7XAWCm0BkwT@mail.gmail.com>
 <1284079254.4828.6.camel@maxim-laptop>
 <AANLkTik4HAspKxOpH1VcT0+TnGa=H+-M2Wpxg5MefPg1@mail.gmail.com>
 <b8a480a446ba264233deebe1e514141a.squirrel@www.hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12625 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753673Ab0IJNSn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Sep 2010 09:18:43 -0400
Content-Disposition: inline
In-Reply-To: <b8a480a446ba264233deebe1e514141a.squirrel@www.hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: Jarod Wilson <jarod@wilsonet.com>, Maxim Levitsky <maximlevitsky@gmail.com>, lirc-list@lists.sourceforge.net, mchehab@infradead.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org

On Fri, Sep 10, 2010 at 10:27:02AM +0200, David H=E4rdeman wrote:
> On Fri, September 10, 2010 03:37, Jarod Wilson wrote:
> > I think for mythtv, we're going to end up having a daemon process w=
ith
> > elevated privs that reads directly from input devices to get around
> > this annoyance, until such time as the annoyance is gone.
>=20
> A similar approach could work for XBMC since it already has input plu=
gins
> (e.g. for using a Nintendo Wii controller, etc).

While attempting to drift off to sleep last night, it occurred to me th=
at
lircd already has support for attaching to input devices, so it might b=
e
an option to extend lircd and the lirc client library to have a "pass r=
aw
keycodes" mode. Both xmbc and mythtv already have options to build in l=
irc
client support, so it'd just be minor extension of its use in both case=
s,
at least in theory...

--=20
Jarod Wilson
jarod@redhat.com

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

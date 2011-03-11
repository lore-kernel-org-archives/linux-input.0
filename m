From: Andres Salomon <dilinger@queued.net>
Subject: Re: [PATCH] Input: enable i8042-level wakeup control
Date: Fri, 11 Mar 2011 09:41:52 +0000
Message-ID: <20110311094152.42c51944@debxo>
References: <20110210171607.D0D419D401D@zog.reactivated.net>
	<20110311010117.18968941@queued.net>
	<AANLkTikpaM2aSUUiVuQExE-Nen=rhsTJUXTEv75bCa-m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LUNGE.MIT.EDU ([18.54.1.69]:51227 "EHLO lunge.queued.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072Ab1CKJlI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 04:41:08 -0500
In-Reply-To: <AANLkTikpaM2aSUUiVuQExE-Nen=rhsTJUXTEv75bCa-m@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, rjw@sisk.pl

On Fri, 11 Mar 2011 09:33:42 +0000
Daniel Drake <dsd@laptop.org> wrote:

> On 11 March 2011 09:01, Andres Salomon <dilinger@queued.net> wrote:
> > What exactly is the purpose of this? =A0 I see this allows various
> > architectures to provide an override here, but it seems like this
> > functionality wasn't previously present (they all just used
> > i8042_pm_reset). =A0Do you have a later patch that makes use of thi=
s
> > or something?
>=20
> Yes, it was mentioned in the original submission:
> http://dev.laptop.org/~dsd/20110114/0015-i8042-Enable-OLPC-s-EC-based=
-i8042-wakeup-control.patch
>=20
> Daniel

Ah, right, and that handles enabling for OLPC as well.  Looks good to
me.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

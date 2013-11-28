From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC][PATCH] Input: define keys for WWAN and SES
Date: Thu, 28 Nov 2013 15:14:25 +0100
Message-ID: <1385648065.17991.11.camel@nuvo>
References: <1385639293-23225-1-git-send-email-zajec5@gmail.com>
	 <529731CB.3010107@hauke-m.de>
	 <CACna6rz58KybJ4dMPWUwXzR6QkQXnkdu_5zvQWteBaepikS0UA@mail.gmail.com>
	 <1385643706.17991.9.camel@nuvo>
	 <CACna6ry8gE28ke=yNgO1OC_ahzcN0EStfpDhFoFL9+N_yddpHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52381 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab3K1OOd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Nov 2013 09:14:33 -0500
In-Reply-To: <CACna6ry8gE28ke=yNgO1OC_ahzcN0EStfpDhFoFL9+N_yddpHg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Thu, 2013-11-28 at 15:06 +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> 2013/11/28 Bastien Nocera <hadess@hadess.net>:
> > On Thu, 2013-11-28 at 13:32 +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> >> I'm just not sure about possible scenarios. I imagined end-user
> >> pressing SES button router and SES button on a device and complain=
ing
> >> it's not working (because of SES being interpreted as WPS).
> >>
> >> If you guys think we should just use WPS for the SES button, I'm O=
K with that.
> >
> > Isn't the fact that it returns WPS or SES an implementation detail?
> >
> > Is WPS vs. SES just a software choice, or a hardware one? If it's a
> > hardware one, you'd expect to have other ways to discover whether S=
ES or
> > WPS was requested (because that's the one supported by the hardware=
). If
> > it's a software choice, then you'd expect the button to one or the =
other
> > based on the software stack.
> >
> > Or are both possible at the same time, and there are devices with b=
oth
> > buttons?
> >
> > Seems that adding a note that other similar "pairing" methods for W=
i-Fi
> > could be triggered when the button is used, in input.h would be eno=
ugh.
>=20
> I think it's just a software thing (some EAP messages probably).
>=20
> Thanks for your comments!
>=20
> What about KEY_WWAN. Does it make sense to add it?

If there are "keys" with that sort of label, it would make sense to me.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

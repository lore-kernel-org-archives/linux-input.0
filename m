From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC][PATCH] Input: define keys for WWAN and SES
Date: Thu, 28 Nov 2013 14:01:46 +0100
Message-ID: <1385643706.17991.9.camel@nuvo>
References: <1385639293-23225-1-git-send-email-zajec5@gmail.com>
	 <529731CB.3010107@hauke-m.de>
	 <CACna6rz58KybJ4dMPWUwXzR6QkQXnkdu_5zvQWteBaepikS0UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42564 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab3K1NBw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Nov 2013 08:01:52 -0500
In-Reply-To: <CACna6rz58KybJ4dMPWUwXzR6QkQXnkdu_5zvQWteBaepikS0UA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Thu, 2013-11-28 at 13:32 +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> 2013/11/28 Hauke Mehrtens <hauke@hauke-m.de>:
> > On 11/28/2013 12:48 PM, Rafa=C5=82 Mi=C5=82ecki wrote:
> >> This is just a RFC, so be nice to this "patch", please ;)
> >>
> >> My goal is to add support for buttons on bcm47xx arch. However aft=
er
> >> analyzing existing database of devices I realized I don't know wha=
t code
> >> I should assign to some buttons.
> >>
> >> First of all, older routers often have a "SES" button. SES stands =
for
> >> SecureEasySetup and is Broadcom's proprietary protocol which was l=
ater
> >> replaced with WPS (Wi-Fi Protected Setup).
> >> Btw. WPS appeared to be broken because it's easy to attack it with
> >> brutal-force method.
> >
> > Only a badly implemented WPS pin authentication is vulnerable to th=
e
> > brute force attack, as far as I know.
>=20
> Oh, indeed, I missed that. Thanks!
>=20
> >> I'm not sure if any distribution have any interest
> >> in using that buttons, but it still would be nice to have support =
for
> >> them in kernel. One option is to add KEY_SES for this purpose.
> >> Is this the right way? It's similar to the KEY_WPS_BUTTON, but I w=
anted
> >> to somehow distinct them. Is there any other option? Should I use
> >> KEY_UNKNOWN or BTN_MISC or BTN_n?
> >
> > I do not think you or someone else plans to implement SecureEasySet=
up on
> > a device running current Linux kernel, why not use the WPS button k=
ey
> > for for these button. If someone wants to implement this just use t=
he
> > WPS button key for that.
>=20
> I'm just not sure about possible scenarios. I imagined end-user
> pressing SES button router and SES button on a device and complaining
> it's not working (because of SES being interpreted as WPS).
>=20
> If you guys think we should just use WPS for the SES button, I'm OK w=
ith that.

Isn't the fact that it returns WPS or SES an implementation detail?

Is WPS vs. SES just a software choice, or a hardware one? If it's a
hardware one, you'd expect to have other ways to discover whether SES o=
r
WPS was requested (because that's the one supported by the hardware). I=
f
it's a software choice, then you'd expect the button to one or the othe=
r
based on the software stack.

Or are both possible at the same time, and there are devices with both
buttons?

Seems that adding a note that other similar "pairing" methods for Wi-Fi
could be triggered when the button is used, in input.h would be enough.

Cheers

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

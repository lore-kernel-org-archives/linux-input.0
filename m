From: Niels Skou Olsen <nolsen@jabra.com>
Subject: RE: [PATCH] HID: Remove Jabra speakerphone devices from ignore list
Date: Fri, 15 Sep 2017 07:52:27 +0000
Message-ID: <VI1PR0701MB2991B9069D430C5DA6A91618DA6C0@VI1PR0701MB2991.eurprd07.prod.outlook.com>
References: <CAP_ceTxM-Rgz=i6Zy_iBOa1Cs5D=5Hi0BgWzQKmXoWmL_9TBWA@mail.gmail.com>
 <VI1PR0701MB2991A0071AE574E241AD37D6DA680@VI1PR0701MB2991.eurprd07.prod.outlook.com>
 <CAP_ceTz-9vYpo1xqUnEF=LtWcGhxx5FiTo7xJwLreL5vYx7xww@mail.gmail.com>
 <VI1PR0701MB299142D55AF9734A4BC5CADADA690@VI1PR0701MB2991.eurprd07.prod.outlook.com>
 <CAP_ceTzwOgA6e2gO2fc8vzps4mUJkxC=LzoGEACHcLKkoygXpA@mail.gmail.com>
 <20170913170238.GB13863@mail.corp.redhat.com>
 <nycvar.YFH.7.76.1709131009350.4703@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-db5eur01on0071.outbound.protection.outlook.com ([104.47.2.71]:3161
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750838AbdIOHwb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 15 Sep 2017 03:52:31 -0400
In-Reply-To: <nycvar.YFH.7.76.1709131009350.4703@jbgna.fhfr.qr>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Cc: Vincent Palatin <vpalatin@chromium.org>, Richard Hughes <richard@hughsie.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "mnilsson@chromium.org" <mnilsson@chromium.org>

On Wed, 13 Sep 2017, jikos@kernel.org wrote:

> On Wed, 13 Sep 2017, benjamin.tissoires@redhat.com wrote:
>
> > I do not see a reason not to. Maybe Jiri will, but the fact that one
> > version works and one doesn't seem enough to allow such specific
> > blacklisting.
>
> The blacklist matching currently doesn't support that, but it'd be trivia=
l to match, and I
> actually think it generally makes sense to me. So feel free (once you guy=
s settle on
> solution that both Chromium and Jabr folk find acceptable) to send this t=
ogether with
> a hid-core patch that'd add a possibility to perform per-fw-version match=
ing.

Great! Shall I give it a shot? Or is there someone with more intimate knowl=
edge
about hid-core that wants to do it?

How should it work?

A simple setup would be to attach an optional list of blacklisted firmware =
versions
to each entry in hid_ignore_list[]? If this list is empty, all firmware ver=
sions are
blacklisted. The attached list could just be a static array. Would this be =
acceptable?

Thanks,
Niels

**** GN GROUP NOTICE - AUTOMATICALLY INSERTED**** The information in this e=
-mail (including attachments, if any) is considered confidential and is int=
ended only for the recipient(s) listed above. Any review, use, disclosure, =
distribution or copying of this e-mail is prohibited except by or on behalf=
 of the intended recipient. If you have received this email in error, pleas=
e notify me immediately by reply e-mail, delete this e-mail, and do not dis=
close its contents to anyone. Any opinions expressed in this e-mail are tho=
se of the individual and not necessarily the GN group. Thank you. *********=
*********** DISCLAIMER END ************************

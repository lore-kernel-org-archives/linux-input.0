From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: HID generic-bluetooth driver
Date: Sun, 8 May 2011 17:02:54 +0200
Message-ID: <20110508150253.GA3271@lovely.krouter>
References: <BANLkTi=tUNCMyCKVEXtv0W=8jYbK-k7HMg@mail.gmail.com>
 <1304855553.4742.3.camel@mars>
 <BANLkTim7BJHV528DvJZvSnzmTzFjn=4qSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35184 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab1EHPLD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 May 2011 11:11:03 -0400
Received: by wwa36 with SMTP id 36so4976090wwa.1
        for <linux-input@vger.kernel.org>; Sun, 08 May 2011 08:11:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTim7BJHV528DvJZvSnzmTzFjn=4qSw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi

On Sun, May 08, 2011 at 02:20:40PM +0200, David Herrmann wrote:
> On Sun, May 8, 2011 at 1:52 PM, Christoph Fritz
> <chf.fritz@googlemail.com> wrote:
> > =A0you can add it to hid_have_special_driver[] (drivers/hid/hid-cor=
e.c).
> >
>=20
> Since I cannot see any MODULE_DEVICE_TABLE() entry there, I guess I
> can't extend this table on runtime?

No you can't extend this table at runtime.

> Adding my device there helped. Thank you.
>=20

You are welcome.

 happy hacking,
  -- chf

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

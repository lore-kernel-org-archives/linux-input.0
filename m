From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for 3.5-rc0
Date: Thu, 24 May 2012 13:36:47 -0700
Message-ID: <20120524203647.GA16024@core.coreip.homeip.net>
References: <20120524083216.GD10562@core.coreip.homeip.net>
 <CA+55aFxw0HRpizzJZxhhA2oqPpzg4DPUvH2r7YoYfctXS6K=WQ@mail.gmail.com>
 <20120524180154.GA15036@core.coreip.homeip.net>
 <CA+55aFx0ww=BtYAj9WEbqMT2R30ZZpjd014cYCpC=b+HRtUf_A@mail.gmail.com>
 <20120524195851.GA15306@core.coreip.homeip.net>
 <CA+55aFxX+xidcuVXb1h4oFTemtHo+ANECaoOw=vxtKN231N+cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57368 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab2EXUgx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 16:36:53 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFxX+xidcuVXb1h4oFTemtHo+ANECaoOw=vxtKN231N+cA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, May 24, 2012 at 01:11:14PM -0700, Linus Torvalds wrote:
> On Thu, May 24, 2012 at 12:58 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> >  Considering your
> >
> > =A0 =A0 =A0 =A0dev_set_name(&dev->dev, "input-%s", dev_name(dev->de=
v.parent));
> >
> > what happens if I unplug and replug my wacom tablet while event nod=
e is
> > still opened and therefore all kobjects are still pinned into memor=
y?
>=20
> I'll let you think about just how stupid that comment was for a momen=
t.

Hmm, I guess we are better now with cleaning and turning devices into
zombies waiting to be reaped. Still have to handle parent have several
input devices (HID devices quite often do it). And I still do not see
the point why we want to bother, the proper layer to report driver
errors is driver and object it is bound to.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

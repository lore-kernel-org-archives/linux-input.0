From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: joydev - fix axes values sent in initial
 js_event
Date: Wed, 12 Sep 2012 21:52:06 -0700
Message-ID: <20120913045206.GB17105@core.coreip.homeip.net>
References: <1344895914-32127-1-git-send-email-vbocek@gmail.com>
 <20120905055218.GA24715@core.coreip.homeip.net>
 <CAOeGmboLCan-fX4sPPxS5jkyepxLTSnRgvdHJ0-edcH8UCQg+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48655 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab2IMEwM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 00:52:12 -0400
Content-Disposition: inline
In-Reply-To: <CAOeGmboLCan-fX4sPPxS5jkyepxLTSnRgvdHJ0-edcH8UCQg+w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?Vm9qdMSbY2ggQm/EjWVr?= <vbocek@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 05, 2012 at 10:09:57PM +0200, Vojt=C4=9Bch Bo=C4=8Dek wrote=
:
> Hi,
>=20
> 2012/9/5 Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > So what guarantees that joystick events will arrive in time, before
> > joydev_generate_startup_event() is called? It looks like your solut=
ion
> > is racy...
> >
> > I wonder if we should not generate the startup event until we have =
seen
> > at least one EV_SYN, i.e. entire device state has been transmitted =
to
> > us.
>=20
> I just tried to delay read() until first EV_SYN arrives as you sugges=
ted,
> but that was not the problem, at least not the main one. First joysti=
ck
> input events arrives immediately after it is plugged in and driver is=
 loaded,
> but when that happens, joydev may not be (and most likely is not)
> opened yet, which means the events will never reach joydev because of
> "if (!handle->open)" check in input_pass_event.
>=20
> I wonder how to handle this. Is "if(!handle->open)" valid check? I th=
ink so,
> my guess is that joydev is the only handler with internal buffer, and=
 it
> is useless to update that buffer when the device is not opened.
> I think reloading abs values on joydev open should be okay.
>=20
> I suppose that if we reload abs values on joydev open, waiting for fi=
rst
> sync is not needed, yes?
>=20
> So the patch could look like this:

This makes sense. Just to confirm - have you tried the patch and
verified it works for you?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

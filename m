From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/5] Input: serio_raw - add monitor/replay debugging
 interface
Date: Fri, 20 Apr 2012 23:21:30 -0700
Message-ID: <20120421062130.GC27551@core.coreip.homeip.net>
References: <1328084386-31110-1-git-send-email-clchiou@chromium.org>
 <1328671497-20880-1-git-send-email-clchiou@chromium.org>
 <CAGS+omDWrSyLtDYWAubyc5F=BUqKOnKmCnyWPn5nNcoREar_aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:53148 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981Ab2DUGVh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Apr 2012 02:21:37 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omDWrSyLtDYWAubyc5F=BUqKOnKmCnyWPn5nNcoREar_aw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@google.com>
Cc: Che-Liang Chiou <clchiou@chromium.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Feb 14, 2012 at 11:18:38AM +0800, Daniel Kurtz wrote:
> On Wed, Feb 8, 2012 at 11:24 AM, Che-Liang Chiou <clchiou@chromium.or=
g> wrote:
> >
> > The serio_raw driver is designed to provide "raw access" to mice, k=
eyboards
> > etc; thus, a driver accessing serio_raw may live entirely in userla=
nd.
> >
> > However, serio_raw lacks testability. =A0It is practically impossib=
le to do
> > regression tests on changes to a serio_raw -based userland driver. =
=A0On the other
> > hand, the kernel's input subsystem has good testability support. =A0=
With the help
> > of tools like utouch-evemu, we may capture and replay input events =
for evdev
> > drivers in regression tests.
> >
> > This patchset contains extensions to the serio_raw driver which add=
 debugfs
> > entries for monitoring and replaying byte sequence between a userla=
nd driver
> > and device. =A0These byte sequences can be used in regression tests=
 of the
> > userland driver. =A0This patchset closes the gap between serio_raw =
and the input
> > subsystem regarding testability.
> >
> > This patchset is successfully applied on kernel version 3.3-rc2.
> >
> > Che-Liang Chiou (5):
> > =A0Input: serio_raw - return proper result when serio_raw_read fail=
s
> > =A0Input: serio_raw - extract queue interface
> > =A0Input: serio_raw - factor out common pattern of write
> > =A0Input: serio_raw - add debugfs interface
> > =A0Input: serio_raw - implement debugfs interface
>=20
> For patches 3-5:
> Reviewed-by: Daniel Kurtz <djkurtz@google.com>
>=20
> For patch 1 (and its implication on queue_read() in patch 2, I'd
> prefer to hear feedback from the list.

I have already taken the patch 1, but I am unsure why we need kernel
support for the monitor and replay. It seems you should only need a
userspace program that would sit between the driver being tested and
serio_raw misc device and pipe data back and forth, optionally saving
it for subsequent replay.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

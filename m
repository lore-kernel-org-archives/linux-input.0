From: Bernhard Seibold <lists@e404.de>
Subject: Re: Lenovo Keyboard with TrackPoint
Date: Tue, 24 Jan 2012 14:37:10 +0100
Message-ID: <20120124143710.5242ae0c@e404.de>
References: <CAH4eiUgTN7GvWE_bw0aVBKNipJpgg7euFGmWSY=o9i6FkSp3Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mcp.e404.de ([78.47.239.181]:56616 "EHLO mcp.e404.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755116Ab2AXNos convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jan 2012 08:44:48 -0500
In-Reply-To: <CAH4eiUgTN7GvWE_bw0aVBKNipJpgg7euFGmWSY=o9i6FkSp3Vw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: CC <ccomren@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, 20 Jan 2012 17:06:25 +0100
CC <ccomren@gmail.com> wrote:

> I couldn't find a follow-up thread to
> http://www.spinics.net/lists/linux-input/msg15423.html
>=20
> Is there a reason this was not commited into the main kernel?
>=20
> Thanks, =A0CC

Hi!

I didn't get much feedback on my patch, and since 2.6.30 had a patch
that made it possible to set the sensitivity from userspace using
hidraw, I had no reason to further try getting this patch in.
There's a slightly updated version available on github.

https://github.com/bseibold/linux-2.6/tree/tpkbd

It also includes support for controlling the LEDs in the mute keys, but
this has a few problems regarding naming of the registered LEDs.

If someone wants to get this patch in, please give me some feedback and
I'll try to update it accordingly and resubmit it.

Regards,
Bernhard
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

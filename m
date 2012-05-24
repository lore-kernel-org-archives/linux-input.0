From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Input updates for 3.5-rc0
Date: Thu, 24 May 2012 14:59:21 -0700
Message-ID: <CA+55aFwTo=Q2b1oERe31Lpc6BL5UBhURmB0N21=87TZJA8mWvw@mail.gmail.com>
References: <CA+55aFxw0HRpizzJZxhhA2oqPpzg4DPUvH2r7YoYfctXS6K=WQ@mail.gmail.com>
 <20120524180154.GA15036@core.coreip.homeip.net> <CA+55aFx0ww=BtYAj9WEbqMT2R30ZZpjd014cYCpC=b+HRtUf_A@mail.gmail.com>
 <20120524195851.GA15306@core.coreip.homeip.net> <CA+55aFxX+xidcuVXb1h4oFTemtHo+ANECaoOw=vxtKN231N+cA@mail.gmail.com>
 <20120524203647.GA16024@core.coreip.homeip.net> <CA+55aFz9Fp2J=oCkoDAwNTnEJoBeKC9tn+5dqMCKf4C22CAi6Q@mail.gmail.com>
 <20120524205952.GA16621@core.coreip.homeip.net> <CA+55aFybQDXjGaEK0k=60gS88bxwE8vC7XvOffaQAf3de9cCfg@mail.gmail.com>
 <CA+55aFzZm2aAhgZagWq=rsfKTt=2_2_mpVjXDN3LAqAJmWoZqw@mail.gmail.com> <20120524215654.GB17452@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45615 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933919Ab2EXV7m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 17:59:42 -0400
In-Reply-To: <20120524215654.GB17452@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, May 24, 2012 at 2:56 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Maybe we could traverse up the tree till we find first non-class devi=
ce
> (i.e. device with real driver bound to it)? Then we'd have:
>
> =A0 =A0 =A0 =A0wacom 2-1.2:1.0/inputX/eventY: some error happened
>
> type of messages...

That really sounds quite nice. It would make sense to show both the
actual device information, and the "software layer" on top of it.

Except maybe it then would be absolutely disgusting for some other
case. Hmm. I really can't think of any bad situation off-hand, though.

                    Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

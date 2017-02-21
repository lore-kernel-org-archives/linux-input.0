From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: rmi: fallback to generic/multitouch if hid-rmi is
 not built (was Re: [GIT PULL] HID for 4.11)
Date: Tue, 21 Feb 2017 18:42:26 +0100
Message-ID: <20170221174226.GB21560@mail.corp.redhat.com>
References: <alpine.LSU.2.20.1702201508280.24579@cbobk.fhfr.pm>
 <CA+55aFxLmgA7drrGfUJmCRPT-A74ROYf6GQHFGO5pzVjZ0dL7Q@mail.gmail.com>
 <CA+55aFzLGosGoB5STrAampHPQ9H-K7v08N2Jx9ETsHnMFgv+=A@mail.gmail.com>
 <CA+55aFzfUbcB44UYwbKv-qci-wxCsWKEZs4Mso-J5cCoz9x0qQ@mail.gmail.com>
 <alpine.LSU.2.20.1702211514540.24579@cbobk.fhfr.pm>
 <CA+55aFwbJDBMQi4nzcD8-cWUZ4S1jNAEYqo38_FinLJA4FfYCA@mail.gmail.com>
 <alpine.LSU.2.20.1702211644090.24579@cbobk.fhfr.pm>
 <CA+55aFyBkUWy+Qpm6XxyEUi-FU_YSj-r01aRLuh0qoTm_vSq9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752823AbdBURmd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Feb 2017 12:42:33 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFyBkUWy+Qpm6XxyEUi-FU_YSj-r01aRLuh0qoTm_vSq9g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Feb 21 2017 or thereabouts, Linus Torvalds wrote:
> On Tue, Feb 21, 2017 at 7:46 AM, Jiri Kosina <jikos@kernel.org> wrote:
> > On Tue, 21 Feb 2017, Linus Torvalds wrote:
> >>
> >> .. and maybe we should do this same thing for the WACOM case a couple
> >> of lines up from your patch?
> >
> > Well, that's far more questionable. I am pretty sure Wacom devices are
> > completely dysfunctional without a specific driver, as they have their own
> > protocol.
> 
> Ah, ok. Never mind then.
> 
>             Linus

Well, Wacom devices use to need a special driver, but the latest
generation should somewhat be able to work without a driver (IIRC).
The only thing I can think of is that Wacom devices require
HID_QUIRK_NO_INIT_REPORTS, so they might not work out of the box after
all.

Let's see what Ping and Jason think about the question.

Cheers,
Benjamin

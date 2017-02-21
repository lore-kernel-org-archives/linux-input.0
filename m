From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: rmi: fallback to generic/multitouch if hid-rmi is
 not built (was Re: [GIT PULL] HID for 4.11)
Date: Tue, 21 Feb 2017 16:46:44 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1702211644090.24579@cbobk.fhfr.pm>
References: <alpine.LSU.2.20.1702201508280.24579@cbobk.fhfr.pm> <CA+55aFxLmgA7drrGfUJmCRPT-A74ROYf6GQHFGO5pzVjZ0dL7Q@mail.gmail.com> <CA+55aFzLGosGoB5STrAampHPQ9H-K7v08N2Jx9ETsHnMFgv+=A@mail.gmail.com> <CA+55aFzfUbcB44UYwbKv-qci-wxCsWKEZs4Mso-J5cCoz9x0qQ@mail.gmail.com>
 <alpine.LSU.2.20.1702211514540.24579@cbobk.fhfr.pm> <CA+55aFwbJDBMQi4nzcD8-cWUZ4S1jNAEYqo38_FinLJA4FfYCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50093 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751374AbdBUPqq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Feb 2017 10:46:46 -0500
In-Reply-To: <CA+55aFwbJDBMQi4nzcD8-cWUZ4S1jNAEYqo38_FinLJA4FfYCA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, 21 Feb 2017, Linus Torvalds wrote:

> > I agree; that's in line with what we usually try to stick to (force
> > specific drivers if the device doesn't work with the generic at all and
> > switch over to generic in compile-time for devices that have limited
> > functionality with the generic driver).
> 
> .. and maybe we should do this same thing for the WACOM case a couple
> of lines up from your patch?

Well, that's far more questionable. I am pretty sure Wacom devices are 
completely dysfunctional without a specific driver, as they have their own 
protocol.

Adding Ping and Jason to CC.

-- 
Jiri Kosina
SUSE Labs


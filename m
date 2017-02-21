From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] HID: rmi: fallback to generic/multitouch if hid-rmi is
 not built (was Re: [GIT PULL] HID for 4.11)
Date: Tue, 21 Feb 2017 07:43:36 -0800
Message-ID: <CA+55aFwbJDBMQi4nzcD8-cWUZ4S1jNAEYqo38_FinLJA4FfYCA@mail.gmail.com>
References: <alpine.LSU.2.20.1702201508280.24579@cbobk.fhfr.pm>
 <CA+55aFxLmgA7drrGfUJmCRPT-A74ROYf6GQHFGO5pzVjZ0dL7Q@mail.gmail.com>
 <CA+55aFzLGosGoB5STrAampHPQ9H-K7v08N2Jx9ETsHnMFgv+=A@mail.gmail.com>
 <CA+55aFzfUbcB44UYwbKv-qci-wxCsWKEZs4Mso-J5cCoz9x0qQ@mail.gmail.com> <alpine.LSU.2.20.1702211514540.24579@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34456 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbdBUPnn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Feb 2017 10:43:43 -0500
In-Reply-To: <alpine.LSU.2.20.1702211514540.24579@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Feb 21, 2017 at 6:17 AM, Jiri Kosina <jikos@kernel.org> wrote:
>
> I agree; that's in line with what we usually try to stick to (force
> specific drivers if the device doesn't work with the generic at all and
> switch over to generic in compile-time for devices that have limited
> functionality with the generic driver).

.. and maybe we should do this same thing for the WACOM case a couple
of lines up from your patch?

              Linus

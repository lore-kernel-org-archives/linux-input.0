From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Another HID problem this merge window..
Date: Sat, 27 Oct 2018 13:17:05 -0700
Message-ID: <CAHk-=wgTMd_orbgEmjtKdpPJdnFcho_-66_R3PBr7joxFOxqsw@mail.gmail.com>
References: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
 <c6b7e5b26883c53db35454e9b0ffb44898517228.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c6b7e5b26883c53db35454e9b0ffb44898517228.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joe@perches.com
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Oct 27, 2018 at 12:36 PM Joe Perches <joe@perches.com> wrote:
>
> In fairness, it seems many of the HID drivers do exactly that
> and this could have been a "copy from example" addition.

Interesting, and I think you're right.

I wonder why I haven't noticed this before. Some of those might be
hidden by other dependencies - what I do is to just check how "make
oldconfig" changes my normal fairly minimal configuration, and then
complain when I notice that somebody enables some odd new hardware.

Anyway, those other "!EXPERT" defaults look pretty questionable too.
HID itself beind default y and the HID_GENERIC driver defaulting on
seems eminently sane. And HID_LOGITECH might fall under both "very
common" and "enables other config options".

But even then, the !EXPERT seems an odd choice. Why not just 'y' for
the truly common cases?

I wonder if there is some truly old historical legacy there, ie the
old PC keyboard support would have been configurable out only for
expert users to avoid errors, and maybe the HID Kconfig file started
getting ideas from that...

                Linus

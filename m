From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Another HID problem this merge window..
Date: Sat, 27 Oct 2018 11:13:17 -0700
Message-ID: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Ok, so this is a much smaller issue than the i2c one that cause boot
problems, but it's annoying.

We do *not* enable new random drivers by default. And we most
*definitely* don't do it when they are odd-ball ones that most people
have never heard of.

Yet the new "BigBen Interactive" driver that was added this merge
window did exactly that.

Just don't do it.

Yes, yes, every developer always thinks that _their_ driver is so
special and so magically important that it should be enabled by
default. But no. When we have thousands of drivers, we don't randomly
pick one new driver to be enabled by default just because some
developer thinks it is special. It's not.

So the

        default !EXPERT

was completely wrong in commit 256a90ed9e46 ("HID: hid-bigbenff:
driver for BigBen Interactive PS3OFMINIPAD gamepad"). Please don't do
things like this.

                         Linus

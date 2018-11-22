From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 8/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
Date: Thu, 22 Nov 2018 09:05:47 -0800
Message-ID: <CAHk-=wh9pB3k6kuKHUfxeMaCLqm35CJs3W1kQteEHR5r8G4RUQ@mail.gmail.com>
References: <20181122063409.15816-1-peter.hutterer@who-t.net> <20181122063409.15816-9-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122063409.15816-9-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, nlopezcasad@logitech.com, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Wed, Nov 21, 2018 at 10:35 PM Peter Hutterer
<peter.hutterer@who-t.net> wrote:
>
> This patch is a combinations of the now-reverted commits 1ff2e1a44e0,
> d56ca9855bf9, 5fe2ccbef9d, 044ee89028 together with some extra bits for the
> directional and timeout-based reset.

Instead of using an actual timer (which is quite expensive), how about
just saving the "last time" data along with the remainder?

We have a fairly low-overhead 'sched_clock()' function that gives a
clock approximation in nanoseconds (64 bits). Note that it doesn't
actually give nanosecond precision - it might fall back to jiffies for
hardware that doesn't have anything better, but for timeouts on the
order of a second, it's fine.

                      Linus

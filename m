From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Logitech high-resolution scrolling..
Date: Sun, 28 Oct 2018 12:13:29 -0700
Message-ID: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Cutts <hcutts@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

So I use a Logitech MX Anywhere 2S mouse, and really like it. I have
the scroll-wheel unlocked, because I like flicking once to scroll a
lot.

However, the new high-res scroll code means that the scroll wheel
action is now much too sensitive. It's not even stable - it will
scroll back-and-forth a bit occasionally, and in fact it sometimes
seems to scroll not because I touch the scroll-wheel, but because the
movement of the mouse itself causes the scroll wheel to move slightly
and wiggle the scroll action.

So the recent change to enable the high-res scrolling really seems a
bit *too* extreme.

Is there some middle ground that turns the mouse from "look at it
sideways and it starts scrolling" to something slightly more
reasonable?

                      Linus

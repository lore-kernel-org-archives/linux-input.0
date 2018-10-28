From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Logitech high-resolution scrolling..
Date: Sun, 28 Oct 2018 14:08:31 -0700
Message-ID: <CAHk-=wjisf8Bmgbtf3y0W+Lu58t3nSnvKGc0J=Zo=rmz3eA+Cw@mail.gmail.com>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Cutts <hcutts@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Oct 28, 2018 at 12:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So the recent change to enable the high-res scrolling really seems a
> bit *too* extreme.
>
> Is there some middle ground that turns the mouse from "look at it
> sideways and it starts scrolling" to something slightly more
> reasonable?

Actually, I think the bug may be in the generic HID high-resolution
scrolling code, and I only notice because the Logitech support means
that now I see it.

In particular, if you look at hid_scroll_counter_handle_scroll(),
you'll notice that it tries to turn a high-res scroll event into a
regular wheel event by using the resolution_multiplier.

But that code looks really broken. It tries to react to a "half
multiplier" thing:

        int threshold = counter->resolution_multiplier / 2;
   ..
        counter->remainder += hi_res_value;
        if (abs(counter->remainder) >= threshold) {

and that's absolutely and entirely wrong.

Imagine that the high-res wheel counter has just moved a bit up (by
one high-res) tick, so now it's at the half-way mark to the
resolution_multiplier, and we scroll up by one:

                low_res_scroll_amount =
                        counter->remainder / counter->resolution_multiplier
                        + (hi_res_value > 0 ? 1 : -1);
                input_report_rel(counter->dev, REL_WHEEL,
                                 low_res_scroll_amount);

and then correct for it:

                counter->remainder -=
                        low_res_scroll_amount * counter->resolution_multiplier;

now we went from "half resolution multiplier positive" to "half negative".

Which means that next time that the high-res event happens by even
just one high-resolution tick in the other direction, we'll now
generate a low-resolution scroll event in the other direction.

In other words, that function results in unstable behavior. Tiny tiny
movements back-and-forth in the high-res wheel events (which could be
just because either the sensor is unstable, or the wheel is wiggling
imperceptibly) can result in visible movement in the low-res
("regular") wheel reporting.

There is no "damping" function, in other words. Noise in the high
resolution reading can result in noise in the regular wheel reporting.

So that threshold handling needs to be fixed, I feel. Either get rid
of it entirely (you need to scroll a *full* resolution_multiplier to
get a regular wheel event), or the counter->remainder needs to be
*cleared* when a wheel event has been sent so that you don't get into
the whole "back-and-forth" mode.

Or some other damping model. I suspect there are people who have
researched what the right answer is, but I guarantee that the current
code is not the right answer.

I suspect this also explains why I *sometimes* see that "just moving
the mouse sends wheel events", and at other times don't. It needs to
get close to that "half a resolution multiplier" stage to get into the
bad cases, but then tiny tiny perturbations can cause unstable
behavior.

I can't be the only person seeing this, but I guess the Logitech mouse
is right now the only one that uses the new generic HID code, and I
guess not a lot of people have been *using* it.

Harry?

                 Linus

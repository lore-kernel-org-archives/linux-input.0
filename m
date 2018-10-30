From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: Logitech high-resolution scrolling..
Date: Tue, 30 Oct 2018 16:26:57 +1000
Message-ID: <20181030062657.GA5380@jelly>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm>
 <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
 <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
 <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
 <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com>
 <CAHk-=wihpgjONY2iw5mO9gHcQHxRyj+aQcaX2qd9Tjf-MdGNZg@mail.gmail.com>
 <CA+jURcvAQWP-fMLxNBF=PZ7moJZgorjO0SGXn8xSWKt=k+oe1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+jURcvAQWP-fMLxNBF=PZ7moJZgorjO0SGXn8xSWKt=k+oe1w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Cutts <hcutts@chromium.org>
Cc: torvalds@linux-foundation.org, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 29, 2018 at 04:03:54PM -0700, Harry Cutts wrote:
> On Mon, 29 Oct 2018 at 15:01, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > That would work, yes.
> 
> OK, I'll write a patch for this. (It may be next week, though, as I
> have a deadline on a separate project this week.)
> 
> > Except I think you *do* want the "reset on direction change" logic,
> > because otherwise we still end up having the:
> >
> > > - we update remainder to -1
> >
> > where it now gets easier to next time go the wrong way, for no good
> > reason.  So now you only need another 6/8ths the other way to get to
> > within 7/8ths of -8 and scroll back.
> >
> > In other words, the whole "round partial scrolling" also causes that
> > whole "now the other direction is closer" issue.
> >
> > At 7/8's it is less obviously a problem than it was at 1/2, but I
> > still think it's a sign of an unstable algorithm, where changes get
> > triggered too easily in the non-highres world.
> >
> > Also, honestly, I'm not sure I see the point. *IF* you actually scroll
> > more in one direction, it doesn't matter one whit whether you pick
> > 1/2, 7/8, or whole multipliers: the *next* step is still always going
> > to be one whole multiplier away.
> >
> > So I think the whole rounding is actually misguided. I think it may
> > come from the very fact that you did *not* reset the remainder on
> > direction changes, so you could scroll in one direction to -3, and
> > then you change direction and go a "whole" tick the other way, but now
> > it's just at +5, so you think you need to round up.
> >
> > With the whole "reset when changing direction", I don't think the
> > rounding is necessary, and I don't think it makes sense.
> 
> Resetting on direction change would certainly make complete sense in
> smooth mode. The reason that I'm reluctant to do it is for clicky
> mode, where we think it's important that the low-res event happen at a
> consistent point in the movement between notches (the resting
> positions of the wheel). For example, imagine the following scenario
> with a wheel multiplier of 8 and the threshold initially at 7/8ths of
> a notch:
> 
> - I scroll one notch down. The low-res event occurs just before the
> wheel settles in to its notch, leaving a -1/8th remainder, and then
> (on most wheels) the ratchet mechanism settles the wheel 1/8th further
> into its resting position, eliminating the remainder.
> - I move the wheel 3/8ths further down, then change my mind and start
> scrolling upwards.
> 
> If we reset on direction change at this point, then the "zero point"
> will have moved, so that we trigger the low-res movement at -4/8ths
> (at the peak of resistance between the two notches) instead of at
> 7/8ths. If we don't reset but allow the 3/8ths remainder to be
> cleared, the trigger point stays at 7/8ths. It's a minor thing, to be
> sure, but we think that keeping the on-screen response consistent with
> the tactile feel of the wheel is important for the user experience.

IMO this is a lost battle because you cannot know when the ratchet is
enabled or not (at least not on all mice). Users switch between ratchet and
freewheeling time and once you're out of one mode, you have no reference 
to the other mode's reset point anymore.

you could guess it with heuristics. if you get multiple scroll sequences
with $multiplier events, then you're probably back in ratchet mode. Of
course, it's just guesswork...

fwiw, here's a writeup of the issues that I found in the current code,
before Linus' patch. This is as much my note-taking as it is an email.

Let's assume free-wheeling for now, and I'm using high-res values of
2 to reduce typing. multiplier is 8 like the default in the code.

- the first event comes earlier than the second on a consistent scroll
  motion, you get one event after a half movement, the second, third, ...
  events after n + half. Not a huge issue since it only ever happens once
  after plug.  And this is by design as you said, so let's live with
  that :)
- The scroll wheel emulation is unpredictable across scroll events. Let's
  assume multiple sequences of events, with a pause long enough to make the
  user think they are independent scroll motions:
    [2, 2, 2, 2] [2, 2, 2, 2] ← input events
        x            x
    [2, 2] [2, 2, 2, 2, 2, 2] ← input events
        x            x
    [2, 2, 2, 2, 2] [2, 2, 2] ← input events
        x            x
  x marks the spot where the low-res event is sent.
  in the first case, everything is fine, second case has the first sequence
  react quickly, the second one slower. third case is the opposite. The only
  reason this isn't very obvious is because the scroll distance is very
  small either way. we'd need a timeout to avoid this issue, a basic "reset
  remainder after N ms".
- the directional change is what Linus triggered
              [2, 2, -2, 2, -2 ...] ← input events
  remainders:  0  4              r - 8
                 -4  -6          r + 8
                      2  4       r - 8
                        -4  -6
                  x   x  x   x
  if you get in the right state you get to trigger the events on every small
  motion. Note that the issue here isn't the half-way trigger, but the
  missing reset. we could have the half-way trigger in place:
  [2, 2, -2, 2, -2 ...] ← input events
   0  4
     -4   0 ← reset 
         -2  0 ← reset 
             2   0 ← reset 
      x          
  so that would work just fine, that's also what the patch below does.
- fast motion can trigger some odd calculations because of the +1 added.
    [2, 8, -2, 2 ...] ← input events
  r: 0 10               r - 16 
       -6  -8           r + 16 (incorrect)
            8 10        r - 16 (incorrect)
              -6  
       xx  xx xx
  All of these would trigger a double scroll event. Admittedly this is
  physically hard to trigger so it's more a theoretical concern. What's
  easier to trigger is:
    [2, 6, 2, 2 ...] ← input events
     0  8               r - 16
       -8 -6            r + 8 (incorrect)
           2 4          r - 8
            -4  
       xx  x x
  The xx and y events are incorrect here, total movement was 10 units but we
  got 3 units instead of the expected 1. Result is that on fast scrolling we
  may end up with the occasional extra event. 

  The fix for this is in the patch below, by only adding the extra ±1 if
  we're below the multiplier, we get this instead:
    [2, 6, 2, 2 ...] ← input events
     0  8               r - 8
        0  2  4         r + 8
             -4         r - 8
       xx     x

  or on a similar sequence:
    [2, 8, 6, 2 ...] ← input events
     0  8               r - 8
        0  6  4         r + 8
          -2 -4         r - 8
       xx  x  x


Other issues I found with an MX Anywhere 2S is that on slow scroll and in
ratchet mode we get some scroll jitter.  In ratchet mode  we can get this
sequence if you scroll just past the notch and it snaps back:
    [1, 1, 1, 1, 1, 1, 1, 1, -1]
That's quite easy to trigger. In free-wheel mode we may get the same for
slow motion due to human finger jitter (the Anywhere 2S didn't have HW
jitter, but other devices may). So a perceived-consistent scroll motion may
really look like this:
    [1, 1, 1, 1, 1, -1, 1, 1]
Hard to triggger but when it does, it feels like we're dropping events.
The former isn't that much of an issue as long as the ratchet is enabled so
you get the haptic feedback and we (usually) don't drop events.

Finally: I reproduced the issue you mentioned with the 7/8th of a
notch. A slow ratchet scroll does not always give me the same number of
events per notch, there are cases where I get 7 or 9 events instead of the
expected 8 (all with a hi-res value 1). With Linus patch I ended up getting
weirdly ouf of sync here as to when the low res event was triggered during
the motion.

So my suggestion is to combine Linus' reset with your approach and use the
center-point for the trigger. This gives us a few events to slide and still
do the right thing, and any direction change will reset anyway. Biggest
drawback is that the first event after a direction change is triggered
faster than the next event. Otherwise it feels correct to me, both in
free-wheeling and in ratchet mode now.

The timeout I mentioned above is probably something better kept in userspace
if needed.

Cheers,
   Peter

Also, WTF moment: I managed to get the mouse into a state where it would
only give me 1 hi-res event per notch movement but failed to reproduce that
again.


>From a9cb724159cc9515ce9ee1aff15184a19731d80b Mon Sep 17 00:00:00 2001
From: Peter Hutterer <peter.hutterer@who-t.net>
Date: Tue, 30 Oct 2018 14:10:53 +1000
Subject: [PATCH] HID: input: restore the hi-res scroll emulation to work on
 the midpoint

A single notch movement does not always cause exactly $multiplier events in
the hardware. Setting the trigger at the midpoint allows us to slide a few
events either direction while still triggering exactly one scroll event per
multiplier.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/hid/hid-input.c | 25 ++++++++++++++++++-------
 include/linux/hid.h     |  1 +
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index a2f74e6adc70..a170a6823072 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1855,7 +1855,7 @@ EXPORT_SYMBOL_GPL(hidinput_disconnect);
 void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
 				      int hi_res_value)
 {
-	int low_res_value, remainder, multiplier;
+	int low_res_value, remainder, multiplier, direction;
 
 	input_report_rel(counter->dev, REL_WHEEL_HI_RES,
 			 hi_res_value * counter->microns_per_hi_res_unit);
@@ -1865,20 +1865,31 @@ void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
 	 * but reset if the direction has changed.
 	 */
 	remainder = counter->remainder;
-	if ((remainder ^ hi_res_value) < 0)
+	direction = hi_res_value > 0 ? 1 : -1;
+	if (direction != counter->direction)
 		remainder = 0;
+	counter->direction = direction;
 	remainder += hi_res_value;
 
 	/*
 	 * Then just use the resolution multiplier to see if
 	 * we should send a low-res (aka regular wheel) event.
+	 * Threshold is at the mid-point because we'll slide a few events
+	 * back/forth when the mouse gives us more or less than multiplier
+	 * events for a single notch movement.
 	 */
 	multiplier = counter->resolution_multiplier;
-	low_res_value = remainder / multiplier;
-	remainder -= low_res_value * multiplier;
-	counter->remainder = remainder;
-
-	if (low_res_value)
+	if (abs(remainder) >= multiplier/2) {
+		low_res_value = remainder / multiplier;
+                /* Move at minimum 1/-1 because we want to trigger when the wheel
+                 * is half-way to the next notch (i.e. scroll 1 notch after a
+                 * 1/2 notch movement).
+                 */
+		if (low_res_value == 0)
+			low_res_value = (hi_res_value > 0 ? 1 : -1);
+		remainder -= low_res_value * multiplier;
 		input_report_rel(counter->dev, REL_WHEEL, low_res_value);
+	}
+	counter->remainder = remainder;
 }
 EXPORT_SYMBOL_GPL(hid_scroll_counter_handle_scroll);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 2827b87590d8..9752b8a2ee42 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1162,6 +1162,7 @@ struct hid_scroll_counter {
 	int resolution_multiplier;
 
 	int remainder;
+	int direction;
 };
 
 void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
-- 
2.19.1

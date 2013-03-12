From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [RFC] input: mt: Support for touch cancel
Date: Tue, 12 Mar 2013 11:36:05 +1000
Message-ID: <20130312013605.GA31587@yabbi.redhat.com>
References: <CAPDwgkMbwTtf2a5Xuvb3_B18FBJ7w6VJx1CJN=gGwaaRSKzDbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:56828 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab3CLBys (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Mar 2013 21:54:48 -0400
Content-Disposition: inline
In-Reply-To: <CAPDwgkMbwTtf2a5Xuvb3_B18FBJ7w6VJx1CJN=gGwaaRSKzDbA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yufeng Shen <miletus@chromium.org>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Daniel Kurtz <djkurtz@chromium.org>, rbyers@chromium.org

On Mon, Mar 11, 2013 at 04:34:27PM -0400, Yufeng Shen wrote:
> I have ran into cases where I want to make a touch end event to have a
> touch cancel indication.
> 
> This comes from trying to solve the problem of :
> 
> If the touch sequence happens before the system suspends, and the touch
> release event is
> never received after the system resumes, userspace MT state tracking could
> be in a bad state.
> 
> ( see #5 from
> https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-input-synaptics/+bug/968845
> for an example of how this could happen from lid close/open on MBA)

ftr, this a bug in the driver and should be fixed now.
 
> One possible workaround is to let the touch device driver to release all
> existing touches on
> resume, which has the effect of clearing all the MT states in userspace
> touch stacks.
> But the touch release/end event often will result in some gesture being
> recognized and performed,
> like a tap-to-click being generated.
> 
> So I am wondering what's the best way to solve the problem of clearing the
> touch states with
> minimal side effect. One way I can think of is to have MTB protocol add
> support of
> a touch cancel indication on touch release, e.g. making TRACKING_ID = -2
> meaning that
> the touch release is synthesized from the system and really has the meaning
> of releasing and canceling the current touch, while TRACKING_ID = -1
> meaning that the touch release is reported back from the device.
> 
> And from Xf86-input driver level, we can add a corresponding TouchCancel
> for this.

I can handle touch-cancel events in the synaptics driver to avoid
tap-to-click but further details get a bit nasty.

To actually add TouchCancel to the client-protocol means a new XI protocol
revision, plus the stuff in the server _and_ the stuff in the client. that
is quite some lag time here, and if a client cannot handle TouchCancel all
we can do is do a TouchEnd - which will still trigger the gesture.

even if you update the touch clients you're still lacking any solution for
pointer-emulated clients. again, here we can only do a ButtonRelease event
which again will trigger whatever it did.

All the above can be implemented though. In fact, I suspect the protocol
part is the easy bit (just a flag on TouchEnd) but the server part is
reasonably nasty.

the real counter-argument is that I think it is a partial solution only.
>From an X perspective touches also end when you vt-switch away from the
server (device is disabled). but the kernel won't cancel the touch event for
that. Or when the device is disabled by the client ("disable touchpad while
typing" feature), So we'd have to maintain both implicit cancel and explicit
cancel in the driver anyway.

so yeah, I don't think adding this to the kernel would provide any
significant benefit since we still need to handle all the other cases
anyway.

Cheers,
   Peter

From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] Input: clarify gamepad API ABS values
Date: Thu, 14 Nov 2013 18:07:20 +0100
Message-ID: <20131114180720.fece45888942c29d5865073e@studenti.unina.it>
References: <1380806829-11824-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:32178 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754977Ab3KNRND (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Nov 2013 12:13:03 -0500
In-Reply-To: <1380806829-11824-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu,  3 Oct 2013 15:27:09 +0200
David Herrmann <dh.herrmann@gmail.com> wrote:

> It wasn't really clear from the gamepad-API description how ABS values are
> mapped exactly. Clarify that negative is left/up and positive is
> right/down.

I was just going to ask that, thanks.
Has this patch picked up?

> ... Unfortunately, this means I screwed up the Wii U ProController
> ABI. Anyhow, this just means we continue to have 0 compatible gamepad
> drivers in the kernel. User-space needs to fix them up, anyway, as all
> other gamepads are also incompatible.
>

I know it is not really relevant and you won't fix the kernel interface
anyway, but I was just curios: is there any known userspace using the
gamepad API?

Another question is below.

> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  Documentation/input/gamepad.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/input/gamepad.txt b/Documentation/input/gamepad.txt
> index 8002c89..31bb6a4 100644
> --- a/Documentation/input/gamepad.txt
> +++ b/Documentation/input/gamepad.txt
> @@ -122,12 +122,14 @@ D-Pad:
>        BTN_DPAD_*
>      Analog buttons are reported as:
>        ABS_HAT0X and ABS_HAT0Y
> +      (for ABS values negative is left/up, positive is right/down)
>

Does that mean that analog D-Pad Left and D-Pad Right are supposed to be
described as a single axis (ABS_HAT0X), even if in the input report
they come as two different fields (non adjacent even)? And same for
analog Up/Down?

JFYI on the PS3 controller it is possible to have values from analog
D-Pad Left and analog D-Pad Right at the same time, even if it is
mechanically unlikely.

>  Analog-Sticks:
>    The left analog-stick is reported as ABS_X, ABS_Y. The right analog stick is
>    reported as ABS_RX, ABS_RY. Zero, one or two sticks may be present.
>    If analog-sticks provide digital buttons, they are mapped accordingly as
>    BTN_THUMBL (first/left) and BTN_THUMBR (second/right).
> +    (for ABS values negative is left/up, positive is right/down)
>  
>  Triggers:
>    Trigger buttons can be available as digital or analog buttons or both. User-
> @@ -138,6 +140,7 @@ Triggers:
>    ABS_HAT2X (right/ZR) and BTN_TL2 or ABS_HAT2Y (left/ZL).
>    If only one trigger-button combination is present (upper+lower), they are
>    reported as "right" triggers (BTN_TR/ABS_HAT1X).
> +    (ABS trigger values start at 0, pressure is reported as positive values)
>

What about analog Action-Pad buttons?
Do you suggest any mapping for them?

>  Menu-Pad:
>    Menu buttons are always digital and are mapped according to their location

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

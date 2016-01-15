From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH-V2 1/1] HID: Force feedback support for the Logitech G920
Date: Fri, 15 Jan 2016 23:35:33 +0100
Message-ID: <CADbOyBRcDEiyEuPB4YRp2ciT9cbAQ=LVYXUvwYUKGKNtz-GbPA@mail.gmail.com>
References: <1452468315-8978-1-git-send-email-e.velds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36201 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbcAOWfe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 17:35:34 -0500
In-Reply-To: <1452468315-8978-1-git-send-email-e.velds@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Edwin Velds <e.velds@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Simon Wood <simon@mungewell.org>, Jiri Kosina <jkosina@suse.cz>, =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jan 11, 2016 at 12:25 AM, Edwin Velds <e.velds@gmail.com> wrote:
> This patch implements force feedback support for the Logitech
> G920 Driving Force Racing Wheel. It is a generic implementation
> of feature 0x8123 of the Logitech HID++ protocol and should be
> usable for any future devices that implement this feature.
>
> This patch should be applied after the basic G920 support patch
> by Simon Wood:
> http://www.spinics.net/lists/linux-input/msg42174.html
>
> The driving supports everything that is supported by the G920
> firmware:
>     FF_CONSTANT
>     FF_PERIODIC
>     FF_SINE
>     FF_SQUARE
>     FF_SAW_UP
>     FF_SAW_DOWN
>     FF_TRIANGLE
>     FF_SPRING
>     FF_DAMPER
>     FF_AUTOCENTER
>     FF_GAIN
> and for version 2 firmware also:
>     FF_FRICTION
>     FF_INERTIA
>     FF_RAMP
>
> Both envelopes and replay values are supported as well, but some
> problems may occur when using firmware release 1. There is also a
> small residual clockwise damper in the wheel when using the first
> firmware release. All problems are fixed in the soon te be released
> firmware version 2.
>
> The default spring is disabled by permanently placing a spring
> force in the wheel. This spring is also used as the autocenter
> spring.
>
> Signed-off-by: Edwin Velds <e.velds@gmail.com>

Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>

Tested with both firmware version 1 and firmware version 2.

@Dmitry:
As side note, Edwin intentionally did *not* put a clamp(0, 0x7FFF, x)
in the driver,
with x being envelope.attack_level or envelope.fade_level,
since this parameter checking is (/ should be) the task of "ff_core.c".
The device will behave odd when playing an effect that violates this rule,
although most user-space programs don't let them exceed 0x7FFF.
So this is a TODO for "ff-core.c", but not a blocker for this patch,
since the odd behavior will only be triggered during playback of such
violating effect,
and vanishes when the effect stops.

Other note:
For anyone who is interested on which spec this patch is based,
take a look at the excellently written "Logitech Force Feedback
Protocol" document:
https://opensource.logitech.com/opensource/index.php/Technical_Information

Thanks,
Elias

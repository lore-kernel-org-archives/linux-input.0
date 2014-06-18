From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2] Input: evdev - add event-mask API
Date: Wed, 18 Jun 2014 07:39:06 +0200
Message-ID: <CANq1E4T6cntSRQUL7PVNkGFY2ZGm0PkberZo=z0hZQnPHCB95g@mail.gmail.com>
References: <1402913358-682-1-git-send-email-dh.herrmann@gmail.com>
	<20140618044757.GB23028@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:51473 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbaFRFjH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jun 2014 01:39:07 -0400
Received: by mail-ie0-f180.google.com with SMTP id rl12so309991iec.39
        for <linux-input@vger.kernel.org>; Tue, 17 Jun 2014 22:39:06 -0700 (PDT)
In-Reply-To: <20140618044757.GB23028@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Lennart Poettering <lennart@poettering.net>

Hi

On Wed, Jun 18, 2014 at 6:47 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> On Mon, Jun 16, 2014 at 12:09:18PM +0200, David Herrmann wrote:
>> Hardware manufacturers group keys in the weirdest way possible. This may
>> cause a power-key to be grouped together with normal keyboard keys and
>> thus be reported on the same kernel interface.
>>
>> However, user-space is often only interested in specific sets of events.
>> For instance, daemons dealing with system-reboot (like systemd-logind)
>> listen for KEY_POWER, but are not interested in any main keyboard keys.
>> Usually, power keys are reported via separate interfaces, however,
>> some i8042 boards report it in the AT matrix. To avoid waking up those
>> system daemons on each key-press, we had two ideas:
>>  - split off KEY_POWER into a separate interface unconditionally
>>  - allow masking a specific set of events on evdev FDs
>>
>> Splitting of KEY_POWER is a rather weird way to deal with this and may
>> break backwards-compatibility. It is also specific to KEY_POWER and might
>> be required for other stuff, too. Moreover, we might end up with a huge
>> set of input-devices just to have them properly split.
>>
>> Hence, this patchset implements the second idea: An event-mask to specify
>> which events you're interested in. Two ioctls allow setting this mask for
>> each event-type. If not set, all events are reported. The type==0 entry is
>> used same as in EVIOCGBIT to set the actual EV_* mask of masked events.
>> This way, you have a two-level filter.
>
> one comment regarding the wording: I'd prefer to use "filtered" or
> "discarded" instead of "masked". Take for example the comment below:
>
>  "Each event-code is represented by a single bit in the event-mask. If set,
>  the event is not-masked."
>
> So if the mask is set, the event is not masked, which is rather confusing.
> Rewrite this as "if the mask is set, the event is not filtered" and it's a
> lot easier to understand.
>
> [...]
>
>> + * EVIOCGMASK - Retrieve current event-mask
>> + *
>> + * This retrieves the current event-mask for a specific event-type. The
>> + * argument must be of type "struct input_mask" and specifies the event-type to
>> + * query, the receive buffer and the size of the receive buffer.
>> + *
>> + * The event-mask is a per-client mask that specifies which events are forwarded
>> + * to the client. Each event-code is represented by a single bit in the
>> + * event-mask. If set, the event is not-masked. If unset, the event is masked
>> + * and will never be queued on the client's receive buffer.
>
> see comment above, funny thing is that until the "If set" it was quite easy
> to understand, the rest made it more confusing :)
>
>> + *
>> + * This ioctl provides full forward-compatibility. That means, if a kernel is
>> + * queried for an unknown event-type or if the receive buffer is larger than the
>> + * number of event-codes known to the kernel, the kernel will return all zeroes
>> + * for those codes (which means, those codes are masked). This effectively
>> + * means, codes unknown to the kernel are always considered hard-masked.
>
> hard-masked is an odd word, using it here with the masked vs filtered
> vs zeroes makes the whole thing quite confusing.
>
>> + * If the receive buffer is too small to contain the whole event-mask, a
>> + * truncated mask is copied to user-space.
>
> "At maximum, codes_size bytes are copied" says the same and doesn't leave
> one wondering where/when the truncation happens.
>
>> + *
>> + * This ioctl may fail with ENODEV in case the file is revoked. EFAULT is
>> + * returned if the receive-buffer points to invalid memory. EINVAL is returned
>> + * if the kernel does not implement the ioctl.
>
> this is nitpicking, but given that ioctls return -1 and set errno, the
> documentation should consistently use "may fail with..." instead
> of "returns"

I disagree on that one. I document kernel-API and we return negative
error-codes on failure. It's POSIX/glibc that turns this into -1 and
sets errno (and only god knows why that brainfu**ed idea got
standardized..).
However, turning this into "may fail with..." suits both of us, so I'm
fine with it.

Thanks for the re-wording. I amended the changes and also turned
__evdev_is_masked() into __evdev_is_filtered() to make it more
readable.

I will send v3 shortly, thanks!
David

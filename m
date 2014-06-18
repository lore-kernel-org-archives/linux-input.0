From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v2] Input: evdev - add event-mask API
Date: Wed, 18 Jun 2014 14:47:57 +1000
Message-ID: <20140618044757.GB23028@jelly.redhat.com>
References: <1402913358-682-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:59034 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606AbaFRFJI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jun 2014 01:09:08 -0400
Content-Disposition: inline
In-Reply-To: <1402913358-682-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Lennart Poettering <lennart@poettering.net>

On Mon, Jun 16, 2014 at 12:09:18PM +0200, David Herrmann wrote:
> Hardware manufacturers group keys in the weirdest way possible. This may
> cause a power-key to be grouped together with normal keyboard keys and
> thus be reported on the same kernel interface.
> 
> However, user-space is often only interested in specific sets of events.
> For instance, daemons dealing with system-reboot (like systemd-logind)
> listen for KEY_POWER, but are not interested in any main keyboard keys.
> Usually, power keys are reported via separate interfaces, however,
> some i8042 boards report it in the AT matrix. To avoid waking up those
> system daemons on each key-press, we had two ideas:
>  - split off KEY_POWER into a separate interface unconditionally
>  - allow masking a specific set of events on evdev FDs
> 
> Splitting of KEY_POWER is a rather weird way to deal with this and may
> break backwards-compatibility. It is also specific to KEY_POWER and might
> be required for other stuff, too. Moreover, we might end up with a huge
> set of input-devices just to have them properly split.
> 
> Hence, this patchset implements the second idea: An event-mask to specify
> which events you're interested in. Two ioctls allow setting this mask for
> each event-type. If not set, all events are reported. The type==0 entry is
> used same as in EVIOCGBIT to set the actual EV_* mask of masked events.
> This way, you have a two-level filter.

one comment regarding the wording: I'd prefer to use "filtered" or
"discarded" instead of "masked". Take for example the comment below:

 "Each event-code is represented by a single bit in the event-mask. If set,
 the event is not-masked."

So if the mask is set, the event is not masked, which is rather confusing.
Rewrite this as "if the mask is set, the event is not filtered" and it's a
lot easier to understand.

[...]

> + * EVIOCGMASK - Retrieve current event-mask
> + *
> + * This retrieves the current event-mask for a specific event-type. The
> + * argument must be of type "struct input_mask" and specifies the event-type to
> + * query, the receive buffer and the size of the receive buffer.
> + *
> + * The event-mask is a per-client mask that specifies which events are forwarded
> + * to the client. Each event-code is represented by a single bit in the
> + * event-mask. If set, the event is not-masked. If unset, the event is masked
> + * and will never be queued on the client's receive buffer.

see comment above, funny thing is that until the "If set" it was quite easy
to understand, the rest made it more confusing :)

> + *
> + * This ioctl provides full forward-compatibility. That means, if a kernel is
> + * queried for an unknown event-type or if the receive buffer is larger than the
> + * number of event-codes known to the kernel, the kernel will return all zeroes
> + * for those codes (which means, those codes are masked). This effectively
> + * means, codes unknown to the kernel are always considered hard-masked.

hard-masked is an odd word, using it here with the masked vs filtered
vs zeroes makes the whole thing quite confusing.

> + * If the receive buffer is too small to contain the whole event-mask, a
> + * truncated mask is copied to user-space.

"At maximum, codes_size bytes are copied" says the same and doesn't leave
one wondering where/when the truncation happens.

> + *
> + * This ioctl may fail with ENODEV in case the file is revoked. EFAULT is
> + * returned if the receive-buffer points to invalid memory. EINVAL is returned
> + * if the kernel does not implement the ioctl.

this is nitpicking, but given that ioctls return -1 and set errno, the
documentation should consistently use "may fail with..." instead
of "returns"


So, here's the comments folded in:

 EVIOCGMASK - Retrieve current event-mask

 This retrieves the current event-mask for a specific event-type. The
 argument must be of type "struct input_mask" and specifies the event-type to
 query, the receive buffer and the size of the receive buffer.

 The event-mask is a per-client mask that specifies which events are forwarded
 to the client. Each event-code is represented by a single bit in the
 event-mask. If the bit is set, the event is passed to the client normally.
 Otherwise, the event is filtered and and will never be queued on the
 client's receive buffer.

 The default event-mask for a client has all bits set, i.e. all events are
 forwarded to the client. If a kernel is queried for an unknown event-type
 or if the receive buffer is larger than the number of event-codes known to
 the kernel, the kernel returns all zeroes for those codes.

 At maximum, codes_size bytes are copied.

 This ioctl may fail with ENODEV in case the file is revoked, EFAULT
 if the receive-buffer points to invalid memory, or EINVAL if the kernel
 does not implement the ioctl.


Otherwise:
Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

> + */
> +#define EVIOCGMASK		_IOR('E', 0x92, struct input_mask)	/* Get event-masks */
> +
> +/**
> + * EVIOCSMASK - Set event-mask
> + *
> + * This is the counterpart to EVIOCGMASK. Instead of receiving the current
> + * event-mask, this changes the client's event-mask for a specific type. See
> + * EVIOCGMASK for a description of event-masks and the argument-type.
> + *
> + * This ioctl provides full forward-compatibility. If the passed event-type is
> + * unknown to the kernel, or if the number of codes is bigger than known to the
> + * kernel, the ioctl is still accepted and applied. However, any unknown codes
> + * are left untouched and stay masked. That means, the kernel hard-masks unknown
> + * codes regardless of what the client requests.
> + * If the new mask doesn't cover all known event-codes, all remaining codes are
> + * automatically cleared and thus masked.
> + *
> + * This ioctl may fail with ENODEV in case the file is revoked. EFAULT is
> + * returned if the receive-buffer points to invalid memory. EINVAL is returned
> + * if the kernel does not implement the ioctl.
> + */
> +#define EVIOCSMASK		_IOW('E', 0x93, struct input_mask)	/* Set event-masks */
> +
>  #define EVIOCSCLOCKID		_IOW('E', 0xa0, int)			/* Set clockid to be used for timestamps */
>  
>  /*
> -- 
> 2.0.0
> 

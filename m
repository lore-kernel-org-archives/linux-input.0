From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH RESEND RESEND] Input: evdev - add event-mask API
Date: Tue, 4 Nov 2014 11:51:34 +0100
Message-ID: <CANq1E4T-mXU0mXzgCPQi=oDg01DkSEzJN3JEwD1EGDCxWVryrQ@mail.gmail.com>
References: <1407914195-2797-1-git-send-email-dh.herrmann@gmail.com>
	<CANq1E4Q2S6vmpN=My8DXSPMti-pNQD24Hb0V9hqD=9TfND_mrg@mail.gmail.com>
	<20141009225256.GA8583@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:42585 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaKDKvf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2014 05:51:35 -0500
Received: by mail-ig0-f175.google.com with SMTP id h3so6435974igd.14
        for <linux-input@vger.kernel.org>; Tue, 04 Nov 2014 02:51:34 -0800 (PST)
In-Reply-To: <20141009225256.GA8583@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi Dmitry

Sorry for the delay, back from holiday now.

On Fri, Oct 10, 2014 at 12:52 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> diff -u b/include/uapi/linux/input.h b/include/uapi/linux/input.h
> --- b/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -161,53 +161,59 @@
>  #define EVIOCREVOKE            _IOW('E', 0x91, int)                    /* Revoke device access */
>
>  /**
> - * EVIOCGMASK - Retrieve current event-mask
> + * EVIOCGMASK - Retrieve current event mask
>   *
> - * This retrieves the current event-mask for a specific event-type. The
> - * argument must be of type "struct input_mask" and specifies the event-type to
> - * query, the receive buffer and the size of the receive buffer.
> - *
> - * The event-mask is a per-client mask that specifies which events are forwarded
> - * to the client. Each event-code is represented by a single bit in the
> - * event-mask. If the bit is set, the event is passed to the client normally.
> - * Otherwise, the event is filtered and and will never be queued on the
> - * client's receive buffer.
> - * Event-masks do not affect global state of an input-device. They only affect
> - * the open-file they're applied on. Each open-file (i.e, file-description) can
> - * have a different event-mask.
> - *
> - * The default event-mask for a client has all bits set, i.e. all events are
> - * forwarded to the client. If a kernel is queried for an unknown event-type
> - * or if the receive buffer is larger than the number of event-codes known to
> - * the kernel, the kernel returns all zeroes for those codes.
> + * This ioctl allows user to retrieve the current event mask for specific
> + * event type. The argument must be of type "struct input_mask" and
> + * specifies the event type to query, the address of the receive buffer and
> + * the size of the receive buffer.
> + *
> + * The event mask is a per-client mask that specifies which events are
> + * forwarded to the client. Each event code is represented by a single bit
> + * in the event mask. If the bit is set, the event is passed to the client
> + * normally. Otherwise, the event is filtered and will never be queued on
> + * the client's receive buffer.
> + *
> + * Event masks do not affect global state of the input device. They only
> + * affect the file descriptor they are applied to.
> + *
> + * The default event mask for a client has all bits set, i.e. all events
> + * are forwarded to the client. If kernel is queried for an unknown
> + * event type or if the receive buffer is larger than the number of
> + * event codes known to the kernel, the kernel returns all zeroes for those
> + * codes.
>   *
>   * At maximum, codes_size bytes are copied.
>   *
> - * This ioctl may fail with ENODEV in case the file is revoked, EFAULT
> - * if the receive-buffer points to invalid memory, or EINVAL if the kernel
> - * does not implement the ioctl.
> + * This ioctl may fail with ENODEV in case the descriptor is revoked,
> + * EFAULT if the receive buffer points to invalid memory, or EINVAL if the
> + * kernel does not implement the ioctl.

I fixed everything up, except for this hunk. A "descriptor" cannot be
revoked, it's always the "description" that is revoked
(file-descriptor vs. file-description). I'm not sure what name to use
here. "file-description" would serve best, I guess, but it's not that
commonly used (nor understood). It's defined properly by POSIX,
though.

Comments?

Thanks
David

>   */
> +
>  #define EVIOCGMASK             _IOR('E', 0x92, struct input_mask)      /* Get event-masks */
>
>  /**
> - * EVIOCSMASK - Set event-mask
> + * EVIOCSMASK - Set event mask
>   *
> - * This is the counterpart to EVIOCGMASK. Instead of receiving the current
> - * event-mask, this changes the client's event-mask for a specific type. See
> - * EVIOCGMASK for a description of event-masks and the argument-type.
> - *
> - * This ioctl provides full forward-compatibility. If the passed event-type is
> - * unknown to the kernel, or if the number of codes is bigger than known to the
> - * kernel, the ioctl is still accepted and applied. However, any unknown codes
> - * are left untouched and stay cleared. That means, the kernel always filters
> - * unknown codes regardless of what the client requests.
> - * If the new mask doesn't cover all known event-codes, all remaining codes are
> - * automatically cleared and thus filtered.
> + * This ioctl is the counterpart to EVIOCGMASK. Instead of receiving the
> + * current event mask, this changes the client's event mask for a specific
> + * type.  See EVIOCGMASK for a description of event-masks and the
> + * argument-type.
> + *
> + * This ioctl provides full forward compatibility. If the passed event type
> + * is unknown to the kernel, or if the number of event codes specified in
> + * the mask is bigger than what is known to the kernel, the ioctl is still
> + * accepted and applied. However, any unknown codes are left untouched and
> + * stay cleared. That means, the kernel always filters unknown codes
> + * regardless of what the client requests.  If the new mask doesn't cover
> + * all known event-codes, all remaining codes are automatically cleared and
> + * thus filtered.
>   *
>   * This ioctl may fail with ENODEV in case the file is revoked. EFAULT is
> - * returned if the receive-buffer points to invalid memory. EINVAL is returned
> - * if the kernel does not implement the ioctl.
> + * returned if the receive-buffer points to invalid memory. EINVAL is
> + * returned if the kernel does not implement the ioctl.
>   */
> +
>  #define EVIOCSMASK             _IOW('E', 0x93, struct input_mask)      /* Set event-masks */
>
>  #define EVIOCSCLOCKID          _IOW('E', 0xa0, int)                    /* Set clockid to be used for timestamps */

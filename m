From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND RESEND] Input: evdev - add event-mask API
Date: Tue, 4 Nov 2014 10:36:19 -0800
Message-ID: <20141104183619.GC440@dtor-ws>
References: <1407914195-2797-1-git-send-email-dh.herrmann@gmail.com>
 <CANq1E4Q2S6vmpN=My8DXSPMti-pNQD24Hb0V9hqD=9TfND_mrg@mail.gmail.com>
 <20141009225256.GA8583@dtor-ws>
 <CANq1E4T-mXU0mXzgCPQi=oDg01DkSEzJN3JEwD1EGDCxWVryrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:57219 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbaKDSgY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2014 13:36:24 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so7850856iga.9
        for <linux-input@vger.kernel.org>; Tue, 04 Nov 2014 10:36:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANq1E4T-mXU0mXzgCPQi=oDg01DkSEzJN3JEwD1EGDCxWVryrQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Tue, Nov 04, 2014 at 11:51:34AM +0100, David Herrmann wrote:
> Hi Dmitry
> 
> Sorry for the delay, back from holiday now.
> 
> On Fri, Oct 10, 2014 at 12:52 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > diff -u b/include/uapi/linux/input.h b/include/uapi/linux/input.h
> > --- b/include/uapi/linux/input.h
> > +++ b/include/uapi/linux/input.h
> > @@ -161,53 +161,59 @@
> >  #define EVIOCREVOKE            _IOW('E', 0x91, int)                    /* Revoke device access */
> >
> >  /**
> > - * EVIOCGMASK - Retrieve current event-mask
> > + * EVIOCGMASK - Retrieve current event mask
> >   *
> > - * This retrieves the current event-mask for a specific event-type. The
> > - * argument must be of type "struct input_mask" and specifies the event-type to
> > - * query, the receive buffer and the size of the receive buffer.
> > - *
> > - * The event-mask is a per-client mask that specifies which events are forwarded
> > - * to the client. Each event-code is represented by a single bit in the
> > - * event-mask. If the bit is set, the event is passed to the client normally.
> > - * Otherwise, the event is filtered and and will never be queued on the
> > - * client's receive buffer.
> > - * Event-masks do not affect global state of an input-device. They only affect
> > - * the open-file they're applied on. Each open-file (i.e, file-description) can
> > - * have a different event-mask.
> > - *
> > - * The default event-mask for a client has all bits set, i.e. all events are
> > - * forwarded to the client. If a kernel is queried for an unknown event-type
> > - * or if the receive buffer is larger than the number of event-codes known to
> > - * the kernel, the kernel returns all zeroes for those codes.
> > + * This ioctl allows user to retrieve the current event mask for specific
> > + * event type. The argument must be of type "struct input_mask" and
> > + * specifies the event type to query, the address of the receive buffer and
> > + * the size of the receive buffer.
> > + *
> > + * The event mask is a per-client mask that specifies which events are
> > + * forwarded to the client. Each event code is represented by a single bit
> > + * in the event mask. If the bit is set, the event is passed to the client
> > + * normally. Otherwise, the event is filtered and will never be queued on
> > + * the client's receive buffer.
> > + *
> > + * Event masks do not affect global state of the input device. They only
> > + * affect the file descriptor they are applied to.
> > + *
> > + * The default event mask for a client has all bits set, i.e. all events
> > + * are forwarded to the client. If kernel is queried for an unknown
> > + * event type or if the receive buffer is larger than the number of
> > + * event codes known to the kernel, the kernel returns all zeroes for those
> > + * codes.
> >   *
> >   * At maximum, codes_size bytes are copied.
> >   *
> > - * This ioctl may fail with ENODEV in case the file is revoked, EFAULT
> > - * if the receive-buffer points to invalid memory, or EINVAL if the kernel
> > - * does not implement the ioctl.
> > + * This ioctl may fail with ENODEV in case the descriptor is revoked,
> > + * EFAULT if the receive buffer points to invalid memory, or EINVAL if the
> > + * kernel does not implement the ioctl.
> 
> I fixed everything up, except for this hunk. A "descriptor" cannot be
> revoked, it's always the "description" that is revoked
> (file-descriptor vs. file-description). I'm not sure what name to use
> here. "file-description" would serve best, I guess, but it's not that
> commonly used (nor understood). It's defined properly by POSIX,
> though.

OK, let's leave it as is then.

-- 
Dmitry

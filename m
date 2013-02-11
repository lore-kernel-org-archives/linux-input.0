From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: hidraw: Bug in select/poll for writing
Date: Mon, 11 Feb 2013 17:01:27 +0100
Message-ID: <CANq1E4RcU6ZL5AOUYe89kyJbv9qJDArzZq8q6hbvsCSws8QQHA@mail.gmail.com>
References: <CA+hv5qkyis03CgYTWeWX9cr0my-d2Oe+aZo+mjmWRXgjrGqyrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:36442 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757632Ab3BKQB2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2013 11:01:28 -0500
Received: by mail-ee0-f43.google.com with SMTP id c50so3358504eek.16
        for <linux-input@vger.kernel.org>; Mon, 11 Feb 2013 08:01:27 -0800 (PST)
In-Reply-To: <CA+hv5qkyis03CgYTWeWX9cr0my-d2Oe+aZo+mjmWRXgjrGqyrw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tim Peterson <tim@timpeterson.org>
Cc: linux-input@vger.kernel.org, Alan Ott <alan@signal11.us>

Hi Tim

On Tue, Feb 5, 2013 at 12:47 AM, Tim Peterson <tim@timpeterson.org> wrote:
> Hi all,
>
> I have found that when one uses select() on /dev/hidraw0, it will
> never report that it is writable, even though a write will succeed at
> any time.
>
> As a demonstration, the command
> socat -v - /dev/hidraw0 >/dev/null
> will log every time data is read or written from the device. With any
> other device, I can type at the keyboard and see that the data has
> been written. With hidraw, reading works but writing never occurs,
> because socat never finds out that the file is ready for writing.
>
> I believe this is a result of hidraw_poll() never returning POLLOUT:
>
> static unsigned int hidraw_poll(struct file *file, poll_table *wait)
> {
>     struct hidraw_list *list = file->private_data;
>
>     poll_wait(file, &list->hidraw->wait, wait);
>     if (list->head != list->tail)
>         return POLLIN | POLLRDNORM;
>     if (!list->hidraw->exist)
>         return POLLERR | POLLHUP;
>     return 0;
> }
>
> I am not familiar with how these drivers work, so I'm not sure how to
> proceed. Is it safe to always add POLLOUT | POLLWRNORM to the return
> value, or is there a case in which it would not be writable?

Ah, yeah, that's a bit ugly. The problem is we don't support
nonblocking writes there. Instead, the hidraw driver simply calls a
blocking backend function. Therefore, POLLOUT hasn't been reported so
far.

But POLLOUT might be useful even without O_NONBLOCK so I think it is
safe to add POLLOUT to the flags unconditionally. If we want to
support O_NONBLOCK we would have to change a lot more, anyway.

But you might also simply write to the device without waiting for
POLLOUT. This only breaks generic commands like socat, so a patch
would be appreciated.

Regards
David

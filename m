From: Tim Peterson <tim@timpeterson.org>
Subject: hidraw: Bug in select/poll for writing
Date: Mon, 4 Feb 2013 18:47:50 -0500
Message-ID: <CA+hv5qkyis03CgYTWeWX9cr0my-d2Oe+aZo+mjmWRXgjrGqyrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from berry.timpeterson.org ([66.228.34.45]:53140 "EHLO
	berry.timpeterson.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab3BEAYP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Feb 2013 19:24:15 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46])
	by berry.timpeterson.org with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.72)
	(envelope-from <tim@timpeterson.org>)
	id 1U2Vlp-0002Tq-3l
	for linux-input@vger.kernel.org; Mon, 04 Feb 2013 18:48:17 -0500
Received: by mail-la0-f46.google.com with SMTP id fq12so5202271lab.33
        for <linux-input@vger.kernel.org>; Mon, 04 Feb 2013 15:48:10 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Alan Ott <alan@signal11.us>

Hi all,

I have found that when one uses select() on /dev/hidraw0, it will
never report that it is writable, even though a write will succeed at
any time.

As a demonstration, the command
socat -v - /dev/hidraw0 >/dev/null
will log every time data is read or written from the device. With any
other device, I can type at the keyboard and see that the data has
been written. With hidraw, reading works but writing never occurs,
because socat never finds out that the file is ready for writing.

I believe this is a result of hidraw_poll() never returning POLLOUT:

static unsigned int hidraw_poll(struct file *file, poll_table *wait)
{
    struct hidraw_list *list = file->private_data;

    poll_wait(file, &list->hidraw->wait, wait);
    if (list->head != list->tail)
        return POLLIN | POLLRDNORM;
    if (!list->hidraw->exist)
        return POLLERR | POLLHUP;
    return 0;
}

I am not familiar with how these drivers work, so I'm not sure how to
proceed. Is it safe to always add POLLOUT | POLLWRNORM to the return
value, or is there a case in which it would not be writable?

Thanks,
--Tim

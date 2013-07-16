From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC 5/8] HID: i2c: use generic hidinput_input_event()
Date: Tue, 16 Jul 2013 10:08:32 +0200
Message-ID: <CAN+gG=G_HHxNCx4Hp5fzTgFSSN6BP7-GadfJ8Ab5-T+M=7w7bg@mail.gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
	<1373908217-16748-6-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:64556 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab3GPIIe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jul 2013 04:08:34 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so278967lab.36
        for <linux-input@vger.kernel.org>; Tue, 16 Jul 2013 01:08:33 -0700 (PDT)
In-Reply-To: <1373908217-16748-6-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>

On Mon, Jul 15, 2013 at 7:10 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> HID core provides the same functionality, so drop the custom handler.
> Besides, the current handler doesn't schedule any outgoing report so it
> did not work, anyway.
>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---


Yep, by re-reading it, the led are not updated at all... :(
Thanks!

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC 4/8] HID: usbhid: use generic hidinput_input_event()
Date: Tue, 16 Jul 2013 10:06:47 +0200
Message-ID: <CAN+gG=G8Q2UcizbkmL9hKt6kRg2UgtSbYCmhmTj3asNaEm+4Ow@mail.gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
	<1373908217-16748-5-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:62968 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980Ab3GPIGt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jul 2013 04:06:49 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so283313lab.4
        for <linux-input@vger.kernel.org>; Tue, 16 Jul 2013 01:06:47 -0700 (PDT)
In-Reply-To: <1373908217-16748-5-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>

On Mon, Jul 15, 2013 at 7:10 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> HID core provides the same functionality as we do, so drop the custom
> hidinput_input_event() handler.
>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC 6/8] HID: uhid: use generic hidinput_input_event()
Date: Tue, 16 Jul 2013 10:10:48 +0200
Message-ID: <CAN+gG=E4s4oR3GnnuYyb6b0kTrLmO4RnSpXFkcadwL5byQQrpg@mail.gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
	<1373908217-16748-7-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:39348 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab3GPIKt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jul 2013 04:10:49 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so365211lbd.1
        for <linux-input@vger.kernel.org>; Tue, 16 Jul 2013 01:10:48 -0700 (PDT)
In-Reply-To: <1373908217-16748-7-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>

On Mon, Jul 15, 2013 at 7:10 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> HID core provides the same functionality and can convert the input event
> to a raw output report. We can thus drop UHID_OUTPUT_EV and rely on the
> mandatory UHID_OUTPUT.
>
> User-space wasn't able to do anything with UHID_OUTPUT_EV, anyway. They
> don't have access to the report fields.
>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---

I personally don't use UHID_OUTPUT_EV in hid-replay (nor UHID_OUTPUT
either :-P ).

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

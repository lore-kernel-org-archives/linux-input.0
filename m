From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC 1/8] HID: usbhid: make usbhid_set_leds() static
Date: Tue, 16 Jul 2013 09:41:12 +0200
Message-ID: <CAN+gG=E_Jg37vKnwn0b-=qQ4ozEDKyuZN70pkRNxkcYcPG4jOw@mail.gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
	<1373908217-16748-2-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:47967 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab3GPHlO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jul 2013 03:41:14 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so343357lbh.10
        for <linux-input@vger.kernel.org>; Tue, 16 Jul 2013 00:41:13 -0700 (PDT)
In-Reply-To: <1373908217-16748-2-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>

On Mon, Jul 15, 2013 at 7:10 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> usbhid_set_leds() is only used inside of usbhid/hid-core.c so no need to
> export it.
>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---

Hi David,

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

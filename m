From: Tom Gundersen <teg@jklm.no>
Subject: Re: [systemd-devel] Supporting U2F over HID on Linux?
Date: Sun, 2 Nov 2014 21:47:20 +0100
Message-ID: <CAG-2HqVug0hixSm5Lad7pVSZgJOm4smbL=2jzmREz4Zwk2zghw@mail.gmail.com>
References: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:42213 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbaKBUrl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Nov 2014 15:47:41 -0500
Received: by mail-yh0-f51.google.com with SMTP id z6so908795yhz.38
        for <linux-input@vger.kernel.org>; Sun, 02 Nov 2014 12:47:40 -0800 (PST)
In-Reply-To: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Kay Sievers <kay@vrfy.org>, Greg KH <gregkh@linuxfoundation.org>, systemd Mailing List <systemd-devel@lists.freedesktop.org>, Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Andy,

On Sun, Nov 2, 2014 at 7:57 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> I want to get U2F (universal second factor, sometimes called "security
> key" or even "gnubby") working on Linux.  U2F tokens are HID devices
> that speak a custom protocol.  The intent is that user code will speak
> to then using something like HIDAPI.
>
> The trick is that, for HIDAPI to work, something needs to recognize
> these devices and get udev to set appropriate device permissions.
>
> My question is: how should this be done?  The official way to
> enumerate U2F devices is to look for a HID usage page 0xf1d0
> containing usage 0x1.
>
> Options include:
>
>  - A builtin udev helper that reads the sysfs report_descriptor for
> hid or hidraw devices and sets attributes accordingly (either
> ID_SECURITY_TOKEN or something more general).

I don't think we should have such special-purpose logic in the udev core.

[...]

> - HID core code in the kernel to add
> HID_USAGES=f1d00001:lots:of:other:things to the uevent (or udev code
> to do the same).  This might end up producing a rather long string or
> some devices.

This makes the most sense to me. We could put this logic (adapting the
patch you posted) in src/udev/udev-builtin-usb_id.c.

I'll comment on the patch separately.

Cheers,

Tom

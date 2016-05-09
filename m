From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: New HID++ 2.0 mouse, Logitech G602
Date: Mon, 9 May 2016 10:40:16 +0200
Message-ID: <CAN+gG=GTUkDg_Ah-zO9nGrrXFwYeEKEwuv1pMby0VcPU5e0kPg@mail.gmail.com>
References: <6d3c32d0-6905-22d1-a391-4f1256695cd1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36011 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbcEIIkR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 May 2016 04:40:17 -0400
Received: by mail-vk0-f54.google.com with SMTP id s184so57350804vkb.3
        for <linux-input@vger.kernel.org>; Mon, 09 May 2016 01:40:16 -0700 (PDT)
In-Reply-To: <6d3c32d0-6905-22d1-a391-4f1256695cd1@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marty Plummer <netz.kernel@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>

Hi Marty,

On Mon, May 9, 2016 at 10:32 AM, Marty Plummer <netz.kernel@gmail.com> wrote:
> Greetings
>         Your name seems to come up most frequently in regards to the various
> logitech kernel modules, and I figured I should ping you regarding it.
>
> The Logitech G602 mouse apparently speaks the HID++ 2.0 protocol, and supports
> on-device remapping of its 11 buttons to either standard 'mouse' buttons or
> keyboard keys, plus a few custom functions related to the mouse itself (dpi
> control and other things), however these can only be easily remapped using the
> official Logitech software on windows (and maybe mac), so I'm interested in
> better kernel support for this device.

We are actually working on a user-space library to handle programmable
mice, and this include the HID++ 2.0 devices. Feel free to have a look
at libratbag[1]. We even have a gui for it[2] (well, not so sure it
will work completely).

I think with latest master branch, the G602 should work out of the box
for remapping buttons (you can use the CLI tool ratbag-command).

>
> Don't misunderstand, the device is pretty solid in usage already, but I find
> the need to boot a vm just for the sake of tweaking it to be a bit exasperating.
> I've been doing a bit of reverse engineering on the device already and would
> be glad to provide any information you may require for full support of
> the device.

Yes, we know it can be exasperating, and that's why we started libratbag :)

Cheers,
Benjamin

[1] https://github.com/libratbag/libratbag
[2] https://github.com/libratbag/piper

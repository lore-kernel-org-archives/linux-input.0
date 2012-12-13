From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH RFC] Add support for the matrix keyboard used in
 Bachmann's OT200
Date: Thu, 13 Dec 2012 09:17:49 +0100
Message-ID: <CAH9NwWeaU0RO5Zt2wzEeGSw9uNxNCWaFrrfMLBNACqfxUN_LRA@mail.gmail.com>
References: <1355319341-26597-1-git-send-email-christian.gmeiner@gmail.com> <20121212190255.GB10583@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57812 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab2LMISL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Dec 2012 03:18:11 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so1800283vby.19
        for <linux-input@vger.kernel.org>; Thu, 13 Dec 2012 00:18:10 -0800 (PST)
In-Reply-To: <20121212190255.GB10583@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

> On Wed, Dec 12, 2012 at 02:35:41PM +0100, Christian Gmeiner wrote:
>> The used matrix keyboard controler (implemented via FPGA) supports
>> two simultaneous key presses. The driver sends the raw register
>> values for each key (row & column) to userspace.
>>
>> In userspace a small tool is running, which reads a 'mapping'
>> file, processes the key events and send the configured keycodes
>> back to the kernel via uinput.
>
> This is a bit roundabout way of doing it. Why can't the kernel driver
> perform lookup in it's internal table and emit proper keycodes itself?

I thought that T9 can not be done in kernel. The biggest problem is that
I need have separate keys to change the behavior:

- one key to switch between T9 and normal number input
- one shift key
- one key for caps lock

This means that I need to have some sort of logic to interpret the same
key differently depending on the operation mode.
Is this possible in the input subsystem?

If not it should be no problem to send the raw register value back to userspace
and handle it there.

> We have wealth of options for supplying keymaps to the kernel drivers,
> including:
>
> - platform data
> - device tree data
> - loading from userspace via EVIOCSKEYCODE ioctl.

For this driver only EVIOCSKEYCODE could be an option as my company
uses the same hardware with different front panels (with different key options).
That is the reason I have a userspace tool that parses simple ini file and do
the logic there.

Thanks
--
Christian Gmeiner, MSc

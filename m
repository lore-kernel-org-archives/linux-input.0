From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Sun, 1 Apr 2012 22:10:05 +0200
Message-ID: <CANq1E4RTrqwn5-5VXMJYw4Ye55Am7bT3VsAgr6U4GkDjGV2U_Q@mail.gmail.com>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com>
	<alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz>
	<CALu8Fe9=itXEMO38vMQ9GsER0s-J=XxQ4+RAxZvMX7gEGuTHrA@mail.gmail.com>
	<CANq1E4QrSdoEHtJeNH3k4FU7S0WQKRadJB9qMTG+q+khVgqBsg@mail.gmail.com>
	<4F78B036.8070207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:50931 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab2DAUKH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Apr 2012 16:10:07 -0400
Received: by wgbdr13 with SMTP id dr13so2085077wgb.1
        for <linux-input@vger.kernel.org>; Sun, 01 Apr 2012 13:10:05 -0700 (PDT)
In-Reply-To: <4F78B036.8070207@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

Hi Nikolai

On Sun, Apr 1, 2012 at 9:44 PM, Nikolai Kondrashov <spbnick@gmail.com> wrote:
> Hi David,
>
>
> On 03/31/2012 02:03 AM, David Herrmann wrote:
>>
>> Rebinding works perfectly well for me. I use it all the time when
>> testing HID drivers.
>
>
> Thank you.
>
> I've tried it, but it doesn't work for me, because HID report descriptors
> are not re-parsed after rebinding and I rely on report_fixup's a lot. Please
> see my reply to Jiri for slightly more details:
> http://thread.gmane.org/gmane.linux.kernel.input/23708/focus=24337
>
>
>> Furthermore, there is a dynid-implementation in the kernel so when hacking
>> on something like this I'd recommend using this. It would also remove the
>> hard limit that you currently have.
>
>
> Thanks, but this doesn't suit me currently. I don't implement report parsing
> in my drivers, but rather describe every device protocol separately with a
> report descriptor and rely on the generic driver for parsing. Thus, I save
> in code complexity and maintenance, but loose in portability.

I think you don't understand me correctly. I meant instead of using
some static global table in the module you could instead implement
something like the "new_id"/store_new_id()/dyn_list/dyn_lock mechanism
but for the special_driver-id-array. So one could use "echo vid:pid
>/sys/bus/hid/new_special_driver_id" and it would be added to a linked
list which is checked additionally to the static array.

Such a mechanism is already used by all kinds of buses, hid, usb,
pci... but only for the id-lists of drivers, not a global module list.
At least this would look less hackish than a fixed-length-array module
parameter ;)

> However, I plan to make a non-HID driver for Waltop tablets, using their
> proprietary, HID-incompatible protocol and there I will probably use that.
>
> Sincerely,
> Nick

Regards
David

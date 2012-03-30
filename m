From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Sat, 31 Mar 2012 01:03:38 +0200
Message-ID: <CANq1E4QrSdoEHtJeNH3k4FU7S0WQKRadJB9qMTG+q+khVgqBsg@mail.gmail.com>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com>
	<alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz>
	<CALu8Fe9=itXEMO38vMQ9GsER0s-J=XxQ4+RAxZvMX7gEGuTHrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35883 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934822Ab2C3XDj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Mar 2012 19:03:39 -0400
Received: by wibhr17 with SMTP id hr17so1048737wib.1
        for <linux-input@vger.kernel.org>; Fri, 30 Mar 2012 16:03:38 -0700 (PDT)
In-Reply-To: <CALu8Fe9=itXEMO38vMQ9GsER0s-J=XxQ4+RAxZvMX7gEGuTHrA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

Hi Nikolai

On Fri, Mar 30, 2012 at 5:22 PM, Nikolai Kondrashov <spbnick@gmail.com> wrote:
> Hi Jiri,
>
> On Fri, Mar 30, 2012 at 4:49 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>> On Mon, 20 Feb 2012, Nikolai Kondrashov wrote:
>>> Add "have_special_driver" hid module parameter - a list of additional HID
>>> devices which have specialized driver on HID bus. Needed to support out-of-tree
>>> HID drivers.
>>
>> I find this a little bit hackish :) How about for example the userspace
>> transport drivers for Bluetooth-LE that are currently in the works?
>
> I like the idea and the implementation seems good, but I can't see how it
> is related to the task of having out-of-tree HID drivers, sorry.
>
>> I'd very much prefer just using sysfs (bind/unbind) way of doing things if
>> possible for this purpose. What do you think?
>
> To my shame I must admit I didn't know or forgot of this mechanism. Although
> I did some research asking kernel developers at work about possibility to
> rebind a different driver. They either forgot about it at the time too, or I
> didn't ask properly.
>
> I think, I can craft an udev rule which will detach a tablet from the
> generic HID driver and attach it to my driver through sysfs.
>
> Please forget about this patch for now, I will resume bothering you in case
> it's not possible or not appropriate :)

Rebinding works perfectly well for me. I use it all the time when
testing HID drivers. Furthermore, there is a dynid-implementation in
the kernel so when hacking on something like this I'd recommend using
this. It would also remove the hard limit that you currently have.

> Thanks!
>
> Sincerely,
> Nick

Regards
David

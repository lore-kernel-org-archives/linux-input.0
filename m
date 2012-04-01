From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Sun, 01 Apr 2012 23:22:32 +0300
Message-ID: <4F78B908.10707@gmail.com>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com>	<alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz>	<CALu8Fe9=itXEMO38vMQ9GsER0s-J=XxQ4+RAxZvMX7gEGuTHrA@mail.gmail.com>	<CANq1E4QrSdoEHtJeNH3k4FU7S0WQKRadJB9qMTG+q+khVgqBsg@mail.gmail.com>	<4F78B036.8070207@gmail.com> <CANq1E4RTrqwn5-5VXMJYw4Ye55Am7bT3VsAgr6U4GkDjGV2U_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36859 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab2DAUWf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Apr 2012 16:22:35 -0400
Received: by wibhq7 with SMTP id hq7so2090136wib.1
        for <linux-input@vger.kernel.org>; Sun, 01 Apr 2012 13:22:34 -0700 (PDT)
In-Reply-To: <CANq1E4RTrqwn5-5VXMJYw4Ye55Am7bT3VsAgr6U4GkDjGV2U_Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

Hi David,

On 04/01/2012 11:10 PM, David Herrmann wrote:
> On Sun, Apr 1, 2012 at 9:44 PM, Nikolai Kondrashov<spbnick@gmail.com>  wrote:
>> Thanks, but this doesn't suit me currently. I don't implement report parsing
>> in my drivers, but rather describe every device protocol separately with a
>> report descriptor and rely on the generic driver for parsing. Thus, I save
>> in code complexity and maintenance, but loose in portability.
>
> I think you don't understand me correctly.

Yes, I didn't, sorry :)

> I meant instead of using some static global table in the module you could
> instead implement something like the
> "new_id"/store_new_id()/dyn_list/dyn_lock mechanism but for the
> special_driver-id-array. So one could use "echo vid:pid
>> /sys/bus/hid/new_special_driver_id" and it would be added to a linked
> list which is checked additionally to the static array.
>
> Such a mechanism is already used by all kinds of buses, hid, usb,
> pci... but only for the id-lists of drivers, not a global module list.
> At least this would look less hackish than a fixed-length-array module
> parameter ;)

Yes, it could be done like this. However, I think Jiri would reject it. It
basically has the same hackishness WRT the overall design, while having more
complicated implementation.

Then, at least for my purpose, it would be worse. Because it would be harder
to configure it permanently. With a module parameter you could just modify
modprobe configuration, but with a sysfs node, you would need to have some
sort of a script. Then cold-plugged devices won't work unless you care to
unbind the existing devices when adding an ID.

Sincerely,
Nick

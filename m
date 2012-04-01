From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Sun, 01 Apr 2012 22:33:31 +0300
Message-ID: <4F78AD8B.9020104@gmail.com>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com> <alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:42077 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab2DATdf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Apr 2012 15:33:35 -0400
Received: by wgbds11 with SMTP id ds11so1948417wgb.1
        for <linux-input@vger.kernel.org>; Sun, 01 Apr 2012 12:33:34 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Jiri,

On 03/30/2012 04:49 PM, Jiri Kosina wrote:
> On Mon, 20 Feb 2012, Nikolai Kondrashov wrote:
>> Add "have_special_driver" hid module parameter - a list of additional HID
>> devices which have specialized driver on HID bus. Needed to support out-of-tree
>> HID drivers.
>
> I'd very much prefer just using sysfs (bind/unbind) way of doing things if
> possible for this purpose. What do you think?

I've tried this and it is not suitable. At least not in the current shape.

In short, two reasons:

1. The HID report descriptor is parsed only once, on first device probe and
    the resulting data is kept within device structure. It is not parsed
    again after unbind/bind, thus report_fixup of my driver is not called and
    the reports are getting interpreted according to the old one, rendering
    the device (partially) unusable.

2. The udev rules and scripts needed to make it work in a plug'n'play manner
    suitable for users are considerably more hacky than this solution.

I'd like to ask you to accept this patch for now.  Would it still be
possible to get this patch into 3.4? I promise to look for a better
solution. First step would probably be to fix rebinding.

It seems that you don't have much time recently to review/accept my patches.
Would you direct me to someone else who could do this and thus reduce your
load?

Thanks you.

Sincerely,
Nick

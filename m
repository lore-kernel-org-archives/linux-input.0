From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/1] HID: multitouch: enable palm rejection if device
 implements confidence usage
Date: Thu, 17 Dec 2015 22:52:37 +0100
Message-ID: <CAN+gG=Ga92-UPbbcjiL0p2b4gO0iQE_-U6wXiq_x3=39z+edSg@mail.gmail.com>
References: <1448014866-25348-1-git-send-email-allen_hung@dell.com>
	<alpine.LNX.2.00.1511261521350.20111@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34376 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932967AbbLQVwj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Dec 2015 16:52:39 -0500
In-Reply-To: <alpine.LNX.2.00.1511261521350.20111@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Allen Hung <allen_hung@dell.com>, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

On Thu, Nov 26, 2015 at 3:21 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Fri, 20 Nov 2015, Allen Hung wrote:
>
>> The usage Confidence is mandary to Windows Precision Touchpad devices. The
>> appearance of this usage is checked in hidinput_connect but the quirk
>> MT_QUIRK_VALID_IS_CONFIDENCE is not applied to device accordingly.
>> Apply this quirk and also remove quirk MT_QUIRK_ALWAYS_VALID to enable palm
>> rejection for the WIN 8 touchpad devices which have implemented usage
>> Confidence in its input reports.
>>
>> Tested on Dell XPS 13 laptop.
>>
>> Signed-off-by: Allen Hung <allen_hung@dell.com>
>
> Applied to for-4.5/multitouch. Thanks,
>

Allen, looks like the Dell XPS13 2015 (or was it the 2014?) has
problems with your patch:
https://bugzilla.redhat.com/show_bug.cgi?id=1292583 (we backported
this change in the Fedora kernel 4.2.7).

Would you mind checking that this patch does not create regressions on
older series of laptops?

Thanks in advance.

Cheers,
Benjamin

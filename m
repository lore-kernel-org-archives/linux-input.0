From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 0/2] HID: Force feedback support for the Logitech G920 Wheel
Date: Thu, 26 Nov 2015 16:13:55 +0100
Message-ID: <CAN+gG=Gb+pgvuQbtEgvaYoVwL0OLq=+8M8bDAkBOVkTjOy7TSA@mail.gmail.com>
References: <1448109431-10459-1-git-send-email-e.velds@gmail.com>
	<alpine.LNX.2.00.1511261541470.20111@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35982 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbKZPN4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2015 10:13:56 -0500
In-Reply-To: <alpine.LNX.2.00.1511261541470.20111@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Edwin Velds <e.velds@gmail.com>, Simon Wood <simon@mungewell.org>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, Nov 26, 2015 at 3:42 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Sat, 21 Nov 2015, Edwin Velds wrote:
>
>> This patch implements force feedback support for the Logitech G920 Driving Force
>> Racing Wheel.
>>
>> This patch is based on the basic G920 support patch by Simon Wood:
>> http://www.spinics.net/lists/linux-input/msg42174.html
>
> Simon, it'd be nice if I could get your Tested-by: / Reviewed-by: for
> this.
>

Talking about it, I am not a big fan of renaming hid-logitech-hidpp.c
into hid-logitech-hidpp-base.c. This will just break history for no
reasons.
We could keep it named like that and just add the ff module later.

The other question is why do we need to have the ff module in a
separate file? We generally try to keep the number of file to a small
number, and I am not sure we need to split this for ff only.
I am open to any position in favor of splitting, I am just asking.

Cheers,
Benjamin

From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] HID: add support for PenMount dual-touch panel
Date: Thu, 21 Apr 2011 12:53:02 +0200
Message-ID: <BANLkTinND+uw=JYS4WbwNLAX8P5SF1VGqw@mail.gmail.com>
References: <1303291155-3148-1-git-send-email-salt@salt.com.tw>
	<20110420094700.GA2258@polaris.bitmath.org>
	<BANLkTin7Q3fD3vg90qCk12MGaVEvLBe0Mg@mail.gmail.com>
	<20110420100759.GA2436@polaris.bitmath.org>
	<alpine.LNX.2.00.1104211115570.12035@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34541 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab1DUKxE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Apr 2011 06:53:04 -0400
In-Reply-To: <alpine.LNX.2.00.1104211115570.12035@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, Richard Nauber <richard.nauber@googlemail.com>, PenMount <penmount.touch@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, PenMount <salt@salt.com.tw>

On Thu, Apr 21, 2011 at 11:17, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 20 Apr 2011, Henrik Rydberg wrote:
>
>> > In fact, I have a second patch just on top of this one. It has been
>> > tested by Ryan with PenMount devices.
>>
>> Great, and good timing. :-)
>>
>> > I was waiting for Penmount to be included first as it does not impact
>> > any other drivers.
>>
>> I would prefer the opposite order, since it is cleaner and means one
>> less device to test for the major change.
>
> I agree with Henrik on this.
>
> Once you are done with testing the last_field_index change, it'd be great
> if you could respin the patches so that the first one perfoms this change,
> and the second one adds PenMount support on top of it.
>
> I'll then apply it. Thanks,

Hi Jiri,

I'll do that as soon as Henrik tells me it is working.

Cheers,
Benjamin

>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Add hid-over-i2c name to i2c id table
Date: Wed, 9 Mar 2016 16:15:00 -0800
Message-ID: <CAKdAkRQwpQ8RmptQgfbPF4-w9qXGHHA0kXQEQkU23jr+FMjOAA@mail.gmail.com>
References: <20160308192539.GA23955@dtor-ws>
	<alpine.LNX.2.00.1603092150060.3656@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35014 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbcCJAPB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2016 19:15:01 -0500
In-Reply-To: <alpine.LNX.2.00.1603092150060.3656@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Benson Leung <bleung@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Wed, Mar 9, 2016 at 12:50 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Tue, 8 Mar 2016, Dmitry Torokhov wrote:
>
>> When using the device tree binding OF compatible = "hid-over-i2c" the
>> i2c id table also needs to have that name in order to auto load this
>> driver, since i2c core reports module alias as i2c:<string> where
>> <string> is compatible string of OF binding stripped of manufacturer's
>> prefix.
>>
>> Signed-off-by: Benson Leung <bleung@chromium.org>
>> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
>
> Applied, thanks.

Crap, can you change author on this to "Benson Leung
<bleung@chromium.org>" and on "HID: i2c-hid: Fix suspend/resume when
already runtime suspended" to "Doug Anderson <dianders@chromium.org>"?

I need to fix my script...

Thanks.

-- 
Dmitry

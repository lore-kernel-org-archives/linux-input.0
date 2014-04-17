From: Kees Cook <keescook@chromium.org>
Subject: Re: HID: hid-logitech - missing HID_OUTPUT_REPORT 0
Date: Thu, 17 Apr 2014 10:09:43 -0700
Message-ID: <CAGXu5jL4H2ukqQDV4syME148bbD3wcSqM0NscvOujnMYtW5w1g@mail.gmail.com>
References: <6452400bfacafd7e1f0d0f7a98b06248.squirrel@mungewell.org>
	<CAGXu5jKTcV9m70tgsxrBhUXWp5eXdXRJkCdYJDhpdOtB16b=6w@mail.gmail.com>
	<796aa99e55f8812aa6422d35610d4ed3.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:52691 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbaDQRJo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Apr 2014 13:09:44 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so741619oag.17
        for <linux-input@vger.kernel.org>; Thu, 17 Apr 2014 10:09:43 -0700 (PDT)
In-Reply-To: <796aa99e55f8812aa6422d35610d4ed3.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Elias Vanderstuyft <elias.vds@gmail.com>

On Thu, Apr 17, 2014 at 9:35 AM,  <simon@mungewell.org> wrote:
>
>> I don't know the lg driver very well, but it looks like it's expecting
>> a single report ID (0), but the device is showing two report IDs: 1
>> and 2. So, from the perspective of the driver, this is correct: it
>> wouldn't know how to deal with things since it is only expecting
>> Report ID 0. It seems like the driver needs to be updated for this
>> different device.
>
> Hi,
> The 'hid-lgff.c' driver supports lots of devices (see end of 'hid-lg.c'),
> and presumably these devices offer up a wide/varied range of HID
> descriptors.
>
> Does the recently introduced(/changed) check need to have prior knowledge
> of which 'Report ID's are actually used? If so, it possible that the
> change has broken a number of devices...
>
> I am trying to get the end user to test with an older kernel to see
> whether his device was always 'broken'.

Ah-ha, actually, when taking a closer look at this, I see that lgff
isn't using ID "0", it's actually using "the first report in the
list", without using an ID at all. This appears to be true for all the
lg*ff devices, actually. Instead of validating ID 0, it needs to
validate "the first report".

Documentation for hid_validate_values says:
 * @id: which report ID to examine (0 for first)

Benjamin, does that mean "first report in the list", or is that a hint
that IDs are 0-indexed? What do you think is the best way to handle
this? Seems like passing something for "id" that means "whatever is
first in list" would be safest? I don't think overloading the meaning
of "0" is good, in case a driver really is using a 0 index but no
report with that ID exists in the list. Or if we do change the
meaning, make sure drivers always use the report returned by
hid_validate_values instead of re-finding it later.

-Kees

-- 
Kees Cook
Chrome OS Security

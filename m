From: Kees Cook <keescook@chromium.org>
Subject: Re: HID: hid-logitech - missing HID_OUTPUT_REPORT 0
Date: Thu, 17 Apr 2014 13:05:29 -0700
Message-ID: <CAGXu5jLLgTOHbJXOt8t1+YYCjz_GR6z8FSmjL3UyXccWztDGRw@mail.gmail.com>
References: <6452400bfacafd7e1f0d0f7a98b06248.squirrel@mungewell.org>
	<CAGXu5jKTcV9m70tgsxrBhUXWp5eXdXRJkCdYJDhpdOtB16b=6w@mail.gmail.com>
	<796aa99e55f8812aa6422d35610d4ed3.squirrel@mungewell.org>
	<CAGXu5jL4H2ukqQDV4syME148bbD3wcSqM0NscvOujnMYtW5w1g@mail.gmail.com>
	<20140417173723.GC10689@mail.corp.redhat.com>
	<CAGXu5jKVCme=a8EVg1BOrB+5enpjT5aABy3QB=div-t230+NSA@mail.gmail.com>
	<76b32d7527438af3d40dfa6402bf5875.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49233 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaDQUFa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Apr 2014 16:05:30 -0400
Received: by mail-ob0-f174.google.com with SMTP id gq1so979911obb.33
        for <linux-input@vger.kernel.org>; Thu, 17 Apr 2014 13:05:29 -0700 (PDT)
In-Reply-To: <76b32d7527438af3d40dfa6402bf5875.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Elias Vanderstuyft <elias.vds@gmail.com>

On Thu, Apr 17, 2014 at 11:27 AM,  <simon@mungewell.org> wrote:
>
>>>> Ah-ha, actually, when taking a closer look at this, I see that lgff
>>>> isn't using ID "0", it's actually using "the first report in the
>>>> list", without using an ID at all. This appears to be true for all the
>>>> lg*ff devices, actually. Instead of validating ID 0, it needs to
>>>> validate "the first report".
>
>
>> +       if (!report && id == 0) {
>> +               /*
>> +                * Requesting id 0 means we should fall back to the first
>> +                * report in the list.
>> +                */
>> +               report = list_entry(
>> +                               hid->report_enum[type].report_list.next,
>> +                               struct hid_report, list);
>> +       }
>
> Is the task of this check to locate/check the 'output' report? Because for
> this particular device it is defined in Report ID 3, the third one in
> descriptor. So would presumably still fail to be found.

The driver currently uses "the first entry in the report list",
regardless of ID. The bug that got introduced here was that the driver
was effectively forced to look up reports by ID, and the code didn't
acknowledge the concept of ID 0 effectively being a wildcard ID.

-Kees

-- 
Kees Cook
Chrome OS Security

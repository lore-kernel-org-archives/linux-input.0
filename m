From: simon@mungewell.org
Subject: Re: HID: hid-logitech - missing HID_OUTPUT_REPORT 0
Date: Thu, 17 Apr 2014 14:27:12 -0400
Message-ID: <76b32d7527438af3d40dfa6402bf5875.squirrel@mungewell.org>
References: <6452400bfacafd7e1f0d0f7a98b06248.squirrel@mungewell.org>
    <CAGXu5jKTcV9m70tgsxrBhUXWp5eXdXRJkCdYJDhpdOtB16b=6w@mail.gmail.com>
    <796aa99e55f8812aa6422d35610d4ed3.squirrel@mungewell.org>
    <CAGXu5jL4H2ukqQDV4syME148bbD3wcSqM0NscvOujnMYtW5w1g@mail.gmail.com>
    <20140417173723.GC10689@mail.corp.redhat.com>
    <CAGXu5jKVCme=a8EVg1BOrB+5enpjT5aABy3QB=div-t230+NSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:34125 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbaDQS1P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Apr 2014 14:27:15 -0400
In-Reply-To: <CAGXu5jKVCme=a8EVg1BOrB+5enpjT5aABy3QB=div-t230+NSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Elias Vanderstuyft <elias.vds@gmail.com>


>>> Ah-ha, actually, when taking a closer look at this, I see that lgff
>>> isn't using ID "0", it's actually using "the first report in the
>>> list", without using an ID at all. This appears to be true for all the
>>> lg*ff devices, actually. Instead of validating ID 0, it needs to
>>> validate "the first report".


> +       if (!report && id == 0) {
> +               /*
> +                * Requesting id 0 means we should fall back to the first
> +                * report in the list.
> +                */
> +               report = list_entry(
> +                               hid->report_enum[type].report_list.next,
> +                               struct hid_report, list);
> +       }

Is the task of this check to locate/check the 'output' report? Because for
this particular device it is defined in Report ID 3, the third one in
descriptor. So would presumably still fail to be found.

I don't have any devices which use hid-lgff, but have some which use
hid-lg4ff which was also changed to perform the same test. I can check
their operation/HID reports over the weekend.

Simon.


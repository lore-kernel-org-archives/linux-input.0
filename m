From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] hid-chicony: Add support for another ASUS Zen AiO keyboard
Date: Wed, 26 Apr 2017 12:54:43 -0600
Message-ID: <CAD8Lp47oPXz+Sc+c+1uQ971vm_=0KmOOOROwdE4KJ0L5C9J5MA@mail.gmail.com>
References: <20170217134052.440-1-drake@endlessm.com> <20170301171514.GJ7064@mail.corp.redhat.com>
 <CAD8Lp451UxrFh_3ZesvVfzf82O4zwgvSDzDOGf27RmYhm3xvWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34636 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965598AbdDZSyp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Apr 2017 14:54:45 -0400
Received: by mail-oi0-f53.google.com with SMTP id x184so12168554oia.1
        for <linux-input@vger.kernel.org>; Wed, 26 Apr 2017 11:54:44 -0700 (PDT)
In-Reply-To: <CAD8Lp451UxrFh_3ZesvVfzf82O4zwgvSDzDOGf27RmYhm3xvWw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>, cyrus.lien@canonical.com

Hi Benjamin,

Trying to pick this up again.

On Thu, Mar 23, 2017 at 1:00 PM, Daniel Drake <drake@endlessm.com> wrote:
> On Wed, Mar 1, 2017 at 11:15 AM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>> On Feb 17 2017 or thereabouts, Daniel Drake wrote:
>>> This device is not visibly branded as Chicony, and the USB Vendor ID
>>> suggests that it is a JESS device. However this seems like the right place
>>> to put it: the usage codes are identical to the currently supported
>>> devices, and this driver already supports the ASUS AIO keyboard AK1D.
>>
>> Except that the AK1D is branded as Chicony. So I think it will confuse
>> users to ask them to load hid-chicony on a Asus keyboard branded as
>> JESS.
>>
>> How about adding this one to hid-asus directly (with maybe a guard
>> against either the PID or a quirk for it)?
>
> Indeed the new keyboard added here is not branded as Chicony nor Jess,
> but only as Asus.
>
> We additionally now have another keyboard that needs the same key
> handling, again only branded as Asus, but this time the USB ID is
> 0x062a:0x5110 suggesting manufacturer TURBOX.
>
> I am assuming you'd prefer that we have both of these keyboards
> handled by hid-asus instead of hid-chicony even that would duplicate a
> bit of code. But is it really necessary to quirk it based on PID,
> can't we just check for (usage->hid & HID_USAGE_PAGE) ==
> HID_UP_MSVENDOR like hid-chicony does?

I'm going to assume that following hid-chicony here (just check the
usage page) is enough.

What I'm now curious about, looking closer, is whether we should move
the original hid-chicony Asus AK1D support to hid-asus too. You
mentioned that this keyboard is physically branded as Chicony, but are
you sure? This is not mentioned in the commit message, nor in the
original bug link, nor in the patch submission discussion.
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1027789
http://www.spinics.net/lists/linux-input/msg21670.html

And google image search brings up results for both the top and bottom
of this keyboard, and no sign of any Chicony branding.
https://www.google.com/search?q=asus+AK1D&source=lnms&tbm=isch

So should I move AK1D support to hid-asus too, to match the physical branding?

Thanks
Daniel

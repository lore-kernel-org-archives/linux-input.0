From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 01/14] HID: validate HID report id size
Date: Thu, 29 Aug 2013 11:21:15 +0200
Message-ID: <CAN+gG=FuTm0Mn-gTZeOEict90SBuppjHx5Ag4MPb5h1bC+2YUQ@mail.gmail.com>
References: <alpine.LNX.2.00.1308282158220.22181@pobox.suse.cz>
	<alpine.LNX.2.00.1308291102380.23267@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:53013 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650Ab3H2JVQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Aug 2013 05:21:16 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so191753pbc.35
        for <linux-input@vger.kernel.org>; Thu, 29 Aug 2013 02:21:15 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1308291102380.23267@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Kees Cook <keescook@chromium.org>

On Thu, Aug 29, 2013 at 11:03 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 28 Aug 2013, Jiri Kosina wrote:
>
>> From: Kees Cook <keescook@chromium.org>
>>
>> The "Report ID" field of a HID report is used to build indexes of
>> reports. The kernel's index of these is limited to 256 entries, so any
>> malicious device that sets a Report ID greater than 255 will trigger
>> memory corruption on the host:
>>
>> [ 1347.156239] BUG: unable to handle kernel paging request at ffff88094958a878
>> [ 1347.156261] IP: [<ffffffff813e4da0>] hid_register_report+0x2a/0x8b
>>
>> CVE-2013-2888
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Cc: stable@kernel.org
>
> Applied this one to hid.git#for-3.11/CVE-2013-2888

Well, I am a little bit lost here. I know the patch will not break any
existing things, but still, I really can not understand how this can
happen:

- Report IDs are specifically specified to be 1-byte fields. That
means that the max they can have is 0xFF, which is 255 :-/
- If I look at the implementation, hid_get_report() is where we fetch
the report ID from the data. But the report ID is declared as an u8...
so with a max of 255.

So the only problem might comes when specific hid drivers call
manually hid_register_report(), and in this case, we can easily
prevent this by looking at their code. No? Or we could also
specifically change the type of the argument id in
hid_register_report() to be an u8.

Basically, I'd be eager to have proper hid report descriptors and
events that can produce them, so I can add them to my HID regressions
test suite.

Cheers,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

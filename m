From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] HID: add Asus macrokey support for Asus "Republic of
 Gamers" laptop
Date: Tue, 31 Jan 2017 13:42:00 -0600
Message-ID: <CAD8Lp46eSzFTEF2VbOHESBHRPOQ0UWO34-DNQYkkwWNKT9kf9g@mail.gmail.com>
References: <1481546578-40703-1-git-send-email-chiu@endlessm.com> <20161213081632.GC13907@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34811 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbdAaTmB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 14:42:01 -0500
Received: by mail-oi0-f47.google.com with SMTP id s203so89089321oie.1
        for <linux-input@vger.kernel.org>; Tue, 31 Jan 2017 11:42:01 -0800 (PST)
In-Reply-To: <20161213081632.GC13907@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Chris Chiu <chiu@endlessm.com>, Jiri Kosina <jikos@kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>

Hi Benjamin,

On Tue, Dec 13, 2016 at 2:16 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Dec 12 2016 or thereabouts, Chris Chiu wrote:
>> ROG means ASUS "Republic of Gamers" laptops. The input device info
>> also represents itself as "ASASTeK COMPUTER INC. ROG MacroKey". It
>> uses special HID_USAGE code for function keys. This commit remap the
>> special code to standard keycode for function keys handling. It's
>> verified on GL553VD/VE, GL753VD/VE.
>>
>> Signed-off-by: Chris Chiu <chiu@endlessm.com>
>> Reported-by: Yukai Li <yukaili@gmail.com>
>> ---
>
> Hi Chris,
>
> there is no real point of having a separate driver from hid-asus. The
> HID tree prefer to group drivers by vendors, so these keyboards should
> be supported through hid-asus.

Thanks for the feedback. We will submit a new version soon.

Just to confirm, hid-asus currently depends on I2C_HID. The new
devices being quirked now are USB devices. With this patch should we
now update it to depend on I2C_HID && USB_HID?

Daniel

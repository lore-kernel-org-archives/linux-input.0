From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Dell XPS 13 Fn key bug?
Date: Thu, 2 Feb 2017 08:47:48 -0800
Message-ID: <20170202164748.GB21924@dtor-ws>
References: <20170125084732.5hawvooeegtw4wwc@zenon.in.qult.net>
 <CAKdAkRQ=jCsQvPb8vK1byYYAbLSEeBHpMMDuMGhgwdqVKvQ_yg@mail.gmail.com>
 <20170202084033.76d6youemdr2pc5f@zenon.in.qult.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35103 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbdBBQrv (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Feb 2017 11:47:51 -0500
Received: by mail-pf0-f193.google.com with SMTP id f144so1835671pfa.2
        for <linux-input@vger.kernel.org>; Thu, 02 Feb 2017 08:47:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170202084033.76d6youemdr2pc5f@zenon.in.qult.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ignacy =?utf-8?B?R2F3xJlkemtp?= <bugs@qult.net>
Cc: Mario Limonciello <Mario_Limonciello@dell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Feb 02, 2017 at 09:40:33AM +0100, Ignacy Gawędzki wrote:
> On Wed, Feb 01, 2017 at 04:16:13PM -0800, thus spake Dmitry Torokhov:
> > OK, so 'cd' is scancode for KEY_RIGHT and 'cf' is scancode for
> > KEY_END, and it seems that implementation of FN handling is very naive
> > as it emits "release" keycodes for the state FN is currently in, not
> > the state it was when key was pressed.
> > 
> > Ideally Dell would fix that. Mario, any chance of that?
> 
> I'm just wondering whether this is still something that could be fixed
> or worked around in the input driver,

Well, obviously I'd rather fix the bug at its root rather than piling
workarounds in the driver.

> since the bug obviously doesn't
> show up in neither in the linux console nor in Windows.

So where does it not work in Linux? Because keyboard driver in console
and elsewhere is the same. Maybe it is not noticeable when in text
console?

In Windows the bug might be masked if they use hardware autorepeat for
PS/2 keyboards. I don't know if they do or not.

Thanks.

-- 
Dmitry

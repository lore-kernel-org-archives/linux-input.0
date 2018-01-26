From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 3/3] Input: goodix - use generic touchscreen_properties
Date: Fri, 26 Jan 2018 15:57:58 -0800
Message-ID: <CAKdAkRTcsTOqj_jT7uu09k5i82wDEB0Fm-sb4TrNviwKbeb9iw@mail.gmail.com>
References: <20180125190829.8968-1-m.niestroj@grinn-global.com>
 <20180125190829.8968-4-m.niestroj@grinn-global.com> <20180126191945.q3sx2pcs7rvpil33@dtor-ws>
 <1517010494.2592.27.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:42669 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbeAZX57 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Jan 2018 18:57:59 -0500
Received: by mail-ua0-f174.google.com with SMTP id n2so1366054uak.9
        for <linux-input@vger.kernel.org>; Fri, 26 Jan 2018 15:57:59 -0800 (PST)
In-Reply-To: <1517010494.2592.27.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>, Antonio Ospite <ao2@ao2.it>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, Jan 26, 2018 at 3:48 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Fri, 2018-01-26 at 11:19 -0800, Dmitry Torokhov wrote:
>> Can you please try the version below (note that I sqashed all your 3
>> patches in one as, as I mentioed, I do not see why they need to be
>> split
>> in the first place).
>
> It was easier to read, and backport. Patch 1 and 2 at least are easily
> backportable, and "easy" fixes on top of the existing code. Breakages
> would be easier to spot with the 3 separate fixes, and that's how I'd
> prefer it if it's not too much bother.

There is nothing to read if you drop the patch 2, as it is something
that was done and immediately deleted.

Thanks.

-- 
Dmitry

From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH] input: pegasus_notetaker: add license information
Date: Sun, 26 Nov 2017 12:28:49 +0100
Message-ID: <CAOFm3uE7wX-zmSCwABGR3_RR2gZY8MBMwFw42SwRwnDdrJ78Nw@mail.gmail.com>
References: <20171118084518.8437-1-martink@posteo.de> <20171126004259.xjl2icw3gbyg3hck@dtor-ws>
 <20171126085951.GA10018@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32920 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbdKZL3b (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 26 Nov 2017 06:29:31 -0500
Received: by mail-wr0-f195.google.com with SMTP id 55so7542201wrx.0
        for <linux-input@vger.kernel.org>; Sun, 26 Nov 2017 03:29:30 -0800 (PST)
In-Reply-To: <20171126085951.GA10018@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Martin Kepplinger <martink@posteo.de>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Greg, Martin:

On Sun, Nov 26, 2017 at 9:59 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Nov 25, 2017 at 04:42:59PM -0800, Dmitry Torokhov wrote:
>> Hi Martin,
>>
>> On Sat, Nov 18, 2017 at 09:45:18AM +0100, Martin Kepplinger wrote:
>> > This adds an SPDX license identifier to this driver I wrote some time back.
>> >
>> > Signed-off-by: Martin Kepplinger <martink@posteo.de>
>> > ---
>> >  drivers/input/tablet/pegasus_notetaker.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
>> > index 47de5a81172f..cdf75c989469 100644
>> > --- a/drivers/input/tablet/pegasus_notetaker.c
>> > +++ b/drivers/input/tablet/pegasus_notetaker.c
>> > @@ -1,3 +1,4 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>>
>> Should this be GPL-2.0+? The MODULE_LICENSE specifies that the module is
>> "GPL" which in kernel land means GPLv2+. Or we should change the module
>> license to strict "GPLv2"?
>
> That is up to Martin, given that he is the author, as to what he wants
> to mark this as.  Odd that it missed the big "fix up all files with no
> license information" sweep.
>
> Philippe, how did we miss this one?

It was not missed but instead was set aside by design.
drivers/input/tablet/pegasus_notetaker.c does not have (or rather did
not have until now) any licensing information beside a
MODULE_LICENSE("GPL") and these were left aside as requiring some
extra review and the eventual need of a clarification by the author,
just as Martin is rightfully doing so just now.

>> Doing this would prevent mismatches between license notices, SPDX tags
>> and MODULE_LCENSE() strings, which happen very often.
>
> I agree, but now that we are getting SPDX tags, we can fix up all of the
> mismatches in MODULE_LICENSE() strings, of which there are a lot.

I said that I would take a stab at it... but I did not attack this yet:
Let me get over the ThanksGiving hangover and provide a list this
week. I guess there could be three lists in fact:

- modules with only a MODULE_LICENSE and no other license info: these
could be candidates for adding an SPDX id matching the MODULE_LICENSE

- modules updated to use an SPDX id and with a conflicting
MODULE_LICENSE: the MODULE_LICENSE should be aligned to match the SPDX
id

- modules not yet updated to use an SPDX id and with a license notice
conflicting with the MODULE_LICENSE: the MODULE_LICENSE should be
aligned to match the licensing

I'll run a scancode-toolkit scan on the tip of Linus' tree and create
a CSV from that to surface these oddities.
Unless you prefer me to use another tree like on the USB side for a start.

-- 
Cordially
Philippe Ombredanne, the wild licenses tamer

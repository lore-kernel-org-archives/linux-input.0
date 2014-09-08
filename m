From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: EVIOCSFF macro inconsistency
Date: Mon, 8 Sep 2014 21:03:11 +0200
Message-ID: <CADbOyBT_UJJg3d4VYGi5Xry4L5egqc_T3_PGEL7th=4TO=NPcA@mail.gmail.com>
References: <CADbOyBRcKFntUAruYTGcqzt2Vi=MHJDFoZK5v4fE8WLFjT0viw@mail.gmail.com>
	<20140908183157.GA36623@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:44231 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826AbaIHTDM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Sep 2014 15:03:12 -0400
Received: by mail-vc0-f172.google.com with SMTP id hy10so2226839vcb.17
        for <linux-input@vger.kernel.org>; Mon, 08 Sep 2014 12:03:11 -0700 (PDT)
In-Reply-To: <20140908183157.GA36623@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Mon, Sep 8, 2014 at 8:31 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Elias,
>
> On Mon, Sep 08, 2014 at 08:14:13PM +0200, Elias Vanderstuyft wrote:
>> Hi everyone,
>>
>> After inspecting the <linux/input.h> header file, I found that there
>> is one single ioctl value macro that is inconsistent w.r.t. the other
>> macros that do an IOC_WRITE :
>>     EVIOCSFF   _IOC(_IOC_WRITE, 'E', 0x80, sizeof(struct ff_effect))
>> Why not define it as follows? :
>>     EVIOCSFF   _IOW('E', 0x80, struct ff_effect)
>> Apart from having a more readable definition, it also explicitly
>> reveals type info ("struct ff_effect").
>
> I think it is just historical.
>
>> Is it worth to create a patch to fix it?
>
> Sure, why not.

Cool, thanks!

So probably the same applies to the IOC_READ counter parts? :
    EVIOCGBIT(ev,len)    _IOC(_IOC_READ, 'E', 0x20 + (ev), len)
    EVIOCGKEY(len)    _IOC(_IOC_READ, 'E', 0x18, len)
    EVIOCGLED(len)    _IOC(_IOC_READ, 'E', 0x19, len)
    EVIOCGMTSLOTS(len)    _IOC(_IOC_READ, 'E', 0x0a, len)
    EVIOCGNAME(len)    _IOC(_IOC_READ, 'E', 0x06, len)
    EVIOCGPHYS(len)    _IOC(_IOC_READ, 'E', 0x07, len)
    EVIOCGPROP(len)    _IOC(_IOC_READ, 'E', 0x09, len)
    EVIOCGSND(len)    _IOC(_IOC_READ, 'E', 0x1a, len)
    EVIOCGSW(len)    _IOC(_IOC_READ, 'E', 0x1b, len)
    EVIOCGUNIQ(len)    _IOC(_IOC_READ, 'E', 0x08, len)
to be converted to:
    EVIOCGBIT(ev,len)    _IOR('E', 0x20 + (ev), len)
    EVIOCGKEY(len)    _IOR('E', 0x18, len)
    EVIOCGLED(len)    _IOR('E', 0x19, len)
    EVIOCGMTSLOTS(len)    _IOR('E', 0x0a, len)
    EVIOCGNAME(len)    _IOR('E', 0x06, len)
    EVIOCGPHYS(len)    _IOR('E', 0x07, len)
    EVIOCGPROP(len)    _IOR('E', 0x09, len)
    EVIOCGSND(len)    _IOR('E', 0x1a, len)
    EVIOCGSW(len)    _IOR('E', 0x1b, len)
    EVIOCGUNIQ(len)    _IOR('E', 0x08, len)

Thanks,
Elias

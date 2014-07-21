From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH RESEND 4/5] Input: uinput - add new UINPUT_DEV_SETUP ioctl
Date: Mon, 21 Jul 2014 23:08:59 +0200
Message-ID: <CANq1E4QiB8trV4eJ0drPsHhCV=ijU+3FGRu0RYz=WJ0UfOReUQ@mail.gmail.com>
References: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
	<1405775445-4454-5-git-send-email-dh.herrmann@gmail.com>
	<20140721010110.GD22552@core.coreip.homeip.net>
	<CANq1E4S0=h=PccuHVAFPMgdMvGWyBLitpaeJAkZ--PmuTT0xxg@mail.gmail.com>
	<20140721201155.GA10889@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:59955 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbaGUVJB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2014 17:09:01 -0400
Received: by mail-ie0-f172.google.com with SMTP id lx4so7329826iec.31
        for <linux-input@vger.kernel.org>; Mon, 21 Jul 2014 14:08:59 -0700 (PDT)
In-Reply-To: <20140721201155.GA10889@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>

Hi

On Mon, Jul 21, 2014 at 10:11 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Jul 21, 2014 at 08:22:09AM +0200, David Herrmann wrote:
>> I know, but there is no "old absinfo". Once we extend "struct absinfo"
>> I expect this code to change to:
>>
>> {
>>         /* initially supported absinfo had size 24 */
>>         if (setup.absinfo_size < 24)
>>                return -EINVAL;
>>
>>         /* ...pseudo code... */
>>         memset(&absinfo, 0, sizeof(absinfo));
>>         memcpy(&absinfo, sth->absinfo, MIN(setup.absinfo_size,
>> sizeof(absinfo)));
>> }
>>
>> This allows you to use this ioctl with old absinfo objects. I can
>> change the current code to this already, if you want? I tried to avoid
>> it, because a memset() is not neccessarily an appropriate way to
>> initialize unset fields.
>> I cal also add support for "absinfo" without the "resolution" field,
>> which I think is the only field that wasn't available in the initial
>> structure.
>
> I think for now I would do:
>
>         /*
>          * Whoever is changing struct input_absinfo will have to take
>          * care of backwards compatibility.
>          */
>         BUILD_BUG_ON(sizeof(struct input_absinfo)) != 24);
>         if (setup.absinfo_size != sizeof(struct input_absinfo))
>                 return -EINVAL;
>
>         ...
>
> and later when we detect setup.absinfo_size < sizeof(struct
> input_absinfo) we'll have to take care about backwards compatibility. We
> do not need to take care of forward compatibility as we do not know if
> userspace will be satisfied with partial results or not and newer
> userspace can deal with proper handling of older kernels.

I'm not sure I agree. I'm a fan of forward-compatibility, but that's
probably a matter of taste. I will change my code accordingly.

> By the way, I realize I do not like the new IOCTL as it is - it's too
> big and would be hard to extend if we want to change items other than
> absinfo. Why don't we create UI_DEV_SETUP that only sets name, id, and
> number of effects, and add UI_SET_ABSAXIS that would take:
>
>         struct uinput_abs_setup {
>                 __u16   code;   /* axis code */
>                 /* __u16 filler; */
>                 struct input_absinfo absinfo;
>         }

Hm, that is actually a good idea. I will give it a try.

> By the way, while you are hacking on uinput can we also fix formatting
> style of switch/case and switch printk() to pr_debug() and friends? I'd
> do it myself but do not want to step on your toes.

Yepp, I will include those in the next revision.

Thanks
David

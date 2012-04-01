From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Sun, 01 Apr 2012 23:50:10 +0300
Message-ID: <4F78BF82.70903@gmail.com>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com> <alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz> <4F78AD8B.9020104@gmail.com> <alpine.LNX.2.00.1204012137150.16928@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56769 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab2DAUuO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Apr 2012 16:50:14 -0400
Received: by wibhq7 with SMTP id hq7so2100843wib.1
        for <linux-input@vger.kernel.org>; Sun, 01 Apr 2012 13:50:13 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1204012137150.16928@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

On 04/01/2012 10:46 PM, Jiri Kosina wrote:
> On Sun, 1 Apr 2012, Nikolai Kondrashov wrote:
>> 1. The HID report descriptor is parsed only once, on first device probe and
>>     the resulting data is kept within device structure. It is not parsed
>>     again after unbind/bind, thus report_fixup of my driver is not called and
>>     the reports are getting interpreted according to the old one, rendering
>>     the device (partially) unusable.
>
> Hmm, you are absolutely right. This is the thing we should fix first,
> instead of introducing more-or-less hackish workarounds.

I agree. It's just I didn't think I could fix it quickly and didn't expect
anyone to be interested in fixing it for me. Thus, I proposed accepting this
solution for now.

> I will be travelling for the whole day tomorrow, so I will look into this
> onboard the airplane and will try to come up with a fix.

Great! Thank you :)!

>> 2. The udev rules and scripts needed to make it work in a plug'n'play manner
>>     suitable for users are considerably more hacky than this solution.
>
> As this is solely for the purpose of out-of-tree drivers, I believe it's
> better to keep the hackery in userspace though.

I tend to agree. After all, decision on which module to load lies on
userspace, so it might as well decide which one to use. Anyway, I haven't
implemented it fully yet and am still to see if it's really that bad.

>> I'd like to ask you to accept this patch for now.  Would it still be
>> possible to get this patch into 3.4? I promise to look for a better
>> solution. First step would probably be to fix rebinding.
>
> Let's see whether we can come up with proper rebinding fix quickly enough.
> I don't want to end up introducing module parameter that we don't need, as
> we'll have to be maintaining it for compatibility reasons forever.

Sure. I must admit, I didn't think about maintaining the compatibility,
sorry.

>> It seems that you don't have much time recently to review/accept my patches.
>> Would you direct me to someone else who could do this and thus reduce your
>> load?
>
> It's just a matter of prioritizing the incoming queue. I believe I process
> your new drivers and support for new devices by in-tree drivers in a
> timely manner.

Sorry, I didn't mean to complain. It's just we didn't get to discuss this
patch properly until more than a month after I submitted it and then the
Waltop Sirius patch didn't make it into 3.4, so I thought maybe I'm not
supposed to send everything to you and there is some other way.

Thank you for reviewing my patches all this time.

> But this is a core infrastructure change, influencing how we aproach
> out-of-tree drivers, so we'd better be sure to get it right before
> merging (even more so as your solution introduces a userspace interface
> (module parameter) that we'll have to keep forever).

I agree.

Thank you.

Sincerely,
Nick

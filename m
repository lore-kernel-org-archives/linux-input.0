From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] HID: hid-input: Fix accessing freed memory during driver unbind
Date: Sun, 2 Aug 2015 14:09:23 +0900
Message-ID: <CAJKOXPdrpkdpJcW+qiMx6FUmMdDMFuSsbGfE0NmNzC-pEBe3vw@mail.gmail.com>
References: <1438042590-17719-1-git-send-email-k.kozlowski@samsung.com>
	<alpine.LNX.2.00.1507291506500.925@pobox.suse.cz>
	<20150729174619.GC23178@dtor-ws>
	<CAJKOXPcsHAj7_pggVw9eeU-C1_zKuZJA7oUodtXp=ZJH4AWg9w@mail.gmail.com>
	<20150730001026.GH23178@dtor-ws>
	<alpine.LNX.2.00.1508011410170.925@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35666 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbbHBFJY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Aug 2015 01:09:24 -0400
In-Reply-To: <alpine.LNX.2.00.1508011410170.925@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux-pm@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>, stable@vger.kernel.org

2015-08-01 21:11 GMT+09:00 Jiri Kosina <jkosina@suse.com>:
> On Wed, 29 Jul 2015, Dmitry Torokhov wrote:
>
>> > Another and less intrusive fix would be:
>> >
>> >     char *name = dev->battery->desc->name;
>> >     struct power_supply_desc *psy_desc = dev->battery->desc;
>> >     power_supply_unregister(dev->battery);
>> >     kfree(name);
>> >     kfree(psy_desc);
>>
>> I would much rather prefer this to the other version as it does not
>> leave memory hanging around, potentially indefinitely, but ultimately it
>> is up to Jiri.
>
> I must have been in some broken state of mind when applying the original
> one, thanks a lot for catching my brainfart, Dmitry!
>
> Kryzstof, could you please send me properly formatted patch with the
> above, on top of your previous fix?


Of course, I'll send next version.

Best regards,
Krzysztof

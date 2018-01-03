From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] platform/x86: silead_dmi: Add entry for the Teclast
 X98 Plus II
Date: Wed, 3 Jan 2018 09:01:34 +0100
Message-ID: <5c5301e1-48f5-5762-b1d8-95e5f4a2bd8d@redhat.com>
References: <20180102134239.3579-1-paul@crapouillou.net>
 <20180102183928.15267-1-paul@crapouillou.net> <20180102234033.GB24794@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35597 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeACIBh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 3 Jan 2018 03:01:37 -0500
Received: by mail-wm0-f66.google.com with SMTP id a79so1174012wma.0
        for <linux-input@vger.kernel.org>; Wed, 03 Jan 2018 00:01:36 -0800 (PST)
In-Reply-To: <20180102234033.GB24794@fury>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Paul Cercueil <paul@crapouillou.net>
Cc: Andy Shevchenko <andy@infradead.org>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 03-01-18 00:40, Darren Hart wrote:
> On Tue, Jan 02, 2018 at 07:39:27PM +0100, Paul Cercueil wrote:
>> Add touchscreen platform data for the Teclast X98 Plus II tablet.
>>
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/platform/x86/silead_dmi.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>>   v2: Rebased on top of http://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git/shortlog/refs/heads/review-andy
> 
> Generally "testing" is the branch you want to base on if linus/master
> doesn't work as the review-* branches *will* rebase frequently.
> Exceptions exist of course, and this patch is just fine - just for
> future reference.

This is my "fault", I asked Paul to rebase on top of
review-andy as that had 1 new silead_dmi patches missing
from testing, so otherwise we would end up with a conflict when
merging review branches. Same reason why I've been basing my
silead_dmi patches on top of review-andy even though that is
an unusual base to use.

Regards,

Hans


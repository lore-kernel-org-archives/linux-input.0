From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH 1/2] input: Add Qualcomm PM8941 power key driver
Date: Mon, 8 Dec 2014 14:55:30 -0800
Message-ID: <CAJAp7OisbcELW0kUVLAhTbuCU4ksaHbNh_sZi7JzLnF+qiVQSg@mail.gmail.com>
References: <1412644321-27683-1-git-send-email-bjorn.andersson@sonymobile.com>
	<1412644321-27683-2-git-send-email-bjorn.andersson@sonymobile.com>
	<5433B843.5060200@smartplayin.com>
	<20141007233045.GD31125@sonymobile.com>
	<20141007234224.GL16469@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:44282 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbaLHWzb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Dec 2014 17:55:31 -0500
Received: by mail-la0-f46.google.com with SMTP id q1so4761309lam.5
        for <linux-input@vger.kernel.org>; Mon, 08 Dec 2014 14:55:30 -0800 (PST)
In-Reply-To: <20141007234224.GL16469@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Kiran Padwal <kiran.padwal@smartplayin.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>

On Tue, Oct 7, 2014 at 4:42 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Oct 07, 2014 at 04:30:46PM -0700, Bjorn Andersson wrote:
>> On Tue 07 Oct 02:54 PDT 2014, Kiran Padwal wrote:
>>
[..]
>> > Shouldn't we unregister input device?
>> >
>>
>> It's allocated with devm_input_allocate_device() so I assumed that it goes away
>> upon the device being removed. Looking at input_register_device() seems to
>> confirm that.
>
> Yes, devices allocated with devm_input_allocate_device() will be
> unregistered and freed automatically.
>
> Thanks.
>

Hi Dmitry,

Will you pick this up? (couldn't find it in linux-next...)
Or is there anything else you need from me?

Regards,
Bjorn

From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] input: Rename keypad and ts platform driver for w90p910
Date: Mon, 17 Aug 2009 16:44:03 +0800
Message-ID: <e68bb3470908170144w49cf2e44g56eba456424a9a4b@mail.gmail.com>
References: <4A88D499.30302@gmail.com>
	 <20090817084848.6720F526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:58053 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757401AbZHQIoC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Aug 2009 04:44:02 -0400
Received: by pzk34 with SMTP id 34so1839087pzk.4
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2009 01:44:03 -0700 (PDT)
In-Reply-To: <20090817084848.6720F526EA5@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org

Dear Dmitry,

Sir, Due to only w90p910 was renamed, other CPUs of the series
originally was named after NUC9xx,
the ts and keypad was public use by w90p910 ,nuc950 and nuc920, so, if
the 'w90p910-ts' and 'w90p910-keypad' could not be renamed ,I have to
make the platform device names of nuc920 and nuc960 named after
'w90p910-ts' and 'w90p910-keypad' too, Hmm, I think it is so confused.
Also, it is my mistake not to map out well my w90x900 series platform
before submitting it.

But, if you insist on, I think I can obey without question.

Thanks!

2009/8/17 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Mon, Aug 17, 2009 at 11:55:05AM +0800, Wan ZongShun wrote:
>> Dear Dmitry,
>>
>> Due to I modified the corresponding platform device name,
>> so I make the patch to rename keypad and ts platform driver
>> for w90p910 platform.
>>
>
> Do we really need to go through renaming the drivers just because the
> company changed it's name?
>
> --
> Dmitry
>



-- 
Wan z.s

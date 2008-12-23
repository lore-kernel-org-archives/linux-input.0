From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/3] input: add da9034 touchscreen support
Date: Tue, 23 Dec 2008 21:16:50 +0800
Message-ID: <f17812d70812230516n675fc90i1faac1a02a996fb7@mail.gmail.com>
References: <f17812d70812041810o57726d24j4feabfbe89e7c271@mail.gmail.com>
	 <20081223093428.GD14302@anvil.corenet.prv>
	 <f17812d70812230207x4c0cc483tdf1c0b75b4c81808@mail.gmail.com>
	 <200812230317.07220.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:22768 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbYLWNQw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Dec 2008 08:16:52 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2365888rvb.1
        for <linux-input@vger.kernel.org>; Tue, 23 Dec 2008 05:16:51 -0800 (PST)
In-Reply-To: <200812230317.07220.dmitry.torokhov@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Dec 23, 2008 at 7:17 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tuesday 23 December 2008 02:07:00 Eric Miao wrote:
>> On Tue, Dec 23, 2008 at 5:34 PM, Dmitry Torokhov
>>
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Fri, Dec 05, 2008 at 10:10:35AM +0800, Eric Miao wrote:
>> >> From a3259123035102444c5868d825aa06fd9a49fad4 Mon Sep 17 00:00:00 2001
>> >> From: Eric Miao <eric.miao@marvell.com>
>> >> Date: Wed, 3 Dec 2008 13:39:28 +0800
>> >> Subject: [PATCH] input: add da9034 touchscreen support
>> >>
>> >> Add support for the built-in touchscreen controller in DA9034 (aka
>> >> Micco), usually found on platforms with xscale processors.
>> >>
>> >> Signed-off-by: Eric Miao <eric.miao@marvell.com>
>> >
>> > Applied with the following changes, thank you Eric.
>>
>> I'm sorry for the broken gmail web interface to mess up with the original
>> message, next time I'll give an attachment as well if you are OK with that.
>
> Umm? The patch was not corrupted in any way, as far as I can see...
>

I was seeing some blank line changes so I suspected that was caused by
the mailer. Any way, thanks for the changes.

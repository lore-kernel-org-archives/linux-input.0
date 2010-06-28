From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Mon, 28 Jun 2010 11:10:02 +0200
Message-ID: <4C2866EA.207@euromail.se>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com> <4C24B86E.1030407@euromail.se> <4C283048.1090601@samsung.com> <4C285124.1050201@euromail.se> <4C285AB1.7030301@samsung.com> <4C285E85.6080008@euromail.se> <20100628084212.GE25287@core.coreip.homeip.net> <4C286183.6080304@euromail.se> <20100628090135.GA13523@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:44488 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751070Ab0F1JKi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 05:10:38 -0400
In-Reply-To: <20100628090135.GA13523@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, kyungmin.park@samsung.com

Dmitry Torokhov wrote:
> On Mon, Jun 28, 2010 at 10:46:59AM +0200, Henrik Rydberg wrote:
>> Dmitry Torokhov wrote:
>>> On Mon, Jun 28, 2010 at 10:34:13AM +0200, Henrik Rydberg wrote:
>>>> It is a bit confusing I agree, but the document is correct. The empty
>>>> input_mt_sync() is used when there is no data to report, no lifted fingers,
>>>> nothing. Just imagine a device which gets polled periodically.
>>> If there is no new data to report why we need to call input_mt_sync() at
>>> all? You can send input_sync() but input core will filter it out...
>>>
>> Yep, that is the reason. Admittedly, this is a corner cases that type A does not
>> handle very gracefully, but it works. The only device so far where this seems
>> useful is for the magic mouse, which does not want to report BTN_TOUCH at all.
>>
> 
> So what if we filter everything out? Userspace will never know that we
> got an interrupt and will be just fine...
> 

Userspace would still want to know if that last finger stayed on the pad the
whole time, or if it was actually removed in between.

Henrik

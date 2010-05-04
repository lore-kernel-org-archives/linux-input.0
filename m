From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: mt: introduce MT event slots
Date: Tue, 04 May 2010 23:41:24 +0200
Message-ID: <4BE09484.9000600@euromail.se>
References: <1270685590-2204-1-git-send-email-rydberg@euromail.se> <20100415232523.GA18263@core.coreip.homeip.net> <4BDFD356.7070008@bitmath.org> <20100504172903.GB29428@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:43312 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933217Ab0EDVl7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 4 May 2010 17:41:59 -0400
In-Reply-To: <20100504172903.GB29428@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Tue, May 04, 2010 at 09:57:10AM +0200, Henrik Rydberg wrote:
>>> It would be nice to use abs[ABS_MT_MAX - ABS_MT_TOUCH_MAJOR] to save
>>> some memory.
>>>
>> Is it possible this was meant to read "ABS_MAX - ABS_MT_TOUCH_MAJOR"? It would
>> explain my confusion.
>>
> 
> By ABS_MT_MAX I meant highest MT event currently defined. No need to go all
> the way to ABS_MAX if there are no MT events defined there.
> 

I see, thanks.

Henrik

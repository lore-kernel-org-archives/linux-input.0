From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 1/3] input: mt: Simplify event bypass logic
Date: Tue, 04 May 2010 09:34:21 +0200
Message-ID: <4BDFCDFD.60402@euromail.se>
References: <1272721779-2124-1-git-send-email-rydberg@euromail.se> <20100504064905.GB17482@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:45373 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756631Ab0EDHek (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 4 May 2010 03:34:40 -0400
In-Reply-To: <20100504064905.GB17482@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Sat, May 01, 2010 at 03:49:39PM +0200, Henrik Rydberg wrote:
>> The input bypass mechanism is only used by the MT events. Since all
>> MT events use bypassing by construction, the current list is a mere
>> duplication of input.h. This patch replaces the bypass list by a
>> simple range test.
>>
> 
> Henrik,
> 
> I disagree with the patch. I can not guarantee that we will be able to
> maintain continuous range of ABS_MT_* events and thus current scheme is
> more flexible.
> 
> Thanks.
> 

Yes, I was hesitant myself. I would rather keep all [ABS_MAX + 1 - ABS_MT_MIN]
in the slot. Introduces a memory slack but is more flexible.

Henrik

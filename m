From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: mt: Interface and MT_TOOL documentation updates
Date: Fri, 10 Dec 2010 14:54:07 +0100
Message-ID: <4D0230FF.6070207@euromail.se>
References: <1291929732-5989-1-git-send-email-rydberg@euromail.se> <20101210074351.GC21009@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:59365 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752712Ab0LJNyy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Dec 2010 08:54:54 -0500
In-Reply-To: <20101210074351.GC21009@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/10/2010 08:43 AM, Dmitry Torokhov wrote:

> On Thu, Dec 09, 2010 at 10:22:12PM +0100, Henrik Rydberg wrote:
>> The recent input-mt interface changes together with
>> recent discussions about pen and touch and support
>> for legacy multitouch pads suggest that the documentation
>> on MT tool types be expanded. This patch adds references
>> to the new interface, and adds a section for MT_TOOL types,
>> in particular documenting the use of MT_TOOL_ENVELOPE.
>>
>> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> 
> 
> The explanation of the new types makes sense to me... Do you think we
> could add some comments directly to input.h?


Good idea, will do.

Thanks,
Henrik

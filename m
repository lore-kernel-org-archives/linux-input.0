From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] Input: cap1106 - allow changing key mapping from userspace
Date: Fri, 08 Aug 2014 12:27:53 +0200
Message-ID: <53E4A629.3040008@gmail.com>
References: <20140721012045.GA4395@core.coreip.homeip.net> <20140807062033.GD651@core.coreip.homeip.net> <53E321B0.9040701@gmail.com> <20140808065038.GC8103@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:49243 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296AbaHHK17 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Aug 2014 06:27:59 -0400
In-Reply-To: <20140808065038.GC8103@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/08/2014 08:50 AM, Dmitry Torokhov wrote:
> On Thu, Aug 07, 2014 at 08:50:24AM +0200, Daniel Mack wrote:
>> Hi Dmitry,
>>
>> On 08/07/2014 08:20 AM, Dmitry Torokhov wrote:
>>> On Sun, Jul 20, 2014 at 06:20:49PM -0700, Dmitry Torokhov wrote:
>>>> Wire up support for EVIOC{G|S}KEYCODE to allow users change key mappings
>>>> from userspace.
>>>>
>>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>> ---
>>>>
>>>> Just compiled, not tested.
>>>
>>> *ping* Any chance you could give it a try? Thanks!
>>
>> Oh, sorry, I didn't realize you're waiting for me on this.
>>
>> Unfortunately, I can't test it myself anymore, as I had to return the
>> board I found this chip on. But as the change looks very straight
>> forward, I'd suggest you just apply that patch and I ask the vendor to
>> give it a quick try. In case of any problems, I'll let you know. Does
>> that sound feasible?
> 
> OK, I'll put you down as reviewed-by then so we can share the glory (and the
> blame ;))

Alright, thanks :)


Thanks,
Daniel


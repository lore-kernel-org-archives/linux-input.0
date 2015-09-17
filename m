From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] devicetree: bindings: use input-event-codes.h for
 evdev codes
Date: Thu, 17 Sep 2015 15:00:47 -0500
Message-ID: <55FB1BEF.4090107@kernel.org>
References: <1442064372-3030-1-git-send-email-hdegoede@redhat.com>
 <1442064372-3030-3-git-send-email-hdegoede@redhat.com>
 <1442316292.3549.386.camel@hellion.org.uk> <55F97C3D.5020702@redhat.com>
 <1442414443.18856.110.camel@hellion.org.uk>
 <1442487617.18856.177.camel@hellion.org.uk> <55FB15E7.6080502@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33558 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbbIQUAs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2015 16:00:48 -0400
In-Reply-To: <55FB15E7.6080502@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ian Campbell <ijc@hellion.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On 09/17/2015 02:35 PM, Hans de Goede wrote:
> Hi,
> 
> On 09/17/2015 07:00 AM, Ian Campbell wrote:
>> On Wed, 2015-09-16 at 15:40 +0100, Ian Campbell wrote:
>>>> The intend of the symlink was that the conversion script would copy
>>>> the target,
>>>> rather then follow the symlink. This sorta assumes that there are
>>>> will be not
>>>> symlinks under dt-bindings which link to files inside dt-bindings
>>>> and thus
>>>> should be preserved as symlinks.
>>>>
>>>> If the copy done in the script will follow the symlink then nothing
>>>> should
>>>> really change for the split DT repo.
>>>
>>> Interesting idea. I'll see if I can make the conversion routine do that.
>>>
>>> TBH I have a horrid feeling that this is going to be beyond git rewrite
>>> -branch, at least in the mode it is used in today.
>>
>> It seems that it is possible, after a fashion.
>>
>> The downside is that either _all_ symlinks (which end up in the
>> output) get
>> flattened or some sort of black/whitelisting is needed in the conversion
>> scripts themselves (potentially leading to issues or discontinuities) as
>> new stuff arrives).
>>
>> It isn't possible AFAICT tell if a symlink points to something outside of
>> the converted set of paths and adjust, at least not without an
>> unreasonable
>> amount of overhead on each commit during the rewrite.
>>
>> Since this new file would be the first symlink in the converted repo I
>> took
>> the former approach in my lash up to try it out
> 
> Ack, sounds good.
> 
>> which was essentially to
>> insert the below script into the middle of the "git ls-files | rewrite
>> -paths.sed" pipeline which is called by git filter-branch --index-filter.
>> Not pretty but it does seem to work.
>>
>> I want to avoid switching to --tree-filter if at all possible because it
>> checks out the tree and is therefore a _little_ I/O intensive ;-)
> 
> Thanks for your work on this, so what does this mean for moving forward
> with the patch-set I posted. Can this be merged now ? And if not what
> are we waiting for ?

I thought you were sending another version using "linux-event-codes.h."

Anyway, for the series for DT:

Acked-by: Rob Herring <robh@kernel.org>

Rob


From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel] [PATCH 0/2] xen, input: xen-kbdfront pointing device
 resolution support
Date: Fri, 7 Apr 2017 16:45:42 +0300
Message-ID: <3dbe74f4-7a23-126f-04c1-545220801508@gmail.com>
References: <20170321171905.31584-1-jgross@suse.com>
 <ffacba2c-e86f-eacc-b76c-8434871022a3@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33298 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755486AbdDGNpq (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Apr 2017 09:45:46 -0400
In-Reply-To: <ffacba2c-e86f-eacc-b76c-8434871022a3@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hi, all and ping2

I am also interested in the destiny of this patch

as I am planning to base multi-touch support on it

Dmitry, I would appreciate if you could review the patch

as it is hanging around for quite a while now

Thank you,
Oleksandr

On 04/04/2017 02:58 PM, Juergen Gross wrote:
> On 21/03/17 18:19, Juergen Gross wrote:
>> As my patch tying the resolution of the xen pointing device to that of
>> the framebuffer wasn't accepted add support for different resolutions
>> via a module parameter.
>>
>> Another possibility would be to set parameters via Xenstore, but this
>> is broken (patch 2 fixes that) and not yet supported by Xen tools.
>>
>> Juergen Gross (2):
>>    xen,input: add xen-kbdfront module parameter for setting resolution
>>    xen,input: repair xen-kbdfront resolution setting via xenstore
>>
>>   drivers/input/misc/xen-kbdfront.c | 42 ++++++++++++++++++++++++++-------------
>>   1 file changed, 28 insertions(+), 14 deletions(-)
>>
> Ping?
>
>
> Juergen
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> https://lists.xen.org/xen-devel


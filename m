From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH v2 1/2] xen,input: add xen-kbdfront module parameter for
 setting resolution
Date: Tue, 11 Apr 2017 12:39:40 +0300
Message-ID: <b4479241-3b60-d5cc-dea1-8927064def7c@gmail.com>
References: <20170411085028.6750-1-jgross@suse.com>
 <20170411085028.6750-2-jgross@suse.com>
 <c7608f78-912b-c777-0aa9-1db64fb003f4@gmail.com>
 <7298823d-0896-2ec9-363d-bde965b264bf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34792 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbdDKJjn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Apr 2017 05:39:43 -0400
In-Reply-To: <7298823d-0896-2ec9-363d-bde965b264bf@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, dmitry.torokhov@gmail.com

On 04/11/2017 12:35 PM, Juergen Gross wrote:
> On 11/04/17 11:26, Oleksandr Andrushchenko wrote:
>> On 04/11/2017 11:50 AM, Juergen Gross wrote:
>>> Add a parameter for setting the resolution of xen-kbdfront in order to
>>> be able to cope with a (virtual) frame buffer of arbitrary resolution.
>>>
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>> ---
>>>    drivers/input/misc/xen-kbdfront.c | 18 ++++++++++++++----
>>>    1 file changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/input/misc/xen-kbdfront.c
>>> b/drivers/input/misc/xen-kbdfront.c
>>> index 3900875dec10..90e7981a7768 100644
>>> --- a/drivers/input/misc/xen-kbdfront.c
>>> +++ b/drivers/input/misc/xen-kbdfront.c
>>> @@ -41,6 +41,12 @@ struct xenkbd_info {
>>>        char phys[32];
>>>    };
>>>    +enum { KPARAM_WIDTH, KPARAM_HEIGHT, KPARAM_CNT };
>>> +static int size[KPARAM_CNT] = { XENFB_WIDTH, XENFB_HEIGHT };
>> if you are about to release yet another version of the series,
>> could you please also rename "size" to "ptr_size/pointer_size/XXX",
>> so later when I add multi-touch support I can have
>> "mtouch_size" module parameter and they are consistent all together?
> Sure. After all I think I can merge the patches, as reading width and
> height a second time while connecting the device seems to be pointless.
>
> While logically patch 2 seems to correct the connection process there
> was never a problem with it being wrong: width and height would have
> been already read during probing of the device so missing to read them
> again wouldn't lead to any wrong settings.
Exactly, IMO this driver does need attention, but it
will also require changes to qemu-fb-backend if state
machine changes. This is why we still use this logic
in our backend as well
>
> Juergen


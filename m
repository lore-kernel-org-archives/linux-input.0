From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel] [PATCH 1/2] xen, input: add xen-kbdfront module
 parameter for setting resolution
Date: Mon, 10 Apr 2017 17:00:49 +0300
Message-ID: <f1ac5586-2611-c484-9320-de03bdb6c23f@gmail.com>
References: <20170321171905.31584-1-jgross@suse.com>
 <20170321171905.31584-2-jgross@suse.com>
 <cd255f47-a8fc-890d-1527-d56eaa6df311@gmail.com>
 <44a8ef04-53eb-df79-868e-96cc12302a78@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36778 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbdDJOBC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 10:01:02 -0400
In-Reply-To: <44a8ef04-53eb-df79-868e-96cc12302a78@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com



On 04/10/2017 04:50 PM, Juergen Gross wrote:
> On 10/04/17 15:44, Oleksandr Andrushchenko wrote:
>> Hi, Juergen!
>>
>> On 03/21/2017 07:19 PM, Juergen Gross wrote:
>>> Add a parameter for setting the resolution of xen-kbdfront in order to
>>> be able to cope with a (virtual) frame buffer of arbitrary resolution.
>>>
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>> ---
>>>    drivers/input/misc/xen-kbdfront.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/input/misc/xen-kbdfront.c
>>> b/drivers/input/misc/xen-kbdfront.c
>>> index 3900875..2df5678 100644
>>> --- a/drivers/input/misc/xen-kbdfront.c
>>> +++ b/drivers/input/misc/xen-kbdfront.c
>>> @@ -41,6 +41,12 @@ struct xenkbd_info {
>>>        char phys[32];
>>>    };
>>>    +enum { KPARAM_WIDTH, KPARAM_HEIGHT, KPARAM_CNT };
>>> +static int size[KPARAM_CNT] = { XENFB_WIDTH, XENFB_HEIGHT };
>>> +module_param_array(size, int, NULL, 0444);
>> is this by intention that you use 0444 here?
>> It means read-only, thus one cannot change these,
>> so what is the point of the module parameters then?
> You can see the settings in sysfs.
this is good so we can see actual width/height
used by the pv driver
> The values are settable via boot parameter.
but then, if one has other values set in XenStore,
these will/may be overridden, making it inconsistent,
e.g. values loaded at start as module parameters
(*size* array) is not going to be updated on
XenbusStateInitWait/XenbusStateConnected. So, we'll
end up with wrong parameters shown via sysfs
one more question is why do we need module parameters
if the same can be read from XenStore?

>
> Juergen
Thank you,
Oleksandr

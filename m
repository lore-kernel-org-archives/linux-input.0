From: Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel] [PATCH 1/2] xen, input: add xen-kbdfront module
 parameter for setting resolution
Date: Mon, 10 Apr 2017 15:50:08 +0200
Message-ID: <44a8ef04-53eb-df79-868e-96cc12302a78@suse.com>
References: <20170321171905.31584-1-jgross@suse.com>
 <20170321171905.31584-2-jgross@suse.com>
 <cd255f47-a8fc-890d-1527-d56eaa6df311@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51915 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753334AbdDJNuM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 09:50:12 -0400
In-Reply-To: <cd255f47-a8fc-890d-1527-d56eaa6df311@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

On 10/04/17 15:44, Oleksandr Andrushchenko wrote:
> Hi, Juergen!
> 
> On 03/21/2017 07:19 PM, Juergen Gross wrote:
>> Add a parameter for setting the resolution of xen-kbdfront in order to
>> be able to cope with a (virtual) frame buffer of arbitrary resolution.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   drivers/input/misc/xen-kbdfront.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/misc/xen-kbdfront.c
>> b/drivers/input/misc/xen-kbdfront.c
>> index 3900875..2df5678 100644
>> --- a/drivers/input/misc/xen-kbdfront.c
>> +++ b/drivers/input/misc/xen-kbdfront.c
>> @@ -41,6 +41,12 @@ struct xenkbd_info {
>>       char phys[32];
>>   };
>>   +enum { KPARAM_WIDTH, KPARAM_HEIGHT, KPARAM_CNT };
>> +static int size[KPARAM_CNT] = { XENFB_WIDTH, XENFB_HEIGHT };
>> +module_param_array(size, int, NULL, 0444);
> is this by intention that you use 0444 here?
> It means read-only, thus one cannot change these,
> so what is the point of the module parameters then?

You can see the settings in sysfs.

The values are settable via boot parameter.


Juergen

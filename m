From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 4/6 v2] HID: magicmouse: remove axis data filtering
Date: Tue, 31 Aug 2010 23:18:48 +0200
Message-ID: <4C7D71B8.4020408@euromail.se>
References: <1283280068-12285-1-git-send-email-chase.douglas@canonical.com>	 <1283280068-12285-4-git-send-email-chase.douglas@canonical.com>	 <4C7D6739.5000601@euromail.se> <1283288319.2255.103.camel@mini>	 <4C7D6ECB.2000308@euromail.se> <1283289360.2255.113.camel@mini>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283289360.2255.113.camel@mini>
Sender: linux-kernel-owner@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Michael Poole <mdpoole@troilus.org>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 08/31/2010 11:16 PM, Chase Douglas wrote:

> On Tue, 2010-08-31 at 23:06 +0200, Henrik Rydberg wrote:
>> On 08/31/2010 10:58 PM, Chase Douglas wrote:
>>
>>> On Tue, 2010-08-31 at 22:34 +0200, Henrik Rydberg wrote:
>>>> On 08/31/2010 08:41 PM, Chase Douglas wrote:
>>>>
>>>>> The Magic Mouse device is very precise. No driver filtering of input
>>>>> data needs to be performed.
>>>>>
>>>>> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
>>>>> Acked-by: Michael Poole <mdpoole@troilus.org>
>>>>> ---
>>>>
>>>>
>>>> I am still not sure this is a good idea. Bandwidth from MT devices is a big
>>>> deal. A statement roughly how much data comes out of mtdev (which does the
>>>> filtering for type A devices) before and after this change would be reassuring.
>>>
>>> As it is right now, hid-magicmouse doesn't support MT slots. I think all
>>> the fuzz code ends up comparing in the MT case is between one touch and
>>> another touch, not between one touch's current location and its previous
>>> location. If I'm correct, then it means a fuzz > 0 is incorrect for
>>> non-slotted MT devices.
>>>
>>> In fact, the code in drivers/input/input.c around line 194 looks like it
>>> discards defuzzing in this case, so one could say this patch is making
>>> things more correct :).
>>
>>
>> For type A devices, the filtering is performed in userspace, in mtdev, in the
>> same manner as it would have been performed in the kernel in the MT slot case.
>> Therefore, knowing the amount of messages coming out of mtdev is a direct
>> measurement of the effect of filtering.
> 
> Yes, but we're only interested in the kernel driver when reviewing this
> patch. Leaving the fuzz in as it is has no effect right now on ABS_MT_*
> axes. On the other axes, such as the touch orientation, it's probably
> more harmful than good.


"We" are interested in knowing if this patch makes any sense, given that
filtering is in actuality performed in userspace, and thus modifying this code
changes the stream rate into userspace applications, thank you.

Henrik

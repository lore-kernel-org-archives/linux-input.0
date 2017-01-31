From: "Robert R. Howell" <rhowell@uwyo.edu>
Subject: Re: PROBLEM: Baytrail tablet touchscreen fails after pinctrl commit
 [3ae02c14d964499da76b5ef4d8912710902e64f8]
Date: Tue, 31 Jan 2017 12:01:35 -0700
Message-ID: <d8a84b76-c232-b1e2-8a27-e4fc1c73e972@uwyo.edu>
References: <6306d18a-d5d3-3e89-5f41-2a45d3de1398@uwyo.edu>
 <1483812841.26691.7.camel@linux.intel.com>
 <CAKdAkRRHJ+FVKV3o38gpZQ5R2Q6uuV+TPnuwHLvGJ7QehNHWuQ@mail.gmail.com>
 <20170131102113.GR17297@lahna.fi.intel.com>
 <d9ae0add-cf5b-2008-0fc9-ee14c478ecec@uwyo.edu>
 <20170131183753.GA13642@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-dm3nam03on0138.outbound.protection.outlook.com ([104.47.41.138]:8480
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751372AbdAaThk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 14:37:40 -0500
In-Reply-To: <20170131183753.GA13642@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On 01/31/2017 11:37 AM, Dmitry Torokhov wrote:
> On Tue, Jan 31, 2017 at 10:11:16AM -0700, Robert R. Howell wrote:
>> On 01/31/2017 03:21 AM, Mika Westerberg wrote:
>>> On Mon, Jan 30, 2017 at 04:52:27PM -0800, Dmitry Torokhov wrote:
>>>> On Sat, Jan 7, 2017 at 10:14 AM, Andy Shevchenko
>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>> On Fri, 2017-01-06 at 02:30 -0700, Robert R. Howell wrote:
>>>>>> [1.]  Baytrail tablet touchscreen fails after pinctrl commit
>>>>>> [3ae02c14d964499da76b5ef4d8912710902e64f8]
>>>>>>
>>>>>> [2.]  Beginning with kernel 4.10-rc1 (and continuing with 4.10-rc2)
>>>>>> the
>>>>>> touchscreen on two Baytrail devices, an ASUS T100TA and a Toshiba
>>>>>> Encore
>>>>>> 8, no longer works.  They did work properly up though at least 4.9.0.
>>>>>> As
>>>>>> indicated in the DMESG output appended below, the ATML1000
>>>>>> touchscreen
>>>>>> controller fails to reset and initialize properly on boot. The reset
>>>>>> command issued through i2c_hid appears to time out after its 5 second
>>>>>> wait for completion.  (There are similar problems with an i2c
>>>>>> orientation sensor.)  Using git bisect I've found that the problem
>>>>>> begins with commit [3ae02c14d964499da76b5ef4d8912710902e64f8]
>>>>>> pinctrl: intel: set default handler to be handle_bad_irq()
>>>>>>
>>>>>> I've appended the git bisect log output at the end.  Reverting that
>>>>>> single commit (tested with 4.10-rc2) fixes the problem.
>>>>>
>>>>> Thanks for the report. For me it looks like that commit actually
>>>>> discovers other problems we have in the code somewhere.
>>>>>
>>>>> Yeah, I confirm the issue on T100TA. I will investigate this next week.
>>>>
>>>> This still happens on chromeOS Baytrail devices with -rc6 here as
>>>> well. Can we revert this and try again in 4.11 timeframe?
>>>
>>> Are you sure you have commit 49c030962638 ("pinctrl: baytrail: Do not
>>> add all GPIOs to IRQ domain")? That is supposed to fix the issue if I
>>> understand correctly.
>>>
>>
>> I've just tested 4.10-rc6 on an ASUS T100-TAM, a T100-TA, and a
>> Toshiba Encore 8 and the i2c connected touchscreen is working on all
>> of them. RC-6 DOES incorporate Andy Shevchenko's "[PATCH v1 1/2]
>> pinctrl: baytrail: Do not add all GPIOs to IRQ domain", which is
>> what seems to fix the problem.
>
> Yes, indeed it works. I guess I messed up my tree somehow, sorry about
> the noise.
>
> Thanks.
>

My first attempt to compile a new 4.10-rc6 kernel from a download on 
Sunday resulted in something that actually claimed it was still rc4, and 
SEEMED to have code without the "Do not add all GPIOs..." patch.  I 
started over last night with a new download, thinking I had somehow just 
unpacked the wrong distribution file.  But if both of us had trouble 
maybe something was wrong with the initially posted rc6 distribution file.

Thanks again to Andy and the others involved for fixing this bug.

Bob Howell




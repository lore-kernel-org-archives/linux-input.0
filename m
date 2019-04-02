From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] HID: force setting drvdata to NULL when removing the
 driver
Date: Tue, 2 Apr 2019 16:02:53 +0200
Message-ID: <5a31f086-7f30-bce9-5bdd-0deeb3bffd29@redhat.com>
References: <20190328155151.577687-1-benjamin.tissoires@redhat.com>
 <CAKdAkRRwKS+wzXjh=gyOQtSEiMwWhArZVc_cwecJsEZ=MGRa8w@mail.gmail.com>
 <CAO-hwJK2yusO2f+oFnUcNGuxo6e_+7F6Cjqmcsuimy4zrm-Jww@mail.gmail.com>
 <a31a6f95-924a-4930-e4df-5576abc694fb@redhat.com>
 <CAO-hwJK5B1uEmw7vnt73k2BLv4YQeLMf_KwS58-LgAOrLfCqhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJK5B1uEmw7vnt73k2BLv4YQeLMf_KwS58-LgAOrLfCqhA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jason Gerecke <killertofu@gmail.com>, Ping Cheng <pinglinux@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 02-04-19 16:00, Benjamin Tissoires wrote:
> On Tue, Apr 2, 2019 at 3:52 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 02-04-19 15:44, Benjamin Tissoires wrote:
>>> Hi Dmitry,
>>>
>>> On Fri, Mar 29, 2019 at 11:26 PM Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>>>
>>>> Hi Benjamin,
>>>>
>>>> On Thu, Mar 28, 2019 at 8:52 AM Benjamin Tissoires
>>>> <benjamin.tissoires@redhat.com> wrote:
>>>>>
>>>>> Or when the probe failed.
>>>>>
>>>>> This is a common pattern in the HID drivers to reset the drvdata. Some
>>>>> do it properly, some do it only in case of failure.
>>>>> Anyway, it's never a good thing to have breadcrumbs, so force a clean
>>>>> state when removing or when probe is failing.
>>>>
>>>> Just a data point: driver core already clears drvdata, so as long as
>>>> dev_get/set_drvdata() is the same as hid_get/set_drvdata() no special
>>>> handling is needed in HID core.
>>>
>>> You are correct (as always ;-P). I'll drop the hid-core changes and
>>> send a v2 ASAP.
>>
>> I was just looking at the same thing. I should have known about this
>> since I wrote the patch to make the core clear drvdata. I should have
>> mentioned that, but I was assuming that the hid code was special somehow,
>> however now I see it just uses a regular device_add, so indeed the core
>> changes are not necessary.
>>
>> Given the large hid-logitech-*.c patch-set it might be easier for
>> Jiri if you split out the hid-logitech-*.c changes into a separate
>> patch, then he can keep that on his logitech branch (just a thought).
>>
> 
> I do not expect the logitech changes to now create some big conflict.
> But looking at the current for-5.2* branches, I should probably split
> the series per driver given that there is no more dependency on
> hid-core. This way, we can take the logitech changes in the
> for-5.2/logitech branch, and you can rebase your work on top of it.

Great, thank you.

Regards,

Hans

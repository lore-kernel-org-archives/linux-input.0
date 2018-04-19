From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel] [PATCH] Input: xen-kbdfront - allow better run-time
 configuration
Date: Thu, 19 Apr 2018 16:12:42 +0300
Message-ID: <5ed20b99-263d-d906-9349-d064eead36ad@gmail.com>
References: <20180418150445.9805-1-andr2000@gmail.com>
 <ccb7a33b-7862-9803-fb24-67861d5ecab9@suse.com>
 <2bff035e-303e-d644-5f51-5e64150c097c@gmail.com>
 <c833ab0d-746c-c734-3dbe-e02ae7951d1d@suse.com>
 <d935e7d9-090f-a8b1-7f12-5e0a7f0adf1b@gmail.com>
 <CAKf6xpsM03AB-mHaYdpVfipRdtx9uO1rS=bHZdEi3fkfTo6b4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKf6xpsM03AB-mHaYdpVfipRdtx9uO1rS=bHZdEi3fkfTo6b4g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Andryuk <jandryuk@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com, lyan@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>, andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

On 04/19/2018 04:10 PM, Jason Andryuk wrote:
> On Thu, Apr 19, 2018 at 9:01 AM, Oleksandr Andrushchenko
> <andr2000@gmail.com> wrote:
>> Ok, so I'll send v2 with the following changes:
>>
>> diff --git a/drivers/input/misc/xen-kbdfront.c
>> b/drivers/input/misc/xen-kbdfront.c
>> index a3306aad40b0..d8cca212f737 100644
>> --- a/drivers/input/misc/xen-kbdfront.c
>> +++ b/drivers/input/misc/xen-kbdfront.c
>> @@ -51,13 +51,13 @@ module_param_array(ptr_size, int, NULL, 0444);
>>   MODULE_PARM_DESC(ptr_size,
>>          "Pointing device width, height in pixels (default 800,600)");
>>
>> -static unsigned int no_ptr_dev;
>> -module_param(no_ptr_dev, uint, 0);
>> +static bool no_ptr_dev;
>> +module_param(no_ptr_dev, bool, 0);
>>   MODULE_PARM_DESC(no_ptr_dev,
>>          "If set then no virtual pointing device exposed to the guest");
>>
>> -static unsigned int no_kbd_dev;
>> -module_param(no_kbd_dev, uint, 0);
>> +static bool no_kbd_dev;
>> +module_param(no_kbd_dev, bool, 0);
>>   MODULE_PARM_DESC(no_kbd_dev,
>>          "If set then no virtual keyboard device exposed to the guest");
> I prefer direct logic over inverse logic.  Maybe just use kbd_dev,
> default to true, but allow it to be set off?
>
> static bool kbd_dev = true;
> module_param(kbd_dev, bool, 0);
I have no preference here, either way works for me
Juergen, what do you think about the above?
> Regards,
> Jason

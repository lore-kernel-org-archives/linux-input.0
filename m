From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: mouse: synaptics - change msleep to usleep_range
 for small msecs
Date: Sun, 4 Dec 2016 18:35:43 +0530
Message-ID: <CADYu309AF_NK4jmo5fqYF843vtQ9oKHjaM2uE96nXO38G8LZ5g@mail.gmail.com>
References: <1480362924-5224-1-git-send-email-a.mathur@samsung.com>
 <CAOXgUe0FPkByE-0piMeNLaU3iTd_k0Nj_pZzEU4pv_9WzBzt1w@mail.gmail.com> <bd65a3e5-8178-cfc9-2d29-c86b7e300297@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bd65a3e5-8178-cfc9-2d29-c86b7e300297@compulab.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SAMUEL SEQUEIRA <s.samuel@samsung.com>, Rahul Mahale <r.mahale@samsung.com>, Aniroop Mathur <a.mathur@samsung.com>
List-Id: linux-input@vger.kernel.org

Hello Mr. Igor Grinberg

On Sun, Dec 4, 2016 at 1:32 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Hi Aniroop Mathur,
>
> On 11/29/16 23:02, Aniroop Mathur wrote:
>> Dear Mike Rapoport, Igor Grinberg,
>> Greetings!
>>
>> I am Aniroop Mathur from Samsung R&D Institute, India.
>>
>> I have submitted one patch as below for review to Linux Open Source.
>> The problem is that we do not have the hardware available with us to
>> test it and we would like to test it before actually applying it.
>> As you are the author of this driver, I am contacting you to request you
>> provide your feedback upon this patch.
>>
>> Also if you have the hardware available, could you please help to
>> test this patch on your hardware? or could you provide contact points
>> of individuals who could support to test it?
>
> This touchpad and the driver was used on an old PXA270 based PDA.
> I currently don't have those at hand to test the patch.
>
>>
>> Thank you!
>>
>> BR,
>> Aniroop Mathur
>>
>> On Tue, Nov 29, 2016 at 1:25 AM, Aniroop Mathur <a.mathur@samsung.com> wrote:
>>> msleep(1~20) may not do what the caller intends, and will often sleep longer.
>>> (~20 ms actual sleep for any value given in the 1~20ms range)
>
> Well, it should be at least 1ms as stated in my comment just before the define.
> So, from the correctness perspective larger values will also do the job.
> Additionally, since I've taken a spare 2ms, and you are making it even more
> precise (3000us + 100us) - it will still do the job and stay correct.
> So, there should be no issue from correctness POV.
>

Alright, Thanks!

>>> This is not the desired behaviour for many cases like device resume time,
>>> device suspend time, device enable time, retry logic, etc.
>>> Thus, change msleep to usleep_range for precise wakeups.
>
> This is a human interface touchpad device, even having 20ms soft reset
> sleep time will not impact the responsiveness for humans.
> IMHO, there is no need for precise wakeups for this device, so I wouldn't
> bother.
>

Well, from the point of view of device working and responsiveness for "humans",
I agree that it is okay to sleep for 20 / 40 ms or even 100 ms. However, this
patch is not trying to solve any such issues. This patch is only trying to make
the process sleep for appropriate time as mentioned in the parameter and does
not cause any harm here. I could see that this function is called during device
resume and device probe time. So this change will improve the resume and probe
time for this device and doing the same change in other drivers will
contribute to
improvement in overall kernel resume and boot time a little bit so response time
increases a little bit. Plus, it is recommended and mentioned in kernel
documentation to use usleep_range for delays between 1-10 ms.
So usleep_range should serve better here.
Explained originally here to why not use msleep for 1 - 20 ms:
http://lkml.org/lkml/2007/8/3/250

Thanks.

BR,
Aniroop Mathur

>>>
>>> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>>> ---
>>>  drivers/input/mouse/synaptics_i2c.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
>>> index aa7c5da..4d688a6 100644
>>> --- a/drivers/input/mouse/synaptics_i2c.c
>>> +++ b/drivers/input/mouse/synaptics_i2c.c
>>> @@ -29,7 +29,7 @@
>>>   * after soft reset, we should wait for 1 ms
>>>   * before the device becomes operational
>>>   */
>>> -#define SOFT_RESET_DELAY_MS    3
>>> +#define SOFT_RESET_DELAY_US    3000
>>>  /* and after hard reset, we should wait for max 500ms */
>>>  #define HARD_RESET_DELAY_MS    500
>>>
>>> @@ -311,7 +311,7 @@ static int synaptics_i2c_reset_config(struct i2c_client *client)
>>>         if (ret) {
>>>                 dev_err(&client->dev, "Unable to reset device\n");
>>>         } else {
>>> -               msleep(SOFT_RESET_DELAY_MS);
>>> +               usleep_range(SOFT_RESET_DELAY_US, SOFT_RESET_DELAY_US + 100);
>>>                 ret = synaptics_i2c_config(client);
>>>                 if (ret)
>>>                         dev_err(&client->dev, "Unable to config device\n");
>>> --
>>> 2.6.2
>>>
>>
>
> --
> Regards,
> Igor.

From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/2] platform/x86: silead_dmi: Add silead,home-button
 property to some tablets
Date: Thu, 16 Nov 2017 15:02:20 +0100
Message-ID: <fc1a0310-8944-27dc-a464-4ac6409b359b@redhat.com>
References: <20171017154512.30524-1-hdegoede@redhat.com>
 <20171017154512.30524-2-hdegoede@redhat.com>
 <CAHp75Vf=MPfCfj3X8ob0+LT_+MT+SW9nsNzw0Pai2OcBrdqWvA@mail.gmail.com>
 <2e5b4fd2-5445-a1f6-c509-5de2bb96c491@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <2e5b4fd2-5445-a1f6-c509-5de2bb96c491@redhat.com>
Content-Language: en-US
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 27-10-17 17:26, Hans de Goede wrote:
> Hi,
> 
> On 27-10-17 16:39, Andy Shevchenko wrote:
>> On Tue, Oct 17, 2017 at 6:45 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> Add "silead,home-button" property to entries for tablets which have
>>> a capacitive home button (typically a windows logo on the front).
>>>
>>> This new property is checked for by the new capacitive home button
>>> support in the silead touchscreen driver.
>>>
>>
>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>
>> I suppose it's going through input subsystem as dependent patch?
> 
> Since silead_dmi tends to see several patches each cycle I don't
> think that is a good idea, both patches can be merged independently.
> 
> Either patch will not do anything until the other one is merged,
> having just one or the other present will not cause any problems,
> so IMHO merging each patch separately is best.
> 
> It is probably a good idea to wait for an ack from RobH on the
> property name before merging this though.

This has been Acked by Rob now, so this patch is ready for merging.
As discussed before both patches can be merged independently of
each other.

Regards,

Hans



>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>   drivers/platform/x86/silead_dmi.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
>>> index fadfce9b3f5f..ac304f2318cc 100644
>>> --- a/drivers/platform/x86/silead_dmi.c
>>> +++ b/drivers/platform/x86/silead_dmi.c
>>> @@ -58,6 +58,7 @@ static const struct property_entry dexp_ursus_7w_props[] = {
>>>          PROPERTY_ENTRY_U32("touchscreen-size-y", 630),
>>>          PROPERTY_ENTRY_STRING("firmware-name", "gsl1686-dexp-ursus-7w.fw"),
>>>          PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>>> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
>>>          { }
>>>   };
>>>
>>> @@ -72,6 +73,7 @@ static const struct property_entry surftab_wintron70_st70416_6_props[] = {
>>>          PROPERTY_ENTRY_STRING("firmware-name",
>>>                                "gsl1686-surftab-wintron70-st70416-6.fw"),
>>>          PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>>> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
>>>          { }
>>>   };
>>>
>>> @@ -116,6 +118,7 @@ static const struct property_entry pov_mobii_wintab_p800w_props[] = {
>>>          PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>>>          PROPERTY_ENTRY_STRING("firmware-name",
>>>                                "gsl3692-pov-mobii-wintab-p800w.fw"),
>>> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
>>>          { }
>>>   };
>>>
>>> @@ -143,6 +146,7 @@ static const struct property_entry chuwi_hi8_pro_props[] = {
>>>          PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
>>>          PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>>>          PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-chuwi-hi8-pro.fw"),
>>> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
>>>          { }
>>>   };
>>>
>>> -- 
>>> 2.14.1
>>>
>>
>>
>>

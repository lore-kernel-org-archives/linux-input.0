From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/2] platform/x86: silead_dmi: Add silead,home-button
 property to some tablets
Date: Fri, 17 Nov 2017 18:15:55 +0200
Message-ID: <CAHp75VdG2xRiy-eKuXRy29kfbONU1bDJUYpyOjX37Yjt=1meAQ@mail.gmail.com>
References: <20171017154512.30524-1-hdegoede@redhat.com> <20171017154512.30524-2-hdegoede@redhat.com>
 <CAHp75Vf=MPfCfj3X8ob0+LT_+MT+SW9nsNzw0Pai2OcBrdqWvA@mail.gmail.com>
 <2e5b4fd2-5445-a1f6-c509-5de2bb96c491@redhat.com> <fc1a0310-8944-27dc-a464-4ac6409b359b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <fc1a0310-8944-27dc-a464-4ac6409b359b@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 16, 2017 at 4:02 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On 27-10-17 17:26, Hans de Goede wrote:
>> On 27-10-17 16:39, Andy Shevchenko wrote:
>>> On Tue, Oct 17, 2017 at 6:45 PM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:

>>>> Add "silead,home-button" property to entries for tablets which have
>>>> a capacitive home button (typically a windows logo on the front).
>>>>
>>>> This new property is checked for by the new capacitive home button
>>>> support in the silead touchscreen driver.
>>>>
>>>
>>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>
>>> I suppose it's going through input subsystem as dependent patch?
>>
>>
>> Since silead_dmi tends to see several patches each cycle I don't
>> think that is a good idea, both patches can be merged independently.
>>
>> Either patch will not do anything until the other one is merged,
>> having just one or the other present will not cause any problems,
>> so IMHO merging each patch separately is best.
>>
>> It is probably a good idea to wait for an ack from RobH on the
>> property name before merging this though.
>
>
> This has been Acked by Rob now, so this patch is ready for merging.
> As discussed before both patches can be merged independently of
> each other.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko

From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [Regression] 5.3-rc1: hid_llogitech_dj does not work
Date: Mon, 29 Jul 2019 17:49:43 +0200
Message-ID: <5036172e-1fa9-d038-4473-b4f257764b78@redhat.com>
References: <CAHk-=wjm7FQxdF=RKa8Xe23CLNNpbGDOACewgo8e-hwDJ8TyQg@mail.gmail.com>
 <2480108.bWkXKoXas6@kreacher>
 <1dddedba-ca02-1014-36e0-ba4e3631f28b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1dddedba-ca02-1014-36e0-ba4e3631f28b@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Rafael,

On 25-07-19 17:50, Hans de Goede wrote:
> Hi Rafael,
> 
> On 25-07-19 12:07, Rafael J. Wysocki wrote:
>> Hi Hans,
>>
>> This is similar to a problem I reported some time ago:
>>
>> https://lore.kernel.org/lkml/2268131.Lc39eCoc3j@kreacher/
>>
>> and the device affected by it is the same.
>>
>> The symptom is simply that the mouse just doesn't work (no reaction).  If I do
>> "rmmod hid_llogitech_dj", it says "Killed", but the module does go away and
>> the mouse starts to work (through the generic code I suppose), but then
>> the machine hangs on attempts to suspend (nasty).
>>
>> Reverting all of the hid_llogitech_dj changes between 5.2 and 5.3-rc1:
>>
>> dbcbabf7da92 HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices
>> 39d21e7e0043 HID: logitech-dj: make const array template static
>> 423dfbc362b7 HID: logitech-dj: Add usb-id for the 27MHz MX3000 receiver
>>
>> helps here, but the first two don't really look like they can make any difference,
>> so I guess I'm an unlucky owner of a MX3000 that doesn't quite work as expected.
>>
>> Any help will be appreciated. :-)
> 
> Actually we received another bug report about this and the reporter there
> has come up with a patch with points to
> 
> dbcbabf7da92 HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices
> 
> Being the culprit, can you try just reverting that one?
> 
> I will take a closer look at this soonish.

Thank you for reporting this.

After upgrading to 5.3-rc2 I can reproduce this myself and the dbcbabf7da92 commit
indeed is the culprit. I've prepared a fix for this which I'm about to submit upstream.

I've put you in the Cc of the fix.

Regards,

Hans

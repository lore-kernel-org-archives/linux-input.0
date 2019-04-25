From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] HID: Increase maximum report size allowed by
 hid_field_extract()
Date: Fri, 26 Apr 2019 02:29:11 +0800
Message-ID: <08CA35F5-1ADC-4C55-ACF5-04B19CC77A25@canonical.com>
References: <20190308051117.21899-1-kai.heng.feng@canonical.com>
 <CAO-hwJLDuMZuqKiawnkq3YxL6T9SqNGqQ1Q_Vs=kMKmsx6SD0w@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJLDuMZuqKiawnkq3YxL6T9SqNGqQ1Q_Vs=kMKmsx6SD0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, =?utf-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>
List-Id: linux-input@vger.kernel.org

at 17:42, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:

> Hi,
>
>
> On Fri, Mar 8, 2019 at 6:11 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> Commit 71f6fa90a353 ("HID: increase maximum global item tag report size
>> to 256") increases the max report size from 128 to 256.
>>
>> We also need to update the report size in hid_field_extract() otherwise
>> it complains and truncates now valid report size:
>> [ 406.165461] hid-sensor-hub 001F:8086:22D8.0002: hid_field_extract()  
>> called with n (192) > 32! (kworker/5:1)
>>
>> BugLink: https://bugs.launchpad.net/bugs/1818547
>> Fixes: 71f6fa90a353 ("HID: increase maximum global item tag report size  
>> to 256")
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/hid/hid-core.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 9993b692598f..860e21ec6a49 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1301,10 +1301,10 @@ static u32 __extract(u8 *report, unsigned  
>> offset, int n)
>>  u32 hid_field_extract(const struct hid_device *hid, u8 *report,
>>                         unsigned offset, unsigned n)
>
> Ronald (Cc-ed) raised quite a good point:
> what's the benefit of removing the error message if this function (and
> __extract) can only report an unsigned 32 bits value?

I didn’t spot this, sorry.

>
> My take is we should revert 94a9992f7dbdfb28976b upstream and think at
> a better solution.

I think using a new fix to replace it will be a better approach, as it at  
least partially solves the issue.

Kai-Heng

>
> Cheers,
> Benjamin
>
>> {
>> -       if (n > 32) {
>> -               hid_warn(hid, "hid_field_extract() called with n (%d) >  
>> 32! (%s)\n",
>> +       if (n > 256) {
>> +               hid_warn(hid, "hid_field_extract() called with n (%d) >  
>> 256! (%s)\n",
>>                          n, current->comm);
>> -               n = 32;
>> +               n = 256;
>>         }
>>
>>         return __extract(report, offset, n);
>> —

>> 2.17.1

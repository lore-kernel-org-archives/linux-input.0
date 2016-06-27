From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/2] Revert "HID: multitouch: enable palm rejection if
 device implements confidence usage"
Date: Mon, 27 Jun 2016 15:25:41 -0700
Message-ID: <CALCETrWhHWeqGK6zmng=+8_N87cezi6EwO7xW96HoMTxTkzxeQ@mail.gmail.com>
References: <1466670690-77458-1-git-send-email-allen_hung@dell.com> <2407f04d-4658-c3d5-1434-5e548f2063e0@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2407f04d-4658-c3d5-1434-5e548f2063e0@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Allen Hung <allen_hung@dell.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jun 27, 2016 at 10:55 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On 06/23/2016 01:31 AM, Allen Hung wrote:
>>
>> This reverts commit 25a84db15b3f ("HID: multitouch: enable palm rejection
>> if device implements confidence usage")
>>
>> The commit enables palm rejection for Win8 Precision Touchpad devices but
>> the quirk MT_QUIRK_VALID_IS_CONFIDENCE it is using is not working very
>> properly. This quirk is originally designed for some WIn7 touchscreens.
>> Use
>> of this for a Win8 Precision Touchpad will cause unexpected pointer
>> jumping
>> problem.
>>
>> Signed-off-by: Allen Hung <allen_hung@dell.com>
>> ---
>>  drivers/hid/hid-multitouch.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
>> index 95b7d61..4ef7006 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -502,11 +502,6 @@ static int mt_touch_input_mapping(struct hid_device
>> *hdev, struct hid_input *hi,
>>                         mt_store_field(usage, td, hi);
>>                         return 1;
>>                 case HID_DG_CONFIDENCE:
>> -                       if (cls->name == MT_CLS_WIN_8 &&
>> -                               field->application == HID_DG_TOUCHPAD) {
>> -                               cls->quirks &= ~MT_QUIRK_ALWAYS_VALID;
>> -                               cls->quirks |=
>> MT_QUIRK_VALID_IS_CONFIDENCE;
>> -                       }
>>                         mt_store_field(usage, td, hi);
>>                         return 1;
>>                 case HID_DG_TIPSWITCH:
>>
>
> This and patch 2 are:
>
> Tested-by: Andy Lutomirski <luto@kernel.org> # XPS 13 9350, BIOS 1.4.3
>
> (And I'm curious why 1.4.3 seems to have been pulled.  Might it have been
> this issue?  For better or for worse, I upgraded in the narrow window in
> which it was available on Dell's website.)
>

I should amend that Tested-by slightly: these patches seem to make the
problem merely about as bad as it was before.  It's still not perfect
-- I still occasionally get stuck touches.

--Andy

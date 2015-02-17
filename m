From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: wacom: do not directly use input_mt_report_pointer_emulation
Date: Tue, 17 Feb 2015 17:50:06 -0500
Message-ID: <CAN+gG=GWAVKrbaC_Ww7DXWuJ8VkHEqO4GbrygGP6Xpb9FZ897w@mail.gmail.com>
References: <1424200786-4009-1-git-send-email-benjamin.tissoires@redhat.com>
	<CAF8JNhKwMpLEnBYSAA4-sT_qNLQN7ymKpiYxb6a5m6VTbE_1cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAF8JNhKwMpLEnBYSAA4-sT_qNLQN7ymKpiYxb6a5m6VTbE_1cQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Feb 17, 2015 at 5:36 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> On Tue, Feb 17, 2015 at 11:19 AM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>> input_mt_sync_frame() calls input_mt_report_pointer_emulation() and do
>> some internal steps required to keep in sync the state of the touch within
>> the various reports.
>>
>> Given that we use input_mt_assign_slot() in this driver, it is better to
>> use input_mt_sync_frame().
>
> It is sensible to me, except I think you meant input_mt_slot() instead
> of input_mt_assign_slot().

Hehe, I should have actually checked the call. I meant
input_mt_get_slot_by_key().

>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Reviewed-by: Ping Cheng <pingc@wacom.com>

Thanks!
Benjamin

>
> Ping
>
>> ---
>>  drivers/hid/wacom_wac.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
>> index 8627581..de93968 100644
>> --- a/drivers/hid/wacom_wac.c
>> +++ b/drivers/hid/wacom_wac.c
>> @@ -1093,7 +1093,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
>>                         }
>>                 }
>>         }
>> -       input_mt_report_pointer_emulation(input, true);
>> +       input_mt_sync_frame(input);
>>
>>         wacom->num_contacts_left -= contacts_to_send;
>>         if (wacom->num_contacts_left <= 0)
>> @@ -1144,7 +1144,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
>>                         input_report_abs(input, ABS_MT_POSITION_Y, y);
>>                 }
>>         }
>> -       input_mt_report_pointer_emulation(input, true);
>> +       input_mt_sync_frame(input);
>>
>>         wacom->num_contacts_left -= contacts_to_send;
>>         if (wacom->num_contacts_left < 0)
>> @@ -1176,7 +1176,7 @@ static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
>>                         contact_with_no_pen_down_count++;
>>                 }
>>         }
>> -       input_mt_report_pointer_emulation(input, true);
>> +       input_mt_sync_frame(input);
>>
>>         /* keep touch state for pen event */
>>         wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
>> @@ -1638,7 +1638,7 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
>>                 }
>>         }
>>
>> -       input_mt_report_pointer_emulation(input, true);
>> +       input_mt_sync_frame(input);
>>
>>         input_report_key(pad_input, BTN_LEFT, (data[1] & 0x08) != 0);
>>         input_report_key(pad_input, BTN_FORWARD, (data[1] & 0x04) != 0);
>> @@ -1728,7 +1728,7 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
>>                         wacom_bpt3_button_msg(wacom, data + offset);
>>
>>         }
>> -       input_mt_report_pointer_emulation(input, true);
>> +       input_mt_sync_frame(input);
>>
>>         return 1;
>>  }
>> --
>> 2.1.0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

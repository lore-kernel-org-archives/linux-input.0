From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH 3/3] Add logitech m560 driver
Date: Wed, 27 Aug 2014 19:18:01 +0200
Message-ID: <CAE7qMrrwqd5aKsTGWSTo5xpOSyGYH1uGULiGQ17ShW9ie4jiMQ@mail.gmail.com>
References: <1408797629-3474-1-git-send-email-kreijack@inwind.it>
 <1408797629-3474-4-git-send-email-kreijack@inwind.it> <CAE7qMrpgPULMq95wZhLgsLWXJ+=DiVoe9XzxZB5poU0ZmqFiXg@mail.gmail.com>
 <CAN+gG=F_KvfqbQXKcMzMRLJu0AJ+wdmXvWLi+-PC-jZE_pPXTA@mail.gmail.com> <53FD14F3.2090905@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na6sys009bog013.obsmtp.com ([74.125.150.66]:49966 "EHLO
	na6sys009bog013.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933776AbaH0RYA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Aug 2014 13:24:00 -0400
Received: by mail-yk0-f175.google.com with SMTP id q200so511087ykb.20
        for <linux-input@vger.kernel.org>; Wed, 27 Aug 2014 10:23:58 -0700 (PDT)
In-Reply-To: <53FD14F3.2090905@inwind.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Goffredo Baroncelli <kreijack@inwind.it>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Goffredo Baroncelli <kreijack@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Wed, Aug 27, 2014 at 1:14 AM, Goffredo Baroncelli <kreijack@inwind.it> wrote:
> Hi Benjamin
>
> On 08/26/2014 11:22 PM, Benjamin Tissoires wrote:
>> Hi guys,
>>
>> On Mon, Aug 25, 2014 at 4:38 AM, Nestor Lopez Casado
>> <nlopezcasad@logitech.com> wrote:
>>> Hi,
>>>
>>> If you want to have a special driver for a specific Unifying device
>>> you should put in place the right structure to have a separate driver
>>> for it.
>>>
>>> hid-logitech-dj is a "bus" driver for the Unifying *receiver*, not a
>>> driver for any specific Unifying device.
>>>
>>> Benjamin Tisssoires (github bentiss) has uploaded a few patches to his
>>> github account to finish the infrastructure for specific Unifying
>>> devices drivers. Look for the more complete branch 'for-whot' See how
>>> he created a hid-logitech-wtp driver for the Different wireless
>>> touchpads.
>>>
>>> This would be the right approach to what you are trying to do.
>>>
>>
>> I have been willing to review/answer to this patch series since
>> Monday, but did not found the time to do so. I have a small spot now,
>> so here I am.
>>
>> So, Goffredo, as Nestor said, I wouldn't have coded this in the way of
>> your patch. However, do not take Nestor's words as a strong rejection
>> and that we do not want you to submit anything else :)
>
> Don't worry. I was prepared to a first reject. In fact I proposed
> these patches as RFC because even to me these seemed too complex.
>
> On the basis of the Nestor's suggestions I started to give a look
> to the branch "for-whot". Definitely this branch is what I was
> looking for. As Nestor highlighted, in your branch a
> dj_device uses the wireless id; this avoid the needing of
> my second patch (the biggest one)
>
> I am rewriting my patches against "for-whot" branch, and now it is
> more simpler. It is only a file like hid-logitech-wtp.
> I need some day to do some clean up and I hoping
> to re-post in the next few days.
>
>> I am in fault here because I should have sent upstream the branch
>> Nestor pointed at a long time ago now, and this would have avoided you
>> a lot of pain.
>>
>> The thing which prevented me to send this upstream is that Jiri tries
>> to group the various hid drivers by vendor, and this branch creates 2
>> new for supporting various dj/hid++ devices.
>
> As reported above I already started to work against your branch (for-whot).
> Now I looked at Jiri tree, but it seems not able to support "sub-driver".
> When a dj_device is created, it uses the ID of the receiver.
>
> But I am confused about a point: are you suggesting to start working
> against the "Jiri" branch or against your one (as Nestor suggested) ?
>
> To me it seems that the Jiri branch doesn't have the necessary
> infrastructure to handle these hid-(sub)-dj-driver.
>
>
>>
>> I have though one specific comment Goffredo with your patch (again I
>> did not went in depth of them, but this jumped into my eyes). Why
>> don't you simply use the wireless ID instead of the name of the
>> device. The wireless id is unique across all Logitech unifying
>> devices, and it's definitively easier to compare than a string.
>
> I did so ... because I was unaware of the other possibility :-).
> Looking at hid-logitech-wtp I discovered the possibility to use
> the Wireless (P)ID :-). Now my patch act so.
>
>>
>> One other thing is may be answered by Nestor: is there any command we
>> can send to the device for it to send only regular buttons? This may
>> just be an easier solution than having to remap the keyboards events
>> into buttons.
>
> This really would help a lot.
Quick answer: I need to double check, but there surely is a command
that disables the behaviour of the W8 button, but it wont be possible
to make it send a standard hid report, instead,  you will get a hidpp
notification that you can map to any hid usage you would like to. In
any case, this approach would be much more simple than the one you are
implementing. I suggest you to look at the draft specifications for
the logitech hid++ 2.0 protocol. Then you will need to use the feature
1b04 to modify the mouse behaviour. Part of what you would need to do
is already done in Benjamin's 'for-whot' branch, so actually, in my
opinion, the best thing to do would be take benjamin's code, and
extract all the infrastructure for multiple drivers and hid++ access,
leaving out the wtp code, and implement your driver based on that.

I would also suggest that you take a look at  the Solaar application
for Unifying devices, which already takes care of sending hidpp
commands to Unifying devices and has all the infrastructure you need
to deal with your use case in user mode. This may be a better aproach
than a kernel driver for this mouse.

The specifications for the logitech hid++ 2.0 protocol are publicly
available, but they are a bit outdated, we are working on a solution
that will enable public access to our most up-to-date specs but it is
not quite ready yet.

If you have trouble with the specs, then ask me and I will try to help you.

Cheers,
-nestor


>
>>
>> Cheers,
>> Benjamin
>>
>>> On Sat, Aug 23, 2014 at 2:40 PM, Goffredo Baroncelli <kreijack@gmail.com> wrote:
>>>> Add logitech m560 support. In the init phase the driver
>>>> send a sequence which avoid some unnecessary key sending
>>>> from the mouse.
>>>>
>>>> The mouse appears as a couple of mouse and keyboard. Some buttons
>>>> emit a key event instead of the "mouse button" event. However
>>>> some event (like the middle button release) aren't generated.
>>>> Fortunately, the device generates an additional event to
>>>> track it. The event type is 0x0a.
>>>>
>>>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>>>> ---
>>>>  drivers/hid/hid-logitech-dj.c | 92 +++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 92 insertions(+)
>>>>
>>>> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
>>>> index feddd3d..40c5ea1 100644
>>>> --- a/drivers/hid/hid-logitech-dj.c
>>>> +++ b/drivers/hid/hid-logitech-dj.c
>>>> @@ -222,7 +222,99 @@ static inline void call_destroy(struct dj_device *djdev)
>>>>         djdev->methods->destroy(djdev);
>>>>  }
>>>>
>>>> +/*
>>>> + * Send the sequence 10xx0a35 00af03
>>>> + * to the mouse id xx. It disables the key sending by the central button.
>>>> + */
>>>> +
>>>> +static int lg_m560_init_device(struct dj_device *dj_device)
>>>> +{
>>>> +       struct dj_report *dj_report;
>>>> +       int retval;
>>>> +       static u8 reset_data[] = {0x35, 0x00, 0xaf, 0x03};
>>>> +
>>>> +       dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
>>>> +       if (!dj_report)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       dj_device->userdata = dj_report;
>>>> +
>>>> +       dj_report->report_id = REPORT_ID_RECV_SHORT;
>>>> +       dj_report->device_index = dj_device->device_index;
>>>> +       dj_report->report_type = 0x0a;
>>>> +
>>>> +       memcpy(dj_report->report_params, reset_data, sizeof(reset_data));
>>>> +
>>>> +       retval = hid_hw_raw_request(dj_device->dj_receiver_dev->hdev,
>>>> +               dj_report->report_id,
>>>> +               (void *)dj_report, REPORT_ID_RECV_SHORT_LENGTH,
>>>> +               HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
>>>> +
>>>> +       memset(dj_report, 0, sizeof(struct dj_report));
>>>> +
>>>> +       return retval;
>>>> +}
>>>> +
>>>> +static int lg_m560_parse_raw_event(struct dj_device *dj_device,
>>>> +                                       struct dj_report *dj_report)
>>>> +{
>>>> +       u8 *m506_last_mouse_report = dj_device->userdata;
>>>> +
>>>> +       BUG_ON(!dj_device);
>>>> +
>>>> +       /* don't pass keys when the mouse is a m560 */
>>>> +       if (dj_report->report_type == REPORT_TYPE_KEYBOARD)
>>>> +               return true;
>>>> +
>>>> +       if (dj_report->report_id == 0x11 && dj_report->report_type == 0x0a) {
>>>> +               int btn;
>>>> +
>>>> +               /* check if the event is a button */
>>>> +               btn = dj_report->report_params[2];
>>>> +               if (btn != 0x00 && btn != 0xb0 && btn != 0xae && btn != 0xaf)
>>>> +                       return true;
>>>> +
>>>> +               if (btn == 0xaf)
>>>> +                       m506_last_mouse_report[1] |= 4;
>>>> +               if (btn == 0xae)
>>>> +                       m506_last_mouse_report[2] |= 2;
>>>> +               if (btn == 0xb0)
>>>> +                       m506_last_mouse_report[2] |= 4;
>>>> +               if (btn == 0x00) {
>>>> +                       m506_last_mouse_report[1] &= ~4;
>>>> +                       m506_last_mouse_report[2] &= ~(4|2);
>>>> +               }
>>>> +
>>>> +               if (hid_input_report(dj_device->hdev, HID_INPUT_REPORT,
>>>> +                                       m506_last_mouse_report, 8, 1)) {
>>>> +                               dbg_hid("hid_input_report error\n");
>>>> +               }
>>>> +               return true;
>>>> +       }
>>>> +
>>>> +       /* copy the button status */
>>>> +       if (dj_report->report_type == REPORT_TYPE_MOUSE) {
>>>> +               /* copy only the first 3 bytes: type, btn0..7, btn8..16 */
>>>> +               memcpy(dj_device->userdata,
>>>> +                       &dj_report->report_type, 3);
>>>> +       }
>>>> +
>>>> +       /* continue with the standard handler */
>>>> +       return false;
>>>> +}
>>>> +
>>>> +static void lg_m560_destroy(struct dj_device *dev)
>>>> +{
>>>> +       kfree(dev->userdata);
>>>> +}
>>>> +
>>>>  static struct dj_device_method dj_device_method[] = {
>>>> +       {       /* logitech M560 */
>>>> +               .device_names = (char *[]){ "M560", NULL },
>>>> +               .init_device = lg_m560_init_device,
>>>> +               .parse_raw_event = lg_m560_parse_raw_event,
>>>> +               .destroy = lg_m560_destroy
>>>> +       },
>>>>
>>>>         /* last element */
>>>>         { NULL, }
>>>> --
>>>> 1.9.3
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli (kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

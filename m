From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 3/3] Add logitech m560 driver
Date: Tue, 26 Aug 2014 17:22:25 -0400
Message-ID: <CAN+gG=F_KvfqbQXKcMzMRLJu0AJ+wdmXvWLi+-PC-jZE_pPXTA@mail.gmail.com>
References: <1408797629-3474-1-git-send-email-kreijack@inwind.it>
	<1408797629-3474-4-git-send-email-kreijack@inwind.it>
	<CAE7qMrpgPULMq95wZhLgsLWXJ+=DiVoe9XzxZB5poU0ZmqFiXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:53286 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbaHZVW0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Aug 2014 17:22:26 -0400
Received: by mail-qc0-f169.google.com with SMTP id c9so16619092qcz.28
        for <linux-input@vger.kernel.org>; Tue, 26 Aug 2014 14:22:25 -0700 (PDT)
In-Reply-To: <CAE7qMrpgPULMq95wZhLgsLWXJ+=DiVoe9XzxZB5poU0ZmqFiXg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Goffredo Baroncelli <kreijack@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Goffredo Baroncelli <kreijack@inwind.it>

Hi guys,

On Mon, Aug 25, 2014 at 4:38 AM, Nestor Lopez Casado
<nlopezcasad@logitech.com> wrote:
> Hi,
>
> If you want to have a special driver for a specific Unifying device
> you should put in place the right structure to have a separate driver
> for it.
>
> hid-logitech-dj is a "bus" driver for the Unifying *receiver*, not a
> driver for any specific Unifying device.
>
> Benjamin Tisssoires (github bentiss) has uploaded a few patches to his
> github account to finish the infrastructure for specific Unifying
> devices drivers. Look for the more complete branch 'for-whot' See how
> he created a hid-logitech-wtp driver for the Different wireless
> touchpads.
>
> This would be the right approach to what you are trying to do.
>

I have been willing to review/answer to this patch series since
Monday, but did not found the time to do so. I have a small spot now,
so here I am.

So, Goffredo, as Nestor said, I wouldn't have coded this in the way of
your patch. However, do not take Nestor's words as a strong rejection
and that we do not want you to submit anything else :)

I am in fault here because I should have sent upstream the branch
Nestor pointed at a long time ago now, and this would have avoided you
a lot of pain.

The thing which prevented me to send this upstream is that Jiri tries
to group the various hid drivers by vendor, and this branch creates 2
new for supporting various dj/hid++ devices.

I have though one specific comment Goffredo with your patch (again I
did not went in depth of them, but this jumped into my eyes). Why
don't you simply use the wireless ID instead of the name of the
device. The wireless id is unique across all Logitech unifying
devices, and it's definitively easier to compare than a string.

One other thing is may be answered by Nestor: is there any command we
can send to the device for it to send only regular buttons? This may
just be an easier solution than having to remap the keyboards events
into buttons.

Cheers,
Benjamin

> On Sat, Aug 23, 2014 at 2:40 PM, Goffredo Baroncelli <kreijack@gmail.com> wrote:
>> Add logitech m560 support. In the init phase the driver
>> send a sequence which avoid some unnecessary key sending
>> from the mouse.
>>
>> The mouse appears as a couple of mouse and keyboard. Some buttons
>> emit a key event instead of the "mouse button" event. However
>> some event (like the middle button release) aren't generated.
>> Fortunately, the device generates an additional event to
>> track it. The event type is 0x0a.
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>> ---
>>  drivers/hid/hid-logitech-dj.c | 92 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 92 insertions(+)
>>
>> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
>> index feddd3d..40c5ea1 100644
>> --- a/drivers/hid/hid-logitech-dj.c
>> +++ b/drivers/hid/hid-logitech-dj.c
>> @@ -222,7 +222,99 @@ static inline void call_destroy(struct dj_device *djdev)
>>         djdev->methods->destroy(djdev);
>>  }
>>
>> +/*
>> + * Send the sequence 10xx0a35 00af03
>> + * to the mouse id xx. It disables the key sending by the central button.
>> + */
>> +
>> +static int lg_m560_init_device(struct dj_device *dj_device)
>> +{
>> +       struct dj_report *dj_report;
>> +       int retval;
>> +       static u8 reset_data[] = {0x35, 0x00, 0xaf, 0x03};
>> +
>> +       dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
>> +       if (!dj_report)
>> +               return -ENOMEM;
>> +
>> +       dj_device->userdata = dj_report;
>> +
>> +       dj_report->report_id = REPORT_ID_RECV_SHORT;
>> +       dj_report->device_index = dj_device->device_index;
>> +       dj_report->report_type = 0x0a;
>> +
>> +       memcpy(dj_report->report_params, reset_data, sizeof(reset_data));
>> +
>> +       retval = hid_hw_raw_request(dj_device->dj_receiver_dev->hdev,
>> +               dj_report->report_id,
>> +               (void *)dj_report, REPORT_ID_RECV_SHORT_LENGTH,
>> +               HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
>> +
>> +       memset(dj_report, 0, sizeof(struct dj_report));
>> +
>> +       return retval;
>> +}
>> +
>> +static int lg_m560_parse_raw_event(struct dj_device *dj_device,
>> +                                       struct dj_report *dj_report)
>> +{
>> +       u8 *m506_last_mouse_report = dj_device->userdata;
>> +
>> +       BUG_ON(!dj_device);
>> +
>> +       /* don't pass keys when the mouse is a m560 */
>> +       if (dj_report->report_type == REPORT_TYPE_KEYBOARD)
>> +               return true;
>> +
>> +       if (dj_report->report_id == 0x11 && dj_report->report_type == 0x0a) {
>> +               int btn;
>> +
>> +               /* check if the event is a button */
>> +               btn = dj_report->report_params[2];
>> +               if (btn != 0x00 && btn != 0xb0 && btn != 0xae && btn != 0xaf)
>> +                       return true;
>> +
>> +               if (btn == 0xaf)
>> +                       m506_last_mouse_report[1] |= 4;
>> +               if (btn == 0xae)
>> +                       m506_last_mouse_report[2] |= 2;
>> +               if (btn == 0xb0)
>> +                       m506_last_mouse_report[2] |= 4;
>> +               if (btn == 0x00) {
>> +                       m506_last_mouse_report[1] &= ~4;
>> +                       m506_last_mouse_report[2] &= ~(4|2);
>> +               }
>> +
>> +               if (hid_input_report(dj_device->hdev, HID_INPUT_REPORT,
>> +                                       m506_last_mouse_report, 8, 1)) {
>> +                               dbg_hid("hid_input_report error\n");
>> +               }
>> +               return true;
>> +       }
>> +
>> +       /* copy the button status */
>> +       if (dj_report->report_type == REPORT_TYPE_MOUSE) {
>> +               /* copy only the first 3 bytes: type, btn0..7, btn8..16 */
>> +               memcpy(dj_device->userdata,
>> +                       &dj_report->report_type, 3);
>> +       }
>> +
>> +       /* continue with the standard handler */
>> +       return false;
>> +}
>> +
>> +static void lg_m560_destroy(struct dj_device *dev)
>> +{
>> +       kfree(dev->userdata);
>> +}
>> +
>>  static struct dj_device_method dj_device_method[] = {
>> +       {       /* logitech M560 */
>> +               .device_names = (char *[]){ "M560", NULL },
>> +               .init_device = lg_m560_init_device,
>> +               .parse_raw_event = lg_m560_parse_raw_event,
>> +               .destroy = lg_m560_destroy
>> +       },
>>
>>         /* last element */
>>         { NULL, }
>> --
>> 1.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

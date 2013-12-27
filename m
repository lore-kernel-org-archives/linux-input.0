From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Bluetooth: hidp: make sure input buffers are big enough
Date: Fri, 27 Dec 2013 13:35:24 +0100
Message-ID: <CANq1E4TOHvb3--H6SoRhB09sUwuYkrvSAXCNN2Y0PaVSOEte=w@mail.gmail.com>
References: <1387451372-6881-1-git-send-email-dh.herrmann@gmail.com>
	<3109C2D8-E01C-4728-A593-1978BB3D202D@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34519 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab3L0MfY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Dec 2013 07:35:24 -0500
In-Reply-To: <3109C2D8-E01C-4728-A593-1978BB3D202D@holtmann.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>

Hi Marcel

On Fri, Dec 20, 2013 at 2:36 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi David,
>
>> HID core expects the input buffers to be at least of size 4096
>> (HID_MAX_BUFFER_SIZE). Other sizes will result in buffer-overflows if an
>> input-report is smaller than advertised. We could, like i2c, compute the
>> biggest report-size instead of using HID_MAX_BUFFER_SIZE, but this will
>> blow up if report-descriptors are changed after ->start() has been called.
>> So lets be safe and just use the biggest buffer we have.
>>
>> Note that this adds an additional copy to the HIDP input path. If there is
>> a way to make sure the skb-buf is big enough, we should use that instead.
>>
>> The best way would be to make hid-core honor the @size argument, though,
>> that sounds easier than it is. So lets just fix the buffer-overflows for
>> now and afterwards look for a faster way for all transport drivers.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> ---
>> Hi
>>
>> Any ideas how to improve this patch? I'd like to avoid the extra copy but I have
>> no clue how the skb stuff works exactly.
>
> the buffers are coming straight from L2CAP. They might come in fragments. We have to reassemble them and while there are large packets for sure, we rather not want to allocate 4096 for every reassembled packet to make HID happy.
>
> I am not super familiar with the underlying memory management of SKBs, but I assume they use slices of some sort internally. So uses large SKBs for 20 byte HID report will cause an issue with all other protocols running on top of L2CAP

I was more thinking of an skb call to increase the underlying buffer
of a single package. We could call this together with skb_linearize()
in HIDP to guarantee the skb-buf is big enough. Technically, this will
probably result in the same behavior as my own patch so probably not
the way to go.

>> I also haven't figured out a nice way to make HID-core honor the "size"
>> parameter. hid-input depends on getting the whole input-report.
>
> I think this needs clearly fixing.

And we have a volunteer, yippie! ;)

I think hid_input_report() in hid-core.c is the only place that relies
on this. Maybe it really is easier to fix it. But I am not even
slightly familiar with that code. So if no-one of the HID core
developers steps up to fix it, we should take the transport-driver
fixes instead. As nearly all transport-drivers are affected by this,
maybe we should even move this buffer into hid_device and provide
hid_input_truncated_report() which does this.

Anyhow, waiting for Jiri's comments on this.

>> Comments welcome!
>> David
>>
>> net/bluetooth/hidp/core.c | 16 ++++++++++++++--
>> net/bluetooth/hidp/hidp.h |  4 ++++
>> 2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
>> index 292e619..d9fb934 100644
>> --- a/net/bluetooth/hidp/core.c
>> +++ b/net/bluetooth/hidp/core.c
>> @@ -430,6 +430,16 @@ static void hidp_del_timer(struct hidp_session *session)
>>               del_timer(&session->timer);
>> }
>>
>> +static void hidp_process_report(struct hidp_session *session,
>> +                             int type, const u8 *data, int len, int intr)
>> +{
>> +     if (len > HID_MAX_BUFFER_SIZE)
>> +             len = HID_MAX_BUFFER_SIZE;
>> +
>> +     memcpy(session->input_buf, data, len);
>> +     hid_input_report(session->hid, type, session->input_buf, len, intr);
>> +}
>> +
>> static void hidp_process_handshake(struct hidp_session *session,
>>                                       unsigned char param)
>> {
>> @@ -502,7 +512,8 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
>>                       hidp_input_report(session, skb);
>>
>>               if (session->hid)
>> -                     hid_input_report(session->hid, HID_INPUT_REPORT, skb->data, skb->len, 0);
>> +                     hidp_process_report(session, HID_INPUT_REPORT,
>> +                                         skb->data, skb->len, 0);
>>               break;
>>
>>       case HIDP_DATA_RTYPE_OTHER:
>> @@ -584,7 +595,8 @@ static void hidp_recv_intr_frame(struct hidp_session *session,
>>                       hidp_input_report(session, skb);
>>
>>               if (session->hid) {
>> -                     hid_input_report(session->hid, HID_INPUT_REPORT, skb->data, skb->len, 1);
>> +                     hidp_process_report(session, HID_INPUT_REPORT,
>> +                                         skb->data, skb->len, 1);
>>                       BT_DBG("report len %d", skb->len);
>>               }
>>       } else {
>> diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
>> index ab52414..8798492 100644
>> --- a/net/bluetooth/hidp/hidp.h
>> +++ b/net/bluetooth/hidp/hidp.h
>> @@ -24,6 +24,7 @@
>> #define __HIDP_H
>>
>> #include <linux/types.h>
>> +#include <linux/hid.h>
>> #include <linux/kref.h>
>> #include <net/bluetooth/bluetooth.h>
>> #include <net/bluetooth/l2cap.h>
>> @@ -179,6 +180,9 @@ struct hidp_session {
>>
>>       /* Used in hidp_output_raw_report() */
>>       int output_report_success; /* boolean */
>> +
>> +     /* temporary input buffer */
>> +     u8 input_buf[HID_MAX_BUFFER_SIZE];
>> };
>
> The report does not need any specific alignment?

This is already aligned to native size, isn't it? Anyhow, HID core
does not have any alignment-restrictions I am aware of. Jiri? I
thought the extract()/implement() stuff was fixed recently.

Thanks
David

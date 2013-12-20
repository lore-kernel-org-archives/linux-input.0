From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: hidp: make sure input buffers are big enough
Date: Fri, 20 Dec 2013 05:36:29 -0800
Message-ID: <3109C2D8-E01C-4728-A593-1978BB3D202D@holtmann.org>
References: <1387451372-6881-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:51744 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932292Ab3LTNgi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Dec 2013 08:36:38 -0500
In-Reply-To: <1387451372-6881-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>

Hi David,

> HID core expects the input buffers to be at least of size 4096
> (HID_MAX_BUFFER_SIZE). Other sizes will result in buffer-overflows if an
> input-report is smaller than advertised. We could, like i2c, compute the
> biggest report-size instead of using HID_MAX_BUFFER_SIZE, but this will
> blow up if report-descriptors are changed after ->start() has been called.
> So lets be safe and just use the biggest buffer we have.
> 
> Note that this adds an additional copy to the HIDP input path. If there is
> a way to make sure the skb-buf is big enough, we should use that instead.
> 
> The best way would be to make hid-core honor the @size argument, though,
> that sounds easier than it is. So lets just fix the buffer-overflows for
> now and afterwards look for a faster way for all transport drivers.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
> Hi
> 
> Any ideas how to improve this patch? I'd like to avoid the extra copy but I have
> no clue how the skb stuff works exactly.

the buffers are coming straight from L2CAP. They might come in fragments. We have to reassemble them and while there are large packets for sure, we rather not want to allocate 4096 for every reassembled packet to make HID happy.

I am not super familiar with the underlying memory management of SKBs, but I assume they use slices of some sort internally. So uses large SKBs for 20 byte HID report will cause an issue with all other protocols running on top of L2CAP>

> I also haven't figured out a nice way to make HID-core honor the "size"
> parameter. hid-input depends on getting the whole input-report.

I think this needs clearly fixing.

> Comments welcome!
> David
> 
> net/bluetooth/hidp/core.c | 16 ++++++++++++++--
> net/bluetooth/hidp/hidp.h |  4 ++++
> 2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 292e619..d9fb934 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -430,6 +430,16 @@ static void hidp_del_timer(struct hidp_session *session)
> 		del_timer(&session->timer);
> }
> 
> +static void hidp_process_report(struct hidp_session *session,
> +				int type, const u8 *data, int len, int intr)
> +{
> +	if (len > HID_MAX_BUFFER_SIZE)
> +		len = HID_MAX_BUFFER_SIZE;
> +
> +	memcpy(session->input_buf, data, len);
> +	hid_input_report(session->hid, type, session->input_buf, len, intr);
> +}
> +
> static void hidp_process_handshake(struct hidp_session *session,
> 					unsigned char param)
> {
> @@ -502,7 +512,8 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
> 			hidp_input_report(session, skb);
> 
> 		if (session->hid)
> -			hid_input_report(session->hid, HID_INPUT_REPORT, skb->data, skb->len, 0);
> +			hidp_process_report(session, HID_INPUT_REPORT,
> +					    skb->data, skb->len, 0);
> 		break;
> 
> 	case HIDP_DATA_RTYPE_OTHER:
> @@ -584,7 +595,8 @@ static void hidp_recv_intr_frame(struct hidp_session *session,
> 			hidp_input_report(session, skb);
> 
> 		if (session->hid) {
> -			hid_input_report(session->hid, HID_INPUT_REPORT, skb->data, skb->len, 1);
> +			hidp_process_report(session, HID_INPUT_REPORT,
> +					    skb->data, skb->len, 1);
> 			BT_DBG("report len %d", skb->len);
> 		}
> 	} else {
> diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
> index ab52414..8798492 100644
> --- a/net/bluetooth/hidp/hidp.h
> +++ b/net/bluetooth/hidp/hidp.h
> @@ -24,6 +24,7 @@
> #define __HIDP_H
> 
> #include <linux/types.h>
> +#include <linux/hid.h>
> #include <linux/kref.h>
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/l2cap.h>
> @@ -179,6 +180,9 @@ struct hidp_session {
> 
> 	/* Used in hidp_output_raw_report() */
> 	int output_report_success; /* boolean */
> +
> +	/* temporary input buffer */
> +	u8 input_buf[HID_MAX_BUFFER_SIZE];
> };

The report does not need any specific alignment?

Regards

Marcel


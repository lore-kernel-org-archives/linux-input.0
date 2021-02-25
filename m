Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD38C433E0
	for <linux-input@archiver.kernel.org>; Thu, 25 Feb 2021 15:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED8A164F19
	for <linux-input@archiver.kernel.org>; Thu, 25 Feb 2021 15:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhBYP76 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 25 Feb 2021 10:59:58 -0500
Received: from netrider.rowland.org ([192.131.102.5]:46387 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229566AbhBYP75 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Feb 2021 10:59:57 -0500
Received: (qmail 1351795 invoked by uid 1000); 25 Feb 2021 10:59:14 -0500
Date:   Thu, 25 Feb 2021 10:59:14 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+ab02336a647181a886a6@syzkaller.appspotmail.com
Subject: Re: [PATCH] drivers/hid: fix for the big hid report length
Message-ID: <20210225155914.GA1350993@rowland.harvard.edu>
References: <20210225145215.3438202-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225145215.3438202-1-snovitoll@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Feb 25, 2021 at 08:52:15PM +0600, Sabyrzhan Tasbolatov wrote:
> syzbot found WARNING in hid_alloc_report_buf[1] when the raw buffer for
> report is kmalloc() allocated with length > KMALLOC_MAX_SIZE, causing
> order >= MAX_ORDER condition:
> 
> u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
> {
> 	/*
> 	 * 7 extra bytes are necessary to achieve proper functionality
> 	 * of implement() working on 8 byte chunks
> 	 */
> 
> 	u32 len = hid_report_len(report) + 7;
> 
> 	return kmalloc(len, flags);
> 
> The restriction with HID_MAX_BUFFER_SIZE (16kb) is, seems, a valid max
> limit. I've come up with this in all hid_report_len() xrefs.
> 
> The fix inside hid_report_len(), not in *hid_alloc_report_buf() is also
> fixing out-of-bounds here in memcpy():
> 
> statc int hid_submit_ctrl(..)
> {
> ..
> 	len = hid_report_len(report);
> 	if (dir == USB_DIR_OUT) {
> 		..
> 		if (raw_report) {
> 			memcpy(usbhid->ctrlbuf, raw_report, len);
> ..
> 
> So I've decided to return HID_MAX_BUFFER_SIZE if it the report length is
> bigger than limit, otherwise the return the report length.
> 
> [1]
> Call Trace:
>  alloc_pages include/linux/gfp.h:547 [inline]
>  kmalloc_order+0x40/0x130 mm/slab_common.c:837
>  kmalloc_order_trace+0x15/0x70 mm/slab_common.c:853
>  kmalloc_large include/linux/slab.h:481 [inline]
>  __kmalloc+0x257/0x330 mm/slub.c:3974
>  kmalloc include/linux/slab.h:557 [inline]
>  hid_alloc_report_buf+0x70/0xa0 drivers/hid/hid-core.c:1648
>  __usbhid_submit_report drivers/hid/usbhid/hid-core.c:590 [inline]
> 
> Reported-by: syzbot+ab02336a647181a886a6@syzkaller.appspotmail.com
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  drivers/hid/usbhid/hid-core.c | 2 +-
>  include/linux/hid.h           | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 86257ce6d619..4e9077363c96 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -374,7 +374,7 @@ static int hid_submit_ctrl(struct hid_device *hid)
>  	raw_report = usbhid->ctrl[usbhid->ctrltail].raw_report;
>  	dir = usbhid->ctrl[usbhid->ctrltail].dir;
>  
> -	len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
> +	len = hid_report_len(report);
>  	if (dir == USB_DIR_OUT) {
>  		usbhid->urbctrl->pipe = usb_sndctrlpipe(hid_to_usb_dev(hid), 0);
>  		usbhid->urbctrl->transfer_buffer_length = len;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index c39d71eb1fd0..509a6ffdca00 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -1156,7 +1156,9 @@ static inline void hid_hw_wait(struct hid_device *hdev)
>  static inline u32 hid_report_len(struct hid_report *report)
>  {
>  	/* equivalent to DIV_ROUND_UP(report->size, 8) + !!(report->id > 0) */
> -	return ((report->size - 1) >> 3) + 1 + (report->id > 0);
> +	u32 len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
> +
> +	return len > HID_MAX_BUFFER_SIZE ? HID_MAX_BUFFER_SIZE : len;

Won't this cause silent errors?

How about instead just rejecting any device which includes a report 
whose length is too big (along with an line in the system log explaining 
what's wrong)?

Alan Stern

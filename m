From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/6] HID: Add the client_addr member to the hid_device struct
Date: Fri, 31 Jan 2014 14:12:18 -0500
Message-ID: <CAN+gG=HkjDJ29m1UXoryJyzcfdjohm=FfqZvVWkFcMgjTAj-cw@mail.gmail.com>
References: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
	<1391189573-2591-2-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:62160 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236AbaAaTMU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 14:12:20 -0500
Received: by mail-lb0-f177.google.com with SMTP id z5so3746780lbh.36
        for <linux-input@vger.kernel.org>; Fri, 31 Jan 2014 11:12:19 -0800 (PST)
In-Reply-To: <1391189573-2591-2-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

On Fri, Jan 31, 2014 at 12:32 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> Add the client_addr member to the hid_device struct for storing the client
> address of a connected device.
>
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>  include/linux/hid.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 31b9d29..283fc6e 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -495,6 +495,7 @@ struct hid_device {                                                 /* device report descriptor */
>         char name[128];                                                 /* Device name */
>         char phys[64];                                                  /* Device physical location */
>         char uniq[64];                                                  /* Device unique identifier (serial #) */
> +       __u8 client_addr[6];                                            /* Device client address (if wireless) */

It is good to make small patches, but this one should definitively be
squashed with 2/6.
You should be able to say why you add a field in a struct by looking
at the code in the patch.

Cheers,
Benjamin

>
>         void *driver_data;
>
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

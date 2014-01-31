From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 3/6] HID: Add support for setting client_addr in uhid.
Date: Fri, 31 Jan 2014 14:16:30 -0500
Message-ID: <CAN+gG=G6TNugTh3truT0U-uMcqC8+9AvBiQ3jOxWHMaALM7sxA@mail.gmail.com>
References: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
	<1391189573-2591-4-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:48541 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932651AbaAaTQb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 14:16:31 -0500
Received: by mail-lb0-f173.google.com with SMTP id y6so3734391lbh.18
        for <linux-input@vger.kernel.org>; Fri, 31 Jan 2014 11:16:30 -0800 (PST)
In-Reply-To: <1391189573-2591-4-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

On Fri, Jan 31, 2014 at 12:32 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> Add support for setting the client address of a device in uhid.
>
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>  drivers/hid/uhid.c        | 5 +++++
>  include/uapi/linux/uhid.h | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index cedc6da..cfd2b93 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -259,6 +259,7 @@ struct uhid_create_req_compat {
>         __u8 name[128];
>         __u8 phys[64];
>         __u8 uniq[64];
> +       __u8 client_addr[6];
>
>         compat_uptr_t rd_data;
>         __u16 rd_size;
> @@ -308,6 +309,8 @@ static int uhid_event_from_user(const char __user *buffer, size_t len,
>                                 sizeof(compat->phys));
>                         memcpy(event->u.create.uniq, compat->uniq,
>                                 sizeof(compat->uniq));
> +                       memcpy(event->u.create.client_addr, compat->client_addr,
> +                               sizeof(compat->client_addr));
>
>                         event->u.create.rd_data = compat_ptr(compat->rd_data);
>                         event->u.create.rd_size = compat->rd_size;
> @@ -375,6 +378,8 @@ static int uhid_dev_create(struct uhid_device *uhid,
>         hid->phys[63] = 0;
>         strncpy(hid->uniq, ev->u.create.uniq, 63);
>         hid->uniq[63] = 0;
> +       memcpy(hid->client_addr, ev->u.create.client_addr,
> +               sizeof(hid->client_addr));
>
>         hid->ll_driver = &uhid_hid_driver;
>         hid->hid_get_raw_report = uhid_hid_get_raw;
> diff --git a/include/uapi/linux/uhid.h b/include/uapi/linux/uhid.h
> index 414b74b..5e48acc 100644
> --- a/include/uapi/linux/uhid.h
> +++ b/include/uapi/linux/uhid.h
> @@ -40,6 +40,7 @@ struct uhid_create_req {
>         __u8 name[128];
>         __u8 phys[64];
>         __u8 uniq[64];
> +       __u8 client_addr[6];

This is definitively wrong. By that I mean adding a field in the
middle of a struct in a user-space API without handling the case where
a user-space program will use the old API.

You are breaking the API and the ABI here, and you will lead to kernel
crash if the program using this has not been recompiled.
You can add fields in a struct, don't misinterpret me, but you have to
be sure that you will support both old and new API/ABI.

And yes, there are some users (programs) of uhid which would be broken by this.

Cheers,
Benjamin

>         __u8 __user *rd_data;
>         __u16 rd_size;
>
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

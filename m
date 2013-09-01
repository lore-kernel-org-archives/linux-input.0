From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: uhid: add devname module alias
Date: Sun, 1 Sep 2013 20:36:11 +0200
Message-ID: <CANq1E4SMMY+aO3DfmKCWST9GUc0Lwugy9iB1TZq3Mg_QtjEAWw@mail.gmail.com>
References: <1378058566-5207-1-git-send-email-marcel@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:40262 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757839Ab3IASgM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Sep 2013 14:36:12 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so2175375ieb.28
        for <linux-input@vger.kernel.org>; Sun, 01 Sep 2013 11:36:12 -0700 (PDT)
In-Reply-To: <1378058566-5207-1-git-send-email-marcel@holtmann.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Sun, Sep 1, 2013 at 8:02 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> For simple device node creation, add the devname module alias.

Yepp, looks good. uinput already has it, so:
Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David

> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/hid/uhid.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index fc307e0..9ab7dfc 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -659,3 +659,4 @@ module_exit(uhid_exit);
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("David Herrmann <dh.herrmann@gmail.com>");
>  MODULE_DESCRIPTION("User-space I/O driver support for HID subsystem");
> +MODULE_ALIAS("devname:" UHID_NAME);
> --
> 1.8.3.1
>

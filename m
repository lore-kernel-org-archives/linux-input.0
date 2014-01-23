From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: add short note about ABS_MISC+<n> axes
Date: Thu, 23 Jan 2014 15:39:55 +0100
Message-ID: <CANq1E4SRhgGD_c=vAMseWGmV8NQB_BTygsFoVHf_MLuM8udv2A@mail.gmail.com>
References: <1387207386-4601-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36907 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbaAWOsP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jan 2014 09:48:15 -0500
Received: by mail-ie0-f178.google.com with SMTP id x13so1202081ief.37
        for <linux-input@vger.kernel.org>; Thu, 23 Jan 2014 06:48:14 -0800 (PST)
In-Reply-To: <1387207386-4601-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Hi Dmitry

ping?

David

On Mon, Dec 16, 2013 at 4:23 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> We must not reassign those axes or we will break backwards-compat. Add a
> small note for that so we don't accidentally some day reuse these.
>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  include/uapi/linux/input.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index a372627..da1125e 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -816,6 +816,10 @@ struct input_keymap_entry {
>
>  #define ABS_MISC               0x28
>
> +/* ABS_MISC+x is used by HID to assign to unknown axes. Note that they used to
> + * flow over into the MT definitions. For backwards-compatibility, we must
> + * not reassign [0x29-0x2e] */
> +
>  #define ABS_MT_SLOT            0x2f    /* MT slot being modified */
>  #define ABS_MT_TOUCH_MAJOR     0x30    /* Major axis of touching ellipse */
>  #define ABS_MT_TOUCH_MINOR     0x31    /* Minor axis (omit if circular) */
> --
> 1.8.5.1
>

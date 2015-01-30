From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input.h: Add BTN_SIDE2 button code
Date: Fri, 30 Jan 2015 14:35:37 -0800
Message-ID: <20150130223537.GB23203@dtor-ws>
References: <1422008690-920-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:58078 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbbA3Wfm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2015 17:35:42 -0500
Received: by mail-ie0-f179.google.com with SMTP id x19so6630551ier.10
        for <linux-input@vger.kernel.org>; Fri, 30 Jan 2015 14:35:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1422008690-920-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

Hi Hans,

On Fri, Jan 23, 2015 at 11:24:50AM +0100, Hans de Goede wrote:
> Some mice report buttons with a MSC_SCAN of 589833 this maps to a button code
> of 0x118, add a BTN_SIDE2 define for this to input.h
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1184352
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looking at Logitech website it seems that one of teh buttons is marked
"zoom", so why don't we use KEY_ZOOM for it?

> ---
>  include/uapi/linux/input.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index a1d7e93..27b0f6a 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -498,6 +498,7 @@ struct input_keymap_entry {
>  #define BTN_FORWARD		0x115
>  #define BTN_BACK		0x116
>  #define BTN_TASK		0x117
> +#define BTN_SIDE2		0x118
>  
>  #define BTN_JOYSTICK		0x120
>  #define BTN_TRIGGER		0x120
> -- 
> 2.1.0
> 

Thanks.

-- 
Dmitry

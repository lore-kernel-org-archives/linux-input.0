From: Fredrik Hallenberg <megahallon@gmail.com>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some keyboards
Date: Tue, 9 Sep 2014 11:40:24 +0200
Message-ID: <CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:35536 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870AbaIIJkZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Sep 2014 05:40:25 -0400
Received: by mail-qc0-f171.google.com with SMTP id x3so17091466qcv.16
        for <linux-input@vger.kernel.org>; Tue, 09 Sep 2014 02:40:25 -0700 (PDT)
In-Reply-To: <1407664566-5303-1-git-send-email-megahallon@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi, time for a bump on this one.

On Sun, Aug 10, 2014 at 11:56 AM, Fredrik Hallenberg
<megahallon@gmail.com> wrote:
> Here is my attempt on a fix for bug 70181, please review it. It is
> tested on my nordic Corsair K70, if this solution is deemed acceptable
> I can ask some people with other problematic keyboards to test it.
>
> Signed-off-by: Fredrik Hallenberg <megahallon@gmail.com>
> ---
>  drivers/hid/hid-input.c | 14 ++++++++++++++
>  include/linux/hid.h     |  1 +
>  2 files changed, 15 insertions(+)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 2619f7f..56429c0 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1085,6 +1085,20 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>                 return;
>         }
>
> +       /*
> +        * Some keyboards will report both HID keys 0x31 (\ and |) and
> +        * 0x32 (Non-US # and ~) which are both mapped to
> +        * KEY_BACKSLASH. This will cause spurious events causing
> +        * repeated backslash key presses. Handle this by tracking the
> +        * active HID code and ignoring the other one.
> +        */
> +       if (usage->type == EV_KEY && usage->code == KEY_BACKSLASH) {
> +               if (value)
> +                       field->hidinput->backslash_usage = usage->hid;
> +               else if (field->hidinput->backslash_usage != usage->hid)
> +                       return;
> +       }
> +
>         /* report the usage code as scancode if the key status has changed */
>         if (usage->type == EV_KEY && !!test_bit(usage->code, input->key) != value)
>                 input_event(input, EV_MSC, MSC_SCAN, usage->hid);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index f53c4a9..1c59f8f 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -448,6 +448,7 @@ struct hid_input {
>         struct list_head list;
>         struct hid_report *report;
>         struct input_dev *input;
> +       unsigned backslash_usage;
>  };
>
>  enum hid_type {
> --
> 2.1.0.rc1
>

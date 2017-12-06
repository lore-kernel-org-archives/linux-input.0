From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: core: lower log level for unknown main item tags to warnings
Date: Wed, 6 Dec 2017 18:24:36 +0100
Message-ID: <CAO-hwJJuhzpS3tT9PKvkSuG-KCBUfJ1qweSk4wGQxDsjcRn4qQ@mail.gmail.com>
References: <20171206165438.676-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37223 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdLFRYh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 6 Dec 2017 12:24:37 -0500
Received: by mail-qt0-f195.google.com with SMTP id f2so10737595qtj.4
        for <linux-input@vger.kernel.org>; Wed, 06 Dec 2017 09:24:37 -0800 (PST)
In-Reply-To: <20171206165438.676-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Wed, Dec 6, 2017 at 5:54 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Given all the effort distros have done with splash-screens to give
> users a nice clean boot experience, we really want dmesg --level=err
> to not print anything unless there is a real problem with either the
> hardware or the kernel. Buggy HID descriptors unfortunately happen
> all too often, so lower the log level to warning keep the console
> clear of error messages such as:
>
> [  441.079664] apple 0005:05AC:0239.0003: unknown main item tag 0x0
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/hid-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 7297b1d1300c..c2560aae5542 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -551,7 +551,7 @@ static int hid_parser_main(struct hid_parser *parser, struct hid_item *item)
>                 ret = hid_add_field(parser, HID_FEATURE_REPORT, data);
>                 break;
>         default:
> -               hid_err(parser->device, "unknown main item tag 0x%x\n", item->tag);
> +               hid_warn(parser->device, "unknown main item tag 0x%x\n", item->tag);
>                 ret = 0;
>         }
>
> --
> 2.14.3
>

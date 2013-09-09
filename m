From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 6/7] HID: lenovo-tpkbd: validate output report details
Date: Mon, 9 Sep 2013 15:28:22 +0200
Message-ID: <CAN+gG=EEzGsh7nd7Dk+=bxQBhSq-M-nUjnQj=Ckvkz+QwhBe0w@mail.gmail.com>
References: <1378312645-27736-1-git-send-email-keescook@chromium.org>
	<1378312645-27736-7-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:53565 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab3IIN2X (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 09:28:23 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so5109567lbi.1
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 06:28:22 -0700 (PDT)
In-Reply-To: <1378312645-27736-7-git-send-email-keescook@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, stable@kernel.org

On Wed, Sep 4, 2013 at 6:37 PM, Kees Cook <keescook@chromium.org> wrote:
> A HID device could send a malicious output report that would cause the
> lenovo-tpkbd HID driver to write just beyond the output report allocation
> during initialization, causing a heap overflow:
>
> [   76.109807] usb 1-1: New USB device found, idVendor=17ef, idProduct=6009
> ...
> [   80.462540] BUG kmalloc-192 (Tainted: G        W   ): Redzone overwritten
>
> CVE-2013-2894
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org
> ---

As mentioned by Josh on the previous thread, this patch triggers a bug
for the users:
https://bugzilla.redhat.com/show_bug.cgi?id=1003998

I am writing the comments I have given the bug:

>  drivers/hid/hid-lenovo-tpkbd.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-lenovo-tpkbd.c b/drivers/hid/hid-lenovo-tpkbd.c
> index 07837f5..f458e76 100644
> --- a/drivers/hid/hid-lenovo-tpkbd.c
> +++ b/drivers/hid/hid-lenovo-tpkbd.c
> @@ -339,7 +339,15 @@ static int tpkbd_probe_tp(struct hid_device *hdev)
>         struct tpkbd_data_pointer *data_pointer;
>         size_t name_sz = strlen(dev_name(dev)) + 16;
>         char *name_mute, *name_micmute;
> -       int ret;
> +       int i, ret;
> +
> +       /* Validate required reports. */
> +       for (i = 0; i < 4; i++) {
> +               if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 4, i, 1))

The report descriptor shows that the report ID 4 is a FEATURE, not an OUTPUT.

> +                       return -ENODEV;

There is a problem in the probe() function when tpkbd_probe_tp()
fails: it directly bails out instead of calling hid_hw_stop(), thus,
the input devices are still there while nobody has a pointer to them.
This way, ODEBUG is triggered. But this should be address in an other
patch I would say.

Cheers,
Benjamin

> +       }
> +       if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 3, 0, 2))
> +               return -ENODEV;
>
>         if (sysfs_create_group(&hdev->dev.kobj,
>                                 &tpkbd_attr_group_pointer)) {
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

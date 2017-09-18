From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] HID: wacom: Always increment hdev refcount within wacom_get_hdev_data
Date: Mon, 18 Sep 2017 14:03:50 -0700
Message-ID: <CAF8JNhJ3YDhg=+CqFUukHZ0Sc=QGpBxaiH7tY0oMjzMWBSy39w@mail.gmail.com>
References: <20170918162742.10717-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35693 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdIRVEM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 18 Sep 2017 17:04:12 -0400
In-Reply-To: <20170918162742.10717-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Aaron Skomra <skomra@gmail.com>, "stable # v4 . 10" <stable@vger.kernel.org>, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, Sep 18, 2017 at 9:27 AM, Jason Gerecke <killertofu@gmail.com> wrote:
> The wacom_get_hdev_data function is used to find and return a reference to
> the "other half" of a Wacom device (i.e., the touch device associated with
> a pen, or vice-versa). To ensure these references are properly accounted
> for, the function is supposed to automatically increment the refcount before
> returning. This was not done, however, for devices which have pen & touch
> on different interfaces of the same USB device. This can lead to a WARNING
> ("refcount_t: underflow; use-after-free") when removing the module or device
> as we call kref_put() more times than kref_get(). Triggering an "actual" use-
> after-free would be difficult since both devices will disappear nearly-
> simultaneously. To silence this warning and prevent the potential error, we
> need to increment the refcount for all cases within wacom_get_hdev_data.
>
> Fixes: 41372d5d40 ("HID: wacom: Augment 'oVid' and 'oPid' with heuristics for HID_GENERIC")
> Cc: <stable@vger.kernel.org> # v4.9+
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Reviewed-by: Ping Cheng <ping.cheng@wacom.com>

Cheers,
Ping

> ---
>  drivers/hid/wacom_sys.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 735bfbbcaa82..906e654fb0ba 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -668,8 +668,10 @@ static struct wacom_hdev_data *wacom_get_hdev_data(struct hid_device *hdev)
>
>         /* Try to find an already-probed interface from the same device */
>         list_for_each_entry(data, &wacom_udev_list, list) {
> -               if (compare_device_paths(hdev, data->dev, '/'))
> +               if (compare_device_paths(hdev, data->dev, '/')) {
> +                       kref_get(&data->kref);
>                         return data;
> +               }
>         }
>
>         /* Fallback to finding devices that appear to be "siblings" */
> --
> 2.14.1
>

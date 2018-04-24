From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: wacom: Release device resource data obtained by devres_alloc()
Date: Tue, 24 Apr 2018 11:04:02 +0200
Message-ID: <CAO-hwJ+cM2nPPiQbHM=u2E0vzvdztR9CFtQD5xztLw8QPOBPbA@mail.gmail.com>
References: <9b8c9c6134cb27ee8ac37224098e382ab9189d62.1524556744.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9b8c9c6134cb27ee8ac37224098e382ab9189d62.1524556744.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, jkosina@suse.cz, lkml <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Apr 24, 2018 at 10:03 AM, Arvind Yadav
<arvind.yadav.cs@gmail.com> wrote:
> Free device resource data, if __wacom_devm_sysfs_create_group
> is not successful.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/wacom_sys.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index b54ef1f..ee7a37e 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1213,8 +1213,10 @@ static int __wacom_devm_sysfs_create_group(struct wacom *wacom,
>         devres->root = root;
>
>         error = sysfs_create_group(devres->root, group);
> -       if (error)
> +       if (error) {
> +               devres_free(devres);
>                 return error;
> +       }
>
>         devres_add(&wacom->hdev->dev, devres);
>
> --
> 1.9.1
>

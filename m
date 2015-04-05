From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 9/16] HID: logitech-hidpp: fix error return code
Date: Sun, 5 Apr 2015 10:38:13 -0400
Message-ID: <CAN+gG=G_=+VGxFuT3hHLDXJE5t-6C8pkk7opO4CheDcBO7LckQ@mail.gmail.com>
References: <1428235596-4757-1-git-send-email-Julia.Lawall@lip6.fr>
	<1428235596-4757-10-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428235596-4757-10-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, kernel-janitors@vger.kernel.org, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Apr 5, 2015 at 8:06 AM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> Return a negative error code on failure.
>
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @@
> identifier ret; expression e1,e2;
> @@
> (
> if (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks!
Benjamin

>  drivers/hid/hid-logitech-hidpp.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index e77658c..ce9819f 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -1210,6 +1210,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         connected = hidpp_is_connected(hidpp);
>         if (id->group != HID_GROUP_LOGITECH_DJ_DEVICE) {
>                 if (!connected) {
> +                       ret = -ENODEV;
>                         hid_err(hdev, "Device not connected");
>                         hid_device_io_stop(hdev);
>                         goto hid_parse_fail;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: uhid: Add UHID_CREATE2 + UHID_INPUT2
Date: Sun, 23 Mar 2014 15:22:37 +0100
Message-ID: <CANq1E4SKtB3+pQas9NVE93yVJAArc=LB1r2ojTgE=33YzRnDiw@mail.gmail.com>
References: <20140319034501.4B61E10081C@puck.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:64947 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbaCWOWh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Mar 2014 10:22:37 -0400
Received: by mail-ie0-f177.google.com with SMTP id rl12so4388576iec.36
        for <linux-input@vger.kernel.org>; Sun, 23 Mar 2014 07:22:37 -0700 (PDT)
In-Reply-To: <20140319034501.4B61E10081C@puck.mtv.corp.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petri Gynther <pgynther@google.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Wed, Mar 19, 2014 at 4:45 AM, Petri Gynther <pgynther@google.com> wrote:
> UHID_CREATE2:
> HID report descriptor data (rd_data) is an array in struct uhid_create2_req,
> instead of a pointer. Enables use from languages that don't support pointers,
> e.g. Python.

..and this also makes the x32-COMPAT crap obsolete.

>
> UHID_INPUT2:
> Data array is the last field of struct uhid_input2_req. Enables userspace to
> write only the required bytes to kernel (ev.type + ev.u.input2.size + the part
> of the data array that matters), instead of the entire struct uhid_input2_req.

We should have swapped these fields right from the beginning. We
explicitly support truncated input, but I only ever tested that with
output, not input.. Thanks for fixing that!

> Signed-off-by: Petri Gynther <pgynther@google.com>
> ---
>  Documentation/hid/uhid.txt | 11 +++++++
>  drivers/hid/uhid.c         | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/uhid.h  | 23 +++++++++++++
>  3 files changed, 114 insertions(+)
>
> diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.txt
> index dc35a2b..ee65936 100644
> --- a/Documentation/hid/uhid.txt
> +++ b/Documentation/hid/uhid.txt
> @@ -93,6 +93,11 @@ the request was handled successfully.
>    event to the kernel. The payload is of type struct uhid_create_req and
>    contains information about your device. You can start I/O now.
>
> +  UHID_CREATE2:
> +  Same as UHID_CREATE, but the HID report descriptor data (rd_data) is an array
> +  inside struct uhid_create2_req, instead of a pointer to a separate array.
> +  Enables use from languages that don't support pointers, e.g. Python.
> +
>    UHID_DESTROY:
>    This destroys the internal HID device. No further I/O will be accepted. There
>    may still be pending messages that you can receive with read() but no further
> @@ -105,6 +110,12 @@ the request was handled successfully.
>    contains a data-payload. This is the raw data that you read from your device.
>    The kernel will parse the HID reports and react on it.
>
> +  UHID_INPUT2:
> +  Same as UHID_INPUT, but the data array is the last field of uhid_input2_req.
> +  Enables userspace to write only the required bytes to kernel (ev.type +
> +  ev.u.input2.size + the part of the data array that matters), instead of
> +  the entire struct uhid_input2_req.
> +
>    UHID_FEATURE_ANSWER:
>    If you receive a UHID_FEATURE request you must answer with this request. You
>    must copy the "id" field from the request into the answer. Set the "err" field
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index cedc6da..c5ee173 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -407,6 +407,69 @@ err_free:
>         return ret;
>  }
>
> +static int uhid_dev_create2(struct uhid_device *uhid,
> +                           const struct uhid_event *ev)
> +{
> +       struct hid_device *hid;
> +       int ret;
> +
> +       if (uhid->running)
> +               return -EALREADY;
> +
> +       uhid->rd_size = ev->u.create2.rd_size;
> +       if (uhid->rd_size <= 0 || uhid->rd_size > HID_MAX_DESCRIPTOR_SIZE)
> +               return -EINVAL;
> +
> +       uhid->rd_data = kmalloc(uhid->rd_size, GFP_KERNEL);
> +       if (!uhid->rd_data)
> +               return -ENOMEM;
> +
> +       memcpy(uhid->rd_data, ev->u.create2.rd_data, uhid->rd_size);

Why don't we just use uhid_dev_create() and do this:

if (ev->type == UHID_CREATE) {
        ...copy_from_user()...
} else if (ev->type == UHID_CREATE2) {
        memcpy(...);
}

This way we can avoid copying this whole function.

> +
> +       hid = hid_allocate_device();
> +       if (IS_ERR(hid)) {
> +               ret = PTR_ERR(hid);
> +               goto err_free;
> +       }
> +
> +       strncpy(hid->name, ev->u.create2.name, 127);
> +       hid->name[127] = 0;
> +       strncpy(hid->phys, ev->u.create2.phys, 63);
> +       hid->phys[63] = 0;
> +       strncpy(hid->uniq, ev->u.create2.uniq, 63);
> +       hid->uniq[63] = 0;
> +
> +       hid->ll_driver = &uhid_hid_driver;
> +       hid->hid_get_raw_report = uhid_hid_get_raw;
> +       hid->hid_output_raw_report = uhid_hid_output_raw;
> +       hid->bus = ev->u.create2.bus;
> +       hid->vendor = ev->u.create2.vendor;
> +       hid->product = ev->u.create2.product;
> +       hid->version = ev->u.create2.version;
> +       hid->country = ev->u.create2.country;
> +       hid->driver_data = uhid;
> +       hid->dev.parent = uhid_misc.this_device;
> +
> +       uhid->hid = hid;
> +       uhid->running = true;
> +
> +       ret = hid_add_device(hid);
> +       if (ret) {
> +               hid_err(hid, "Cannot register HID device\n");
> +               goto err_hid;
> +       }
> +
> +       return 0;
> +
> +err_hid:
> +       hid_destroy_device(hid);
> +       uhid->hid = NULL;
> +       uhid->running = false;
> +err_free:
> +       kfree(uhid->rd_data);
> +       return ret;
> +}
> +
>  static int uhid_dev_destroy(struct uhid_device *uhid)
>  {
>         if (!uhid->running)
> @@ -435,6 +498,17 @@ static int uhid_dev_input(struct uhid_device *uhid, struct uhid_event *ev)
>         return 0;
>  }
>
> +static int uhid_dev_input2(struct uhid_device *uhid, struct uhid_event *ev)
> +{
> +       if (!uhid->running)
> +               return -EINVAL;
> +
> +       hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data,
> +                        min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
> +
> +       return 0;
> +}
> +
>  static int uhid_dev_feature_answer(struct uhid_device *uhid,
>                                    struct uhid_event *ev)
>  {
> @@ -571,12 +645,18 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
>         case UHID_CREATE:
>                 ret = uhid_dev_create(uhid, &uhid->input_buf);
>                 break;
> +       case UHID_CREATE2:
> +               ret = uhid_dev_create2(uhid, &uhid->input_buf);
> +               break;
>         case UHID_DESTROY:
>                 ret = uhid_dev_destroy(uhid);
>                 break;
>         case UHID_INPUT:
>                 ret = uhid_dev_input(uhid, &uhid->input_buf);
>                 break;
> +       case UHID_INPUT2:
> +               ret = uhid_dev_input2(uhid, &uhid->input_buf);
> +               break;
>         case UHID_FEATURE_ANSWER:
>                 ret = uhid_dev_feature_answer(uhid, &uhid->input_buf);
>                 break;
> diff --git a/include/uapi/linux/uhid.h b/include/uapi/linux/uhid.h
> index 414b74b..1e3b09c 100644
> --- a/include/uapi/linux/uhid.h
> +++ b/include/uapi/linux/uhid.h
> @@ -21,6 +21,7 @@
>
>  #include <linux/input.h>
>  #include <linux/types.h>
> +#include <linux/hid.h>
>
>  enum uhid_event_type {
>         UHID_CREATE,
> @@ -34,6 +35,8 @@ enum uhid_event_type {
>         UHID_INPUT,
>         UHID_FEATURE,
>         UHID_FEATURE_ANSWER,
> +       UHID_CREATE2,
> +       UHID_INPUT2,
>  };
>
>  struct uhid_create_req {
> @@ -50,6 +53,19 @@ struct uhid_create_req {
>         __u32 country;
>  } __attribute__((__packed__));
>
> +struct uhid_create2_req {
> +       __u8 name[128];
> +       __u8 phys[64];
> +       __u8 uniq[64];
> +       __u16 rd_size;
> +       __u16 bus;
> +       __u32 vendor;
> +       __u32 product;
> +       __u32 version;
> +       __u32 country;
> +       __u8 rd_data[HID_MAX_DESCRIPTOR_SIZE];
> +} __attribute__((__packed__));
> +
>  #define UHID_DATA_MAX 4096
>
>  enum uhid_report_type {
> @@ -63,6 +79,11 @@ struct uhid_input_req {
>         __u16 size;
>  } __attribute__((__packed__));
>
> +struct uhid_input2_req {
> +       __u16 size;
> +       __u8 data[UHID_DATA_MAX];
> +} __attribute__((__packed__));
> +
>  struct uhid_output_req {
>         __u8 data[UHID_DATA_MAX];
>         __u16 size;
> @@ -100,6 +121,8 @@ struct uhid_event {
>                 struct uhid_output_ev_req output_ev;
>                 struct uhid_feature_req feature;
>                 struct uhid_feature_answer_req feature_answer;
> +               struct uhid_create2_req create2;
> +               struct uhid_input2_req input2;

We change the size of uhid_output_req here, but I think that is fine.
But you might wanna note that down in the commit-message.

Patch looks fine. If you fix the minor issues, this is:
Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

And please always put Jiri on CC for all HID patches: "Jiri Kosina
<jkosina@suse.cz>"

Thanks
David

>         } u;
>  } __attribute__((__packed__));
>
> --
> 1.9.0.279.gdc9e3eb
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

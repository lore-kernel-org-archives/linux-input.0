From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 02/14] HID: uHID: implement .raw_request
Date: Wed, 12 Feb 2014 11:18:35 +0100
Message-ID: <CANq1E4TiQbVspwm9-Ag3Epaq34R+a-s6Mh3E3=5xcprnyMBiaw@mail.gmail.com>
References: <1392055139-19631-1-git-send-email-benjamin.tissoires@redhat.com>
	<1392055139-19631-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392055139-19631-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi

On Mon, Feb 10, 2014 at 6:58 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> uHID is missing a SET_REPORT protocol implementation, but as
> .hid_get_raw_report() as been removed from struct hid_device,
> there were no means to access GET_REPORT in uhid.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/uhid.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index b6de903..60acee4 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -250,6 +250,21 @@ static int uhid_hid_output_report(struct hid_device *hid, __u8 *buf,
>         return uhid_hid_output_raw(hid, buf, count, HID_OUTPUT_REPORT);
>  }
>
> +static int uhid_raw_request(struct hid_device *hid, unsigned char reportnum,
> +                           __u8 *buf, size_t len, unsigned char rtype,
> +                           int reqtype)
> +{
> +       switch (reqtype) {
> +       case HID_REQ_GET_REPORT:
> +               return uhid_hid_get_raw(hid, reportnum, buf, len, rtype);
> +       case HID_REQ_SET_REPORT:
> +               /* TODO: implement proper SET_REPORT functionality */
> +               return -ENOSYS;

Looks good. I will try to implement it today and send a patch.

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David

> +       default:
> +               return -EIO;
> +       }
> +}
> +
>  static struct hid_ll_driver uhid_hid_driver = {
>         .start = uhid_hid_start,
>         .stop = uhid_hid_stop,
> @@ -257,6 +272,7 @@ static struct hid_ll_driver uhid_hid_driver = {
>         .close = uhid_hid_close,
>         .parse = uhid_hid_parse,
>         .output_report = uhid_hid_output_report,
> +       .raw_request = uhid_raw_request,
>  };
>
>  #ifdef CONFIG_COMPAT
> --
> 1.8.3.1
>

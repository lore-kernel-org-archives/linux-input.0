From: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1] HID: cp2112: support large i2c transfers in hid-cp2112
Date: Sat, 20 Jun 2015 23:10:23 +0800
Message-ID: <CAAj6DX0dvoL8RJtEtjE-+SPstLkvRGwgqSfsonDgG_Vgn8dKEQ@mail.gmail.com>
References: <1434587656-2359-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434587656-2359-1-git-send-email-ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: David Barksdale <dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 18, 2015 at 8:34 AM, Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org> wrote:
> cp2112_i2c_xfer() only reads up to 61 bytes, returning EIO
> on longers reads.  The fix is to wrap a loop around
> cp2112_read() to pick up all the returned data.
>
> Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>

Hi Ellen,

with this patch the driver occasionally enters in an infinite loop.
I spent some time to understand the reason.

The sequence for a data read in cp2112_i2c_xfer() is:
1) send report CP2112_DATA_READ_REQUEST (no reply is expected)
2) send report CP2112_TRANSFER_STATUS_REQUEST
3) wait for reply report CP2112_TRANSFER_STATUS_RESPONSE to indicate
i2c read completed
4) send report CP2112_DATA_READ_FORCE_SEND
5) wait for reply report CP2112_DATA_READ_RESPONSE containing the data just read

Your patch repeats step 4) and 5) until all data are received.

Every report CP2112_DATA_READ_RESPONSE can carry max 61 bytes of data.
It is not reported in Silab documentation (or maybe I failed to find
it), but if you send a request CP2112_DATA_READ_FORCE_SEND for _more_
than 61 bytes then cp2112 replies with a sequence of reports
CP2112_DATA_READ_RESPONSE, each report carrying 61 bytes max.

To get only one report as reply, the request in 4) should not exceed 61 bytes!

The current code in cp2112_raw_event() is very simple and can only
handle receiving one data report at a time; it's not designed to
handle a sequence of reports.
If a new incoming report arrives while we are still consuming a
previous report, the new data will overwrite the older one.

If the loop over 4) and 5) is not fast enough (e.g. CPU overloaded,
interrupts) then you get reports overwritten.
Once one report is overwritten, we fail to get the whole data, the
loop will not reach the upper limit and will never exit!

I got this case just adding a hid_info() inside the loop.
If you want, you can check by adding a msleep(100) inside the loop.
Enough to get infinite loop at almost every execution.

Hints in the code below:

> ---
> This is like the previous patch but with the controversial
> part left out.
> ---
>  drivers/hid/hid-cp2112.c |   26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 3318de6..5a72819 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -509,13 +509,25 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>         if (!(msgs->flags & I2C_M_RD))
>                 goto finish;
>
> -       ret = cp2112_read(dev, msgs->buf, msgs->len);
> -       if (ret < 0)
> -               goto power_normal;
> -       if (ret != msgs->len) {
> -               hid_warn(hdev, "short read: %d < %d\n", ret, msgs->len);
> -               ret = -EIO;
> -               goto power_normal;
> +       for (count = 0; count < msgs->len;) {
> +               ret = cp2112_read(dev, msgs->buf + count, msgs->len - count);

Limit the read to 61 bytes with a check like
        if (size > 61)
                size = 61;
        ret = cp2112_read(..., size);
This guarantees we get back only one report at a time.
Instead of the magic number 61, you can use sizeof(dev->read_data).

Or, better, put the check inside cp2112_read(). We are not supposed to
use this function for more than 61 bytes due to current simple
cp2112_raw_event(). Please also comment the change in cp2112_read().
The code in cp2112_read() expects only one report of data. Seams the
proper place to limit the amount of data requested.

> +               if (ret < 0)
> +                       goto power_normal;

If ret == 0 it means we have lost one report and the operation should
be aborted.
I cannot imagine what could cause it (maybe weak USB contacts or line
noise), but for sure this return value is unexpected.
Please generate error for ret == 0 so we never get infinite loop.

Thanks,
Antonio

> +               count += ret;
> +               if (count > msgs->len) {
> +                       /*
> +                        * The hardware returned too much data.
> +                        * This is mostly harmless because cp2112_read()
> +                        * has a limit check so didn't overrun our
> +                        * buffer.  Nevertheless, we return an error
> +                        * because something is seriously wrong and
> +                        * it shouldn't go unnoticed.
> +                        */
> +                       hid_err(hdev, "long read: %d > %zd\n",
> +                               ret, msgs->len - count + ret);
> +                       ret = -EIO;
> +                       goto power_normal;
> +               }
>         }
>
>  finish:
> --
> 1.7.10.4
>

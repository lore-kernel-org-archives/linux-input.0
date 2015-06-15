From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: Re: [PATCH v2] HID: support i2c write-read and large transfers in hid-cp2112
Date: Mon, 15 Jun 2015 17:10:58 +0800
Message-ID: <CAAj6DX0w2p0h_wS2_T2+kU-zLEDo+adCmosPaUHWPVJeEpsaTw@mail.gmail.com>
References: <1434183990-2324-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34369 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbbFOJK7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jun 2015 05:10:59 -0400
In-Reply-To: <1434183990-2324-1-git-send-email-ellen@cumulusnetworks.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>
Cc: David Barksdale <dbarksdale@uplogix.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, linux-i2c@vger.kernel.org

On Sat, Jun 13, 2015 at 4:26 PM, Ellen Wang <ellen@cumulusnetworks.com> wrote:
> cp2112_i2c_xfer() only supports a single i2c_msg and only
> reads up to 61 bytes.  More than one message at a time
> and longers reads just return errors.  This breaks certain
> important cases.  For example, the at24 eeprom driver generates
> paired write and read messages (for eeprom address and data).
> And the reads can be larger than 61 bytes.
>
> Since the device doesn't support i2c repeated starts in general,
> but does support a single write-repeated-start-read pair
> (as CP2112_DATA_WRITE_READ_REQUEST), we recognize the latter
> case and implement only that.
>
> To support large reads, we wrap a loop around cp2112_read()
> to pick up all the returned data.

Hi Ellen,

to keep git log consistent, the subject should change to something like
HID: cp2112: ...

Actually you are adding two features.
I think should be better to split them in two independent patches.

> Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
> ---
> As Antonio Borneo and I discussed previously, this is the updated
> patch that preserves the repeated start semantics (by not incorrectly
> implementing cases that don't work).
>
> Thank you for your time!
> ---
>  drivers/hid/hid-cp2112.c |   79 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 57 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 3318de6..2c10a45 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -444,6 +444,24 @@ static int cp2112_i2c_write_req(void *buf, u8 slave_address, u8 *data,
>         return data_length + 3;
>  }
>
> +static int cp2112_i2c_write_read_req(void *buf, u8 slave_address,
> +                                    u8 *addr, int addr_length,
> +                                    int read_length)
> +{
> +       struct cp2112_write_read_req_report *report = buf;
> +
> +       if (read_length < 1 || read_length > 512 ||
> +           addr_length > sizeof(report->target_address))
> +               return -EINVAL;
> +
> +       report->report = CP2112_DATA_WRITE_READ_REQUEST;
> +       report->slave_address = slave_address << 1;
> +       report->length = cpu_to_be16(read_length);
> +       report->target_address_length = addr_length;
> +       memcpy(report->target_address, addr, addr_length);
> +       return addr_length + 5;
> +}
> +
>  static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>                            int num)
>  {
> @@ -451,26 +469,45 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>         struct hid_device *hdev = dev->hdev;
>         u8 buf[64];
>         ssize_t count;
> +       ssize_t read_length = 0;
> +       u8 *read_buf = NULL;
>         unsigned int retries;
>         int ret;
>
>         hid_dbg(hdev, "I2C %d messages\n", num);
>
> -       if (num != 1) {
> +       if (num == 1) {
> +               if (msgs->flags & I2C_M_RD) {
> +                       hid_dbg(hdev, "I2C read %#04x len %d\n",
> +                               msgs->addr, msgs->len);
> +                       read_length = msgs->len;
> +                       read_buf = msgs->buf;
> +                       count = cp2112_read_req(buf, msgs->addr, msgs->len);
> +               } else {
> +                       hid_dbg(hdev, "I2C write %#04x len %d\n",
> +                               msgs->addr, msgs->len);
> +                       count = cp2112_i2c_write_req(buf, msgs->addr,
> +                                                    msgs->buf, msgs->len);
> +               }
> +               if (count < 0)
> +                       return count;
> +       } else if (num == 2 &&
> +                  msgs[0].addr == msgs[1].addr &&
> +                  !(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD)) {
> +               hid_dbg(hdev, "I2C write-read %#04x wlen %d rlen %d\n",
> +                       msgs[0].addr, msgs[0].len, msgs[1].len);
> +               read_length = msgs[1].len;
> +               read_buf = msgs[1].buf;
> +               count = cp2112_i2c_write_read_req(buf, msgs[0].addr,
> +                               msgs[0].buf, msgs[0].len, msgs[1].len);
> +               if (count < 0)
> +                       return count;
> +       } else {
>                 hid_err(hdev,
>                         "Multi-message I2C transactions not supported\n");
>                 return -EOPNOTSUPP;
>         }
>
> -       if (msgs->flags & I2C_M_RD)
> -               count = cp2112_read_req(buf, msgs->addr, msgs->len);
> -       else
> -               count = cp2112_i2c_write_req(buf, msgs->addr, msgs->buf,
> -                                            msgs->len);
> -
> -       if (count < 0)
> -               return count;
> -
>         ret = hid_hw_power(hdev, PM_HINT_FULLON);
>         if (ret < 0) {
>                 hid_err(hdev, "power management error: %d\n", ret);

The part above goes in a patch for write-read, the part below in
another patch for large transfers.

I have tested you patch and works fine; I can read an I2C eeprom.

But I also check with an oscilloscope the I2C signals and I got
disappointed. There is no repeated START.
I can clearly see cp2112 generating a STOP immediately followed by a START.
Datasheet of cp2112 in figure 8 reports the expected time diagram with
repeated START, but it's not what I get on my HW.
Your code seam ok. Maybe my device is outdated or broken.
The errata document from Silabs does not report anythink relevant.

Can you verify with a scope on your HW too?

Thanks,
Antonio

> @@ -506,21 +543,19 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>                 goto power_normal;
>         }
>
> -       if (!(msgs->flags & I2C_M_RD))
> -               goto finish;
> -
> -       ret = cp2112_read(dev, msgs->buf, msgs->len);
> -       if (ret < 0)
> -               goto power_normal;
> -       if (ret != msgs->len) {
> -               hid_warn(hdev, "short read: %d < %d\n", ret, msgs->len);
> -               ret = -EIO;
> -               goto power_normal;
> +       for (count = 0; count < read_length;) {
> +               ret = cp2112_read(dev, read_buf + count, read_length - count);
> +               if (ret < 0)
> +                       goto power_normal;
> +               count += ret;
> +               if (count > read_length) {
> +                       hid_warn(hdev, "long read: %d > %zd\n",
> +                                ret, read_length - count + ret);
> +               }
>         }
>
> -finish:
>         /* return the number of transferred messages */
> -       ret = 1;
> +       ret = num;
>
>  power_normal:
>         hid_hw_power(hdev, PM_HINT_NORMAL);
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

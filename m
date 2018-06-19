From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input elan_i2c_smbus - Fix more potential stack buffer overflows
Date: Tue, 19 Jun 2018 14:05:14 +0200
Message-ID: <CAO-hwJLVjR2Av5HC1U+gstGM3DOy9z2KvACivuPDF2tgVX02ig@mail.gmail.com>
References: <20180618175117.yj6zxpir6whtvisb@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180618175117.yj6zxpir6whtvisb@xylophone.i.decadent.org.uk>
Sender: stable-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>, =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "3.8+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jun 18, 2018 at 7:56 PM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> Commit 40f7090bb1b4 ("Input: elan_i2c_smbus - fix corrupted stack")
> fixed most of the functions using i2c_smbus_read_block_data() to
> allocate a buffer with the maximum block size.  However three
> functions were left unchanged:
>
> * In elan_smbus_initialize(), increase the buffer size in the same
>   way.
> * In elan_smbus_calibrate_result(), the buffer is provided by the
>   caller (calibrate_store()), so introduce a bounce buffer.  Also
>   name the result buffer size.
> * In elan_smbus_get_report(), the buffer is provided by the caller
>   but happens to be the right length.  Add a compile-time assertion
>   to ensure this remains the case.
>
> Cc: <stable@vger.kernel.org> # 3.19+
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---
> This is compile-tested only.

[adding KT in Cc]

We are currently testing the Lenovo P52, and this patch seems to
behave well. We have other issues with the P52, but unrelated to this
patch.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
> Ben.
>
>  drivers/input/mouse/elan_i2c.h       |  2 ++
>  drivers/input/mouse/elan_i2c_core.c  |  2 +-
>  drivers/input/mouse/elan_i2c_smbus.c | 10 ++++++++--
>  3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/elan_i2c.h
> index 599544c1a91c..243e0fa6e3e3 100644
> --- a/drivers/input/mouse/elan_i2c.h
> +++ b/drivers/input/mouse/elan_i2c.h
> @@ -27,6 +27,8 @@
>  #define ETP_DISABLE_POWER      0x0001
>  #define ETP_PRESSURE_OFFSET    25
>
> +#define ETP_CALIBRATE_MAX_LEN  3
> +
>  /* IAP Firmware handling */
>  #define ETP_PRODUCT_ID_FORMAT_STRING   "%d.0"
>  #define ETP_FW_NAME            "elan_i2c_" ETP_PRODUCT_ID_FORMAT_STRING ".bin"
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 75e757520ef0..d5f74dd7e23b 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -610,7 +610,7 @@ static ssize_t calibrate_store(struct device *dev,
>         int tries = 20;
>         int retval;
>         int error;
> -       u8 val[3];
> +       u8 val[ETP_CALIBRATE_MAX_LEN];
>
>         retval = mutex_lock_interruptible(&data->sysfs_mutex);
>         if (retval)
> diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
> index cfcb32559925..c060d270bc4d 100644
> --- a/drivers/input/mouse/elan_i2c_smbus.c
> +++ b/drivers/input/mouse/elan_i2c_smbus.c
> @@ -56,7 +56,7 @@
>  static int elan_smbus_initialize(struct i2c_client *client)
>  {
>         u8 check[ETP_SMBUS_HELLOPACKET_LEN] = { 0x55, 0x55, 0x55, 0x55, 0x55 };
> -       u8 values[ETP_SMBUS_HELLOPACKET_LEN] = { 0, 0, 0, 0, 0 };
> +       u8 values[I2C_SMBUS_BLOCK_MAX] = {0};
>         int len, error;
>
>         /* Get hello packet */
> @@ -117,12 +117,16 @@ static int elan_smbus_calibrate(struct i2c_client *client)
>  static int elan_smbus_calibrate_result(struct i2c_client *client, u8 *val)
>  {
>         int error;
> +       u8 buf[I2C_SMBUS_BLOCK_MAX] = {0};
> +
> +       BUILD_BUG_ON(ETP_CALIBRATE_MAX_LEN > sizeof(buf));
>
>         error = i2c_smbus_read_block_data(client,
> -                                         ETP_SMBUS_CALIBRATE_QUERY, val);
> +                                         ETP_SMBUS_CALIBRATE_QUERY, buf);
>         if (error < 0)
>                 return error;
>
> +       memcpy(val, buf, ETP_CALIBRATE_MAX_LEN);
>         return 0;
>  }
>
> @@ -472,6 +476,8 @@ static int elan_smbus_get_report(struct i2c_client *client, u8 *report)
>  {
>         int len;
>
> +       BUILD_BUG_ON(I2C_SMBUS_BLOCK_MAX > ETP_SMBUS_REPORT_LEN);
> +
>         len = i2c_smbus_read_block_data(client,
>                                         ETP_SMBUS_PACKET_QUERY,
>                                         &report[ETP_SMBUS_REPORT_OFFSET]);
> --
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom
>

From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH v5] Fix the resolution issue in ChromeOS
Date: Fri, 29 May 2015 08:56:02 +0200
Message-ID: <CAH6sp9Ny3onDBaGEGUUGUMioG4OAiwy5RxantCjEqrYy-Qdcsw@mail.gmail.com>
References: <1432873649-32484-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33021 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbbE2G4E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 May 2015 02:56:04 -0400
In-Reply-To: <1432873649-32484-1-git-send-email-hn.chen@weidahitech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: HungNien Chen <hn.chen@weidahitech.com>
Cc: linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com

Hi,

On Fri, May 29, 2015 at 6:27 AM, HungNien Chen <hn.chen@weidahitech.com> wrote:
> Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>

This seems rather short for adding a new driver. I also just noticed
that your subjects don't quite match up with the actual contents of
the commit. They rather seem to mention the difference between the
current and the previous patch. I would have expected something like:

Subject: [PATCH] input: add a driver for wdt87xx touchscreen controller

Add a driver that reports touch events from, and allows firmware
updates of the wdt87xx.

Signed-off-by: ...

---
list of changes to the patch since previous version(s)

> ---
>  drivers/input/touchscreen/Kconfig       |   12 +
>  drivers/input/touchscreen/Makefile      |    1 +
>  drivers/input/touchscreen/wdt87xx_i2c.c | 1404 +++++++++++++++++++++++++++++++
>  3 files changed, 1417 insertions(+)
>  create mode 100644 drivers/input/touchscreen/wdt87xx_i2c.c
>

Got some further remarks and questions below.

> + * Note: this is a I2C device driver and report touch events througt the
> + *                     input device
> + */

s,report,reports,
s,througt,through,

Wouldn't it be more logical to claim that this is an input device
driver that happens to be using I2C to communicate? Why should we take
note of this?

> +/* the definition for this driver needed */
> +struct wdt87xx_ts_data {
> +       struct i2c_client       *client;
> +       struct input_dev        *input_dev;
> +/* to protect the operation in sysfs */
> +       struct mutex            sysfs_mutex;
> +       u32                     max_retries;
> +       struct sys_param        param;
> +       u8      phys[32];
> +       u32                     packet_type;
> +       u32                     max_x;
> +       u32                     max_y;
> +};
> +
> +/* communacation commands */

s,communacation,communication,


> +
> +/* the definition of command structure */
> +union cmd_data {
> +       struct {
> +       u8      report_id;
> +       u8      type;
> +       u16     index;
> +       u32     length;
> +       } defined_data;
> +       u8      buffer[8];
> +};
> +
> +/* the definition of packet structure */
> +union req_data {
> +       struct {
> +       u8      report_id;
> +       u8      type;
> +       u16     index;
> +       u32     length;
> +       u8      data[PACKET_SIZE];
> +       } defined_data;
> +       u8      buffer[64];
> +};

This now seems to lead to calls with 'magic' numbers

> +               err = wdt87xx_set_feature(client, req_data_set.buffer, 64);

I would expect either (at least):

    wdt87xx_set_feature(client, req_data_set.buffer,
sizeof(req_data_set.buffer));

or no union at all:

    struct req_data {
        u8 report_id;
        u8 type;
        u16 index;
        u32 length;
        u8 data[PACKET_SIZE];
    };
    wdt87xx_set_feature(client, req_data_set, sizeof(req_data_set));

Do these structs need to be packed, by the way?

> +
> +static int wdt87xx_get_checksum(struct i2c_client *client,
> +       u32 *checksum, u32 address, int length)
> +{
> +       int             err;
> +       int             time_delay;
> +       union req_data  req_data_get;
> +       union cmd_data  cmd_data_get;
> +
> +       err = wdt87xx_send_command(client, VND_SET_CHECKSUM_LENGTH, length);
> +       if (err) {
> +               dev_err(&client->dev, "set checksum length fail (%d)\n", err);
> +               return err;
> +       }
> +
> +       err = wdt87xx_send_command(client, VND_SET_CHECKSUM_CALC, address);
> +       if (err) {
> +               dev_err(&client->dev, "calc checksum fail (%d)\n", err);
> +               return err;
> +       }

Documentation/CodingStyle ch. 13 says:

"Printing numbers in parentheses (%d) adds no value and should be avoided."

> +
> +       time_delay = (length + 1023) / 1024;
> +       /* to wait the operation compeletion */

to wait for operation completion
to wait for the operation to complete

> +       msleep(time_delay * 10);

Are these (and other) delay times based on datasheet values?

> +
> +       cmd_data_get.defined_data.report_id = VND_REQ_READ;
> +       cmd_data_get.defined_data.type = VND_GET_CHECKSUM;
> +       cmd_data_get.defined_data.index = 0;
> +       cmd_data_get.defined_data.length = 0;
> +
> +       err = wdt87xx_set_feature(client, cmd_data_get.buffer, 8);
> +       if (err) {
> +               dev_err(&client->dev, "checksum set read fail (%d)\n", err);
> +               return err;
> +       }
> +
> +       memset(req_data_get.buffer, 0, 64);
> +       req_data_get.defined_data.report_id = VND_READ_DATA;
> +       err = wdt87xx_get_feature(client, req_data_get.buffer, 64);
> +       if (err) {
> +               dev_err(&client->dev, "read checksum fail (%d)\n", err);
> +               return err;
> +       }
> +
> +       *checksum = get_unaligned_le16(&req_data_get.buffer[8]);
> +
> +       return err;
> +}
> +
> +static u16 fw_checksum(const u8 *data, u32 length)
> +{
> +       u32     i;
> +       u16     checksum = 0;
> +
> +       checksum = 0x0000;

This assignment seems rather pointless. 'checksum' is already zero by
the looks of it.

> +
> +       for (i = 0; i < length; i++)
> +               checksum = misr(checksum, data[i]);
> +
> +       return checksum;
> +}
> +


> +
> +static ssize_t wdt87xx_update_fw(struct device *dev,
> +       struct device_attribute *attr, const char *buf, size_t count)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
> +       int err;
> +       u8 option = 0;
> +
> +       if (count <= 0)
> +               return -EINVAL;
> +
> +       err = kstrtou8(buf, 0, &option);
> +       if (err)
> +               return err;
> +
> +       dev_info(dev, "update option (%d)\n", option);
> +       if (option < 1 || option > 3)   {
> +               dev_err(&client->dev, "option is not supported\n");
> +               return -1;
> +       }
> +
> +       err = mutex_lock_interruptible(&dev_wdt87xx->sysfs_mutex);
> +       if (err)
> +               return err;
> +
> +       err = wdt87xx_load_fw(dev, WDT87XX_FW_NAME, option);
> +       if (err) {
> +               dev_err(&client->dev, "the firmware update failed(%d)\n",
> +                       err);
> +               count = err;
> +       }
> +
> +       mutex_unlock(&dev_wdt87xx->sysfs_mutex);
> +
> +       return count;
> +}
> +
> +static ssize_t wdt87xx_fw_version(struct device *dev,
> +       struct device_attribute *attr, char *buf)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
> +
> +       return scnprintf(buf, PAGE_SIZE, "%x\n", dev_wdt87xx->param.fw_id);
> +}
> +
> +static ssize_t wdt87xx_plat_id(struct device *dev,
> +       struct device_attribute *attr, char *buf)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
> +
> +       return scnprintf(buf, PAGE_SIZE, "%x\n", dev_wdt87xx->param.plat_id);
> +}
> +
> +static ssize_t wdt87xx_config_csum(struct device *dev,
> +       struct device_attribute *attr, char *buf)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct wdt87xx_ts_data *dev_wdt87xx = i2c_get_clientdata(client);
> +       u32 cfg_csum;
> +
> +       cfg_csum = dev_wdt87xx->param.xmls_id1;
> +       cfg_csum = (cfg_csum << 16) | dev_wdt87xx->param.xmls_id2;
> +
> +       return scnprintf(buf, PAGE_SIZE, "%x\n", cfg_csum);
> +}
> +
> +static DEVICE_ATTR(update_fw, S_IWUSR, NULL, wdt87xx_update_fw);
> +static DEVICE_ATTR(fw_version, S_IRUGO, wdt87xx_fw_version, NULL);
> +static DEVICE_ATTR(plat_id, S_IRUGO, wdt87xx_plat_id, NULL);
> +static DEVICE_ATTR(config_csum, S_IRUGO, wdt87xx_config_csum, NULL);

If you change the function names to

update_fw_store()
fw_version_show()
plat_id_show()
config_csum_show()

you can suffice with using the far more readable

static DEVICE_ATTR_WO(update_fw);
static DEVICE_ATTR_RO(fw_version);
static DEVICE_ATTR_RO(plat_id);
static DEVICE_ATTR_RO(config_csum);

Thanks,
Frans

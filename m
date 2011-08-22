From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 3/4] Input: ad714x - use DMA-safe buffers for spi_write()
Date: Mon, 22 Aug 2011 13:43:52 +0200
Message-ID: <4E5240F8.3050205@analog.com>
References: <1313957345-22608-1-git-send-email-dmitry.torokhov@gmail.com> <1313957345-22608-3-git-send-email-dmitry.torokhov@gmail.com>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:10189
	"EHLO AM1EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751473Ab1HVLn4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Aug 2011 07:43:56 -0400
In-Reply-To: <1313957345-22608-3-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Drivers <Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

On 08/21/2011 10:09 PM, Dmitry Torokhov wrote:
> spi_write() requires use of DMA-safe (cacheline aligned) buffers.
> Also use the same buffers when reading data since to avoid extra
> locking and potential memory allocation in spi_write_then_read().
>
> Signed-off-by: Dmitry Torokhov<dtor@mail.ru>
Looks good - one piece of the original patch set got lost.
See below - patch follows.

Thanks!

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/input/misc/ad714x-i2c.c |   60 ++++++++++++++------------
>   drivers/input/misc/ad714x-spi.c |   51 ++++++++++++++++------
>   drivers/input/misc/ad714x.c     |   90 +++++++++++++--------------------------
>   drivers/input/misc/ad714x.h     |   33 +++++++++++++-
>   4 files changed, 131 insertions(+), 103 deletions(-)
>
> diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
> index 00a6a22..6c61218 100644
> --- a/drivers/input/misc/ad714x-i2c.c
> +++ b/drivers/input/misc/ad714x-i2c.c
> @@ -27,40 +27,46 @@ static int ad714x_i2c_resume(struct device *dev)
>
>   static SIMPLE_DEV_PM_OPS(ad714x_i2c_pm, ad714x_i2c_suspend, ad714x_i2c_resume);
>
> -static int ad714x_i2c_write(struct device *dev, unsigned short reg,
> -                               unsigned short data)
> +static int ad714x_i2c_write(struct ad714x_chip *chip,
> +                           unsigned short reg, unsigned short data)
>   {
> -       struct i2c_client *client = to_i2c_client(dev);
> -       int ret = 0;
> -       unsigned short tx[2] = {
> -               cpu_to_be16(reg),
> -               cpu_to_be16(data)
> -       };
> -
> -       ret = i2c_master_send(client, (u8 *)tx, 4);
> -       if (ret<  0)
> -               dev_err(&client->dev, "I2C write error\n");
> -
> -       return ret;
> +       struct i2c_client *client = to_i2c_client(chip->dev);
> +       int error;
> +
> +       chip->xfer_buf[0] = cpu_to_be16(reg);
> +       chip->xfer_buf[1] = cpu_to_be16(data);
> +
> +       error = i2c_master_send(client, (u8 *)chip->xfer_buf,
> +                               2 * sizeof(*chip->xfer_buf));
> +       if (unlikely(error<  0)) {
> +               dev_err(&client->dev, "I2C write error: %d\n", error);
> +               return error;
> +       }
> +
> +       return 0;
>   }
>
> -static int ad714x_i2c_read(struct device *dev, unsigned short reg,
> -                               unsigned short *data)
> +static int ad714x_i2c_read(struct ad714x_chip *chip,
> +                          unsigned short reg, unsigned short *data)
>   {
> -       struct i2c_client *client = to_i2c_client(dev);
> -       int ret = 0;
> -       unsigned short tx = cpu_to_be16(reg);
> +       struct i2c_client *client = to_i2c_client(chip->dev);
> +       int error;
> +
> +       chip->xfer_buf[0] = cpu_to_be16(reg);
>
> -       ret = i2c_master_send(client, (u8 *)&tx, 2);
> -       if (ret>= 0)
> -               ret = i2c_master_recv(client, (u8 *)data, 2);
> +       error = i2c_master_send(client, (u8 *)chip->xfer_buf,
> +                               sizeof(*chip->xfer_buf));
> +       if (error>= 0)
> +               error = i2c_master_recv(client, (u8 *)chip->xfer_buf,
> +                                       sizeof(*chip->xfer_buf));
>
> -       if (unlikely(ret<  0))
> -               dev_err(&client->dev, "I2C read error\n");
> -       else
> -               *data = be16_to_cpu(*data);
> +       if (unlikely(error<  0)) {
> +               dev_err(&client->dev, "I2C read error: %d\n", error);
> +               return error;
> +       }
>
> -       return ret;
> +       *data = be16_to_cpup(chip->xfer_buf);
> +       return 0;
>   }
>
>   static int __devinit ad714x_i2c_probe(struct i2c_client *client,
> diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
> index 0c7f948..306577d 100644
> --- a/drivers/input/misc/ad714x-spi.c
> +++ b/drivers/input/misc/ad714x-spi.c
> @@ -30,31 +30,54 @@ static int ad714x_spi_resume(struct device *dev)
>
>   static SIMPLE_DEV_PM_OPS(ad714x_spi_pm, ad714x_spi_suspend, ad714x_spi_resume);
>
> -static int ad714x_spi_read(struct device *dev,
> +static int ad714x_spi_read(struct ad714x_chip *chip,
>                             unsigned short reg, unsigned short *data)
>   {
> -       struct spi_device *spi = to_spi_device(dev);
> -       unsigned short tx = cpu_to_be16(AD714x_SPI_CMD_PREFIX |
> +       struct spi_device *spi = to_spi_device(chip->dev);
> +       struct spi_message message;
> +       struct spi_transfer xfer[2];
> +       int error;
> +
> +       spi_message_init(&message);
> +       memset(xfer, 0, sizeof(xfer));
> +
> +       chip->xfer_buf[0] = cpu_to_be16(AD714x_SPI_CMD_PREFIX |
>                                          AD714x_SPI_READ | reg);
> -       int ret;
> +       xfer[0].tx_buf =&chip->xfer_buf[0];
> +       xfer[0].len = sizeof(chip->xfer_buf[0]);
> +       spi_message_add_tail(&xfer[0],&message);
>
> -       ret = spi_write_then_read(spi,&tx, 2, data, 2);
> +       xfer[1].rx_buf =&chip->xfer_buf[1];
> +       xfer[1].len = sizeof(chip->xfer_buf[1]);
> +       spi_message_add_tail(&xfer[1],&message);
>
> -       *data = be16_to_cpup(data);
> +       error = spi_sync(spi,&message);
> +       if (unlikely(error)) {
> +               dev_err(chip->dev, "SPI read error: %d\n", error);
> +               return error;
> +       }
>
> -       return ret;
> +       *data = be16_to_cpu(chip->xfer_buf[1]);
> +       return 0;
>   }
>
> -static int ad714x_spi_write(struct device *dev,
> +static int ad714x_spi_write(struct ad714x_chip *chip,
>                              unsigned short reg, unsigned short data)
>   {
> -       struct spi_device *spi = to_spi_device(dev);
> -       unsigned short tx[2] = {
> -               cpu_to_be16(AD714x_SPI_CMD_PREFIX | reg),
> -               cpu_to_be16(data)
> -       };
> +       struct spi_device *spi = to_spi_device(chip->dev);
> +       int error;
>
> -       return spi_write(spi, (u8 *)tx, 4);
> +       chip->xfer_buf[0] = cpu_to_be16(AD714x_SPI_CMD_PREFIX | reg);
> +       chip->xfer_buf[1] = cpu_to_be16(data);
> +
> +       error = spi_write(spi, (u8 *)chip->xfer_buf,
> +                         2 * sizeof(*chip->xfer_buf));
> +       if (unlikely(error)) {
> +               dev_err(chip->dev, "SPI write error: %d\n", error);
> +               return error;
> +       }
> +
> +       return 0;
>   }
>
>   static int __devinit ad714x_spi_probe(struct spi_device *spi)
> diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
> index c3a62c4..2be0366 100644
> --- a/drivers/input/misc/ad714x.c
> +++ b/drivers/input/misc/ad714x.c
> @@ -59,7 +59,6 @@
>   #define STAGE11_AMBIENT                0x27D
>
>   #define PER_STAGE_REG_NUM      36
> -#define STAGE_NUM              12
>   #define STAGE_CFGREG_NUM       8
>   #define SYS_CFGREG_NUM         8
>
> @@ -124,28 +123,6 @@ struct ad714x_driver_data {
>    * information to integrate all things which will be private data
>    * of spi/i2c device
>    */
> -struct ad714x_chip {
> -       unsigned short h_state;
> -       unsigned short l_state;
> -       unsigned short c_state;
> -       unsigned short adc_reg[STAGE_NUM];
> -       unsigned short amb_reg[STAGE_NUM];
> -       unsigned short sensor_val[STAGE_NUM];
> -
> -       struct ad714x_platform_data *hw;
> -       struct ad714x_driver_data *sw;
> -
> -       int irq;
> -       struct device *dev;
> -       ad714x_read_t read;
> -       ad714x_write_t write;
> -
> -       struct mutex mutex;
> -
> -       unsigned product;
> -       unsigned version;
> -};
> -
>   static void ad714x_use_com_int(struct ad714x_chip *ad714x,
>                                  int start_stage, int end_stage)
>   {
> @@ -154,13 +131,13 @@ static void ad714x_use_com_int(struct ad714x_chip *ad714x,
>
>          mask = ((1<<  (end_stage + 1)) - 1) - ((1<<  start_stage) - 1);
>
> -       ad714x->read(ad714x->dev, STG_COM_INT_EN_REG,&data);
> +       ad714x->read(ad714x, STG_COM_INT_EN_REG,&data);
>          data |= 1<<  end_stage;
> -       ad714x->write(ad714x->dev, STG_COM_INT_EN_REG, data);
> +       ad714x->write(ad714x, STG_COM_INT_EN_REG, data);
>
> -       ad714x->read(ad714x->dev, STG_HIGH_INT_EN_REG,&data);
> +       ad714x->read(ad714x, STG_HIGH_INT_EN_REG,&data);
>          data&= ~mask;
> -       ad714x->write(ad714x->dev, STG_HIGH_INT_EN_REG, data);
> +       ad714x->write(ad714x, STG_HIGH_INT_EN_REG, data);
>   }
>
>   static void ad714x_use_thr_int(struct ad714x_chip *ad714x,
> @@ -171,13 +148,13 @@ static void ad714x_use_thr_int(struct ad714x_chip *ad714x,
>
>          mask = ((1<<  (end_stage + 1)) - 1) - ((1<<  start_stage) - 1);
>
> -       ad714x->read(ad714x->dev, STG_COM_INT_EN_REG,&data);
> +       ad714x->read(ad714x, STG_COM_INT_EN_REG,&data);
>          data&= ~(1<<  end_stage);
> -       ad714x->write(ad714x->dev, STG_COM_INT_EN_REG, data);
> +       ad714x->write(ad714x, STG_COM_INT_EN_REG, data);
>
> -       ad714x->read(ad714x->dev, STG_HIGH_INT_EN_REG,&data);
> +       ad714x->read(ad714x, STG_HIGH_INT_EN_REG,&data);
>          data |= mask;
> -       ad714x->write(ad714x->dev, STG_HIGH_INT_EN_REG, data);
> +       ad714x->write(ad714x, STG_HIGH_INT_EN_REG, data);
>   }
>
>   static int ad714x_cal_highest_stage(struct ad714x_chip *ad714x,
> @@ -274,10 +251,8 @@ static void ad714x_slider_cal_sensor_val(struct ad714x_chip *ad714x, int idx)
>          int i;
>
>          for (i = hw->start_stage; i<= hw->end_stage; i++) {
> -               ad714x->read(ad714x->dev, CDC_RESULT_S0 + i,
> -&ad714x->adc_reg[i]);
> -               ad714x->read(ad714x->dev,
> -                               STAGE0_AMBIENT + i * PER_STAGE_REG_NUM,
> +               ad714x->read(ad714x, CDC_RESULT_S0 + i,&ad714x->adc_reg[i]);
> +               ad714x->read(ad714x, STAGE0_AMBIENT + i * PER_STAGE_REG_NUM,
>                                  &ad714x->amb_reg[i]);
>
>                  ad714x->sensor_val[i] = abs(ad714x->adc_reg[i] -
> @@ -445,10 +420,8 @@ static void ad714x_wheel_cal_sensor_val(struct ad714x_chip *ad714x, int idx)
>          int i;
>
>          for (i = hw->start_stage; i<= hw->end_stage; i++) {
> -               ad714x->read(ad714x->dev, CDC_RESULT_S0 + i,
> -&ad714x->adc_reg[i]);
> -               ad714x->read(ad714x->dev,
> -                               STAGE0_AMBIENT + i * PER_STAGE_REG_NUM,
> +               ad714x->read(ad714x, CDC_RESULT_S0 + i,&ad714x->adc_reg[i]);
> +               ad714x->read(ad714x, STAGE0_AMBIENT + i * PER_STAGE_REG_NUM,
>                                  &ad714x->amb_reg[i]);
>                  if (ad714x->adc_reg[i]>  ad714x->amb_reg[i])
>                          ad714x->sensor_val[i] = ad714x->adc_reg[i] -
> @@ -598,10 +571,8 @@ static void touchpad_cal_sensor_val(struct ad714x_chip *ad714x, int idx)
>          int i;
>
>          for (i = hw->x_start_stage; i<= hw->x_end_stage; i++) {
> -               ad714x->read(ad714x->dev, CDC_RESULT_S0 + i,
> -&ad714x->adc_reg[i]);
> -               ad714x->read(ad714x->dev,
> -                               STAGE0_AMBIENT + i * PER_STAGE_REG_NUM,
> +               ad714x->read(ad714x, CDC_RESULT_S0 + i,&ad714x->adc_reg[i]);
> +               ad714x->read(ad714x, STAGE0_AMBIENT + i * PER_STAGE_REG_NUM,
>                                  &ad714x->amb_reg[i]);
>                  if (ad714x->adc_reg[i]>  ad714x->amb_reg[i])
>                          ad714x->sensor_val[i] = ad714x->adc_reg[i] -
> @@ -891,7 +862,7 @@ static int ad714x_hw_detect(struct ad714x_chip *ad714x)
>   {
>          unsigned short data;
>
> -       ad714x->read(ad714x->dev, AD714X_PARTID_REG,&data);
> +       ad714x->read(ad714x, AD714X_PARTID_REG,&data);
>          switch (data&  0xFFF0) {
>          case AD7142_PARTID:
>                  ad714x->product = 0x7142;
> @@ -940,23 +911,22 @@ static void ad714x_hw_init(struct ad714x_chip *ad714x)
>          for (i = 0; i<  STAGE_NUM; i++) {
>                  reg_base = AD714X_STAGECFG_REG + i * STAGE_CFGREG_NUM;
>                  for (j = 0; j<  STAGE_CFGREG_NUM; j++)
> -                       ad714x->write(ad714x->dev, reg_base + j,
> +                       ad714x->write(ad714x, reg_base + j,
>                                          ad714x->hw->stage_cfg_reg[i][j]);
>          }
>
>          for (i = 0; i<  SYS_CFGREG_NUM; i++)
> -               ad714x->write(ad714x->dev, AD714X_SYSCFG_REG + i,
> +               ad714x->write(ad714x, AD714X_SYSCFG_REG + i,
>                          ad714x->hw->sys_cfg_reg[i]);
>          for (i = 0; i<  SYS_CFGREG_NUM; i++)
> -               ad714x->read(ad714x->dev, AD714X_SYSCFG_REG + i,
> -&data);
> +               ad714x->read(ad714x, AD714X_SYSCFG_REG + i,&data);
>
> -       ad714x->write(ad714x->dev, AD714X_STG_CAL_EN_REG, 0xFFF);
> +       ad714x->write(ad714x, AD714X_STG_CAL_EN_REG, 0xFFF);
>
>          /* clear all interrupts */
> -       ad714x->read(ad714x->dev, STG_LOW_INT_STA_REG,&data);
> -       ad714x->read(ad714x->dev, STG_HIGH_INT_STA_REG,&data);
> -       ad714x->read(ad714x->dev, STG_COM_INT_STA_REG,&data);
> +       ad714x->read(ad714x, STG_LOW_INT_STA_REG,&data);
> +       ad714x->read(ad714x, STG_HIGH_INT_STA_REG,&data);
> +       ad714x->read(ad714x, STG_COM_INT_STA_REG,&data);
>   }
>
>   static irqreturn_t ad714x_interrupt_thread(int irq, void *data)
> @@ -966,9 +936,9 @@ static irqreturn_t ad714x_interrupt_thread(int irq, void *data)
>
>          mutex_lock(&ad714x->mutex);
>
> -       ad714x->read(ad714x->dev, STG_LOW_INT_STA_REG,&ad714x->l_state);
> -       ad714x->read(ad714x->dev, STG_HIGH_INT_STA_REG,&ad714x->h_state);
> -       ad714x->read(ad714x->dev, STG_COM_INT_STA_REG,&ad714x->c_state);
> +       ad714x->read(ad714x, STG_LOW_INT_STA_REG,&ad714x->l_state);
> +       ad714x->read(ad714x, STG_HIGH_INT_STA_REG,&ad714x->h_state);
> +       ad714x->read(ad714x, STG_COM_INT_STA_REG,&ad714x->c_state);
>
>          for (i = 0; i<  ad714x->hw->button_num; i++)
>                  ad714x_button_state_machine(ad714x, i);
> @@ -1245,7 +1215,7 @@ int ad714x_disable(struct ad714x_chip *ad714x)
>          mutex_lock(&ad714x->mutex);
>
>          data = ad714x->hw->sys_cfg_reg[AD714X_PWR_CTRL] | 0x3;
> -       ad714x->write(ad714x->dev, AD714X_PWR_CTRL, data);
> +       ad714x->write(ad714x, AD714X_PWR_CTRL, data);
>
>          mutex_unlock(&ad714x->mutex);
>
> @@ -1263,16 +1233,16 @@ int ad714x_enable(struct ad714x_chip *ad714x)
>
>          /* resume to non-shutdown mode */
>
> -       ad714x->write(ad714x->dev, AD714X_PWR_CTRL,
> +       ad714x->write(ad714x, AD714X_PWR_CTRL,
>                          ad714x->hw->sys_cfg_reg[AD714X_PWR_CTRL]);
>
>          /* make sure the interrupt output line is not low level after resume,
>           * otherwise we will get no chance to enter falling-edge irq again
>           */
>
> -       ad714x->read(ad714x->dev, STG_LOW_INT_STA_REG,&data);
> -       ad714x->read(ad714x->dev, STG_HIGH_INT_STA_REG,&data);
> -       ad714x->read(ad714x->dev, STG_COM_INT_STA_REG,&data);
> +       ad714x->read(ad714x, STG_LOW_INT_STA_REG,&data);
> +       ad714x->read(ad714x, STG_HIGH_INT_STA_REG,&data);
> +       ad714x->read(ad714x, STG_COM_INT_STA_REG,&data);
>
>          mutex_unlock(&ad714x->mutex);
>
> diff --git a/drivers/input/misc/ad714x.h b/drivers/input/misc/ad714x.h
> index 45c54fb..d12d149 100644
> --- a/drivers/input/misc/ad714x.h
> +++ b/drivers/input/misc/ad714x.h
> @@ -11,11 +11,40 @@
>
>   #include<linux/types.h>
>
> +#define STAGE_NUM              12
> +
>   struct device;
> +struct ad714x_platform_data;
> +struct ad714x_driver_data;
>   struct ad714x_chip;
>
> -typedef int (*ad714x_read_t)(struct device *, unsigned short, unsigned short *);
> -typedef int (*ad714x_write_t)(struct device *, unsigned short, unsigned short);
> +typedef int (*ad714x_read_t)(struct ad714x_chip *, unsigned short, unsigned short *);
> +typedef int (*ad714x_write_t)(struct ad714x_chip *, unsigned short, unsigned short);
> +
> +struct ad714x_chip {
> +       unsigned short h_state;
> +       unsigned short l_state;
Since we read status interrupt registers in row, we also need to place the
storage members sequentially. This part got dropped from the original 
patch set.
Patch follows.


> +       unsigned short c_state;
> +       unsigned short adc_reg[STAGE_NUM];
> +       unsigned short amb_reg[STAGE_NUM];
> +       unsigned short sensor_val[STAGE_NUM];
> +
> +       struct ad714x_platform_data *hw;
> +       struct ad714x_driver_data *sw;
> +
> +       int irq;
> +       struct device *dev;
> +       ad714x_read_t read;
> +       ad714x_write_t write;
> +
> +       struct mutex mutex;
> +
> +       unsigned product;
> +       unsigned version;
> +
> +       __be16 xfer_buf[16] ____cacheline_aligned;
> +
> +};
>
>   int ad714x_disable(struct ad714x_chip *ad714x);
>   int ad714x_enable(struct ad714x_chip *ad714x);
> --
> 1.7.6
>
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif



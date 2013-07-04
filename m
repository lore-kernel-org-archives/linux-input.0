From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] Input: cyttsp4 - use 16bit address for I2C/SPI communication
Date: Thu, 4 Jul 2013 14:25:36 +0200
Message-ID: <CABxcv=nNQT2EyA5t+V72iLt1YO-e3E1MJzp7RE49w6PqT7g0Lg@mail.gmail.com>
References: <20130703135248.GV5714@mwanda>
	<1372883780-29851-1-git-send-email-fery@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38644 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab3GDMZh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Jul 2013 08:25:37 -0400
Received: by mail-wi0-f174.google.com with SMTP id k10so6264272wiv.13
        for <linux-input@vger.kernel.org>; Thu, 04 Jul 2013 05:25:36 -0700 (PDT)
In-Reply-To: <1372883780-29851-1-git-send-email-fery@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferruh Yigit <fery@cypress.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, ttdrivers@cypress.com, linux-input@vger.kernel.org

On Wed, Jul 3, 2013 at 10:36 PM, Ferruh Yigit <fery@cypress.com> wrote:
> In TSG4, register map is 512bytes long and to access all of it,
> one bit from address byte is used (which bit to use differs for
> I2C and SPI);
>
> Since common code used for TSG3 and TSG4 for I2C, this parameter
> wrongly used as u8. TSG3 does not access beyond 255 bytes
> but TSG4 may.
>
> Signed-off-by: Ferruh Yigit <fery@cypress.com>
> Tested-on: TMA3XX DVB && TMA4XX DVB
> ---
>  drivers/input/touchscreen/cyttsp4_core.h      |   12 +++++-----
>  drivers/input/touchscreen/cyttsp4_spi.c       |   20 ++++++++---------
>  drivers/input/touchscreen/cyttsp_core.h       |    8 +++----
>  drivers/input/touchscreen/cyttsp_i2c_common.c |   30 ++++++++++++++++++-------
>  drivers/input/touchscreen/cyttsp_spi.c        |    6 ++---
>  5 files changed, 44 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/input/touchscreen/cyttsp4_core.h b/drivers/input/touchscreen/cyttsp4_core.h
> index 86a2543..8e0d4d4 100644
> --- a/drivers/input/touchscreen/cyttsp4_core.h
> +++ b/drivers/input/touchscreen/cyttsp4_core.h
> @@ -369,9 +369,9 @@ struct cyttsp4 {
>
>  struct cyttsp4_bus_ops {
>         u16 bustype;
> -       int (*write)(struct device *dev, u8 *xfer_buf, u8 addr, u8 length,
> +       int (*write)(struct device *dev, u8 *xfer_buf, u16 addr, u8 length,
>                         const void *values);
> -       int (*read)(struct device *dev, u8 *xfer_buf, u8 addr, u8 length,
> +       int (*read)(struct device *dev, u8 *xfer_buf, u16 addr, u8 length,
>                         void *values);
>  };
>
> @@ -448,13 +448,13 @@ enum cyttsp4_event_id {
>  /* y-axis, 0:origin is on top side of panel, 1: bottom */
>  #define CY_PCFG_ORIGIN_Y_MASK          0x80
>
> -static inline int cyttsp4_adap_read(struct cyttsp4 *ts, u8 addr, int size,
> +static inline int cyttsp4_adap_read(struct cyttsp4 *ts, u16 addr, int size,
>                 void *buf)
>  {
>         return ts->bus_ops->read(ts->dev, ts->xfer_buf, addr, size, buf);
>  }
>
> -static inline int cyttsp4_adap_write(struct cyttsp4 *ts, u8 addr, int size,
> +static inline int cyttsp4_adap_write(struct cyttsp4 *ts, u16 addr, int size,
>                 const void *buf)
>  {
>         return ts->bus_ops->write(ts->dev, ts->xfer_buf, addr, size, buf);
> @@ -463,9 +463,9 @@ static inline int cyttsp4_adap_write(struct cyttsp4 *ts, u8 addr, int size,
>  extern struct cyttsp4 *cyttsp4_probe(const struct cyttsp4_bus_ops *ops,
>                 struct device *dev, u16 irq, size_t xfer_buf_size);
>  extern int cyttsp4_remove(struct cyttsp4 *ts);
> -int cyttsp_i2c_write_block_data(struct device *dev, u8 *xfer_buf, u8 addr,
> +int cyttsp_i2c_write_block_data(struct device *dev, u8 *xfer_buf, u16 addr,
>                 u8 length, const void *values);
> -int cyttsp_i2c_read_block_data(struct device *dev, u8 *xfer_buf, u8 addr,
> +int cyttsp_i2c_read_block_data(struct device *dev, u8 *xfer_buf, u16 addr,
>                 u8 length, void *values);
>  extern const struct dev_pm_ops cyttsp4_pm_ops;
>
> diff --git a/drivers/input/touchscreen/cyttsp4_spi.c b/drivers/input/touchscreen/cyttsp4_spi.c
> index f8f891b..a71e114 100644
> --- a/drivers/input/touchscreen/cyttsp4_spi.c
> +++ b/drivers/input/touchscreen/cyttsp4_spi.c
> @@ -44,7 +44,7 @@
>  #define CY_SPI_DATA_BUF_SIZE   (CY_SPI_CMD_BYTES + CY_SPI_DATA_SIZE)
>
>  static int cyttsp_spi_xfer(struct device *dev, u8 *xfer_buf,
> -                          u8 op, u8 reg, u8 *buf, int length)
> +                          u8 op, u16 reg, u8 *buf, int length)
>  {
>         struct spi_device *spi = to_spi_device(dev);
>         struct spi_message msg;
> @@ -63,14 +63,12 @@ static int cyttsp_spi_xfer(struct device *dev, u8 *xfer_buf,
>         memset(wr_buf, 0, CY_SPI_DATA_BUF_SIZE);
>         memset(rd_buf, 0, CY_SPI_CMD_BYTES);
>
> -       if (reg > 255)
> -               wr_buf[0] = op + CY_SPI_A8_BIT;
> -       else
> -               wr_buf[0] = op;
> -       if (op == CY_SPI_WR_OP)
> -               wr_buf[1] = reg % 256;
> -       if (op == CY_SPI_WR_OP && length > 0)
> -               memcpy(wr_buf + CY_SPI_CMD_BYTES, buf, length);
> +       wr_buf[0] = op + (((reg >> 8) & 0x1) ? CY_SPI_A8_BIT : 0);
> +       if (op == CY_SPI_WR_OP) {
> +               wr_buf[1] = reg & 0xFF;
> +               if (length > 0)
> +                       memcpy(wr_buf + CY_SPI_CMD_BYTES, buf, length);
> +       }
>
>         memset(xfer, 0, sizeof(xfer));
>         spi_message_init(&msg);
> @@ -130,7 +128,7 @@ static int cyttsp_spi_xfer(struct device *dev, u8 *xfer_buf,
>  }
>
>  static int cyttsp_spi_read_block_data(struct device *dev, u8 *xfer_buf,
> -                                     u8 addr, u8 length, void *data)
> +                                     u16 addr, u8 length, void *data)
>  {
>         int rc;
>
> @@ -143,7 +141,7 @@ static int cyttsp_spi_read_block_data(struct device *dev, u8 *xfer_buf,
>  }
>
>  static int cyttsp_spi_write_block_data(struct device *dev, u8 *xfer_buf,
> -                                      u8 addr, u8 length, const void *data)
> +                                      u16 addr, u8 length, const void *data)
>  {
>         return cyttsp_spi_xfer(dev, xfer_buf, CY_SPI_WR_OP, addr, (void *)data,
>                         length);
> diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
> index 0cf564a..0707411 100644
> --- a/drivers/input/touchscreen/cyttsp_core.h
> +++ b/drivers/input/touchscreen/cyttsp_core.h
> @@ -112,9 +112,9 @@ struct cyttsp;
>
>  struct cyttsp_bus_ops {
>         u16 bustype;
> -       int (*write)(struct device *dev, u8 *xfer_buf, u8 addr, u8 length,
> +       int (*write)(struct device *dev, u8 *xfer_buf, u16 addr, u8 length,
>                         const void *values);
> -       int (*read)(struct device *dev, u8 *xfer_buf, u8 addr, u8 length,
> +       int (*read)(struct device *dev, u8 *xfer_buf, u16 addr, u8 length,
>                         void *values);
>  };
>
> @@ -145,9 +145,9 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
>                             struct device *dev, int irq, size_t xfer_buf_size);
>  void cyttsp_remove(struct cyttsp *ts);
>
> -int cyttsp_i2c_write_block_data(struct device *dev, u8 *xfer_buf, u8 addr,
> +int cyttsp_i2c_write_block_data(struct device *dev, u8 *xfer_buf, u16 addr,
>                 u8 length, const void *values);
> -int cyttsp_i2c_read_block_data(struct device *dev, u8 *xfer_buf, u8 addr,
> +int cyttsp_i2c_read_block_data(struct device *dev, u8 *xfer_buf, u16 addr,
>                 u8 length, void *values);
>  extern const struct dev_pm_ops cyttsp_pm_ops;
>
> diff --git a/drivers/input/touchscreen/cyttsp_i2c_common.c b/drivers/input/touchscreen/cyttsp_i2c_common.c
> index 07c553f..1d7b6f1 100644
> --- a/drivers/input/touchscreen/cyttsp_i2c_common.c
> +++ b/drivers/input/touchscreen/cyttsp_i2c_common.c
> @@ -32,18 +32,20 @@
>  #include <linux/types.h>
>
>  int cyttsp_i2c_read_block_data(struct device *dev, u8 *xfer_buf,
> -                                     u8 addr, u8 length, void *values)
> +                                     u16 addr, u8 length, void *values)
>  {
>         struct i2c_client *client = to_i2c_client(dev);
> +       u8 client_addr = client->addr | ((addr >> 8) & 0x1);
> +       u8 addr_lo = addr & 0xFF;
>         struct i2c_msg msgs[] = {
>                 {
> -                       .addr = client->addr,
> +                       .addr = client_addr,
>                         .flags = 0,
>                         .len = 1,
> -                       .buf = &addr,
> +                       .buf = &addr_lo,
>                 },
>                 {
> -                       .addr = client->addr,
> +                       .addr = client_addr,
>                         .flags = I2C_M_RD,
>                         .len = length,
>                         .buf = values,
> @@ -60,17 +62,29 @@ int cyttsp_i2c_read_block_data(struct device *dev, u8 *xfer_buf,
>  EXPORT_SYMBOL_GPL(cyttsp_i2c_read_block_data);
>
>  int cyttsp_i2c_write_block_data(struct device *dev, u8 *xfer_buf,
> -                                      u8 addr, u8 length, const void *values)
> +                                      u16 addr, u8 length, const void *values)
>  {
>         struct i2c_client *client = to_i2c_client(dev);
> +       u8 client_addr = client->addr | ((addr >> 8) & 0x1);
> +       u8 addr_lo = addr & 0xFF;
> +       struct i2c_msg msgs[] = {
> +               {
> +                       .addr = client_addr,
> +                       .flags = 0,
> +                       .len = length + 1,
> +                       .buf = xfer_buf,
> +               },
> +       };
>         int retval;
>
> -       xfer_buf[0] = addr;
> +       xfer_buf[0] = addr_lo;
>         memcpy(&xfer_buf[1], values, length);
>
> -       retval = i2c_master_send(client, xfer_buf, length + 1);
> +       retval = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +       if (retval < 0)
> +               return retval;
>
> -       return retval < 0 ? retval : 0;
> +       return retval != ARRAY_SIZE(msgs) ? -EIO : 0;
>  }
>  EXPORT_SYMBOL_GPL(cyttsp_i2c_write_block_data);
>
> diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
> index 1df6253..4728bcb 100644
> --- a/drivers/input/touchscreen/cyttsp_spi.c
> +++ b/drivers/input/touchscreen/cyttsp_spi.c
> @@ -41,7 +41,7 @@
>  #define CY_SPI_BITS_PER_WORD   8
>
>  static int cyttsp_spi_xfer(struct device *dev, u8 *xfer_buf,
> -                          u8 op, u8 reg, u8 *buf, int length)
> +                          u8 op, u16 reg, u8 *buf, int length)
>  {
>         struct spi_device *spi = to_spi_device(dev);
>         struct spi_message msg;
> @@ -126,14 +126,14 @@ static int cyttsp_spi_xfer(struct device *dev, u8 *xfer_buf,
>  }
>
>  static int cyttsp_spi_read_block_data(struct device *dev, u8 *xfer_buf,
> -                                     u8 addr, u8 length, void *data)
> +                                     u16 addr, u8 length, void *data)
>  {
>         return cyttsp_spi_xfer(dev, xfer_buf, CY_SPI_RD_OP, addr, data,
>                         length);
>  }
>
>  static int cyttsp_spi_write_block_data(struct device *dev, u8 *xfer_buf,
> -                                      u8 addr, u8 length, const void *data)
> +                                      u16 addr, u8 length, const void *data)
>  {
>         return cyttsp_spi_xfer(dev, xfer_buf, CY_SPI_WR_OP, addr, (void *)data,
>                         length);
> --
> 1.7.9.5
>

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

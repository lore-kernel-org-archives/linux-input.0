From: =?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?= <gcembed@gmail.com>
Subject: Re: Information about Atmel MXT224
Date: Wed, 08 Jan 2014 12:24:59 +0100
Message-ID: <52CD358B.50704@gmail.com>
References: <52CD04F1.8090100@gmail.com> <1389171897.588258801@f329.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:43205 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbaAHLZP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jan 2014 06:25:15 -0500
Received: by mail-ee0-f49.google.com with SMTP id c41so604296eek.36
        for <linux-input@vger.kernel.org>; Wed, 08 Jan 2014 03:25:13 -0800 (PST)
In-Reply-To: <1389171897.588258801@f329.i.mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Joonyoung Shim <jy0922.shim@samsung.com>

Hi,

On 01/08/2014 10:04 AM, Alexander Shiyan wrote:
 > Do not forget about setup IOMUX for IRQ pin?

I don't think so. I follow the same canvas than PMIC_INT. I send my=20
email too fast. The init function was incomplete. Below all I do with=20
MXT_KEY (PB16) connected to /CHG pin of MXT224.
(Of course, PB16 (CSI_PIXCLK) is not used by another driver)
The problem is not interrupt in Kernel. It is MXT224 that does not send=
=20
it. /CHG pin stay High.

I can send you all source code of board declaration if you want.

Thanks a lot.
Ga=C3=ABtan Carlier.

8---------------------------------------------------------
#define MXT_KEY                 IMX_GPIO_NR(2, 16)
static const int imx27gc_pins[] __initconst =3D {
	/* UART1 */
	PE12_PF_UART1_TXD,
	PE13_PF_UART1_RXD,
	PE14_PF_UART1_CTS,
	PE15_PF_UART1_RTS,
	/* UART3 */
	PE8_PF_UART3_TXD,
	PE9_PF_UART3_RXD,
	PE10_PF_UART3_CTS,
	PE11_PF_UART3_RTS,
	/* FEC */
	PD0_AIN_FEC_TXD0,
	PD1_AIN_FEC_TXD1,
	PD2_AIN_FEC_TXD2,
	PD3_AIN_FEC_TXD3,
	PD4_AOUT_FEC_RX_ER,
	PD5_AOUT_FEC_RXD1,
	PD6_AOUT_FEC_RXD2,
	PD7_AOUT_FEC_RXD3,
	PD8_AF_FEC_MDIO,
	PD9_AIN_FEC_MDC,
	PD10_AOUT_FEC_CRS,
	PD11_AOUT_FEC_TX_CLK,
	PD12_AOUT_FEC_RXD0,
	PD13_AOUT_FEC_RX_DV,
	PD14_AOUT_FEC_RX_CLK,
	PD15_AOUT_FEC_COL,
	PD16_AIN_FEC_TX_ER,
	PF23_AIN_FEC_TX_EN,
	/* CSPI2 */
	PD22_PF_CSPI2_SCLK,
	PD23_PF_CSPI2_MISO,
	PD24_PF_CSPI2_MOSI,
	SPI2_SS0 | GPIO_GPIO | GPIO_OUT,
	/* I2C1 */
	PD17_PF_I2C_DATA,
	PD18_PF_I2C_CLK,
	/* I2C2 */
	PC5_PF_I2C2_SDA,
	PC6_PF_I2C2_SCL,
	/* PMIC INT */
	PMIC_INT | GPIO_GPIO | GPIO_IN,
	/* SLCD */
	PA6_AIN_SLCDC_DAT0,
	PA7_AIN_SLCDC_DAT1,
	PA8_AIN_SLCDC_DAT2,
	PA9_AIN_SLCDC_DAT3,
	PA10_AIN_SLCDC_DAT4,
	PA11_AIN_SLCDC_DAT5,
	PA12_AIN_SLCDC_DAT6,
	PA13_AIN_SLCDC_DAT7,
	PA25_AIN_SLCDC_CLS, /* D/C */
	PA26_AIN_SLCDC_CS,
	PA27_AIN_SLCDC_CLK, /* E/RD */
	SLCDC_RESET | GPIO_GPIO | GPIO_OUT,
	SLCDC_BL_POWER | GPIO_GPIO | GPIO_OUT,
	SLCDC_RW | GPIO_GPIO | GPIO_OUT, /* only for manual reading operation =
*/
	/* MXT */
	MXT_KEY | GPIO_GPIO | GPIO_IN, /* Key */
	/* SSI4 */
	PC16_PF_SSI4_FS,
	PC17_PF_SSI4_RXD,
	PC18_PF_SSI4_TXD,
	PC19_PF_SSI4_CLK,
	/* Flash Led */
	FLASH_ENABLE | GPIO_GPIO | GPIO_OUT,
	THT_ENABLE | GPIO_GPIO | GPIO_OUT,
	HP_ENABLE | GPIO_GPIO | GPIO_OUT,
	HEATING_ENABLE | GPIO_GPIO | GPIO_OUT,
	BTNLIGHT_ENABLE | GPIO_GPIO | GPIO_OUT,
	/* GPIO KEY */
	GPIO_KEY1 | GPIO_GPIO | GPIO_IN,
	GPIO_KEY2 | GPIO_GPIO | GPIO_IN,
	GPIO_KEY3 | GPIO_GPIO | GPIO_IN,
};

static void __init imx27gc_init(void)
{
     mxc_gpio_setup_multiple_pins(imx27gc_pins, ARRAY_SIZE(imx27gc_pins=
),
		"imx27gc");
     ...
     imx27gc_i2c0_devices[0].irq =3D gpio_to_irq(MXT_KEY);
     i2c_register_board_info(0, imx27gc_i2c0_devices,
         ARRAY_SIZE(imx27gc_i2c0_devices));
         imx27_add_imx_i2c(0, &imx27gc_i2c0_data);
     ....
}
8---------------------------------------------------------
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

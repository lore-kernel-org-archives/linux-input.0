From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH V3 2/5] input: keyboard: imx_sc: Add i.MX system
 controller key support
Date: Mon, 16 Sep 2019 02:44:05 +0000
Message-ID: <DB3PR0402MB391600DD2C5D0D23BD6B9AAFF58C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1567546600-21566-1-git-send-email-Anson.Huang@nxp.com>
 <1567546600-21566-2-git-send-email-Anson.Huang@nxp.com>
 <20190912202239.GB636@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190912202239.GB636@penguin>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Jacky Bai <ping.bai@nxp.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Peng Fan <peng.fan@nxp.com>, "stefan@agner.ch" <stefan@agner.ch>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, Leonard Crestez <leonard.crestez@nxp.com>, "will@kernel.org" <will@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "yuehaibing@huawei.com" <yuehaibing@huawei.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>, "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "ronald@innovation.ch" <ronald@innovation.ch>, dl-linux-imx <linux-imx@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "s.hauer@pengutronix.de" <s.hauer@pengutroni>
List-Id: linux-input@vger.kernel.org

Hi, Dmitry

> On Tue, Sep 03, 2019 at 05:36:37PM -0400, Anson Huang wrote:
> > i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> > inside, the system controller is in charge of controlling power, clock
> > and scu key etc..
> >
> > Adds i.MX system controller key driver support, Linux kernel has to
> > communicate with system controller via MU (message unit) IPC to get
> > scu key's status.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > Changes since V2:
> > 	- use private platform data instead of global data;
> > 	- use "key" instead of "pwrkey";
> > 	- fix some data format.
> > ---
> >  drivers/input/keyboard/Kconfig      |   7 ++
> >  drivers/input/keyboard/Makefile     |   1 +
> >  drivers/input/keyboard/imx_sc_key.c | 178
> > ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 186 insertions(+)
> >  create mode 100644 drivers/input/keyboard/imx_sc_key.c
> >
> > diff --git a/drivers/input/keyboard/Kconfig
> > b/drivers/input/keyboard/Kconfig index 2e6d288..607acf2 100644
> > --- a/drivers/input/keyboard/Kconfig
> > +++ b/drivers/input/keyboard/Kconfig
> > @@ -469,6 +469,13 @@ config KEYBOARD_IMX
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called imx_keypad.
> >
> > +config KEYBOARD_IMX_SC_KEY
> > +	tristate "IMX SCU Key Driver"
> > +	depends on IMX_SCU
> > +	help
> > +	  This is the system controller key driver for NXP i.MX SoCs with
> > +	  system controller inside.
> > +
> >  config KEYBOARD_NEWTON
> >  	tristate "Newton keyboard"
> >  	select SERIO
> > diff --git a/drivers/input/keyboard/Makefile
> > b/drivers/input/keyboard/Makefile index 9510325..f5b1752 100644
> > --- a/drivers/input/keyboard/Makefile
> > +++ b/drivers/input/keyboard/Makefile
> > @@ -29,6 +29,7 @@ obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
> >  obj-$(CONFIG_KEYBOARD_HIL_OLD)		+= hilkbd.o
> >  obj-$(CONFIG_KEYBOARD_IPAQ_MICRO)	+= ipaq-micro-keys.o
> >  obj-$(CONFIG_KEYBOARD_IMX)		+= imx_keypad.o
> > +obj-$(CONFIG_KEYBOARD_IMX_SC_KEY)	+= imx_sc_key.o
> >  obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
> >  obj-$(CONFIG_KEYBOARD_HP7XX)		+= jornada720_kbd.o
> >  obj-$(CONFIG_KEYBOARD_LKKBD)		+= lkkbd.o
> > diff --git a/drivers/input/keyboard/imx_sc_key.c
> > b/drivers/input/keyboard/imx_sc_key.c
> > new file mode 100644
> > index 0000000..e69479b
> > --- /dev/null
> > +++ b/drivers/input/keyboard/imx_sc_key.c
> > @@ -0,0 +1,178 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2019 NXP.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/firmware/imx/sci.h>
> > +#include <linux/init.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define DEBOUNCE_TIME	100
> > +#define REPEAT_INTERVAL	60
> > +
> > +#define SC_IRQ_BUTTON		1
> > +#define SC_IRQ_GROUP_WAKE	3
> > +#define IMX_SC_MISC_FUNC_GET_BUTTON_STATUS	18
> > +
> > +struct imx_key_drv_data {
> > +	int keycode;
> > +	bool keystate;  /* 1: pressed, 0: release */
> > +	bool delay_check;
> > +	struct delayed_work check_work;
> > +	struct input_dev *input;
> > +	struct imx_sc_ipc *key_ipc_handle;
> > +	struct notifier_block key_notifier;
> > +};
> > +
> > +struct imx_sc_msg_key {
> > +	struct imx_sc_rpc_msg hdr;
> > +	u8 state;
> > +};
> > +
> > +static int imx_sc_key_notify(struct notifier_block *nb,
> > +			     unsigned long event, void *group) {
> > +	struct imx_key_drv_data *priv =
> > +				 container_of(nb,
> > +					      struct imx_key_drv_data,
> > +					      key_notifier);
> > +
> > +	if ((event & SC_IRQ_BUTTON) && (*(u8 *)group ==
> SC_IRQ_GROUP_WAKE)
> > +	    && !priv->delay_check) {
> > +		priv->delay_check = 1;
> > +		schedule_delayed_work(&priv->check_work,
> > +				      msecs_to_jiffies(REPEAT_INTERVAL));
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void imx_sc_check_for_events(struct work_struct *work) {
> > +	struct imx_key_drv_data *priv =
> > +				 container_of(work,
> > +					      struct imx_key_drv_data,
> > +					      check_work.work);
> > +	struct input_dev *input = priv->input;
> > +	struct imx_sc_msg_key msg;
> > +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > +	bool state;
> > +	int ret;
> > +
> > +	hdr->ver = IMX_SC_RPC_VERSION;
> > +	hdr->svc = IMX_SC_RPC_SVC_MISC;
> > +	hdr->func = IMX_SC_MISC_FUNC_GET_BUTTON_STATUS;
> > +	hdr->size = 1;
> > +
> > +	ret = imx_scu_call_rpc(priv->key_ipc_handle, &msg, true);
> > +	if (ret) {
> > +		dev_err(&input->dev, "read imx sc key failed, ret %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	state = (bool)msg.state;
> > +
> > +	if (!state && !priv->keystate)
> > +		state = true;
> > +
> > +	if (state ^ priv->keystate) {
> > +		pm_wakeup_event(input->dev.parent, 0);
> > +		priv->keystate = state;
> > +		input_event(input, EV_KEY, priv->keycode, state);
> > +		input_sync(input);
> > +		if (!state)
> > +			priv->delay_check = 0;
> > +		pm_relax(priv->input->dev.parent);
> > +	}
> > +
> > +	if (state)
> > +		schedule_delayed_work(&priv->check_work,
> > +				      msecs_to_jiffies(DEBOUNCE_TIME));
> 
> Hmm, I am not quite sure follow the code. Judging by the name, you are
> trying to handle debounce, but if I understand this correctly you already sent
> out the press event for now.
> 
> Could you please explain what you are trying to do here.

The name is kind of confused, the "DEBOUNCE_TIME" here should be "REPEAT_INTERVAL"
actually, the  "DEBOUNCE_TIME" should be used in the irq hanlder instead.	
As the SCU ONLY send out interrupt when the key is pressed, so here we have to repeat
the delay work to loop check the button release event, the press event is sent out once the
key state is valid, and then start to check until key is released.

I will switch the "DEBOUNCE_TIME" and "REPEAT_INTERVAL" in V4.

> 
> > +}
> > +
> > +static int imx_sc_key_probe(struct platform_device *pdev) {
> > +	struct device_node *np = pdev->dev.of_node;
> > +	static struct imx_key_drv_data *priv;
> > +	struct input_dev *input;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	ret = imx_scu_get_handle(&priv->key_ipc_handle);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (of_property_read_u32(np, "linux,keycode", &priv->keycode)) {
> > +		dev_err(&pdev->dev, "missing KEY_POWER in DT\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	INIT_DELAYED_WORK(&priv->check_work,
> imx_sc_check_for_events);
> > +
> > +	input = devm_input_allocate_device(&pdev->dev);
> > +	if (!input) {
> > +		dev_err(&pdev->dev, "failed to allocate the input device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	input->name = pdev->name;
> > +	input->phys = "imx-sc-key/input0";
> > +	input->id.bustype = BUS_HOST;
> > +
> > +	input_set_capability(input, EV_KEY, priv->keycode);
> > +
> > +	ret = input_register_device(input);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to register input device\n");
> > +		return ret;
> > +	}
> > +
> > +	priv->input = input;
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	ret = imx_scu_irq_group_enable(SC_IRQ_GROUP_WAKE,
> SC_IRQ_BUTTON, true);
> > +	if (ret) {
> > +		dev_warn(&pdev->dev, "enable scu group irq failed\n");
> > +		return ret;
> > +	}
> > +
> > +	priv->key_notifier.notifier_call = imx_sc_key_notify;
> > +	ret = imx_scu_irq_register_notifier(&priv->key_notifier);
> > +	if (ret) {
> > +		imx_scu_irq_group_enable(SC_IRQ_GROUP_WAKE,
> SC_IRQ_BUTTON, false);
> > +		dev_warn(&pdev->dev, "register scu notifier failed\n");
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct of_device_id imx_sc_key_ids[] = {
> > +	{ .compatible = "fsl,imx-sc-key" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, imx_sc_key_ids);
> > +
> > +static struct platform_driver imx_sc_key_driver = {
> > +	.driver = {
> > +		.name = "imx-sc-key",
> > +		.of_match_table = imx_sc_key_ids,
> > +	},
> > +	.probe = imx_sc_key_probe,
> 
> You need a remove() handler to disable the itq group, remove the notifier,
> cancel the delayed work, etc.

I will add it in V4.

Thanks,
Anson

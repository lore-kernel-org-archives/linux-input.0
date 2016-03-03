From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH] input: cyapa: fix the report events may lost issue during
 set power mode
Date: Thu, 3 Mar 2016 01:51:34 +0000
Message-ID: <SN1PR0601MB19038DCA1721D06E7BAE7B2AD1BD0@SN1PR0601MB1903.namprd06.prod.outlook.com>
References: <1452750033-25692-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0120.outbound.protection.outlook.com ([207.46.100.120]:41408
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753885AbcCCBvh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 20:51:37 -0500
In-Reply-To: <1452750033-25692-1-git-send-email-dudl@cypress.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "eugenesan@gmail.com" <eugenesan@gmail.com>
Cc: "bleung@google.com" <bleung@google.com>, "jmmahler@gmail.com" <jmmahler@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Dmitry,

Is there any update on this patch?
Looking forward to your response.

Thanks,
Dudley

> -----Original Message-----
> From: Dudley Du [mailto:dudl@cypress.com]
> Sent: 2016?1?14? 13:41
> To: dmitry.torokhov@gmail.com; eugenesan@gmail.com
> Cc: Dudley Du; bleung@google.com; jmmahler@gmail.com;
> linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] input: cyapa: fix the report events may lost issue during set power
> mode
>
> When driver set the power mode to change the scan rate in auto suspend
> process, some events may be lost because
> 1) for gen3 trackpad, the driver must msleep() some time to avoid issuing
> next command encounter error;
> 2) for gen5 and later trackpads, the queue dumping function will simply
> ignore the events when waiting for the set power mode command response.
> so, when auto resume process will be executed, the set power mode command
> will be issued can cause the events may be lost.
> The solution is kept polling and report those valid events when the set
> power mode command is in progress.
>
> TEST=test on Acer C720P Chromebook
>
> Signed-off-by: Dudley Du <dudl@cypress.com>
> ---
>  drivers/input/mouse/cyapa.c      |  22 ++++----
>  drivers/input/mouse/cyapa.h      |  14 ++++-
>  drivers/input/mouse/cyapa_gen3.c | 108
> ++++++++++++++++++++++++++++-----------
>  drivers/input/mouse/cyapa_gen5.c |  99 +++++++++++++++++++++++++++++------
>  drivers/input/mouse/cyapa_gen6.c |   4 +-
>  5 files changed, 188 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index eb76b61..dc23942 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -383,7 +383,7 @@ static int cyapa_open(struct input_dev *input)
>   * when in operational mode.
>   */
>  error = cyapa->ops->set_power_mode(cyapa,
> -PWR_MODE_FULL_ACTIVE, 0, false);
> +PWR_MODE_FULL_ACTIVE, 0, CYAPA_PM_ACTIVE);
>  if (error) {
>  dev_warn(dev, "set active power failed: %d\n", error);
>  goto out;
> @@ -424,7 +424,8 @@ static void cyapa_close(struct input_dev *input)
>  pm_runtime_set_suspended(dev);
>
>  if (cyapa->operational)
> -cyapa->ops->set_power_mode(cyapa, PWR_MODE_OFF, 0, false);
> +cyapa->ops->set_power_mode(cyapa,
> +PWR_MODE_OFF, 0, CYAPA_PM_DEACTIVE);
>
>  mutex_unlock(&cyapa->state_sync_lock);
>  }
> @@ -534,7 +535,7 @@ static void cyapa_enable_irq_for_cmd(struct cyapa
> *cyapa)
>   */
>  if (!input || cyapa->operational)
>  cyapa->ops->set_power_mode(cyapa,
> -PWR_MODE_FULL_ACTIVE, 0, false);
> +PWR_MODE_FULL_ACTIVE, 0, CYAPA_PM_ACTIVE);
>  /* Gen3 always using polling mode for command. */
>  if (cyapa->gen >= CYAPA_GEN5)
>  enable_irq(cyapa->client->irq);
> @@ -550,7 +551,7 @@ static void cyapa_disable_irq_for_cmd(struct cyapa
> *cyapa)
>  disable_irq(cyapa->client->irq);
>  if (!input || cyapa->operational)
>  cyapa->ops->set_power_mode(cyapa,
> -   PWR_MODE_OFF, 0, false);
> +PWR_MODE_OFF, 0, CYAPA_PM_ACTIVE);
>  }
>  }
>
> @@ -617,7 +618,8 @@ static int cyapa_initialize(struct cyapa *cyapa)
>
>  /* Power down the device until we need it. */
>  if (cyapa->operational)
> -cyapa->ops->set_power_mode(cyapa, PWR_MODE_OFF, 0, false);
> +cyapa->ops->set_power_mode(cyapa,
> +PWR_MODE_OFF, 0, CYAPA_PM_ACTIVE);
>
>  return 0;
>  }
> @@ -634,7 +636,7 @@ static int cyapa_reinitialize(struct cyapa *cyapa)
>  /* Avoid command failures when TP was in OFF state. */
>  if (cyapa->operational)
>  cyapa->ops->set_power_mode(cyapa,
> -   PWR_MODE_FULL_ACTIVE, 0, false);
> +PWR_MODE_FULL_ACTIVE, 0, CYAPA_PM_ACTIVE);
>
>  error = cyapa_detect(cyapa);
>  if (error)
> @@ -654,7 +656,7 @@ out:
>  /* Reset to power OFF state to save power when no user open. */
>  if (cyapa->operational)
>  cyapa->ops->set_power_mode(cyapa,
> -   PWR_MODE_OFF, 0, false);
> +PWR_MODE_OFF, 0, CYAPA_PM_DEACTIVE);
>  } else if (!error && cyapa->operational) {
>  /*
>   * Make sure only enable runtime PM when device is
> @@ -1392,7 +1394,7 @@ static int __maybe_unused cyapa_suspend(struct device
> *dev)
>  power_mode = device_may_wakeup(dev) ?
> cyapa->suspend_power_mode
>      : PWR_MODE_OFF;
>  error = cyapa->ops->set_power_mode(cyapa, power_mode,
> -cyapa->suspend_sleep_time, true);
> +cyapa->suspend_sleep_time, CYAPA_PM_SUSPEND);
>  if (error)
>  dev_err(dev, "suspend set power mode failed: %d\n",
>  error);
> @@ -1447,7 +1449,7 @@ static int __maybe_unused
> cyapa_runtime_suspend(struct device *dev)
>  error = cyapa->ops->set_power_mode(cyapa,
>  cyapa->runtime_suspend_power_mode,
>  cyapa->runtime_suspend_sleep_time,
> -false);
> +CYAPA_PM_RUNTIME_SUSPEND);
>  if (error)
>  dev_warn(dev, "runtime suspend failed: %d\n", error);
>
> @@ -1460,7 +1462,7 @@ static int __maybe_unused
> cyapa_runtime_resume(struct device *dev)
>  int error;
>
>  error = cyapa->ops->set_power_mode(cyapa,
> -   PWR_MODE_FULL_ACTIVE, 0, false);
> +PWR_MODE_FULL_ACTIVE, 0, CYAPA_PM_RUNTIME_RESUME);
>  if (error)
>  dev_warn(dev, "runtime resume failed: %d\n", error);
>
> diff --git a/drivers/input/mouse/cyapa.h b/drivers/input/mouse/cyapa.h
> index b812bba..ce951fe 100644
> --- a/drivers/input/mouse/cyapa.h
> +++ b/drivers/input/mouse/cyapa.h
> @@ -250,6 +250,15 @@ struct cyapa;
>
>  typedef bool (*cb_sort)(struct cyapa *, u8 *, int);
>
> +enum cyapa_pm_stage {
> +CYAPA_PM_DEACTIVE,
> +CYAPA_PM_ACTIVE,
> +CYAPA_PM_SUSPEND,
> +CYAPA_PM_RESUME,
> +CYAPA_PM_RUNTIME_SUSPEND,
> +CYAPA_PM_RUNTIME_RESUME,
> +};
> +
>  struct cyapa_dev_ops {
>  int (*check_fw)(struct cyapa *, const struct firmware *);
>  int (*bl_enter)(struct cyapa *);
> @@ -273,7 +282,7 @@ struct cyapa_dev_ops {
>  int (*sort_empty_output_data)(struct cyapa *,
>  u8 *, int *, cb_sort);
>
> -int (*set_power_mode)(struct cyapa *, u8, u16, bool);
> +int (*set_power_mode)(struct cyapa *, u8, u16, enum cyapa_pm_stage);
>
>  int (*set_proximity)(struct cyapa *, bool);
>  };
> @@ -289,6 +298,9 @@ struct cyapa_pip_cmd_states {
>  u8 *resp_data;
>  int *resp_len;
>
> +enum cyapa_pm_stage pm_stage;
> +struct mutex pm_stage_lock;
> +
>  u8 irq_cmd_buf[CYAPA_REG_MAP_SIZE];
>  u8 empty_buf[CYAPA_REG_MAP_SIZE];
>  };
> diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
> index 1a9d12a..c86c31f 100644
> --- a/drivers/input/mouse/cyapa_gen3.c
> +++ b/drivers/input/mouse/cyapa_gen3.c
> @@ -269,6 +269,7 @@ static const struct cyapa_cmd_len cyapa_smbus_cmds[] =
> {
>  { CYAPA_SMBUS_MIN_BASELINE, 1 },/* CYAPA_CMD_MIN_BASELINE */
>  };
>
> +static int cyapa_gen3_try_poll_handler(struct cyapa *cyapa);
>
>  /*
>   * cyapa_smbus_read_block - perform smbus block read command
> @@ -950,12 +951,14 @@ static u16 cyapa_get_wait_time_for_pwr_cmd(u8
> pwr_mode)
>   * Device power mode can only be set when device is in operational mode.
>   */
>  static int cyapa_gen3_set_power_mode(struct cyapa *cyapa, u8 power_mode,
> -u16 always_unused, bool is_suspend_unused)
> +u16 always_unused, enum cyapa_pm_stage pm_stage)
>  {
> -int ret;
> +struct input_dev *input = cyapa->input;
>  u8 power;
>  int tries;
> -u16 sleep_time;
> +int sleep_time;
> +int interval;
> +int ret;
>
>  if (cyapa->state != CYAPA_STATE_OP)
>  return 0;
> @@ -977,7 +980,7 @@ static int cyapa_gen3_set_power_mode(struct cyapa
> *cyapa, u8 power_mode,
>  if ((ret & PWR_MODE_MASK) == power_mode)
>  return 0;
>
> -sleep_time = cyapa_get_wait_time_for_pwr_cmd(ret & PWR_MODE_MASK);
> +sleep_time = (int)cyapa_get_wait_time_for_pwr_cmd(ret &
> PWR_MODE_MASK);
>  power = ret;
>  power &= ~PWR_MODE_MASK;
>  power |= power_mode & PWR_MODE_MASK;
> @@ -995,7 +998,23 @@ static int cyapa_gen3_set_power_mode(struct cyapa
> *cyapa, u8 power_mode,
>   * doing so before issuing the next command may result in errors
>   * depending on the command's content.
>   */
> -msleep(sleep_time);
> +if (cyapa->operational && input && input->users &&
> +    (pm_stage == CYAPA_PM_RUNTIME_SUSPEND ||
> +     pm_stage == CYAPA_PM_RUNTIME_RESUME)) {
> +/* Try to polling in 120Hz, read may fail, just ignore it. */
> +interval = 1000 / 120;
> +while (sleep_time > 0) {
> +if (sleep_time > interval)
> +msleep(interval);
> +else
> +msleep(sleep_time);
> +sleep_time -= interval;
> +cyapa_gen3_try_poll_handler(cyapa);
> +}
> +} else {
> +msleep(sleep_time);
> +}
> +
>  return ret;
>  }
>
> @@ -1112,7 +1131,7 @@ static int cyapa_gen3_do_operational_check(struct
> cyapa *cyapa)
>   * may cause problems, so we set the power mode first here.
>   */
>  error = cyapa_gen3_set_power_mode(cyapa,
> -PWR_MODE_FULL_ACTIVE, 0, false);
> +PWR_MODE_FULL_ACTIVE, 0, CYAPA_PM_ACTIVE);
>  if (error)
>  dev_err(dev, "%s: set full power mode failed: %d\n",
>  __func__, error);
> @@ -1168,32 +1187,16 @@ static bool cyapa_gen3_irq_cmd_handler(struct
> cyapa *cyapa)
>  return false;
>  }
>
> -static int cyapa_gen3_irq_handler(struct cyapa *cyapa)
> +static int cyapa_gen3_event_process(struct cyapa *cyapa,
> +    struct cyapa_reg_data *data)
>  {
>  struct input_dev *input = cyapa->input;
> -struct device *dev = &cyapa->client->dev;
> -struct cyapa_reg_data data;
>  int num_fingers;
> -int ret;
>  int i;
>
> -ret = cyapa_read_block(cyapa, CYAPA_CMD_GROUP_DATA, (u8 *)&data);
> -if (ret != sizeof(data)) {
> -dev_err(dev, "failed to read report data, (%d)\n", ret);
> -return -EINVAL;
> -}
> -
> -if ((data.device_status & OP_STATUS_SRC) != OP_STATUS_SRC ||
> -    (data.device_status & OP_STATUS_DEV) != CYAPA_DEV_NORMAL ||
> -    (data.finger_btn & OP_DATA_VALID) != OP_DATA_VALID) {
> -dev_err(dev, "invalid device state bytes, %02x %02x\n",
> -data.device_status, data.finger_btn);
> -return -EINVAL;
> -}
> -
> -num_fingers = (data.finger_btn >> 4) & 0x0f;
> +num_fingers = (data->finger_btn >> 4) & 0x0f;
>  for (i = 0; i < num_fingers; i++) {
> -const struct cyapa_touch *touch = &data.touches[i];
> +const struct cyapa_touch *touch = &data->touches[i];
>  /* Note: touch->id range is 1 to 15; slots are 0 to 14. */
>  int slot = touch->id - 1;
>
> @@ -1210,18 +1213,65 @@ static int cyapa_gen3_irq_handler(struct cyapa
> *cyapa)
>
>  if (cyapa->btn_capability & CAPABILITY_LEFT_BTN_MASK)
>  input_report_key(input, BTN_LEFT,
> - !!(data.finger_btn & OP_DATA_LEFT_BTN));
> + !!(data->finger_btn & OP_DATA_LEFT_BTN));
>  if (cyapa->btn_capability & CAPABILITY_MIDDLE_BTN_MASK)
>  input_report_key(input, BTN_MIDDLE,
> - !!(data.finger_btn & OP_DATA_MIDDLE_BTN));
> + !!(data->finger_btn & OP_DATA_MIDDLE_BTN));
>  if (cyapa->btn_capability & CAPABILITY_RIGHT_BTN_MASK)
>  input_report_key(input, BTN_RIGHT,
> - !!(data.finger_btn & OP_DATA_RIGHT_BTN));
> + !!(data->finger_btn & OP_DATA_RIGHT_BTN));
>  input_sync(input);
>
>  return 0;
>  }
>
> +static int cyapa_gen3_irq_handler(struct cyapa *cyapa)
> +{
> +struct device *dev = &cyapa->client->dev;
> +struct cyapa_reg_data data;
> +int ret;
> +
> +ret = cyapa_read_block(cyapa, CYAPA_CMD_GROUP_DATA, (u8 *)&data);
> +if (ret != sizeof(data)) {
> +dev_err(dev, "failed to read report data, (%d)\n", ret);
> +return -EINVAL;
> +}
> +
> +if ((data.device_status & OP_STATUS_SRC) != OP_STATUS_SRC ||
> +    (data.device_status & OP_STATUS_DEV) != CYAPA_DEV_NORMAL ||
> +    (data.finger_btn & OP_DATA_VALID) != OP_DATA_VALID) {
> +dev_err(dev, "invalid device state bytes, %02x %02x\n",
> +data.device_status, data.finger_btn);
> +return -EINVAL;
> +}
> +
> +return cyapa_gen3_event_process(cyapa, &data);
> +}
> +
> +/*
> + * This function will be called in the cyapa_gen3_set_power_mode function,
> + * and it's known that it may failed in some situation after the set power
> + * mode command was sent. So this function is aimed to avoid the knwon
> + * and unwanted output I2C and data parse error messages.
> + */
> +static int cyapa_gen3_try_poll_handler(struct cyapa *cyapa)
> +{
> +struct cyapa_reg_data data;
> +int ret;
> +
> +ret = cyapa_read_block(cyapa, CYAPA_CMD_GROUP_DATA, (u8 *)&data);
> +if (ret != sizeof(data))
> +return -EINVAL;
> +
> +if ((data.device_status & OP_STATUS_SRC) != OP_STATUS_SRC ||
> +    (data.device_status & OP_STATUS_DEV) != CYAPA_DEV_NORMAL ||
> +    (data.finger_btn & OP_DATA_VALID) != OP_DATA_VALID)
> +return -EINVAL;
> +
> +return cyapa_gen3_event_process(cyapa, &data);
> +
> +}
> +
>  static int cyapa_gen3_initialize(struct cyapa *cyapa) { return 0; }
>  static int cyapa_gen3_bl_initiate(struct cyapa *cyapa,
>  const struct firmware *fw) { return 0; }
> diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
> index 118ba97..5775d40 100644
> --- a/drivers/input/mouse/cyapa_gen5.c
> +++ b/drivers/input/mouse/cyapa_gen5.c
> @@ -342,6 +342,9 @@ u8 pip_bl_read_app_info[] = { 0x04, 0x00, 0x0b, 0x00, 0x40,
> 0x00,
>  static u8 cyapa_pip_bl_cmd_key[] = { 0xa5, 0x01, 0x02, 0x03,
>  0xff, 0xfe, 0xfd, 0x5a };
>
> +static int cyapa_pip_event_process(struct cyapa *cyapa,
> +   struct cyapa_pip_report_data *report_data);
> +
>  int cyapa_pip_cmd_state_initialize(struct cyapa *cyapa)
>  {
>  struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
> @@ -350,6 +353,9 @@ int cyapa_pip_cmd_state_initialize(struct cyapa *cyapa)
>  atomic_set(&pip->cmd_issued, 0);
>  mutex_init(&pip->cmd_lock);
>
> +mutex_init(&pip->pm_stage_lock);
> +pip->pm_stage = CYAPA_PM_DEACTIVE;
> +
>  pip->resp_sort_func = NULL;
>  pip->in_progress_cmd = PIP_INVALID_CMD;
>  pip->resp_data = NULL;
> @@ -397,6 +403,38 @@ ssize_t cyapa_i2c_pip_write(struct cyapa *cyapa, u8 *buf,
> size_t size)
>  return 0;
>  }
>
> +static void cyapa_set_pip_pm_state(struct cyapa *cyapa,
> +   enum cyapa_pm_stage pm_stage)
> +{
> +struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
> +
> +mutex_lock(&pip->pm_stage_lock);
> +pip->pm_stage = pm_stage;
> +mutex_unlock(&pip->pm_stage_lock);
> +}
> +
> +static void cyapa_reset_pip_pm_state(struct cyapa *cyapa)
> +{
> +struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
> +
> +/* Indicates the pip->pm_stage is not valid. */
> +mutex_lock(&pip->pm_stage_lock);
> +pip->pm_stage = CYAPA_PM_DEACTIVE;
> +mutex_unlock(&pip->pm_stage_lock);
> +}
> +
> +static enum cyapa_pm_stage cyapa_get_pip_pm_state(struct cyapa *cyapa)
> +{
> +struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
> +enum cyapa_pm_stage pm_stage;
> +
> +mutex_lock(&pip->pm_stage_lock);
> +pm_stage = pip->pm_stage;
> +mutex_unlock(&pip->pm_stage_lock);
> +
> +return pm_stage;
> +}
> +
>  /**
>   * This function is aimed to dump all not read data in Gen5 trackpad
>   * before send any command, otherwise, the interrupt line will be blocked.
> @@ -404,7 +442,9 @@ ssize_t cyapa_i2c_pip_write(struct cyapa *cyapa, u8 *buf,
> size_t size)
>  int cyapa_empty_pip_output_data(struct cyapa *cyapa,
>  u8 *buf, int *len, cb_sort func)
>  {
> +struct input_dev *input = cyapa->input;
>  struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
> +enum cyapa_pm_stage pm_stage = cyapa_get_pip_pm_state(cyapa);
>  int length;
>  int report_count;
>  int empty_count;
> @@ -478,6 +518,12 @@ int cyapa_empty_pip_output_data(struct cyapa *cyapa,
>  *len = length;
>  /* Response found, success. */
>  return 0;
> +} else if (cyapa->operational && input && input->users &&
> +   (pm_stage == CYAPA_PM_RUNTIME_RESUME ||
> +    pm_stage == CYAPA_PM_RUNTIME_SUSPEND)) {
> +/* Parse the data and report it if it's valid. */
> +cyapa_pip_event_process(cyapa,
> +       (struct cyapa_pip_report_data *)pip->empty_buf);
>  }
>
>  error = -EINVAL;
> @@ -1566,15 +1612,17 @@ int cyapa_pip_deep_sleep(struct cyapa *cyapa, u8
> state)
>  }
>
>  static int cyapa_gen5_set_power_mode(struct cyapa *cyapa,
> -u8 power_mode, u16 sleep_time, bool is_suspend)
> +u8 power_mode, u16 sleep_time, enum cyapa_pm_stage pm_stage)
>  {
>  struct device *dev = &cyapa->client->dev;
>  u8 power_state;
> -int error;
> +int error = 0;
>
>  if (cyapa->state != CYAPA_STATE_GEN5_APP)
>  return 0;
>
> +cyapa_set_pip_pm_state(cyapa, pm_stage);
> +
>  if (PIP_DEV_GET_PWR_STATE(cyapa) == UNINIT_PWR_MODE) {
>  /*
>   * Assume TP in deep sleep mode when driver is loaded,
> @@ -1597,7 +1645,7 @@ static int cyapa_gen5_set_power_mode(struct cyapa
> *cyapa,
>  power_mode == PWR_MODE_BTN_ONLY ||
>  PIP_DEV_GET_SLEEP_TIME(cyapa) == sleep_time) {
>  /* Has in correct power mode state, early return. */
> -return 0;
> +goto out;
>  }
>  }
>
> @@ -1605,11 +1653,11 @@ static int cyapa_gen5_set_power_mode(struct cyapa
> *cyapa,
>  error = cyapa_pip_deep_sleep(cyapa, PIP_DEEP_SLEEP_STATE_OFF);
>  if (error) {
>  dev_err(dev, "enter deep sleep fail: %d\n", error);
> -return error;
> +goto out;
>  }
>
>  PIP_DEV_SET_PWR_STATE(cyapa, PWR_MODE_OFF);
> -return 0;
> +goto out;
>  }
>
>  /*
> @@ -1621,7 +1669,7 @@ static int cyapa_gen5_set_power_mode(struct cyapa
> *cyapa,
>  error = cyapa_pip_deep_sleep(cyapa, PIP_DEEP_SLEEP_STATE_ON);
>  if (error) {
>  dev_err(dev, "deep sleep wake fail: %d\n", error);
> -return error;
> +goto out;
>  }
>  }
>
> @@ -1630,7 +1678,7 @@ static int cyapa_gen5_set_power_mode(struct cyapa
> *cyapa,
>  GEN5_POWER_STATE_ACTIVE);
>  if (error) {
>  dev_err(dev, "change to active fail: %d\n", error);
> -return error;
> +goto out;
>  }
>
>  PIP_DEV_SET_PWR_STATE(cyapa, PWR_MODE_FULL_ACTIVE);
> @@ -1639,7 +1687,7 @@ static int cyapa_gen5_set_power_mode(struct cyapa
> *cyapa,
>  GEN5_POWER_STATE_BTN_ONLY);
>  if (error) {
>  dev_err(dev, "fail to button only mode: %d\n", error);
> -return error;
> +goto out;
>  }
>
>  PIP_DEV_SET_PWR_STATE(cyapa, PWR_MODE_BTN_ONLY);
> @@ -1664,7 +1712,7 @@ static int cyapa_gen5_set_power_mode(struct cyapa
> *cyapa,
>  if (error) {
>  dev_err(dev, "set power state to 0x%02x failed: %d\n",
>  power_state, error);
> -return error;
> +goto out;
>  }
>
>  /*
> @@ -1677,14 +1725,16 @@ static int cyapa_gen5_set_power_mode(struct cyapa
> *cyapa,
>   * is suspending which may cause interrupt line unable to be
>   * asserted again.
>   */
> -if (is_suspend)
> +if (pm_stage == CYAPA_PM_SUSPEND)
>  cyapa_gen5_disable_pip_report(cyapa);
>
>  PIP_DEV_SET_PWR_STATE(cyapa,
>  cyapa_sleep_time_to_pwr_cmd(sleep_time));
>  }
>
> -return 0;
> +out:
> +cyapa_reset_pip_pm_state(cyapa);
> +return error;
>  }
>
>  int cyapa_pip_resume_scanning(struct cyapa *cyapa)
> @@ -2513,7 +2563,7 @@ static int cyapa_gen5_do_operational_check(struct
> cyapa *cyapa)
>   * the device state is required.
>   */
>  error = cyapa_gen5_set_power_mode(cyapa,
> -PWR_MODE_FULL_ACTIVE, 0, false);
> +PWR_MODE_FULL_ACTIVE, 0, CYAPA_PM_ACTIVE);
>  if (error)
>  dev_warn(dev, "%s: failed to set power active mode.\n",
>  __func__);
> @@ -2715,7 +2765,6 @@ int cyapa_pip_irq_handler(struct cyapa *cyapa)
>  struct device *dev = &cyapa->client->dev;
>  struct cyapa_pip_report_data report_data;
>  unsigned int report_len;
> -u8 report_id;
>  int ret;
>
>  if (!cyapa_is_pip_app_mode(cyapa)) {
> @@ -2752,7 +2801,23 @@ int cyapa_pip_irq_handler(struct cyapa *cyapa)
>  return -EINVAL;
>  }
>
> -report_id = report_data.report_head[PIP_RESP_REPORT_ID_OFFSET];
> +return cyapa_pip_event_process(cyapa, &report_data);
> +}
> +
> +static int cyapa_pip_event_process(struct cyapa *cyapa,
> +   struct cyapa_pip_report_data *report_data)
> +{
> +struct device *dev = &cyapa->client->dev;
> +unsigned int report_len;
> +u8 report_id;
> +
> +report_len = get_unaligned_le16(
> +&report_data->report_head[PIP_RESP_LENGTH_OFFSET]);
> +/* Idle, no data for report. */
> +if (report_len == PIP_RESP_LENGTH_SIZE)
> +return 0;
> +
> +report_id = report_data->report_head[PIP_RESP_REPORT_ID_OFFSET];
>  if (report_id == PIP_WAKEUP_EVENT_REPORT_ID &&
>  report_len == PIP_WAKEUP_EVENT_SIZE) {
>  /*
> @@ -2805,11 +2870,11 @@ int cyapa_pip_irq_handler(struct cyapa *cyapa)
>  }
>
>  if (report_id == PIP_TOUCH_REPORT_ID)
> -cyapa_pip_report_touches(cyapa, &report_data);
> +cyapa_pip_report_touches(cyapa, report_data);
>  else if (report_id == PIP_PROXIMITY_REPORT_ID)
> -cyapa_pip_report_proximity(cyapa, &report_data);
> +cyapa_pip_report_proximity(cyapa, report_data);
>  else
> -cyapa_pip_report_buttons(cyapa, &report_data);
> +cyapa_pip_report_buttons(cyapa, report_data);
>
>  return 0;
>  }
> diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
> index e4eb048..0163978 100644
> --- a/drivers/input/mouse/cyapa_gen6.c
> +++ b/drivers/input/mouse/cyapa_gen6.c
> @@ -425,7 +425,7 @@ static int cyapa_gen6_deep_sleep(struct cyapa *cyapa, u8
> state)
>  }
>
>  static int cyapa_gen6_set_power_mode(struct cyapa *cyapa,
> -u8 power_mode, u16 sleep_time, bool is_suspend)
> +u8 power_mode, u16 sleep_time, enum cyapa_pm_stage pm_stage)
>  {
>  struct device *dev = &cyapa->client->dev;
>  struct gen6_interval_setting *interval_setting =
> @@ -689,7 +689,7 @@ static int cyapa_gen6_operational_check(struct cyapa
> *cyapa)
>   * the device state is required.
>   */
>  error = cyapa_gen6_set_power_mode(cyapa,
> -PWR_MODE_FULL_ACTIVE, 0, false);
> +PWR_MODE_FULL_ACTIVE, 0, CYAPA_PM_ACTIVE);
>  if (error)
>  dev_warn(dev, "%s: failed to set power active mode.\n",
>  __func__);
> --
> 1.9.1
>
>
> ---------------------------------------------------------------
> This message and any attachments may contain Cypress (or its
> subsidiaries) confidential information. If it has been received
> in error, please advise the sender and immediately delete this
> message.
> ---------------------------------------------------------------


This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.

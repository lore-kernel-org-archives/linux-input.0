From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 1/7] input: cyapa: change strings of gen5 to pip in
 the name when they are shared
Date: Mon, 20 Jul 2015 17:03:12 -0700
Message-ID: <20150721000312.GB15528@dtor-ws>
References: <1434358897-24668-1-git-send-email-dudl@cypress.com>
 <1434358897-24668-2-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434358897-24668-2-git-send-email-dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, jmmahler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 15, 2015 at 05:01:31PM +0800, Dudley Du wrote:
> Change strings 'gen5' to 'pip' for all macros, variables and functions when
> they are shared in gen5 and gen6 modules. The change of these strings is
> aimed to keep name definition much more clear and readable.
> Also the spelling errors are fix in this patch.
> TEST=test on Chromebook.
> 
> Signed-off-by: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>

Applied, thank you.

> ---
>  drivers/input/mouse/cyapa.c      |   34 +-
>  drivers/input/mouse/cyapa.h      |  136 ++++-
>  drivers/input/mouse/cyapa_gen3.c |    4 +-
>  drivers/input/mouse/cyapa_gen5.c | 1103 ++++++++++++++++++--------------------
>  4 files changed, 673 insertions(+), 604 deletions(-)
> 
> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index efe1484..4f0d76e 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -6,7 +6,7 @@
>   *   Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>   *   Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>   *
> - * Copyright (C) 2011-2014 Cypress Semiconductor, Inc.
> + * Copyright (C) 2011-2015 Cypress Semiconductor, Inc.
>   * Copyright (C) 2011-2012 Google, Inc.
>   *
>   * This file is subject to the terms and conditions of the GNU General Public
> @@ -39,11 +39,27 @@ const char product_id[] = "CYTRA";
>  
>  static int cyapa_reinitialize(struct cyapa *cyapa);
>  
> -static inline bool cyapa_is_bootloader_mode(struct cyapa *cyapa)
> +bool cyapa_is_pip_bl_mode(struct cyapa *cyapa)
>  {
>  	if (cyapa->gen == CYAPA_GEN5 && cyapa->state == CYAPA_STATE_GEN5_BL)
>  		return true;
>  
> +	return false;
> +}
> +
> +bool cyapa_is_pip_app_mode(struct cyapa *cyapa)
> +{
> +	if (cyapa->gen == CYAPA_GEN5 && cyapa->state == CYAPA_STATE_GEN5_APP)
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline bool cyapa_is_bootloader_mode(struct cyapa *cyapa)
> +{
> +	if (cyapa_is_pip_bl_mode(cyapa))
> +		return true;
> +
>  	if (cyapa->gen == CYAPA_GEN3 &&
>  		cyapa->state >= CYAPA_STATE_BL_BUSY &&
>  		cyapa->state <= CYAPA_STATE_BL_ACTIVE)
> @@ -54,7 +70,7 @@ static inline bool cyapa_is_bootloader_mode(struct cyapa *cyapa)
>  
>  static inline bool cyapa_is_operational_mode(struct cyapa *cyapa)
>  {
> -	if (cyapa->gen == CYAPA_GEN5 && cyapa->state == CYAPA_STATE_GEN5_APP)
> +	if (cyapa_is_pip_app_mode(cyapa))
>  		return true;
>  
>  	if (cyapa->gen == CYAPA_GEN3 && cyapa->state == CYAPA_STATE_OP)
> @@ -306,7 +322,7 @@ static int cyapa_check_is_operational(struct cyapa *cyapa)
>  
>  /*
>   * Returns 0 on device detected, negative errno on no device detected.
> - * And when the device is detected and opertaional, it will be reset to
> + * And when the device is detected and operational, it will be reset to
>   * full power active mode automatically.
>   */
>  static int cyapa_detect(struct cyapa *cyapa)
> @@ -629,15 +645,15 @@ static irqreturn_t cyapa_irq(int irq, void *dev_id)
>  	if (device_may_wakeup(dev))
>  		pm_wakeup_event(dev, 0);
>  
> -	/* Interrupt event maybe cuased by host command to trackpad device. */
> +	/* Interrupt event maybe caused by host command to trackpad device. */
>  	if (cyapa->ops->irq_cmd_handler(cyapa)) {
>  		/*
>  		 * Interrupt event maybe from trackpad device input reporting.
>  		 */
>  		if (!cyapa->input) {
>  			/*
> -			 * Still in probling or in firware image
> -			 * udpating or reading.
> +			 * Still in probing or in firmware image
> +			 * updating or reading.
>  			 */
>  			cyapa->ops->sort_empty_output_data(cyapa,
>  					NULL, NULL, NULL);
> @@ -1051,12 +1067,12 @@ static ssize_t cyapa_update_fw_store(struct device *dev,
>  		dev_dbg(dev, "firmware update successfully done.\n");
>  
>  	/*
> -	 * Redetect trackpad device states because firmware update process
> +	 * Re-detect trackpad device states because firmware update process
>  	 * will reset trackpad device into bootloader mode.
>  	 */
>  	ret = cyapa_reinitialize(cyapa);
>  	if (ret) {
> -		dev_err(dev, "failed to redetect after updated: %d\n", ret);
> +		dev_err(dev, "failed to re-detect after updated: %d\n", ret);
>  		error = error ? error : ret;
>  	}
>  
> diff --git a/drivers/input/mouse/cyapa.h b/drivers/input/mouse/cyapa.h
> index adc9ed5..d019d1d 100644
> --- a/drivers/input/mouse/cyapa.h
> +++ b/drivers/input/mouse/cyapa.h
> @@ -3,7 +3,7 @@
>   *
>   * Author: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
>   *
> - * Copyright (C) 2014 Cypress Semiconductor, Inc.
> + * Copyright (C) 2014-2015 Cypress Semiconductor, Inc.
>   *
>   * This file is subject to the terms and conditions of the GNU General Public
>   * License.  See the file COPYING in the main directory of this archive for
> @@ -25,7 +25,7 @@
>  /*
>   * Macros for SMBus communication
>   */
> -#define SMBUS_READ   0x01
> +#define SMBUS_READ  0x01
>  #define SMBUS_WRITE 0x00
>  #define SMBUS_ENCODE_IDX(cmd, idx) ((cmd) | (((idx) & 0x03) << 1))
>  #define SMBUS_ENCODE_RW(cmd, rw) ((cmd) | ((rw) & 0x01))
> @@ -159,12 +159,86 @@
>  
>  #define AUTOSUSPEND_DELAY   2000 /* unit : ms */
>  
> -#define UNINIT_SLEEP_TIME 0xFFFF
> -#define UNINIT_PWR_MODE   0xFF
> -
>  #define BTN_ONLY_MODE_NAME   "buttononly"
>  #define OFF_MODE_NAME        "off"
>  
> +/* Common macros for PIP interface. */
> +#define PIP_HID_DESCRIPTOR_ADDR		0x0001
> +#define PIP_REPORT_DESCRIPTOR_ADDR	0x0002
> +#define PIP_INPUT_REPORT_ADDR		0x0003
> +#define PIP_OUTPUT_REPORT_ADDR		0x0004
> +#define PIP_CMD_DATA_ADDR		0x0006
> +
> +#define PIP_RETRIEVE_DATA_STRUCTURE	0x24
> +#define PIP_CMD_CALIBRATE		0x28
> +#define PIP_BL_CMD_VERIFY_APP_INTEGRITY	0x31
> +#define PIP_BL_CMD_GET_BL_INFO		0x38
> +#define PIP_BL_CMD_PROGRAM_VERIFY_ROW	0x39
> +#define PIP_BL_CMD_LAUNCH_APP		0x3b
> +#define PIP_BL_CMD_INITIATE_BL		0x48
> +#define PIP_INVALID_CMD			0xff
> +
> +#define PIP_HID_DESCRIPTOR_SIZE		32
> +#define PIP_HID_APP_REPORT_ID		0xf7
> +#define PIP_HID_BL_REPORT_ID		0xff
> +
> +#define PIP_BL_CMD_REPORT_ID		0x40
> +#define PIP_BL_RESP_REPORT_ID		0x30
> +#define PIP_APP_CMD_REPORT_ID		0x2f
> +#define PIP_APP_RESP_REPORT_ID		0x1f
> +
> +#define PIP_READ_SYS_INFO_CMD_LENGTH	7
> +#define PIP_BL_READ_APP_INFO_CMD_LENGTH	13
> +#define PIP_MIN_BL_CMD_LENGTH		13
> +#define PIP_MIN_BL_RESP_LENGTH		11
> +#define PIP_MIN_APP_CMD_LENGTH		7
> +#define PIP_MIN_APP_RESP_LENGTH		5
> +#define PIP_UNSUPPORTED_CMD_RESP_LENGTH	6
> +#define PIP_READ_SYS_INFO_RESP_LENGTH	71
> +#define PIP_BL_APP_INFO_RESP_LENGTH	30
> +#define PIP_BL_GET_INFO_RESP_LENGTH	19
> +
> +#define PIP_PRODUCT_FAMILY_MASK		0xf000
> +#define PIP_PRODUCT_FAMILY_TRACKPAD	0x1000
> +
> +#define PIP_DEEP_SLEEP_STATE_ON		0x00
> +#define PIP_DEEP_SLEEP_STATE_OFF	0x01
> +#define PIP_DEEP_SLEEP_STATE_MASK	0x03
> +#define PIP_APP_DEEP_SLEEP_REPORT_ID	0xf0
> +#define PIP_DEEP_SLEEP_RESP_LENGTH	5
> +#define PIP_DEEP_SLEEP_OPCODE		0x08
> +#define PIP_DEEP_SLEEP_OPCODE_MASK	0x0f
> +
> +#define PIP_RESP_LENGTH_OFFSET		0
> +#define	    PIP_RESP_LENGTH_SIZE	2
> +#define PIP_RESP_REPORT_ID_OFFSET	2
> +#define PIP_RESP_RSVD_OFFSET		3
> +#define     PIP_RESP_RSVD_KEY		0x00
> +#define PIP_RESP_BL_SOP_OFFSET		4
> +#define     PIP_SOP_KEY			0x01  /* Start of Packet */
> +#define     PIP_EOP_KEY			0x17  /* End of Packet */
> +#define PIP_RESP_APP_CMD_OFFSET		4
> +#define     GET_PIP_CMD_CODE(reg)	((reg) & 0x7f)
> +#define PIP_RESP_STATUS_OFFSET		5
> +
> +#define VALID_CMD_RESP_HEADER(resp, cmd)				  \
> +	(((resp)[PIP_RESP_REPORT_ID_OFFSET] == PIP_APP_RESP_REPORT_ID) && \
> +	((resp)[PIP_RESP_RSVD_OFFSET] == PIP_RESP_RSVD_KEY) &&		  \
> +	(GET_PIP_CMD_CODE((resp)[PIP_RESP_APP_CMD_OFFSET]) == (cmd)))
> +
> +#define PIP_CMD_COMPLETE_SUCCESS(resp_data) \
> +	((resp_data)[PIP_RESP_STATUS_OFFSET] == 0x00)
> +
> +/* Variables to record latest gen5 trackpad power states. */
> +#define UNINIT_SLEEP_TIME	0xffff
> +#define UNINIT_PWR_MODE		0xff
> +#define PIP_DEV_SET_PWR_STATE(cyapa, s)		((cyapa)->dev_pwr_mode = (s))
> +#define PIP_DEV_GET_PWR_STATE(cyapa)		((cyapa)->dev_pwr_mode)
> +#define PIP_DEV_SET_SLEEP_TIME(cyapa, t)	((cyapa)->dev_sleep_time = (t))
> +#define PIP_DEV_GET_SLEEP_TIME(cyapa)		((cyapa)->dev_sleep_time)
> +#define PIP_DEV_UNINIT_SLEEP_TIME(cyapa)	\
> +		(((cyapa)->dev_sleep_time) == UNINIT_SLEEP_TIME)
> +
>  /* The touch.id is used as the MT slot id, thus max MT slot is 15 */
>  #define CYAPA_MAX_MT_SLOTS  15
>  
> @@ -198,7 +272,7 @@ struct cyapa_dev_ops {
>  	int (*set_power_mode)(struct cyapa *, u8, u16);
>  };
>  
> -struct cyapa_gen5_cmd_states {
> +struct cyapa_pip_cmd_states {
>  	struct mutex cmd_lock;
>  	struct completion cmd_ready;
>  	atomic_t cmd_issued;
> @@ -214,7 +288,7 @@ struct cyapa_gen5_cmd_states {
>  };
>  
>  union cyapa_cmd_states {
> -	struct cyapa_gen5_cmd_states gen5;
> +	struct cyapa_pip_cmd_states pip;
>  };
>  
>  enum cyapa_state {
> @@ -259,7 +333,7 @@ struct cyapa {
>  	int physical_size_y;
>  
>  	/* Used in ttsp and truetouch based trackpad devices. */
> -	u8 x_origin;  /* X Axis Origin: 0 = left side; 1 = rigth side. */
> +	u8 x_origin;  /* X Axis Origin: 0 = left side; 1 = right side. */
>  	u8 y_origin;  /* Y Axis Origin: 0 = top; 1 = bottom. */
>  	int electrodes_x;  /* Number of electrodes on the X Axis*/
>  	int electrodes_y;  /* Number of electrodes on the Y Axis*/
> @@ -282,9 +356,9 @@ struct cyapa {
>  
>  
>  ssize_t cyapa_i2c_reg_read_block(struct cyapa *cyapa, u8 reg, size_t len,
> -				u8 *values);
> +				 u8 *values);
>  ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
> -				u8 *values);
> +			       u8 *values);
>  
>  ssize_t cyapa_read_block(struct cyapa *cyapa, u8 cmd_idx, u8 *values);
>  
> @@ -293,7 +367,47 @@ int cyapa_poll_state(struct cyapa *cyapa, unsigned int timeout);
>  u8 cyapa_sleep_time_to_pwr_cmd(u16 sleep_time);
>  u16 cyapa_pwr_cmd_to_sleep_time(u8 pwr_mode);
>  
> -
> +ssize_t cyapa_i2c_pip_read(struct cyapa *cyapa, u8 *buf, size_t size);
> +ssize_t cyapa_i2c_pip_write(struct cyapa *cyapa, u8 *buf, size_t size);
> +int cyapa_empty_pip_output_data(struct cyapa *cyapa,
> +				u8 *buf, int *len, cb_sort func);
> +int cyapa_i2c_pip_cmd_irq_sync(struct cyapa *cyapa,
> +			       u8 *cmd, int cmd_len,
> +			       u8 *resp_data, int *resp_len,
> +			       unsigned long timeout,
> +			       cb_sort func,
> +			       bool irq_mode);
> +int cyapa_pip_state_parse(struct cyapa *cyapa, u8 *reg_data, int len);
> +bool cyapa_pip_sort_system_info_data(struct cyapa *cyapa, u8 *buf, int len);
> +bool cyapa_sort_tsg_pip_bl_resp_data(struct cyapa *cyapa, u8 *data, int len);
> +int cyapa_pip_deep_sleep(struct cyapa *cyapa, u8 state);
> +bool cyapa_sort_tsg_pip_app_resp_data(struct cyapa *cyapa, u8 *data, int len);
> +int cyapa_pip_bl_exit(struct cyapa *cyapa);
> +int cyapa_pip_bl_enter(struct cyapa *cyapa);
> +
> +
> +bool cyapa_is_pip_bl_mode(struct cyapa *cyapa);
> +bool cyapa_is_pip_app_mode(struct cyapa *cyapa);
> +int cyapa_pip_cmd_state_initialize(struct cyapa *cyapa);
> +
> +int cyapa_pip_resume_scanning(struct cyapa *cyapa);
> +int cyapa_pip_suspend_scanning(struct cyapa *cyapa);
> +
> +int cyapa_pip_check_fw(struct cyapa *cyapa, const struct firmware *fw);
> +int cyapa_pip_bl_initiate(struct cyapa *cyapa, const struct firmware *fw);
> +int cyapa_pip_do_fw_update(struct cyapa *cyapa, const struct firmware *fw);
> +int cyapa_pip_bl_activate(struct cyapa *cyapa);
> +int cyapa_pip_bl_deactivate(struct cyapa *cyapa);
> +ssize_t cyapa_pip_do_calibrate(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count);
> +
> +bool cyapa_pip_irq_cmd_handler(struct cyapa *cyapa);
> +int cyapa_pip_irq_handler(struct cyapa *cyapa);
> +
> +
> +extern u8 pip_read_sys_info[];
> +extern u8 pip_bl_read_app_info[];
>  extern const char product_id[];
>  extern const struct cyapa_dev_ops cyapa_gen3_ops;
>  extern const struct cyapa_dev_ops cyapa_gen5_ops;
> diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
> index 3faf01c..3884311 100644
> --- a/drivers/input/mouse/cyapa_gen3.c
> +++ b/drivers/input/mouse/cyapa_gen3.c
> @@ -6,7 +6,7 @@
>   *   Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>   *   Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>   *
> - * Copyright (C) 2011-2014 Cypress Semiconductor, Inc.
> + * Copyright (C) 2011-2015 Cypress Semiconductor, Inc.
>   * Copyright (C) 2011-2012 Google, Inc.
>   *
>   * This file is subject to the terms and conditions of the GNU General Public
> @@ -1156,7 +1156,7 @@ static bool cyapa_gen3_irq_cmd_handler(struct cyapa *cyapa)
>  	 * so, stop cyapa_gen3_irq_handler to continue process to
>  	 * avoid unwanted to error detecting and processing.
>  	 *
> -	 * And also, avoid the periodicly accerted interrupts to be processed
> +	 * And also, avoid the periodically asserted interrupts to be processed
>  	 * as touch inputs when gen3 failed to launch into application mode,
>  	 * which will cause gen3 stays in bootloader mode.
>  	 */
> diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
> index afc39e7..9d75c6f 100644
> --- a/drivers/input/mouse/cyapa_gen5.c
> +++ b/drivers/input/mouse/cyapa_gen5.c
> @@ -3,7 +3,7 @@
>   *
>   * Author: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
>   *
> - * Copyright (C) 2014 Cypress Semiconductor, Inc.
> + * Copyright (C) 2014-2015 Cypress Semiconductor, Inc.
>   *
>   * This file is subject to the terms and conditions of the GNU General Public
>   * License.  See the file COPYING in the main directory of this archive for
> @@ -22,12 +22,7 @@
>  #include "cyapa.h"
>  
>  
> -/* Macro of Gen5 */
> -#define RECORD_EVENT_NONE        0
> -#define RECORD_EVENT_TOUCHDOWN	 1
> -#define RECORD_EVENT_DISPLACE    2
> -#define RECORD_EVENT_LIFTOFF     3
> -
> +/* Macro of TSG firmware image */
>  #define CYAPA_TSG_FLASH_MAP_BLOCK_SIZE      0x80
>  #define CYAPA_TSG_IMG_FW_HDR_SIZE           13
>  #define CYAPA_TSG_FW_ROW_SIZE               (CYAPA_TSG_FLASH_MAP_BLOCK_SIZE)
> @@ -44,43 +39,48 @@
>  
>  #define CYAPA_TSG_MAX_CMD_SIZE              256
>  
> -#define GEN5_BL_CMD_VERIFY_APP_INTEGRITY    0x31
> -#define GEN5_BL_CMD_GET_BL_INFO		    0x38
> -#define GEN5_BL_CMD_PROGRAM_VERIFY_ROW      0x39
> -#define GEN5_BL_CMD_LAUNCH_APP		    0x3b
> -#define GEN5_BL_CMD_INITIATE_BL		    0x48
> -
> -#define GEN5_HID_DESCRIPTOR_ADDR	0x0001
> -#define GEN5_REPORT_DESCRIPTOR_ADDR	0x0002
> -#define GEN5_INPUT_REPORT_ADDR		0x0003
> -#define GEN5_OUTPUT_REPORT_ADDR		0x0004
> -#define GEN5_CMD_DATA_ADDR		0x0006
> -
> -#define GEN5_TOUCH_REPORT_HEAD_SIZE     7
> -#define GEN5_TOUCH_REPORT_MAX_SIZE      127
> -#define GEN5_BTN_REPORT_HEAD_SIZE       6
> -#define GEN5_BTN_REPORT_MAX_SIZE        14
> -#define GEN5_WAKEUP_EVENT_SIZE          4
> -#define GEN5_RAW_DATA_HEAD_SIZE         24
> -
> -#define GEN5_BL_CMD_REPORT_ID           0x40
> -#define GEN5_BL_RESP_REPORT_ID          0x30
> -#define GEN5_APP_CMD_REPORT_ID          0x2f
> -#define GEN5_APP_RESP_REPORT_ID         0x1f
> -
> -#define GEN5_APP_DEEP_SLEEP_REPORT_ID   0xf0
> -#define GEN5_DEEP_SLEEP_RESP_LENGTH     5
> +/* Macro of PIP interface */
> +#define PIP_BL_INITIATE_RESP_LEN            11
> +#define PIP_BL_FAIL_EXIT_RESP_LEN           11
> +#define PIP_BL_FAIL_EXIT_STATUS_CODE        0x0c
> +#define PIP_BL_VERIFY_INTEGRITY_RESP_LEN    12
> +#define PIP_BL_INTEGRITY_CHEKC_PASS         0x00
> +#define PIP_BL_BLOCK_WRITE_RESP_LEN         11
> +
> +#define PIP_TOUCH_REPORT_ID         0x01
> +#define PIP_BTN_REPORT_ID           0x03
> +#define PIP_WAKEUP_EVENT_REPORT_ID  0x04
> +#define PIP_PUSH_BTN_REPORT_ID      0x06
> +#define GEN5_OLD_PUSH_BTN_REPORT_ID 0x05  /* Special for old Gen5 TP. */
> +
> +#define PIP_TOUCH_REPORT_HEAD_SIZE     7
> +#define PIP_TOUCH_REPORT_MAX_SIZE      127
> +#define PIP_BTN_REPORT_HEAD_SIZE       6
> +#define PIP_BTN_REPORT_MAX_SIZE        14
> +#define PIP_WAKEUP_EVENT_SIZE          4
> +
> +#define PIP_NUMBER_OF_TOUCH_OFFSET  5
> +#define PIP_NUMBER_OF_TOUCH_MASK    0x1f
> +#define PIP_BUTTONS_OFFSET          5
> +#define PIP_BUTTONS_MASK            0x0f
> +#define PIP_GET_EVENT_ID(reg)       (((reg) >> 5) & 0x03)
> +#define PIP_GET_TOUCH_ID(reg)       ((reg) & 0x1f)
> +#define PIP_TOUCH_TYPE_FINGER	    0x00
> +#define PIP_TOUCH_TYPE_PROXIMITY    0x01
> +#define PIP_TOUCH_TYPE_HOVER	    0x02
> +#define PIP_GET_TOUCH_TYPE(reg)     ((reg) & 0x07)
>  
> -#define GEN5_CMD_GET_PARAMETER		     0x05
> -#define GEN5_CMD_SET_PARAMETER		     0x06
> -#define GEN5_PARAMETER_ACT_INTERVL_ID        0x4d
> -#define GEN5_PARAMETER_ACT_INTERVL_SIZE      1
> -#define GEN5_PARAMETER_ACT_LFT_INTERVL_ID    0x4f
> -#define GEN5_PARAMETER_ACT_LFT_INTERVL_SIZE  2
> -#define GEN5_PARAMETER_LP_INTRVL_ID          0x4c
> -#define GEN5_PARAMETER_LP_INTRVL_SIZE        2
> +#define RECORD_EVENT_NONE        0
> +#define RECORD_EVENT_TOUCHDOWN	 1
> +#define RECORD_EVENT_DISPLACE    2
> +#define RECORD_EVENT_LIFTOFF     3
>  
> -#define GEN5_PARAMETER_DISABLE_PIP_REPORT    0x08
> +#define PIP_SENSING_MODE_MUTUAL_CAP_FINE   0x00
> +#define PIP_SENSING_MODE_SELF_CAP          0x02
> +
> +/* Macro of Gen5 */
> +#define GEN5_BL_MAX_OUTPUT_LENGTH     0x0100
> +#define GEN5_APP_MAX_OUTPUT_LENGTH    0x00fe
>  
>  #define GEN5_POWER_STATE_ACTIVE              0x01
>  #define GEN5_POWER_STATE_LOOK_FOR_TOUCH      0x02
> @@ -89,46 +89,19 @@
>  #define GEN5_POWER_STATE_BTN_ONLY            0x05
>  #define GEN5_POWER_STATE_OFF                 0x06
>  
> -#define GEN5_DEEP_SLEEP_STATE_MASK  0x03
> -#define GEN5_DEEP_SLEEP_STATE_ON    0x00
> -#define GEN5_DEEP_SLEEP_STATE_OFF   0x01
> -
> -#define GEN5_DEEP_SLEEP_OPCODE      0x08
> -#define GEN5_DEEP_SLEEP_OPCODE_MASK 0x0f
> -
>  #define GEN5_POWER_READY_MAX_INTRVL_TIME  50   /* Unit: ms */
>  #define GEN5_POWER_IDLE_MAX_INTRVL_TIME   250  /* Unit: ms */
>  
> -#define GEN5_CMD_REPORT_ID_OFFSET       4
> -
> -#define GEN5_RESP_REPORT_ID_OFFSET      2
> -#define GEN5_RESP_RSVD_OFFSET           3
> -#define     GEN5_RESP_RSVD_KEY          0x00
> -#define GEN5_RESP_BL_SOP_OFFSET         4
> -#define     GEN5_SOP_KEY                0x01  /* Start of Packet */
> -#define     GEN5_EOP_KEY                0x17  /* End of Packet */
> -#define GEN5_RESP_APP_CMD_OFFSET        4
> -#define     GET_GEN5_CMD_CODE(reg)      ((reg) & 0x7f)
> -
> -#define VALID_CMD_RESP_HEADER(resp, cmd)				    \
> -	(((resp)[GEN5_RESP_REPORT_ID_OFFSET] == GEN5_APP_RESP_REPORT_ID) && \
> -	((resp)[GEN5_RESP_RSVD_OFFSET] == GEN5_RESP_RSVD_KEY) &&	    \
> -	(GET_GEN5_CMD_CODE((resp)[GEN5_RESP_APP_CMD_OFFSET]) == (cmd)))
> -
> -#define GEN5_MIN_BL_CMD_LENGTH           13
> -#define GEN5_MIN_BL_RESP_LENGTH          11
> -#define GEN5_MIN_APP_CMD_LENGTH          7
> -#define GEN5_MIN_APP_RESP_LENGTH         5
> -#define GEN5_UNSUPPORTED_CMD_RESP_LENGTH 6
> -
> -#define GEN5_RESP_LENGTH_OFFSET  0x00
> -#define GEN5_RESP_LENGTH_SIZE    2
> -
> -#define GEN5_HID_DESCRIPTOR_SIZE      32
> -#define GEN5_BL_HID_REPORT_ID         0xff
> -#define GEN5_APP_HID_REPORT_ID        0xf7
> -#define GEN5_BL_MAX_OUTPUT_LENGTH     0x0100
> -#define GEN5_APP_MAX_OUTPUT_LENGTH    0x00fe
> +#define GEN5_CMD_GET_PARAMETER		     0x05
> +#define GEN5_CMD_SET_PARAMETER		     0x06
> +#define GEN5_PARAMETER_ACT_INTERVL_ID        0x4d
> +#define GEN5_PARAMETER_ACT_INTERVL_SIZE      1
> +#define GEN5_PARAMETER_ACT_LFT_INTERVL_ID    0x4f
> +#define GEN5_PARAMETER_ACT_LFT_INTERVL_SIZE  2
> +#define GEN5_PARAMETER_LP_INTRVL_ID          0x4c
> +#define GEN5_PARAMETER_LP_INTRVL_SIZE        2
> +
> +#define GEN5_PARAMETER_DISABLE_PIP_REPORT    0x08
>  
>  #define GEN5_BL_REPORT_DESCRIPTOR_SIZE            0x1d
>  #define GEN5_BL_REPORT_DESCRIPTOR_ID              0xfe
> @@ -136,26 +109,6 @@
>  #define GEN5_APP_CONTRACT_REPORT_DESCRIPTOR_SIZE  0xfa
>  #define GEN5_APP_REPORT_DESCRIPTOR_ID             0xf6
>  
> -#define GEN5_TOUCH_REPORT_ID         0x01
> -#define GEN5_BTN_REPORT_ID           0x03
> -#define GEN5_WAKEUP_EVENT_REPORT_ID  0x04
> -#define GEN5_OLD_PUSH_BTN_REPORT_ID  0x05
> -#define GEN5_PUSH_BTN_REPORT_ID      0x06
> -
> -#define GEN5_CMD_COMPLETE_SUCCESS(status) ((status) == 0x00)
> -
> -#define GEN5_BL_INITIATE_RESP_LEN            11
> -#define GEN5_BL_FAIL_EXIT_RESP_LEN           11
> -#define GEN5_BL_FAIL_EXIT_STATUS_CODE        0x0c
> -#define GEN5_BL_VERIFY_INTEGRITY_RESP_LEN    12
> -#define GEN5_BL_INTEGRITY_CHEKC_PASS         0x00
> -#define GEN5_BL_BLOCK_WRITE_RESP_LEN         11
> -#define GEN5_BL_READ_APP_INFO_RESP_LEN       31
> -#define GEN5_CMD_CALIBRATE                   0x28
> -#define CYAPA_SENSING_MODE_MUTUAL_CAP_FINE   0x00
> -#define CYAPA_SENSING_MODE_SELF_CAP          0x02
> -
> -#define GEN5_CMD_RETRIEVE_DATA_STRUCTURE     0x24
>  #define GEN5_RETRIEVE_MUTUAL_PWC_DATA        0x00
>  #define GEN5_RETRIEVE_SELF_CAP_PWC_DATA      0x01
>  
> @@ -170,23 +123,12 @@
>  #define GEN5_PANEL_SCAN_SELF_BASELINE        0x04
>  #define GEN5_PANEL_SCAN_SELF_DIFFCOUNT       0x05
>  
> -/* The offset only valid for reterive PWC and panel scan commands */
> +/* The offset only valid for retrieve PWC and panel scan commands */
>  #define GEN5_RESP_DATA_STRUCTURE_OFFSET      10
>  #define GEN5_PWC_DATA_ELEMENT_SIZE_MASK      0x07
>  
> -#define	GEN5_NUMBER_OF_TOUCH_OFFSET  5
> -#define GEN5_NUMBER_OF_TOUCH_MASK    0x1f
> -#define GEN5_BUTTONS_OFFSET          5
> -#define GEN5_BUTTONS_MASK            0x0f
> -#define GEN5_GET_EVENT_ID(reg)       (((reg) >> 5) & 0x03)
> -#define GEN5_GET_TOUCH_ID(reg)       ((reg) & 0x1f)
> -
> -#define GEN5_PRODUCT_FAMILY_MASK        0xf000
> -#define GEN5_PRODUCT_FAMILY_TRACKPAD    0x1000
> -
> -#define TSG_INVALID_CMD   0xff
>  
> -struct cyapa_gen5_touch_record {
> +struct cyapa_pip_touch_record {
>  	/*
>  	 * Bit 7 - 3: reserved
>  	 * Bit 2 - 0: touch type;
> @@ -221,7 +163,11 @@ struct cyapa_gen5_touch_record {
>  	/* Bit 15 - 8 of Y-axis coordinate of the touch in pixel. */
>  	u8 y_hi;
>  
> -	/* Touch intensity in counts, pressure value. */
> +	/*
> +	 * The meaning of this value is different when touch_type is different.
> +	 * For standard finger type:
> +	 *	Touch intensity in counts, pressure value.
> +	 **/
>  	u8 z;
>  
>  	/*
> @@ -260,9 +206,9 @@ struct cyapa_gen5_touch_record {
>  	u8 orientation;
>  } __packed;
>  
> -struct cyapa_gen5_report_data {
> -	u8 report_head[GEN5_TOUCH_REPORT_HEAD_SIZE];
> -	struct cyapa_gen5_touch_record touch_records[10];
> +struct cyapa_pip_report_data {
> +	u8 report_head[PIP_TOUCH_REPORT_HEAD_SIZE];
> +	struct cyapa_pip_touch_record touch_records[10];
>  } __packed;
>  
>  struct cyapa_tsg_bin_image_head {
> @@ -288,36 +234,36 @@ struct cyapa_tsg_bin_image {
>  	struct cyapa_tsg_bin_image_data_record records[0];
>  } __packed;
>  
> -struct gen5_bl_packet_start {
> +struct pip_bl_packet_start {
>  	u8 sop;  /* Start of packet, must be 01h */
>  	u8 cmd_code;
>  	__le16 data_length;  /* Size of data parameter start from data[0] */
>  } __packed;
>  
> -struct gen5_bl_packet_end {
> +struct pip_bl_packet_end {
>  	__le16 crc;
>  	u8 eop;  /* End of packet, must be 17h */
>  } __packed;
>  
> -struct gen5_bl_cmd_head {
> +struct pip_bl_cmd_head {
>  	__le16 addr;   /* Output report register address, must be 0004h */
>  	/* Size of packet not including output report register address */
>  	__le16 length;
>  	u8 report_id;  /* Bootloader output report id, must be 40h */
>  	u8 rsvd;  /* Reserved, must be 0 */
> -	struct gen5_bl_packet_start packet_start;
> +	struct pip_bl_packet_start packet_start;
>  	u8 data[0];  /* Command data variable based on commands */
>  } __packed;
>  
>  /* Initiate bootload command data structure. */
> -struct gen5_bl_initiate_cmd_data {
> +struct pip_bl_initiate_cmd_data {
>  	/* Key must be "A5h 01h 02h 03h FFh FEh FDh 5Ah" */
>  	u8 key[CYAPA_TSG_BL_KEY_SIZE];
>  	u8 metadata_raw_parameter[CYAPA_TSG_FLASH_MAP_METADATA_SIZE];
>  	__le16 metadata_crc;
>  } __packed;
>  
> -struct gen5_bl_metadata_row_params {
> +struct tsg_bl_metadata_row_params {
>  	__le16 size;
>  	__le16 maximum_size;
>  	__le32 app_start;
> @@ -332,13 +278,13 @@ struct gen5_bl_metadata_row_params {
>  } __packed;
>  
>  /* Bootload program and verify row command data structure */
> -struct gen5_bl_flash_row_head {
> +struct tsg_bl_flash_row_head {
>  	u8 flash_array_id;
>  	__le16 flash_row_id;
>  	u8 flash_data[0];
>  } __packed;
>  
> -struct gen5_app_cmd_head {
> +struct pip_app_cmd_head {
>  	__le16 addr;   /* Output report register address, must be 0004h */
>  	/* Size of packet not including output report register address */
>  	__le16 length;
> @@ -369,30 +315,26 @@ struct gen5_retrieve_panel_scan_data {
>  	u8 data_id;
>  } __packed;
>  
> -/* Variables to record latest gen5 trackpad power states. */
> -#define GEN5_DEV_SET_PWR_STATE(cyapa, s)	((cyapa)->dev_pwr_mode = (s))
> -#define GEN5_DEV_GET_PWR_STATE(cyapa)		((cyapa)->dev_pwr_mode)
> -#define GEN5_DEV_SET_SLEEP_TIME(cyapa, t)	((cyapa)->dev_sleep_time = (t))
> -#define GEN5_DEV_GET_SLEEP_TIME(cyapa)		((cyapa)->dev_sleep_time)
> -#define GEN5_DEV_UNINIT_SLEEP_TIME(cyapa)	\
> -		(((cyapa)->dev_sleep_time) == UNINIT_SLEEP_TIME)
> -
> +u8 pip_read_sys_info[] = { 0x04, 0x00, 0x05, 0x00, 0x2f, 0x00, 0x02 };
> +u8 pip_bl_read_app_info[] = { 0x04, 0x00, 0x0b, 0x00, 0x40, 0x00,
> +		0x01, 0x3c, 0x00, 0x00, 0xb0, 0x42, 0x17
> +	};
>  
> -static u8 cyapa_gen5_bl_cmd_key[] = { 0xa5, 0x01, 0x02, 0x03,
> +static u8 cyapa_pip_bl_cmd_key[] = { 0xa5, 0x01, 0x02, 0x03,
>  	0xff, 0xfe, 0xfd, 0x5a };
>  
> -static int cyapa_gen5_initialize(struct cyapa *cyapa)
> +int cyapa_pip_cmd_state_initialize(struct cyapa *cyapa)
>  {
> -	struct cyapa_gen5_cmd_states *gen5_pip = &cyapa->cmd_states.gen5;
> +	struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
>  
> -	init_completion(&gen5_pip->cmd_ready);
> -	atomic_set(&gen5_pip->cmd_issued, 0);
> -	mutex_init(&gen5_pip->cmd_lock);
> +	init_completion(&pip->cmd_ready);
> +	atomic_set(&pip->cmd_issued, 0);
> +	mutex_init(&pip->cmd_lock);
>  
> -	gen5_pip->resp_sort_func = NULL;
> -	gen5_pip->in_progress_cmd = TSG_INVALID_CMD;
> -	gen5_pip->resp_data = NULL;
> -	gen5_pip->resp_len = NULL;
> +	pip->resp_sort_func = NULL;
> +	pip->in_progress_cmd = PIP_INVALID_CMD;
> +	pip->resp_data = NULL;
> +	pip->resp_len = NULL;
>  
>  	cyapa->dev_pwr_mode = UNINIT_PWR_MODE;
>  	cyapa->dev_sleep_time = UNINIT_SLEEP_TIME;
> @@ -401,7 +343,7 @@ static int cyapa_gen5_initialize(struct cyapa *cyapa)
>  }
>  
>  /* Return negative errno, or else the number of bytes read. */
> -static ssize_t cyapa_i2c_pip_read(struct cyapa *cyapa, u8 *buf, size_t size)
> +ssize_t cyapa_i2c_pip_read(struct cyapa *cyapa, u8 *buf, size_t size)
>  {
>  	int ret;
>  
> @@ -415,14 +357,13 @@ static ssize_t cyapa_i2c_pip_read(struct cyapa *cyapa, u8 *buf, size_t size)
>  
>  	if (ret != size)
>  		return (ret < 0) ? ret : -EIO;
> -
>  	return size;
>  }
>  
>  /**
>   * Return a negative errno code else zero on success.
>   */
> -static ssize_t cyapa_i2c_pip_write(struct cyapa *cyapa, u8 *buf, size_t size)
> +ssize_t cyapa_i2c_pip_write(struct cyapa *cyapa, u8 *buf, size_t size)
>  {
>  	int ret;
>  
> @@ -441,10 +382,10 @@ static ssize_t cyapa_i2c_pip_write(struct cyapa *cyapa, u8 *buf, size_t size)
>   * This function is aimed to dump all not read data in Gen5 trackpad
>   * before send any command, otherwise, the interrupt line will be blocked.
>   */
> -static int cyapa_empty_pip_output_data(struct cyapa *cyapa,
> +int cyapa_empty_pip_output_data(struct cyapa *cyapa,
>  		u8 *buf, int *len, cb_sort func)
>  {
> -	struct cyapa_gen5_cmd_states *gen5_pip = &cyapa->cmd_states.gen5;
> +	struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
>  	int length;
>  	int report_count;
>  	int empty_count;
> @@ -476,13 +417,13 @@ static int cyapa_empty_pip_output_data(struct cyapa *cyapa,
>  		if (empty_count > 5)
>  			return 0;
>  
> -		error = cyapa_i2c_pip_read(cyapa, gen5_pip->empty_buf,
> -				GEN5_RESP_LENGTH_SIZE);
> +		error = cyapa_i2c_pip_read(cyapa, pip->empty_buf,
> +				PIP_RESP_LENGTH_SIZE);
>  		if (error < 0)
>  			return error;
>  
> -		length = get_unaligned_le16(gen5_pip->empty_buf);
> -		if (length == GEN5_RESP_LENGTH_SIZE) {
> +		length = get_unaligned_le16(pip->empty_buf);
> +		if (length == PIP_RESP_LENGTH_SIZE) {
>  			empty_count++;
>  			continue;
>  		} else if (length > CYAPA_REG_MAP_SIZE) {
> @@ -490,11 +431,11 @@ static int cyapa_empty_pip_output_data(struct cyapa *cyapa,
>  			return -EINVAL;
>  		} else if (length == 0) {
>  			/* Application or bootloader launch data polled out. */
> -			length = GEN5_RESP_LENGTH_SIZE;
> +			length = PIP_RESP_LENGTH_SIZE;
>  			if (buf && buf_len && func &&
> -				func(cyapa, gen5_pip->empty_buf, length)) {
> +				func(cyapa, pip->empty_buf, length)) {
>  				length = min(buf_len, length);
> -				memcpy(buf, gen5_pip->empty_buf, length);
> +				memcpy(buf, pip->empty_buf, length);
>  				*len = length;
>  				/* Response found, success. */
>  				return 0;
> @@ -502,19 +443,19 @@ static int cyapa_empty_pip_output_data(struct cyapa *cyapa,
>  			continue;
>  		}
>  
> -		error = cyapa_i2c_pip_read(cyapa, gen5_pip->empty_buf, length);
> +		error = cyapa_i2c_pip_read(cyapa, pip->empty_buf, length);
>  		if (error < 0)
>  			return error;
>  
>  		report_count--;
>  		empty_count = 0;
> -		length = get_unaligned_le16(gen5_pip->empty_buf);
> -		if (length <= GEN5_RESP_LENGTH_SIZE) {
> +		length = get_unaligned_le16(pip->empty_buf);
> +		if (length <= PIP_RESP_LENGTH_SIZE) {
>  			empty_count++;
>  		} else if (buf && buf_len && func &&
> -			func(cyapa, gen5_pip->empty_buf, length)) {
> +			func(cyapa, pip->empty_buf, length)) {
>  			length = min(buf_len, length);
> -			memcpy(buf, gen5_pip->empty_buf, length);
> +			memcpy(buf, pip->empty_buf, length);
>  			*len = length;
>  			/* Response found, success. */
>  			return 0;
> @@ -531,24 +472,24 @@ static int cyapa_do_i2c_pip_cmd_irq_sync(
>  		u8 *cmd, size_t cmd_len,
>  		unsigned long timeout)
>  {
> -	struct cyapa_gen5_cmd_states *gen5_pip = &cyapa->cmd_states.gen5;
> +	struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
>  	int error;
>  
>  	/* Wait for interrupt to set ready completion */
> -	init_completion(&gen5_pip->cmd_ready);
> +	init_completion(&pip->cmd_ready);
>  
> -	atomic_inc(&gen5_pip->cmd_issued);
> +	atomic_inc(&pip->cmd_issued);
>  	error = cyapa_i2c_pip_write(cyapa, cmd, cmd_len);
>  	if (error) {
> -		atomic_dec(&gen5_pip->cmd_issued);
> +		atomic_dec(&pip->cmd_issued);
>  		return (error < 0) ? error : -EIO;
>  	}
>  
>  	/* Wait for interrupt to indicate command is completed. */
> -	timeout = wait_for_completion_timeout(&gen5_pip->cmd_ready,
> +	timeout = wait_for_completion_timeout(&pip->cmd_ready,
>  				msecs_to_jiffies(timeout));
>  	if (timeout == 0) {
> -		atomic_dec(&gen5_pip->cmd_issued);
> +		atomic_dec(&pip->cmd_issued);
>  		return -ETIMEDOUT;
>  	}
>  
> @@ -562,15 +503,15 @@ static int cyapa_do_i2c_pip_cmd_polling(
>  		unsigned long timeout,
>  		cb_sort func)
>  {
> -	struct cyapa_gen5_cmd_states *gen5_pip = &cyapa->cmd_states.gen5;
> +	struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
>  	int tries;
>  	int length;
>  	int error;
>  
> -	atomic_inc(&gen5_pip->cmd_issued);
> +	atomic_inc(&pip->cmd_issued);
>  	error = cyapa_i2c_pip_write(cyapa, cmd, cmd_len);
>  	if (error) {
> -		atomic_dec(&gen5_pip->cmd_issued);
> +		atomic_dec(&pip->cmd_issued);
>  		return error < 0 ? error : -EIO;
>  	}
>  
> @@ -591,11 +532,11 @@ static int cyapa_do_i2c_pip_cmd_polling(
>  			error = error ? error : -ETIMEDOUT;
>  	}
>  
> -	atomic_dec(&gen5_pip->cmd_issued);
> +	atomic_dec(&pip->cmd_issued);
>  	return error;
>  }
>  
> -static int cyapa_i2c_pip_cmd_irq_sync(
> +int cyapa_i2c_pip_cmd_irq_sync(
>  		struct cyapa *cyapa,
>  		u8 *cmd, int cmd_len,
>  		u8 *resp_data, int *resp_len,
> @@ -603,34 +544,34 @@ static int cyapa_i2c_pip_cmd_irq_sync(
>  		cb_sort func,
>  		bool irq_mode)
>  {
> -	struct cyapa_gen5_cmd_states *gen5_pip = &cyapa->cmd_states.gen5;
> +	struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
>  	int error;
>  
>  	if (!cmd || !cmd_len)
>  		return -EINVAL;
>  
>  	/* Commands must be serialized. */
> -	error = mutex_lock_interruptible(&gen5_pip->cmd_lock);
> +	error = mutex_lock_interruptible(&pip->cmd_lock);
>  	if (error)
>  		return error;
>  
> -	gen5_pip->resp_sort_func = func;
> -	gen5_pip->resp_data = resp_data;
> -	gen5_pip->resp_len = resp_len;
> +	pip->resp_sort_func = func;
> +	pip->resp_data = resp_data;
> +	pip->resp_len = resp_len;
>  
> -	if (cmd_len >= GEN5_MIN_APP_CMD_LENGTH &&
> -			cmd[4] == GEN5_APP_CMD_REPORT_ID) {
> +	if (cmd_len >= PIP_MIN_APP_CMD_LENGTH &&
> +			cmd[4] == PIP_APP_CMD_REPORT_ID) {
>  		/* Application command */
> -		gen5_pip->in_progress_cmd = cmd[6] & 0x7f;
> -	} else if (cmd_len >= GEN5_MIN_BL_CMD_LENGTH &&
> -			cmd[4] == GEN5_BL_CMD_REPORT_ID) {
> +		pip->in_progress_cmd = cmd[6] & 0x7f;
> +	} else if (cmd_len >= PIP_MIN_BL_CMD_LENGTH &&
> +			cmd[4] == PIP_BL_CMD_REPORT_ID) {
>  		/* Bootloader command */
> -		gen5_pip->in_progress_cmd = cmd[7];
> +		pip->in_progress_cmd = cmd[7];
>  	}
>  
>  	/* Send command data, wait and read output response data's length. */
>  	if (irq_mode) {
> -		gen5_pip->is_irq_mode = true;
> +		pip->is_irq_mode = true;
>  		error = cyapa_do_i2c_pip_cmd_irq_sync(cyapa, cmd, cmd_len,
>  							timeout);
>  		if (error == -ETIMEDOUT && resp_data &&
> @@ -646,54 +587,54 @@ static int cyapa_i2c_pip_cmd_irq_sync(
>  				error = error ? error : -ETIMEDOUT;
>  		}
>  	} else {
> -		gen5_pip->is_irq_mode = false;
> +		pip->is_irq_mode = false;
>  		error = cyapa_do_i2c_pip_cmd_polling(cyapa, cmd, cmd_len,
>  				resp_data, resp_len, timeout, func);
>  	}
>  
> -	gen5_pip->resp_sort_func = NULL;
> -	gen5_pip->resp_data = NULL;
> -	gen5_pip->resp_len = NULL;
> -	gen5_pip->in_progress_cmd = TSG_INVALID_CMD;
> +	pip->resp_sort_func = NULL;
> +	pip->resp_data = NULL;
> +	pip->resp_len = NULL;
> +	pip->in_progress_cmd = PIP_INVALID_CMD;
>  
> -	mutex_unlock(&gen5_pip->cmd_lock);
> +	mutex_unlock(&pip->cmd_lock);
>  	return error;
>  }
>  
> -static bool cyapa_gen5_sort_tsg_pip_bl_resp_data(struct cyapa *cyapa,
> +bool cyapa_sort_tsg_pip_bl_resp_data(struct cyapa *cyapa,
>  		u8 *data, int len)
>  {
> -	if (!data || len < GEN5_MIN_BL_RESP_LENGTH)
> +	if (!data || len < PIP_MIN_BL_RESP_LENGTH)
>  		return false;
>  
>  	/* Bootloader input report id 30h */
> -	if (data[GEN5_RESP_REPORT_ID_OFFSET] == GEN5_BL_RESP_REPORT_ID &&
> -			data[GEN5_RESP_RSVD_OFFSET] == GEN5_RESP_RSVD_KEY &&
> -			data[GEN5_RESP_BL_SOP_OFFSET] == GEN5_SOP_KEY)
> +	if (data[PIP_RESP_REPORT_ID_OFFSET] == PIP_BL_RESP_REPORT_ID &&
> +			data[PIP_RESP_RSVD_OFFSET] == PIP_RESP_RSVD_KEY &&
> +			data[PIP_RESP_BL_SOP_OFFSET] == PIP_SOP_KEY)
>  		return true;
>  
>  	return false;
>  }
>  
> -static bool cyapa_gen5_sort_tsg_pip_app_resp_data(struct cyapa *cyapa,
> +bool cyapa_sort_tsg_pip_app_resp_data(struct cyapa *cyapa,
>  		u8 *data, int len)
>  {
> -	struct cyapa_gen5_cmd_states *gen5_pip = &cyapa->cmd_states.gen5;
> +	struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
>  	int resp_len;
>  
> -	if (!data || len < GEN5_MIN_APP_RESP_LENGTH)
> +	if (!data || len < PIP_MIN_APP_RESP_LENGTH)
>  		return false;
>  
> -	if (data[GEN5_RESP_REPORT_ID_OFFSET] == GEN5_APP_RESP_REPORT_ID &&
> -			data[GEN5_RESP_RSVD_OFFSET] == GEN5_RESP_RSVD_KEY) {
> -		resp_len = get_unaligned_le16(&data[GEN5_RESP_LENGTH_OFFSET]);
> -		if (GET_GEN5_CMD_CODE(data[GEN5_RESP_APP_CMD_OFFSET]) == 0x00 &&
> -			resp_len == GEN5_UNSUPPORTED_CMD_RESP_LENGTH &&
> -			data[5] == gen5_pip->in_progress_cmd) {
> +	if (data[PIP_RESP_REPORT_ID_OFFSET] == PIP_APP_RESP_REPORT_ID &&
> +			data[PIP_RESP_RSVD_OFFSET] == PIP_RESP_RSVD_KEY) {
> +		resp_len = get_unaligned_le16(&data[PIP_RESP_LENGTH_OFFSET]);
> +		if (GET_PIP_CMD_CODE(data[PIP_RESP_APP_CMD_OFFSET]) == 0x00 &&
> +			resp_len == PIP_UNSUPPORTED_CMD_RESP_LENGTH &&
> +			data[5] == pip->in_progress_cmd) {
>  			/* Unsupported command code */
>  			return false;
> -		} else if (GET_GEN5_CMD_CODE(data[GEN5_RESP_APP_CMD_OFFSET]) ==
> -				gen5_pip->in_progress_cmd) {
> +		} else if (GET_PIP_CMD_CODE(data[PIP_RESP_APP_CMD_OFFSET]) ==
> +				pip->in_progress_cmd) {
>  			/* Correct command response received */
>  			return true;
>  		}
> @@ -702,10 +643,10 @@ static bool cyapa_gen5_sort_tsg_pip_app_resp_data(struct cyapa *cyapa,
>  	return false;
>  }
>  
> -static bool cyapa_gen5_sort_application_launch_data(struct cyapa *cyapa,
> +static bool cyapa_sort_pip_application_launch_data(struct cyapa *cyapa,
>  		u8 *buf, int len)
>  {
> -	if (buf == NULL || len < GEN5_RESP_LENGTH_SIZE)
> +	if (buf == NULL || len < PIP_RESP_LENGTH_SIZE)
>  		return false;
>  
>  	/*
> @@ -718,25 +659,25 @@ static bool cyapa_gen5_sort_application_launch_data(struct cyapa *cyapa,
>  	return false;
>  }
>  
> -static bool cyapa_gen5_sort_hid_descriptor_data(struct cyapa *cyapa,
> +static bool cyapa_sort_gen5_hid_descriptor_data(struct cyapa *cyapa,
>  		u8 *buf, int len)
>  {
>  	int resp_len;
>  	int max_output_len;
>  
>  	/* Check hid descriptor. */
> -	if (len != GEN5_HID_DESCRIPTOR_SIZE)
> +	if (len != PIP_HID_DESCRIPTOR_SIZE)
>  		return false;
>  
> -	resp_len = get_unaligned_le16(&buf[GEN5_RESP_LENGTH_OFFSET]);
> +	resp_len = get_unaligned_le16(&buf[PIP_RESP_LENGTH_OFFSET]);
>  	max_output_len = get_unaligned_le16(&buf[16]);
> -	if (resp_len == GEN5_HID_DESCRIPTOR_SIZE) {
> -		if (buf[GEN5_RESP_REPORT_ID_OFFSET] == GEN5_BL_HID_REPORT_ID &&
> +	if (resp_len == PIP_HID_DESCRIPTOR_SIZE) {
> +		if (buf[PIP_RESP_REPORT_ID_OFFSET] == PIP_HID_BL_REPORT_ID &&
>  				max_output_len == GEN5_BL_MAX_OUTPUT_LENGTH) {
>  			/* BL mode HID Descriptor */
>  			return true;
> -		} else if ((buf[GEN5_RESP_REPORT_ID_OFFSET] ==
> -				GEN5_APP_HID_REPORT_ID) &&
> +		} else if ((buf[PIP_RESP_REPORT_ID_OFFSET] ==
> +				PIP_HID_APP_REPORT_ID) &&
>  				max_output_len == GEN5_APP_MAX_OUTPUT_LENGTH) {
>  			/* APP mode HID Descriptor */
>  			return true;
> @@ -746,21 +687,21 @@ static bool cyapa_gen5_sort_hid_descriptor_data(struct cyapa *cyapa,
>  	return false;
>  }
>  
> -static bool cyapa_gen5_sort_deep_sleep_data(struct cyapa *cyapa,
> +static bool cyapa_sort_pip_deep_sleep_data(struct cyapa *cyapa,
>  		u8 *buf, int len)
>  {
> -	if (len == GEN5_DEEP_SLEEP_RESP_LENGTH &&
> -		buf[GEN5_RESP_REPORT_ID_OFFSET] ==
> -			GEN5_APP_DEEP_SLEEP_REPORT_ID &&
> -		(buf[4] & GEN5_DEEP_SLEEP_OPCODE_MASK) ==
> -			GEN5_DEEP_SLEEP_OPCODE)
> +	if (len == PIP_DEEP_SLEEP_RESP_LENGTH &&
> +		buf[PIP_RESP_REPORT_ID_OFFSET] ==
> +			PIP_APP_DEEP_SLEEP_REPORT_ID &&
> +		(buf[4] & PIP_DEEP_SLEEP_OPCODE_MASK) ==
> +			PIP_DEEP_SLEEP_OPCODE)
>  		return true;
>  	return false;
>  }
>  
>  static int gen5_idle_state_parse(struct cyapa *cyapa)
>  {
> -	u8 resp_data[GEN5_HID_DESCRIPTOR_SIZE];
> +	u8 resp_data[PIP_HID_DESCRIPTOR_SIZE];
>  	int max_output_len;
>  	int length;
>  	u8 cmd[2];
> @@ -778,9 +719,9 @@ static int gen5_idle_state_parse(struct cyapa *cyapa)
>  	if (ret != 3)
>  		return ret < 0 ? ret : -EIO;
>  
> -	length = get_unaligned_le16(&resp_data[GEN5_RESP_LENGTH_OFFSET]);
> -	if (length == GEN5_RESP_LENGTH_SIZE) {
> -		/* Normal state of Gen5 with no data to respose */
> +	length = get_unaligned_le16(&resp_data[PIP_RESP_LENGTH_OFFSET]);
> +	if (length == PIP_RESP_LENGTH_SIZE) {
> +		/* Normal state of Gen5 with no data to response */
>  		cyapa->gen = CYAPA_GEN5;
>  
>  		cyapa_empty_pip_output_data(cyapa, NULL, NULL, NULL);
> @@ -788,30 +729,30 @@ static int gen5_idle_state_parse(struct cyapa *cyapa)
>  		/* Read description from trackpad device */
>  		cmd[0] = 0x01;
>  		cmd[1] = 0x00;
> -		length = GEN5_HID_DESCRIPTOR_SIZE;
> +		length = PIP_HID_DESCRIPTOR_SIZE;
>  		error = cyapa_i2c_pip_cmd_irq_sync(cyapa,
> -				cmd, GEN5_RESP_LENGTH_SIZE,
> +				cmd, PIP_RESP_LENGTH_SIZE,
>  				resp_data, &length,
>  				300,
> -				cyapa_gen5_sort_hid_descriptor_data,
> +				cyapa_sort_gen5_hid_descriptor_data,
>  				false);
>  		if (error)
>  			return error;
>  
>  		length = get_unaligned_le16(
> -				&resp_data[GEN5_RESP_LENGTH_OFFSET]);
> +				&resp_data[PIP_RESP_LENGTH_OFFSET]);
>  		max_output_len = get_unaligned_le16(&resp_data[16]);
> -		if ((length == GEN5_HID_DESCRIPTOR_SIZE ||
> -				length == GEN5_RESP_LENGTH_SIZE) &&
> -			(resp_data[GEN5_RESP_REPORT_ID_OFFSET] ==
> -				GEN5_BL_HID_REPORT_ID) &&
> +		if ((length == PIP_HID_DESCRIPTOR_SIZE ||
> +				length == PIP_RESP_LENGTH_SIZE) &&
> +			(resp_data[PIP_RESP_REPORT_ID_OFFSET] ==
> +				PIP_HID_BL_REPORT_ID) &&
>  			max_output_len == GEN5_BL_MAX_OUTPUT_LENGTH) {
>  			/* BL mode HID Description read */
>  			cyapa->state = CYAPA_STATE_GEN5_BL;
> -		} else if ((length == GEN5_HID_DESCRIPTOR_SIZE ||
> -				length == GEN5_RESP_LENGTH_SIZE) &&
> -			(resp_data[GEN5_RESP_REPORT_ID_OFFSET] ==
> -				GEN5_APP_HID_REPORT_ID) &&
> +		} else if ((length == PIP_HID_DESCRIPTOR_SIZE ||
> +				length == PIP_RESP_LENGTH_SIZE) &&
> +			(resp_data[PIP_RESP_REPORT_ID_OFFSET] ==
> +				PIP_HID_APP_REPORT_ID) &&
>  			max_output_len == GEN5_APP_MAX_OUTPUT_LENGTH) {
>  			/* APP mode HID Description read */
>  			cyapa->state = CYAPA_STATE_GEN5_APP;
> @@ -839,14 +780,14 @@ static int gen5_hid_description_header_parse(struct cyapa *cyapa, u8 *reg_data)
>  	 * or report any touch or button data.
>  	 */
>  	ret = cyapa_i2c_pip_read(cyapa, resp_data,
> -			GEN5_HID_DESCRIPTOR_SIZE);
> -	if (ret != GEN5_HID_DESCRIPTOR_SIZE)
> +			PIP_HID_DESCRIPTOR_SIZE);
> +	if (ret != PIP_HID_DESCRIPTOR_SIZE)
>  		return ret < 0 ? ret : -EIO;
> -	length = get_unaligned_le16(&resp_data[GEN5_RESP_LENGTH_OFFSET]);
> +	length = get_unaligned_le16(&resp_data[PIP_RESP_LENGTH_OFFSET]);
>  	max_output_len = get_unaligned_le16(&resp_data[16]);
> -	if (length == GEN5_RESP_LENGTH_SIZE) {
> -		if (reg_data[GEN5_RESP_REPORT_ID_OFFSET] ==
> -				GEN5_BL_HID_REPORT_ID) {
> +	if (length == PIP_RESP_LENGTH_SIZE) {
> +		if (reg_data[PIP_RESP_REPORT_ID_OFFSET] ==
> +				PIP_HID_BL_REPORT_ID) {
>  			/*
>  			 * BL mode HID Description has been previously
>  			 * read out.
> @@ -861,15 +802,15 @@ static int gen5_hid_description_header_parse(struct cyapa *cyapa, u8 *reg_data)
>  			cyapa->gen = CYAPA_GEN5;
>  			cyapa->state = CYAPA_STATE_GEN5_APP;
>  		}
> -	} else if (length == GEN5_HID_DESCRIPTOR_SIZE &&
> -			resp_data[2] == GEN5_BL_HID_REPORT_ID &&
> +	} else if (length == PIP_HID_DESCRIPTOR_SIZE &&
> +			resp_data[2] == PIP_HID_BL_REPORT_ID &&
>  			max_output_len == GEN5_BL_MAX_OUTPUT_LENGTH) {
>  		/* BL mode HID Description read. */
>  		cyapa->gen = CYAPA_GEN5;
>  		cyapa->state = CYAPA_STATE_GEN5_BL;
> -	} else if (length == GEN5_HID_DESCRIPTOR_SIZE &&
> -			(resp_data[GEN5_RESP_REPORT_ID_OFFSET] ==
> -				GEN5_APP_HID_REPORT_ID) &&
> +	} else if (length == PIP_HID_DESCRIPTOR_SIZE &&
> +			(resp_data[PIP_RESP_REPORT_ID_OFFSET] ==
> +				PIP_HID_APP_REPORT_ID) &&
>  			max_output_len == GEN5_APP_MAX_OUTPUT_LENGTH) {
>  		/* APP mode HID Description read. */
>  		cyapa->gen = CYAPA_GEN5;
> @@ -886,22 +827,22 @@ static int gen5_report_data_header_parse(struct cyapa *cyapa, u8 *reg_data)
>  {
>  	int length;
>  
> -	length = get_unaligned_le16(&reg_data[GEN5_RESP_LENGTH_OFFSET]);
> -	switch (reg_data[GEN5_RESP_REPORT_ID_OFFSET]) {
> -	case GEN5_TOUCH_REPORT_ID:
> -		if (length < GEN5_TOUCH_REPORT_HEAD_SIZE ||
> -			length > GEN5_TOUCH_REPORT_MAX_SIZE)
> +	length = get_unaligned_le16(&reg_data[PIP_RESP_LENGTH_OFFSET]);
> +	switch (reg_data[PIP_RESP_REPORT_ID_OFFSET]) {
> +	case PIP_TOUCH_REPORT_ID:
> +		if (length < PIP_TOUCH_REPORT_HEAD_SIZE ||
> +			length > PIP_TOUCH_REPORT_MAX_SIZE)
>  			return -EINVAL;
>  		break;
> -	case GEN5_BTN_REPORT_ID:
> +	case PIP_BTN_REPORT_ID:
>  	case GEN5_OLD_PUSH_BTN_REPORT_ID:
> -	case GEN5_PUSH_BTN_REPORT_ID:
> -		if (length < GEN5_BTN_REPORT_HEAD_SIZE ||
> -			length > GEN5_BTN_REPORT_MAX_SIZE)
> +	case PIP_PUSH_BTN_REPORT_ID:
> +		if (length < PIP_BTN_REPORT_HEAD_SIZE ||
> +			length > PIP_BTN_REPORT_MAX_SIZE)
>  			return -EINVAL;
>  		break;
> -	case GEN5_WAKEUP_EVENT_REPORT_ID:
> -		if (length != GEN5_WAKEUP_EVENT_SIZE)
> +	case PIP_WAKEUP_EVENT_REPORT_ID:
> +		if (length != PIP_WAKEUP_EVENT_SIZE)
>  			return -EINVAL;
>  		break;
>  	default:
> @@ -915,7 +856,7 @@ static int gen5_report_data_header_parse(struct cyapa *cyapa, u8 *reg_data)
>  
>  static int gen5_cmd_resp_header_parse(struct cyapa *cyapa, u8 *reg_data)
>  {
> -	struct cyapa_gen5_cmd_states *gen5_pip = &cyapa->cmd_states.gen5;
> +	struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
>  	int length;
>  	int ret;
>  
> @@ -924,15 +865,15 @@ static int gen5_cmd_resp_header_parse(struct cyapa *cyapa, u8 *reg_data)
>  	 * otherwise Gen5 trackpad cannot response next command
>  	 * or report any touch or button data.
>  	 */
> -	length = get_unaligned_le16(&reg_data[GEN5_RESP_LENGTH_OFFSET]);
> -	ret = cyapa_i2c_pip_read(cyapa, gen5_pip->empty_buf, length);
> +	length = get_unaligned_le16(&reg_data[PIP_RESP_LENGTH_OFFSET]);
> +	ret = cyapa_i2c_pip_read(cyapa, pip->empty_buf, length);
>  	if (ret != length)
>  		return ret < 0 ? ret : -EIO;
>  
> -	if (length == GEN5_RESP_LENGTH_SIZE) {
> +	if (length == PIP_RESP_LENGTH_SIZE) {
>  		/* Previous command has read the data through out. */
> -		if (reg_data[GEN5_RESP_REPORT_ID_OFFSET] ==
> -				GEN5_BL_RESP_REPORT_ID) {
> +		if (reg_data[PIP_RESP_REPORT_ID_OFFSET] ==
> +				PIP_BL_RESP_REPORT_ID) {
>  			/* Gen5 BL command response data detected */
>  			cyapa->gen = CYAPA_GEN5;
>  			cyapa->state = CYAPA_STATE_GEN5_BL;
> @@ -941,21 +882,21 @@ static int gen5_cmd_resp_header_parse(struct cyapa *cyapa, u8 *reg_data)
>  			cyapa->gen = CYAPA_GEN5;
>  			cyapa->state = CYAPA_STATE_GEN5_APP;
>  		}
> -	} else if ((gen5_pip->empty_buf[GEN5_RESP_REPORT_ID_OFFSET] ==
> -				GEN5_BL_RESP_REPORT_ID) &&
> -			(gen5_pip->empty_buf[GEN5_RESP_RSVD_OFFSET] ==
> -				GEN5_RESP_RSVD_KEY) &&
> -			(gen5_pip->empty_buf[GEN5_RESP_BL_SOP_OFFSET] ==
> -				GEN5_SOP_KEY) &&
> -			(gen5_pip->empty_buf[length - 1] ==
> -				GEN5_EOP_KEY)) {
> +	} else if ((pip->empty_buf[PIP_RESP_REPORT_ID_OFFSET] ==
> +				PIP_BL_RESP_REPORT_ID) &&
> +			(pip->empty_buf[PIP_RESP_RSVD_OFFSET] ==
> +				PIP_RESP_RSVD_KEY) &&
> +			(pip->empty_buf[PIP_RESP_BL_SOP_OFFSET] ==
> +				PIP_SOP_KEY) &&
> +			(pip->empty_buf[length - 1] ==
> +				PIP_EOP_KEY)) {
>  		/* Gen5 BL command response data detected */
>  		cyapa->gen = CYAPA_GEN5;
>  		cyapa->state = CYAPA_STATE_GEN5_BL;
> -	} else if (gen5_pip->empty_buf[GEN5_RESP_REPORT_ID_OFFSET] ==
> -				GEN5_APP_RESP_REPORT_ID &&
> -			gen5_pip->empty_buf[GEN5_RESP_RSVD_OFFSET] ==
> -				GEN5_RESP_RSVD_KEY) {
> +	} else if (pip->empty_buf[PIP_RESP_REPORT_ID_OFFSET] ==
> +				PIP_APP_RESP_REPORT_ID &&
> +			pip->empty_buf[PIP_RESP_RSVD_OFFSET] ==
> +				PIP_RESP_RSVD_KEY) {
>  		/* Gen5 APP command response data detected */
>  		cyapa->gen = CYAPA_GEN5;
>  		cyapa->state = CYAPA_STATE_GEN5_APP;
> @@ -977,12 +918,12 @@ static int cyapa_gen5_state_parse(struct cyapa *cyapa, u8 *reg_data, int len)
>  	cyapa->state = CYAPA_STATE_NO_DEVICE;
>  
>  	/* Parse based on Gen5 characteristic registers and bits */
> -	length = get_unaligned_le16(&reg_data[GEN5_RESP_LENGTH_OFFSET]);
> -	if (length == 0 || length == GEN5_RESP_LENGTH_SIZE) {
> +	length = get_unaligned_le16(&reg_data[PIP_RESP_LENGTH_OFFSET]);
> +	if (length == 0 || length == PIP_RESP_LENGTH_SIZE) {
>  		gen5_idle_state_parse(cyapa);
> -	} else if (length == GEN5_HID_DESCRIPTOR_SIZE &&
> -			(reg_data[2] == GEN5_BL_HID_REPORT_ID ||
> -				reg_data[2] == GEN5_APP_HID_REPORT_ID)) {
> +	} else if (length == PIP_HID_DESCRIPTOR_SIZE &&
> +			(reg_data[2] == PIP_HID_BL_REPORT_ID ||
> +				reg_data[2] == PIP_HID_APP_REPORT_ID)) {
>  		gen5_hid_description_header_parse(cyapa, reg_data);
>  	} else if ((length == GEN5_APP_REPORT_DESCRIPTOR_SIZE ||
>  			length == GEN5_APP_CONTRACT_REPORT_DESCRIPTOR_SIZE) &&
> @@ -992,17 +933,17 @@ static int cyapa_gen5_state_parse(struct cyapa *cyapa, u8 *reg_data, int len)
>  		cyapa->state = CYAPA_STATE_GEN5_APP;
>  	} else if (length == GEN5_BL_REPORT_DESCRIPTOR_SIZE &&
>  			reg_data[2] == GEN5_BL_REPORT_DESCRIPTOR_ID) {
> -		/* 0x1D 0x00 0xFE is Gen5 BL report descriptior header. */
> +		/* 0x1D 0x00 0xFE is Gen5 BL report descriptor header. */
>  		cyapa->gen = CYAPA_GEN5;
>  		cyapa->state = CYAPA_STATE_GEN5_BL;
> -	} else if (reg_data[2] == GEN5_TOUCH_REPORT_ID ||
> -			reg_data[2] == GEN5_BTN_REPORT_ID ||
> +	} else if (reg_data[2] == PIP_TOUCH_REPORT_ID ||
> +			reg_data[2] == PIP_BTN_REPORT_ID ||
>  			reg_data[2] == GEN5_OLD_PUSH_BTN_REPORT_ID ||
> -			reg_data[2] == GEN5_PUSH_BTN_REPORT_ID ||
> -			reg_data[2] == GEN5_WAKEUP_EVENT_REPORT_ID) {
> +			reg_data[2] == PIP_PUSH_BTN_REPORT_ID ||
> +			reg_data[2] == PIP_WAKEUP_EVENT_REPORT_ID) {
>  		gen5_report_data_header_parse(cyapa, reg_data);
> -	} else if (reg_data[2] == GEN5_BL_RESP_REPORT_ID ||
> -			reg_data[2] == GEN5_APP_RESP_REPORT_ID) {
> +	} else if (reg_data[2] == PIP_BL_RESP_REPORT_ID ||
> +			reg_data[2] == PIP_APP_RESP_REPORT_ID) {
>  		gen5_cmd_resp_header_parse(cyapa, reg_data);
>  	}
>  
> @@ -1023,14 +964,25 @@ static int cyapa_gen5_state_parse(struct cyapa *cyapa, u8 *reg_data, int len)
>  	return -EAGAIN;
>  }
>  
> -static int cyapa_gen5_bl_initiate(struct cyapa *cyapa,
> -		const struct firmware *fw)
> +static struct cyapa_tsg_bin_image_data_record *
> +cyapa_get_image_record_data_num(const struct firmware *fw,
> +		int *record_num)
> +{
> +	int head_size;
> +
> +	head_size = fw->data[0] + 1;
> +	*record_num = (fw->size - head_size) /
> +			sizeof(struct cyapa_tsg_bin_image_data_record);
> +	return (struct cyapa_tsg_bin_image_data_record *)&fw->data[head_size];
> +}
> +
> +int cyapa_pip_bl_initiate(struct cyapa *cyapa, const struct firmware *fw)
>  {
> -	struct cyapa_tsg_bin_image *image;
> -	struct gen5_bl_cmd_head *bl_cmd_head;
> -	struct gen5_bl_packet_start *bl_packet_start;
> -	struct gen5_bl_initiate_cmd_data *cmd_data;
> -	struct gen5_bl_packet_end *bl_packet_end;
> +	struct cyapa_tsg_bin_image_data_record *image_records;
> +	struct pip_bl_cmd_head *bl_cmd_head;
> +	struct pip_bl_packet_start *bl_packet_start;
> +	struct pip_bl_initiate_cmd_data *cmd_data;
> +	struct pip_bl_packet_end *bl_packet_end;
>  	u8 cmd[CYAPA_TSG_MAX_CMD_SIZE];
>  	int cmd_len;
>  	u16 cmd_data_len;
> @@ -1046,30 +998,28 @@ static int cyapa_gen5_bl_initiate(struct cyapa *cyapa,
>  	cyapa_empty_pip_output_data(cyapa, NULL, NULL, NULL);
>  
>  	memset(cmd, 0, CYAPA_TSG_MAX_CMD_SIZE);
> -	bl_cmd_head = (struct gen5_bl_cmd_head *)cmd;
> +	bl_cmd_head = (struct pip_bl_cmd_head *)cmd;
>  	cmd_data_len = CYAPA_TSG_BL_KEY_SIZE + CYAPA_TSG_FLASH_MAP_BLOCK_SIZE;
> -	cmd_len = sizeof(struct gen5_bl_cmd_head) + cmd_data_len +
> -		  sizeof(struct gen5_bl_packet_end);
> +	cmd_len = sizeof(struct pip_bl_cmd_head) + cmd_data_len +
> +		  sizeof(struct pip_bl_packet_end);
>  
> -	put_unaligned_le16(GEN5_OUTPUT_REPORT_ADDR, &bl_cmd_head->addr);
> +	put_unaligned_le16(PIP_OUTPUT_REPORT_ADDR, &bl_cmd_head->addr);
>  	put_unaligned_le16(cmd_len - 2, &bl_cmd_head->length);
> -	bl_cmd_head->report_id = GEN5_BL_CMD_REPORT_ID;
> +	bl_cmd_head->report_id = PIP_BL_CMD_REPORT_ID;
>  
>  	bl_packet_start = &bl_cmd_head->packet_start;
> -	bl_packet_start->sop = GEN5_SOP_KEY;
> -	bl_packet_start->cmd_code = GEN5_BL_CMD_INITIATE_BL;
> +	bl_packet_start->sop = PIP_SOP_KEY;
> +	bl_packet_start->cmd_code = PIP_BL_CMD_INITIATE_BL;
>  	/* 8 key bytes and 128 bytes block size */
>  	put_unaligned_le16(cmd_data_len, &bl_packet_start->data_length);
>  
> -	cmd_data = (struct gen5_bl_initiate_cmd_data *)bl_cmd_head->data;
> -	memcpy(cmd_data->key, cyapa_gen5_bl_cmd_key, CYAPA_TSG_BL_KEY_SIZE);
> +	cmd_data = (struct pip_bl_initiate_cmd_data *)bl_cmd_head->data;
> +	memcpy(cmd_data->key, cyapa_pip_bl_cmd_key, CYAPA_TSG_BL_KEY_SIZE);
> +
> +	image_records = cyapa_get_image_record_data_num(fw, &records_num);
>  
> -	/* Copy 60 bytes Meta Data Row Parameters */
> -	image = (struct cyapa_tsg_bin_image *)fw->data;
> -	records_num = (fw->size - sizeof(struct cyapa_tsg_bin_image_head)) /
> -				sizeof(struct cyapa_tsg_bin_image_data_record);
>  	/* APP_INTEGRITY row is always the last row block */
> -	data = image->records[records_num - 1].record_data;
> +	data = image_records[records_num - 1].record_data;
>  	memcpy(cmd_data->metadata_raw_parameter, data,
>  		CYAPA_TSG_FLASH_MAP_METADATA_SIZE);
>  
> @@ -1077,47 +1027,47 @@ static int cyapa_gen5_bl_initiate(struct cyapa *cyapa,
>  				CYAPA_TSG_FLASH_MAP_METADATA_SIZE);
>  	put_unaligned_le16(meta_data_crc, &cmd_data->metadata_crc);
>  
> -	bl_packet_end = (struct gen5_bl_packet_end *)(bl_cmd_head->data +
> +	bl_packet_end = (struct pip_bl_packet_end *)(bl_cmd_head->data +
>  				cmd_data_len);
>  	cmd_crc = crc_itu_t(0xffff, (u8 *)bl_packet_start,
> -		sizeof(struct gen5_bl_packet_start) + cmd_data_len);
> +		sizeof(struct pip_bl_packet_start) + cmd_data_len);
>  	put_unaligned_le16(cmd_crc, &bl_packet_end->crc);
> -	bl_packet_end->eop = GEN5_EOP_KEY;
> +	bl_packet_end->eop = PIP_EOP_KEY;
>  
>  	resp_len = sizeof(resp_data);
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa,
>  			cmd, cmd_len,
>  			resp_data, &resp_len, 12000,
> -			cyapa_gen5_sort_tsg_pip_bl_resp_data, true);
> -	if (error || resp_len != GEN5_BL_INITIATE_RESP_LEN ||
> -			resp_data[2] != GEN5_BL_RESP_REPORT_ID ||
> -			!GEN5_CMD_COMPLETE_SUCCESS(resp_data[5]))
> +			cyapa_sort_tsg_pip_bl_resp_data, true);
> +	if (error || resp_len != PIP_BL_INITIATE_RESP_LEN ||
> +			resp_data[2] != PIP_BL_RESP_REPORT_ID ||
> +			!PIP_CMD_COMPLETE_SUCCESS(resp_data))
>  		return error ? error : -EAGAIN;
>  
>  	return 0;
>  }
>  
> -static bool cyapa_gen5_sort_bl_exit_data(struct cyapa *cyapa, u8 *buf, int len)
> +static bool cyapa_sort_pip_bl_exit_data(struct cyapa *cyapa, u8 *buf, int len)
>  {
> -	if (buf == NULL || len < GEN5_RESP_LENGTH_SIZE)
> +	if (buf == NULL || len < PIP_RESP_LENGTH_SIZE)
>  		return false;
>  
>  	if (buf[0] == 0 && buf[1] == 0)
>  		return true;
>  
>  	/* Exit bootloader failed for some reason. */
> -	if (len == GEN5_BL_FAIL_EXIT_RESP_LEN &&
> -			buf[GEN5_RESP_REPORT_ID_OFFSET] ==
> -				GEN5_BL_RESP_REPORT_ID &&
> -			buf[GEN5_RESP_RSVD_OFFSET] == GEN5_RESP_RSVD_KEY &&
> -			buf[GEN5_RESP_BL_SOP_OFFSET] == GEN5_SOP_KEY &&
> -			buf[10] == GEN5_EOP_KEY)
> +	if (len == PIP_BL_FAIL_EXIT_RESP_LEN &&
> +			buf[PIP_RESP_REPORT_ID_OFFSET] ==
> +				PIP_BL_RESP_REPORT_ID &&
> +			buf[PIP_RESP_RSVD_OFFSET] == PIP_RESP_RSVD_KEY &&
> +			buf[PIP_RESP_BL_SOP_OFFSET] == PIP_SOP_KEY &&
> +			buf[10] == PIP_EOP_KEY)
>  		return true;
>  
>  	return false;
>  }
>  
> -static int cyapa_gen5_bl_exit(struct cyapa *cyapa)
> +int cyapa_pip_bl_exit(struct cyapa *cyapa)
>  {
>  
>  	u8 bl_gen5_bl_exit[] = { 0x04, 0x00,
> @@ -1132,13 +1082,13 @@ static int cyapa_gen5_bl_exit(struct cyapa *cyapa)
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa,
>  			bl_gen5_bl_exit, sizeof(bl_gen5_bl_exit),
>  			resp_data, &resp_len,
> -			5000, cyapa_gen5_sort_bl_exit_data, false);
> +			5000, cyapa_sort_pip_bl_exit_data, false);
>  	if (error)
>  		return error;
>  
> -	if (resp_len == GEN5_BL_FAIL_EXIT_RESP_LEN ||
> -			resp_data[GEN5_RESP_REPORT_ID_OFFSET] ==
> -				GEN5_BL_RESP_REPORT_ID)
> +	if (resp_len == PIP_BL_FAIL_EXIT_RESP_LEN ||
> +			resp_data[PIP_RESP_REPORT_ID_OFFSET] ==
> +				PIP_BL_RESP_REPORT_ID)
>  		return -EAGAIN;
>  
>  	if (resp_data[0] == 0x00 && resp_data[1] == 0x00)
> @@ -1147,7 +1097,7 @@ static int cyapa_gen5_bl_exit(struct cyapa *cyapa)
>  	return -ENODEV;
>  }
>  
> -static int cyapa_gen5_bl_enter(struct cyapa *cyapa)
> +int cyapa_pip_bl_enter(struct cyapa *cyapa)
>  {
>  	u8 cmd[] = { 0x04, 0x00, 0x05, 0x00, 0x2F, 0x00, 0x01 };
>  	u8 resp_data[2];
> @@ -1157,15 +1107,12 @@ static int cyapa_gen5_bl_enter(struct cyapa *cyapa)
>  	error = cyapa_poll_state(cyapa, 500);
>  	if (error < 0)
>  		return error;
> -	if (cyapa->gen != CYAPA_GEN5)
> -		return -EINVAL;
>  
> -	/* Already in Gen5 BL. Skipping exit. */
> -	if (cyapa->state == CYAPA_STATE_GEN5_BL)
> +	/* Already in bootloader mode, Skipping exit. */
> +	if (cyapa_is_pip_bl_mode(cyapa))
>  		return 0;
> -
> -	if (cyapa->state != CYAPA_STATE_GEN5_APP)
> -		return -EAGAIN;
> +	else if (!cyapa_is_pip_app_mode(cyapa))
> +		return -EINVAL;
>  
>  	/* Try to dump all buffered report data before any send command. */
>  	cyapa_empty_pip_output_data(cyapa, NULL, NULL, NULL);
> @@ -1179,39 +1126,38 @@ static int cyapa_gen5_bl_enter(struct cyapa *cyapa)
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa,
>  			cmd, sizeof(cmd),
>  			resp_data, &resp_len,
> -			5000, cyapa_gen5_sort_application_launch_data,
> +			5000, cyapa_sort_pip_application_launch_data,
>  			true);
>  	if (error || resp_data[0] != 0x00 || resp_data[1] != 0x00)
>  		return error < 0 ? error : -EAGAIN;
>  
>  	cyapa->operational = false;
> -	cyapa->state = CYAPA_STATE_GEN5_BL;
> +	if (cyapa->gen == CYAPA_GEN5)
> +		cyapa->state = CYAPA_STATE_GEN5_BL;
>  	return 0;
>  }
>  
> -static int cyapa_gen5_check_fw(struct cyapa *cyapa, const struct firmware *fw)
> +int cyapa_pip_check_fw(struct cyapa *cyapa, const struct firmware *fw)
>  {
>  	struct device *dev = &cyapa->client->dev;
> -	const struct cyapa_tsg_bin_image *image = (const void *)fw->data;
> +	struct cyapa_tsg_bin_image_data_record *image_records;
>  	const struct cyapa_tsg_bin_image_data_record *app_integrity;
> -	const struct gen5_bl_metadata_row_params *metadata;
> -	size_t flash_records_count;
> +	const struct tsg_bl_metadata_row_params *metadata;
> +	int flash_records_count;
>  	u32 fw_app_start, fw_upgrade_start;
>  	u16 fw_app_len, fw_upgrade_len;
>  	u16 app_crc;
>  	u16 app_integrity_crc;
> -	int record_index;
>  	int i;
>  
> -	flash_records_count = (fw->size -
> -			sizeof(struct cyapa_tsg_bin_image_head)) /
> -			sizeof(struct cyapa_tsg_bin_image_data_record);
> +	image_records =
> +		cyapa_get_image_record_data_num(fw, &flash_records_count);
>  
>  	/*
>  	 * APP_INTEGRITY row is always the last row block,
>  	 * and the row id must be 0x01ff.
>  	 */
> -	app_integrity = &image->records[flash_records_count - 1];
> +	app_integrity = &image_records[flash_records_count - 1];
>  
>  	if (app_integrity->flash_array_id != 0x00 ||
>  	    get_unaligned_be16(&app_integrity->row_number) != 0x01ff) {
> @@ -1242,14 +1188,11 @@ static int cyapa_gen5_check_fw(struct cyapa *cyapa, const struct firmware *fw)
>  		return -EINVAL;
>  	}
>  
> -	/*
> -	 * Verify application image CRC
> -	 */
> -	record_index = fw_app_start / CYAPA_TSG_FW_ROW_SIZE -
> -				CYAPA_TSG_IMG_START_ROW_NUM;
> +	/* Verify application image CRC. */
>  	app_crc = 0xffffU;
>  	for (i = 0; i < fw_app_len / CYAPA_TSG_FW_ROW_SIZE; i++) {
> -		const u8 *data = image->records[record_index + i].record_data;
> +		const u8 *data = image_records[i].record_data;
> +
>  		app_crc = crc_itu_t(app_crc, data, CYAPA_TSG_FW_ROW_SIZE);
>  	}
>  
> @@ -1261,13 +1204,13 @@ static int cyapa_gen5_check_fw(struct cyapa *cyapa, const struct firmware *fw)
>  	return 0;
>  }
>  
> -static int cyapa_gen5_write_fw_block(struct cyapa *cyapa,
> +static int cyapa_pip_write_fw_block(struct cyapa *cyapa,
>  		struct cyapa_tsg_bin_image_data_record *flash_record)
>  {
> -	struct gen5_bl_cmd_head *bl_cmd_head;
> -	struct gen5_bl_packet_start *bl_packet_start;
> -	struct gen5_bl_flash_row_head *flash_row_head;
> -	struct gen5_bl_packet_end *bl_packet_end;
> +	struct pip_bl_cmd_head *bl_cmd_head;
> +	struct pip_bl_packet_start *bl_packet_start;
> +	struct tsg_bl_flash_row_head *flash_row_head;
> +	struct pip_bl_packet_end *bl_packet_end;
>  	u8 cmd[CYAPA_TSG_MAX_CMD_SIZE];
>  	u16 cmd_len;
>  	u8 flash_array_id;
> @@ -1286,71 +1229,68 @@ static int cyapa_gen5_write_fw_block(struct cyapa *cyapa,
>  	record_data = flash_record->record_data;
>  
>  	memset(cmd, 0, CYAPA_TSG_MAX_CMD_SIZE);
> -	bl_cmd_head = (struct gen5_bl_cmd_head *)cmd;
> +	bl_cmd_head = (struct pip_bl_cmd_head *)cmd;
>  	bl_packet_start = &bl_cmd_head->packet_start;
> -	cmd_len = sizeof(struct gen5_bl_cmd_head) +
> -		  sizeof(struct gen5_bl_flash_row_head) +
> +	cmd_len = sizeof(struct pip_bl_cmd_head) +
> +		  sizeof(struct tsg_bl_flash_row_head) +
>  		  CYAPA_TSG_FLASH_MAP_BLOCK_SIZE +
> -		  sizeof(struct gen5_bl_packet_end);
> +		  sizeof(struct pip_bl_packet_end);
>  
> -	put_unaligned_le16(GEN5_OUTPUT_REPORT_ADDR, &bl_cmd_head->addr);
> +	put_unaligned_le16(PIP_OUTPUT_REPORT_ADDR, &bl_cmd_head->addr);
>  	/* Don't include 2 bytes register address */
>  	put_unaligned_le16(cmd_len - 2, &bl_cmd_head->length);
> -	bl_cmd_head->report_id = GEN5_BL_CMD_REPORT_ID;
> -	bl_packet_start->sop = GEN5_SOP_KEY;
> -	bl_packet_start->cmd_code = GEN5_BL_CMD_PROGRAM_VERIFY_ROW;
> +	bl_cmd_head->report_id = PIP_BL_CMD_REPORT_ID;
> +	bl_packet_start->sop = PIP_SOP_KEY;
> +	bl_packet_start->cmd_code = PIP_BL_CMD_PROGRAM_VERIFY_ROW;
>  
>  	/* 1 (Flash Array ID) + 2 (Flash Row ID) + 128 (flash data) */
> -	data_len = sizeof(struct gen5_bl_flash_row_head) + record_len;
> +	data_len = sizeof(struct tsg_bl_flash_row_head) + record_len;
>  	put_unaligned_le16(data_len, &bl_packet_start->data_length);
>  
> -	flash_row_head = (struct gen5_bl_flash_row_head *)bl_cmd_head->data;
> +	flash_row_head = (struct tsg_bl_flash_row_head *)bl_cmd_head->data;
>  	flash_row_head->flash_array_id = flash_array_id;
>  	put_unaligned_le16(flash_row_id, &flash_row_head->flash_row_id);
>  	memcpy(flash_row_head->flash_data, record_data, record_len);
>  
> -	bl_packet_end = (struct gen5_bl_packet_end *)(bl_cmd_head->data +
> +	bl_packet_end = (struct pip_bl_packet_end *)(bl_cmd_head->data +
>  						      data_len);
>  	crc = crc_itu_t(0xffff, (u8 *)bl_packet_start,
> -		sizeof(struct gen5_bl_packet_start) + data_len);
> +		sizeof(struct pip_bl_packet_start) + data_len);
>  	put_unaligned_le16(crc, &bl_packet_end->crc);
> -	bl_packet_end->eop = GEN5_EOP_KEY;
> +	bl_packet_end->eop = PIP_EOP_KEY;
>  
>  	resp_len = sizeof(resp_data);
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa, cmd, cmd_len,
>  			resp_data, &resp_len,
> -			500, cyapa_gen5_sort_tsg_pip_bl_resp_data, true);
> -	if (error || resp_len != GEN5_BL_BLOCK_WRITE_RESP_LEN ||
> -			resp_data[2] != GEN5_BL_RESP_REPORT_ID ||
> -			!GEN5_CMD_COMPLETE_SUCCESS(resp_data[5]))
> +			500, cyapa_sort_tsg_pip_bl_resp_data, true);
> +	if (error || resp_len != PIP_BL_BLOCK_WRITE_RESP_LEN ||
> +			resp_data[2] != PIP_BL_RESP_REPORT_ID ||
> +			!PIP_CMD_COMPLETE_SUCCESS(resp_data))
>  		return error < 0 ? error : -EAGAIN;
>  
>  	return 0;
>  }
>  
> -static int cyapa_gen5_do_fw_update(struct cyapa *cyapa,
> +int cyapa_pip_do_fw_update(struct cyapa *cyapa,
>  		const struct firmware *fw)
>  {
>  	struct device *dev = &cyapa->client->dev;
> -	struct cyapa_tsg_bin_image_data_record *flash_record;
> -	struct cyapa_tsg_bin_image *image =
> -		(struct cyapa_tsg_bin_image *)fw->data;
> +	struct cyapa_tsg_bin_image_data_record *image_records;
>  	int flash_records_count;
>  	int i;
>  	int error;
>  
>  	cyapa_empty_pip_output_data(cyapa, NULL, NULL, NULL);
>  
> -	flash_records_count =
> -		(fw->size - sizeof(struct cyapa_tsg_bin_image_head)) /
> -			sizeof(struct cyapa_tsg_bin_image_data_record);
> +	image_records =
> +		cyapa_get_image_record_data_num(fw, &flash_records_count);
> +
>  	/*
>  	 * The last flash row 0x01ff has been written through bl_initiate
>  	 * command, so DO NOT write flash 0x01ff to trackpad device.
>  	 */
>  	for (i = 0; i < (flash_records_count - 1); i++) {
> -		flash_record = &image->records[i];
> -		error = cyapa_gen5_write_fw_block(cyapa, flash_record);
> +		error = cyapa_pip_write_fw_block(cyapa, &image_records[i]);
>  		if (error) {
>  			dev_err(dev, "%s: Gen5 FW update aborted: %d\n",
>  				__func__, error);
> @@ -1372,9 +1312,9 @@ static int cyapa_gen5_change_power_state(struct cyapa *cyapa, u8 power_state)
>  	resp_len = sizeof(resp_data);
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa, cmd, sizeof(cmd),
>  			resp_data, &resp_len,
> -			500, cyapa_gen5_sort_tsg_pip_app_resp_data, false);
> +			500, cyapa_sort_tsg_pip_app_resp_data, false);
>  	if (error || !VALID_CMD_RESP_HEADER(resp_data, 0x08) ||
> -			!GEN5_CMD_COMPLETE_SUCCESS(resp_data[5]))
> +			!PIP_CMD_COMPLETE_SUCCESS(resp_data))
>  		return error < 0 ? error : -EINVAL;
>  
>  	return 0;
> @@ -1383,7 +1323,7 @@ static int cyapa_gen5_change_power_state(struct cyapa *cyapa, u8 power_state)
>  static int cyapa_gen5_set_interval_time(struct cyapa *cyapa,
>  		u8 parameter_id, u16 interval_time)
>  {
> -	struct gen5_app_cmd_head *app_cmd_head;
> +	struct pip_app_cmd_head *app_cmd_head;
>  	struct gen5_app_set_parameter_data *parameter_data;
>  	u8 cmd[CYAPA_TSG_MAX_CMD_SIZE];
>  	int cmd_len;
> @@ -1393,10 +1333,10 @@ static int cyapa_gen5_set_interval_time(struct cyapa *cyapa,
>  	int error;
>  
>  	memset(cmd, 0, CYAPA_TSG_MAX_CMD_SIZE);
> -	app_cmd_head = (struct gen5_app_cmd_head *)cmd;
> +	app_cmd_head = (struct pip_app_cmd_head *)cmd;
>  	parameter_data = (struct gen5_app_set_parameter_data *)
>  			 app_cmd_head->parameter_data;
> -	cmd_len = sizeof(struct gen5_app_cmd_head) +
> +	cmd_len = sizeof(struct pip_app_cmd_head) +
>  		  sizeof(struct gen5_app_set_parameter_data);
>  
>  	switch (parameter_id) {
> @@ -1413,14 +1353,14 @@ static int cyapa_gen5_set_interval_time(struct cyapa *cyapa,
>  		return -EINVAL;
>  	}
>  
> -	put_unaligned_le16(GEN5_OUTPUT_REPORT_ADDR, &app_cmd_head->addr);
> +	put_unaligned_le16(PIP_OUTPUT_REPORT_ADDR, &app_cmd_head->addr);
>  	/*
>  	 * Don't include unused parameter value bytes and
>  	 * 2 bytes register address.
>  	 */
>  	put_unaligned_le16(cmd_len - (4 - parameter_size) - 2,
>  			   &app_cmd_head->length);
> -	app_cmd_head->report_id = GEN5_APP_CMD_REPORT_ID;
> +	app_cmd_head->report_id = PIP_APP_CMD_REPORT_ID;
>  	app_cmd_head->cmd_code = GEN5_CMD_SET_PARAMETER;
>  	parameter_data->parameter_id = parameter_id;
>  	parameter_data->parameter_size = parameter_size;
> @@ -1428,7 +1368,7 @@ static int cyapa_gen5_set_interval_time(struct cyapa *cyapa,
>  	resp_len = sizeof(resp_data);
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa, cmd, cmd_len,
>  			resp_data, &resp_len,
> -			500, cyapa_gen5_sort_tsg_pip_app_resp_data, false);
> +			500, cyapa_sort_tsg_pip_app_resp_data, false);
>  	if (error || resp_data[5] != parameter_id ||
>  		resp_data[6] != parameter_size ||
>  		!VALID_CMD_RESP_HEADER(resp_data, GEN5_CMD_SET_PARAMETER))
> @@ -1440,7 +1380,7 @@ static int cyapa_gen5_set_interval_time(struct cyapa *cyapa,
>  static int cyapa_gen5_get_interval_time(struct cyapa *cyapa,
>  		u8 parameter_id, u16 *interval_time)
>  {
> -	struct gen5_app_cmd_head *app_cmd_head;
> +	struct pip_app_cmd_head *app_cmd_head;
>  	struct gen5_app_get_parameter_data *parameter_data;
>  	u8 cmd[CYAPA_TSG_MAX_CMD_SIZE];
>  	int cmd_len;
> @@ -1451,10 +1391,10 @@ static int cyapa_gen5_get_interval_time(struct cyapa *cyapa,
>  	int error;
>  
>  	memset(cmd, 0, CYAPA_TSG_MAX_CMD_SIZE);
> -	app_cmd_head = (struct gen5_app_cmd_head *)cmd;
> +	app_cmd_head = (struct pip_app_cmd_head *)cmd;
>  	parameter_data = (struct gen5_app_get_parameter_data *)
>  			 app_cmd_head->parameter_data;
> -	cmd_len = sizeof(struct gen5_app_cmd_head) +
> +	cmd_len = sizeof(struct pip_app_cmd_head) +
>  		  sizeof(struct gen5_app_get_parameter_data);
>  
>  	*interval_time = 0;
> @@ -1472,17 +1412,17 @@ static int cyapa_gen5_get_interval_time(struct cyapa *cyapa,
>  		return -EINVAL;
>  	}
>  
> -	put_unaligned_le16(GEN5_HID_DESCRIPTOR_ADDR, &app_cmd_head->addr);
> +	put_unaligned_le16(PIP_OUTPUT_REPORT_ADDR, &app_cmd_head->addr);
>  	/* Don't include 2 bytes register address */
>  	put_unaligned_le16(cmd_len - 2, &app_cmd_head->length);
> -	app_cmd_head->report_id = GEN5_APP_CMD_REPORT_ID;
> +	app_cmd_head->report_id = PIP_APP_CMD_REPORT_ID;
>  	app_cmd_head->cmd_code = GEN5_CMD_GET_PARAMETER;
>  	parameter_data->parameter_id = parameter_id;
>  
>  	resp_len = sizeof(resp_data);
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa, cmd, cmd_len,
>  			resp_data, &resp_len,
> -			500, cyapa_gen5_sort_tsg_pip_app_resp_data, false);
> +			500, cyapa_sort_tsg_pip_app_resp_data, false);
>  	if (error || resp_data[5] != parameter_id || resp_data[6] == 0 ||
>  		!VALID_CMD_RESP_HEADER(resp_data, GEN5_CMD_GET_PARAMETER))
>  		return error < 0 ? error : -EINVAL;
> @@ -1497,18 +1437,18 @@ static int cyapa_gen5_get_interval_time(struct cyapa *cyapa,
>  
>  static int cyapa_gen5_disable_pip_report(struct cyapa *cyapa)
>  {
> -	struct gen5_app_cmd_head *app_cmd_head;
> +	struct pip_app_cmd_head *app_cmd_head;
>  	u8 cmd[10];
>  	u8 resp_data[7];
>  	int resp_len;
>  	int error;
>  
>  	memset(cmd, 0, sizeof(cmd));
> -	app_cmd_head = (struct gen5_app_cmd_head *)cmd;
> +	app_cmd_head = (struct pip_app_cmd_head *)cmd;
>  
> -	put_unaligned_le16(GEN5_HID_DESCRIPTOR_ADDR, &app_cmd_head->addr);
> +	put_unaligned_le16(PIP_OUTPUT_REPORT_ADDR, &app_cmd_head->addr);
>  	put_unaligned_le16(sizeof(cmd) - 2, &app_cmd_head->length);
> -	app_cmd_head->report_id = GEN5_APP_CMD_REPORT_ID;
> +	app_cmd_head->report_id = PIP_APP_CMD_REPORT_ID;
>  	app_cmd_head->cmd_code = GEN5_CMD_SET_PARAMETER;
>  	app_cmd_head->parameter_data[0] = GEN5_PARAMETER_DISABLE_PIP_REPORT;
>  	app_cmd_head->parameter_data[1] = 0x01;
> @@ -1516,7 +1456,7 @@ static int cyapa_gen5_disable_pip_report(struct cyapa *cyapa)
>  	resp_len = sizeof(resp_data);
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa, cmd, sizeof(cmd),
>  			resp_data, &resp_len,
> -			500, cyapa_gen5_sort_tsg_pip_app_resp_data, false);
> +			500, cyapa_sort_tsg_pip_app_resp_data, false);
>  	if (error || resp_data[5] != GEN5_PARAMETER_DISABLE_PIP_REPORT ||
>  		!VALID_CMD_RESP_HEADER(resp_data, GEN5_CMD_SET_PARAMETER) ||
>  		resp_data[6] != 0x01)
> @@ -1525,19 +1465,19 @@ static int cyapa_gen5_disable_pip_report(struct cyapa *cyapa)
>  	return 0;
>  }
>  
> -static int cyapa_gen5_deep_sleep(struct cyapa *cyapa, u8 state)
> +int cyapa_pip_deep_sleep(struct cyapa *cyapa, u8 state)
>  {
>  	u8 cmd[] = { 0x05, 0x00, 0x00, 0x08};
>  	u8 resp_data[5];
>  	int resp_len;
>  	int error;
>  
> -	cmd[2] = state & GEN5_DEEP_SLEEP_STATE_MASK;
> +	cmd[2] = state & PIP_DEEP_SLEEP_STATE_MASK;
>  	resp_len = sizeof(resp_data);
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa, cmd, sizeof(cmd),
>  			resp_data, &resp_len,
> -			500, cyapa_gen5_sort_deep_sleep_data, false);
> -	if (error || ((resp_data[3] & GEN5_DEEP_SLEEP_STATE_MASK) != state))
> +			500, cyapa_sort_pip_deep_sleep_data, false);
> +	if (error || ((resp_data[3] & PIP_DEEP_SLEEP_STATE_MASK) != state))
>  		return -EINVAL;
>  
>  	return 0;
> @@ -1556,40 +1496,40 @@ static int cyapa_gen5_set_power_mode(struct cyapa *cyapa,
>  	/* Dump all the report data before do power mode commmands. */
>  	cyapa_empty_pip_output_data(cyapa, NULL, NULL, NULL);
>  
> -	if (GEN5_DEV_GET_PWR_STATE(cyapa) == UNINIT_PWR_MODE) {
> +	if (PIP_DEV_GET_PWR_STATE(cyapa) == UNINIT_PWR_MODE) {
>  		/*
>  		 * Assume TP in deep sleep mode when driver is loaded,
>  		 * avoid driver unload and reload command IO issue caused by TP
>  		 * has been set into deep sleep mode when unloading.
>  		 */
> -		GEN5_DEV_SET_PWR_STATE(cyapa, PWR_MODE_OFF);
> +		PIP_DEV_SET_PWR_STATE(cyapa, PWR_MODE_OFF);
>  	}
>  
> -	if (GEN5_DEV_UNINIT_SLEEP_TIME(cyapa) &&
> -			GEN5_DEV_GET_PWR_STATE(cyapa) != PWR_MODE_OFF)
> +	if (PIP_DEV_UNINIT_SLEEP_TIME(cyapa) &&
> +			PIP_DEV_GET_PWR_STATE(cyapa) != PWR_MODE_OFF)
>  		if (cyapa_gen5_get_interval_time(cyapa,
>  				GEN5_PARAMETER_LP_INTRVL_ID,
>  				&cyapa->dev_sleep_time) != 0)
> -			GEN5_DEV_SET_SLEEP_TIME(cyapa, UNINIT_SLEEP_TIME);
> +			PIP_DEV_SET_SLEEP_TIME(cyapa, UNINIT_SLEEP_TIME);
>  
> -	if (GEN5_DEV_GET_PWR_STATE(cyapa) == power_mode) {
> +	if (PIP_DEV_GET_PWR_STATE(cyapa) == power_mode) {
>  		if (power_mode == PWR_MODE_OFF ||
>  			power_mode == PWR_MODE_FULL_ACTIVE ||
>  			power_mode == PWR_MODE_BTN_ONLY ||
> -			GEN5_DEV_GET_SLEEP_TIME(cyapa) == sleep_time) {
> +			PIP_DEV_GET_SLEEP_TIME(cyapa) == sleep_time) {
>  			/* Has in correct power mode state, early return. */
>  			return 0;
>  		}
>  	}
>  
>  	if (power_mode == PWR_MODE_OFF) {
> -		error = cyapa_gen5_deep_sleep(cyapa, GEN5_DEEP_SLEEP_STATE_OFF);
> +		error = cyapa_pip_deep_sleep(cyapa, PIP_DEEP_SLEEP_STATE_OFF);
>  		if (error) {
>  			dev_err(dev, "enter deep sleep fail: %d\n", error);
>  			return error;
>  		}
>  
> -		GEN5_DEV_SET_PWR_STATE(cyapa, PWR_MODE_OFF);
> +		PIP_DEV_SET_PWR_STATE(cyapa, PWR_MODE_OFF);
>  		return 0;
>  	}
>  
> @@ -1598,8 +1538,8 @@ static int cyapa_gen5_set_power_mode(struct cyapa *cyapa,
>  	 * state directly, must be wake up from sleep firstly, then
>  	 * continue to do next power sate change.
>  	 */
> -	if (GEN5_DEV_GET_PWR_STATE(cyapa) == PWR_MODE_OFF) {
> -		error = cyapa_gen5_deep_sleep(cyapa, GEN5_DEEP_SLEEP_STATE_ON);
> +	if (PIP_DEV_GET_PWR_STATE(cyapa) == PWR_MODE_OFF) {
> +		error = cyapa_pip_deep_sleep(cyapa, PIP_DEEP_SLEEP_STATE_ON);
>  		if (error) {
>  			dev_err(dev, "deep sleep wake fail: %d\n", error);
>  			return error;
> @@ -1614,7 +1554,7 @@ static int cyapa_gen5_set_power_mode(struct cyapa *cyapa,
>  			return error;
>  		}
>  
> -		GEN5_DEV_SET_PWR_STATE(cyapa, PWR_MODE_FULL_ACTIVE);
> +		PIP_DEV_SET_PWR_STATE(cyapa, PWR_MODE_FULL_ACTIVE);
>  	} else if (power_mode == PWR_MODE_BTN_ONLY) {
>  		error = cyapa_gen5_change_power_state(cyapa,
>  				GEN5_POWER_STATE_BTN_ONLY);
> @@ -1623,19 +1563,19 @@ static int cyapa_gen5_set_power_mode(struct cyapa *cyapa,
>  			return error;
>  		}
>  
> -		GEN5_DEV_SET_PWR_STATE(cyapa, PWR_MODE_BTN_ONLY);
> +		PIP_DEV_SET_PWR_STATE(cyapa, PWR_MODE_BTN_ONLY);
>  	} else {
>  		/*
>  		 * Continue to change power mode even failed to set
>  		 * interval time, it won't affect the power mode change.
>  		 * except the sleep interval time is not correct.
>  		 */
> -		if (GEN5_DEV_UNINIT_SLEEP_TIME(cyapa) ||
> -				sleep_time != GEN5_DEV_GET_SLEEP_TIME(cyapa))
> +		if (PIP_DEV_UNINIT_SLEEP_TIME(cyapa) ||
> +				sleep_time != PIP_DEV_GET_SLEEP_TIME(cyapa))
>  			if (cyapa_gen5_set_interval_time(cyapa,
>  					GEN5_PARAMETER_LP_INTRVL_ID,
>  					sleep_time) == 0)
> -				GEN5_DEV_SET_SLEEP_TIME(cyapa, sleep_time);
> +				PIP_DEV_SET_SLEEP_TIME(cyapa, sleep_time);
>  
>  		if (sleep_time <= GEN5_POWER_READY_MAX_INTRVL_TIME)
>  			power_state = GEN5_POWER_STATE_READY;
> @@ -1661,14 +1601,14 @@ static int cyapa_gen5_set_power_mode(struct cyapa *cyapa,
>  		cyapa_empty_pip_output_data(cyapa, NULL, NULL, NULL);
>  		cyapa_gen5_disable_pip_report(cyapa);
>  
> -		GEN5_DEV_SET_PWR_STATE(cyapa,
> +		PIP_DEV_SET_PWR_STATE(cyapa,
>  			cyapa_sleep_time_to_pwr_cmd(sleep_time));
>  	}
>  
>  	return 0;
>  }
>  
> -static int cyapa_gen5_resume_scanning(struct cyapa *cyapa)
> +int cyapa_pip_resume_scanning(struct cyapa *cyapa)
>  {
>  	u8 cmd[] = { 0x04, 0x00, 0x05, 0x00, 0x2f, 0x00, 0x04 };
>  	u8 resp_data[6];
> @@ -1682,7 +1622,7 @@ static int cyapa_gen5_resume_scanning(struct cyapa *cyapa)
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa,
>  			cmd, sizeof(cmd),
>  			resp_data, &resp_len,
> -			500, cyapa_gen5_sort_tsg_pip_app_resp_data, true);
> +			500, cyapa_sort_tsg_pip_app_resp_data, true);
>  	if (error || !VALID_CMD_RESP_HEADER(resp_data, 0x04))
>  		return -EINVAL;
>  
> @@ -1692,7 +1632,7 @@ static int cyapa_gen5_resume_scanning(struct cyapa *cyapa)
>  	return 0;
>  }
>  
> -static int cyapa_gen5_suspend_scanning(struct cyapa *cyapa)
> +int cyapa_pip_suspend_scanning(struct cyapa *cyapa)
>  {
>  	u8 cmd[] = { 0x04, 0x00, 0x05, 0x00, 0x2f, 0x00, 0x03 };
>  	u8 resp_data[6];
> @@ -1706,7 +1646,7 @@ static int cyapa_gen5_suspend_scanning(struct cyapa *cyapa)
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa,
>  			cmd, sizeof(cmd),
>  			resp_data, &resp_len,
> -			500, cyapa_gen5_sort_tsg_pip_app_resp_data, true);
> +			500, cyapa_sort_tsg_pip_app_resp_data, true);
>  	if (error || !VALID_CMD_RESP_HEADER(resp_data, 0x03))
>  		return -EINVAL;
>  
> @@ -1716,10 +1656,10 @@ static int cyapa_gen5_suspend_scanning(struct cyapa *cyapa)
>  	return 0;
>  }
>  
> -static int cyapa_gen5_calibrate_pwcs(struct cyapa *cyapa,
> +static int cyapa_pip_calibrate_pwcs(struct cyapa *cyapa,
>  		u8 calibrate_sensing_mode_type)
>  {
> -	struct gen5_app_cmd_head *app_cmd_head;
> +	struct pip_app_cmd_head *app_cmd_head;
>  	u8 cmd[8];
>  	u8 resp_data[6];
>  	int resp_len;
> @@ -1729,25 +1669,25 @@ static int cyapa_gen5_calibrate_pwcs(struct cyapa *cyapa,
>  	cyapa_empty_pip_output_data(cyapa, NULL, NULL, NULL);
>  
>  	memset(cmd, 0, sizeof(cmd));
> -	app_cmd_head = (struct gen5_app_cmd_head *)cmd;
> -	put_unaligned_le16(GEN5_OUTPUT_REPORT_ADDR, &app_cmd_head->addr);
> +	app_cmd_head = (struct pip_app_cmd_head *)cmd;
> +	put_unaligned_le16(PIP_OUTPUT_REPORT_ADDR, &app_cmd_head->addr);
>  	put_unaligned_le16(sizeof(cmd) - 2, &app_cmd_head->length);
> -	app_cmd_head->report_id = GEN5_APP_CMD_REPORT_ID;
> -	app_cmd_head->cmd_code = GEN5_CMD_CALIBRATE;
> +	app_cmd_head->report_id = PIP_APP_CMD_REPORT_ID;
> +	app_cmd_head->cmd_code = PIP_CMD_CALIBRATE;
>  	app_cmd_head->parameter_data[0] = calibrate_sensing_mode_type;
>  	resp_len = sizeof(resp_data);
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa,
>  			cmd, sizeof(cmd),
>  			resp_data, &resp_len,
> -			5000, cyapa_gen5_sort_tsg_pip_app_resp_data, true);
> -	if (error || !VALID_CMD_RESP_HEADER(resp_data, GEN5_CMD_CALIBRATE) ||
> -			!GEN5_CMD_COMPLETE_SUCCESS(resp_data[5]))
> +			5000, cyapa_sort_tsg_pip_app_resp_data, true);
> +	if (error || !VALID_CMD_RESP_HEADER(resp_data, PIP_CMD_CALIBRATE) ||
> +			!PIP_CMD_COMPLETE_SUCCESS(resp_data))
>  		return error < 0 ? error : -EAGAIN;
>  
>  	return 0;
>  }
>  
> -static ssize_t cyapa_gen5_do_calibrate(struct device *dev,
> +ssize_t cyapa_pip_do_calibrate(struct device *dev,
>  				     struct device_attribute *attr,
>  				     const char *buf, size_t count)
>  {
> @@ -1755,25 +1695,25 @@ static ssize_t cyapa_gen5_do_calibrate(struct device *dev,
>  	int error, calibrate_error;
>  
>  	/* 1. Suspend Scanning*/
> -	error = cyapa_gen5_suspend_scanning(cyapa);
> +	error = cyapa_pip_suspend_scanning(cyapa);
>  	if (error)
>  		return error;
>  
>  	/* 2. Do mutual capacitance fine calibrate. */
> -	calibrate_error = cyapa_gen5_calibrate_pwcs(cyapa,
> -				CYAPA_SENSING_MODE_MUTUAL_CAP_FINE);
> +	calibrate_error = cyapa_pip_calibrate_pwcs(cyapa,
> +				PIP_SENSING_MODE_MUTUAL_CAP_FINE);
>  	if (calibrate_error)
>  		goto resume_scanning;
>  
>  	/* 3. Do self capacitance calibrate. */
> -	calibrate_error = cyapa_gen5_calibrate_pwcs(cyapa,
> -				CYAPA_SENSING_MODE_SELF_CAP);
> +	calibrate_error = cyapa_pip_calibrate_pwcs(cyapa,
> +				PIP_SENSING_MODE_SELF_CAP);
>  	if (calibrate_error)
>  		goto resume_scanning;
>  
>  resume_scanning:
>  	/* 4. Resume Scanning*/
> -	error = cyapa_gen5_resume_scanning(cyapa);
> +	error = cyapa_pip_resume_scanning(cyapa);
>  	if (error || calibrate_error)
>  		return error ? error : calibrate_error;
>  
> @@ -1856,7 +1796,7 @@ static void cyapa_gen5_guess_electrodes(struct cyapa *cyapa,
>   * If the input value of @data_size is not 0, than means read the mutual or
>   * self local PWC data. The @idac_max, @idac_min and @idac_ave are used to
>   * return the max, min and average value of the mutual or self local PWC data.
> - * Note, in order to raed mutual local PWC data, must read invoke this function
> + * Note, in order to read mutual local PWC data, must read invoke this function
>   * to read the mutual global idac data firstly to set the correct Rx number
>   * value, otherwise, the read mutual idac and PWC data may not correct.
>   */
> @@ -1864,7 +1804,7 @@ static int cyapa_gen5_read_idac_data(struct cyapa *cyapa,
>  		u8 cmd_code, u8 idac_data_type, int *data_size,
>  		int *idac_max, int *idac_min, int *idac_ave)
>  {
> -	struct gen5_app_cmd_head *cmd_head;
> +	struct pip_app_cmd_head *cmd_head;
>  	u8 cmd[12];
>  	u8 resp_data[256];
>  	int resp_len;
> @@ -1879,7 +1819,7 @@ static int cyapa_gen5_read_idac_data(struct cyapa *cyapa,
>  	int i;
>  	int error;
>  
> -	if (cmd_code != GEN5_CMD_RETRIEVE_DATA_STRUCTURE ||
> +	if (cmd_code != PIP_RETRIEVE_DATA_STRUCTURE ||
>  		(idac_data_type != GEN5_RETRIEVE_MUTUAL_PWC_DATA &&
>  		idac_data_type != GEN5_RETRIEVE_SELF_CAP_PWC_DATA) ||
>  		!data_size || !idac_max || !idac_min || !idac_ave)
> @@ -1935,10 +1875,10 @@ static int cyapa_gen5_read_idac_data(struct cyapa *cyapa,
>  	}
>  
>  	memset(cmd, 0, sizeof(cmd));
> -	cmd_head = (struct gen5_app_cmd_head *)cmd;
> -	put_unaligned_le16(GEN5_OUTPUT_REPORT_ADDR, &cmd_head->addr);
> +	cmd_head = (struct pip_app_cmd_head *)cmd;
> +	put_unaligned_le16(PIP_OUTPUT_REPORT_ADDR, &cmd_head->addr);
>  	put_unaligned_le16(sizeof(cmd) - 2, &cmd_head->length);
> -	cmd_head->report_id = GEN5_APP_CMD_REPORT_ID;
> +	cmd_head->report_id = PIP_APP_CMD_REPORT_ID;
>  	cmd_head->cmd_code = cmd_code;
>  	do {
>  		read_elements = (256 - GEN5_RESP_DATA_STRUCTURE_OFFSET) /
> @@ -1953,11 +1893,11 @@ static int cyapa_gen5_read_idac_data(struct cyapa *cyapa,
>  		error = cyapa_i2c_pip_cmd_irq_sync(cyapa,
>  				cmd, sizeof(cmd),
>  				resp_data, &resp_len,
> -				500, cyapa_gen5_sort_tsg_pip_app_resp_data,
> +				500, cyapa_sort_tsg_pip_app_resp_data,
>  				true);
>  		if (error || resp_len < GEN5_RESP_DATA_STRUCTURE_OFFSET ||
>  				!VALID_CMD_RESP_HEADER(resp_data, cmd_code) ||
> -				!GEN5_CMD_COMPLETE_SUCCESS(resp_data[5]) ||
> +				!PIP_CMD_COMPLETE_SUCCESS(resp_data) ||
>  				resp_data[6] != idac_data_type)
>  			return (error < 0) ? error : -EAGAIN;
>  		read_len = get_unaligned_le16(&resp_data[7]);
> @@ -1997,7 +1937,7 @@ static int cyapa_gen5_read_idac_data(struct cyapa *cyapa,
>  				tmp_count < cyapa->aligned_electrodes_rx &&
>  				read_global_idac) {
>  				/*
> -				 * The value gap betwen global and local mutual
> +				 * The value gap between global and local mutual
>  				 * idac data must bigger than 50%.
>  				 * Normally, global value bigger than 50,
>  				 * local values less than 10.
> @@ -2061,7 +2001,7 @@ static int cyapa_gen5_read_mutual_idac_data(struct cyapa *cyapa,
>  
>  	data_size = 0;
>  	error = cyapa_gen5_read_idac_data(cyapa,
> -		GEN5_CMD_RETRIEVE_DATA_STRUCTURE,
> +		PIP_RETRIEVE_DATA_STRUCTURE,
>  		GEN5_RETRIEVE_MUTUAL_PWC_DATA,
>  		&data_size,
>  		gidac_mutual_max, gidac_mutual_min, gidac_mutual_ave);
> @@ -2069,7 +2009,7 @@ static int cyapa_gen5_read_mutual_idac_data(struct cyapa *cyapa,
>  		return error;
>  
>  	error = cyapa_gen5_read_idac_data(cyapa,
> -		GEN5_CMD_RETRIEVE_DATA_STRUCTURE,
> +		PIP_RETRIEVE_DATA_STRUCTURE,
>  		GEN5_RETRIEVE_MUTUAL_PWC_DATA,
>  		&data_size,
>  		lidac_mutual_max, lidac_mutual_min, lidac_mutual_ave);
> @@ -2088,7 +2028,7 @@ static int cyapa_gen5_read_self_idac_data(struct cyapa *cyapa,
>  
>  	data_size = 0;
>  	error = cyapa_gen5_read_idac_data(cyapa,
> -		GEN5_CMD_RETRIEVE_DATA_STRUCTURE,
> +		PIP_RETRIEVE_DATA_STRUCTURE,
>  		GEN5_RETRIEVE_SELF_CAP_PWC_DATA,
>  		&data_size,
>  		lidac_self_max, lidac_self_min, lidac_self_ave);
> @@ -2098,7 +2038,7 @@ static int cyapa_gen5_read_self_idac_data(struct cyapa *cyapa,
>  	*gidac_self_tx = *lidac_self_min;
>  
>  	error = cyapa_gen5_read_idac_data(cyapa,
> -		GEN5_CMD_RETRIEVE_DATA_STRUCTURE,
> +		PIP_RETRIEVE_DATA_STRUCTURE,
>  		GEN5_RETRIEVE_SELF_CAP_PWC_DATA,
>  		&data_size,
>  		lidac_self_max, lidac_self_min, lidac_self_ave);
> @@ -2107,27 +2047,27 @@ static int cyapa_gen5_read_self_idac_data(struct cyapa *cyapa,
>  
>  static ssize_t cyapa_gen5_execute_panel_scan(struct cyapa *cyapa)
>  {
> -	struct gen5_app_cmd_head *app_cmd_head;
> +	struct pip_app_cmd_head *app_cmd_head;
>  	u8 cmd[7];
>  	u8 resp_data[6];
>  	int resp_len;
>  	int error;
>  
>  	memset(cmd, 0, sizeof(cmd));
> -	app_cmd_head = (struct gen5_app_cmd_head *)cmd;
> -	put_unaligned_le16(GEN5_OUTPUT_REPORT_ADDR, &app_cmd_head->addr);
> +	app_cmd_head = (struct pip_app_cmd_head *)cmd;
> +	put_unaligned_le16(PIP_OUTPUT_REPORT_ADDR, &app_cmd_head->addr);
>  	put_unaligned_le16(sizeof(cmd) - 2, &app_cmd_head->length);
> -	app_cmd_head->report_id = GEN5_APP_CMD_REPORT_ID;
> +	app_cmd_head->report_id = PIP_APP_CMD_REPORT_ID;
>  	app_cmd_head->cmd_code = GEN5_CMD_EXECUTE_PANEL_SCAN;
>  	resp_len = sizeof(resp_data);
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa,
>  			cmd, sizeof(cmd),
>  			resp_data, &resp_len,
> -			500, cyapa_gen5_sort_tsg_pip_app_resp_data, true);
> +			500, cyapa_sort_tsg_pip_app_resp_data, true);
>  	if (error || resp_len != sizeof(resp_data) ||
>  			!VALID_CMD_RESP_HEADER(resp_data,
>  				GEN5_CMD_EXECUTE_PANEL_SCAN) ||
> -			!GEN5_CMD_COMPLETE_SUCCESS(resp_data[5]))
> +			!PIP_CMD_COMPLETE_SUCCESS(resp_data))
>  		return error ? error : -EAGAIN;
>  
>  	return 0;
> @@ -2138,7 +2078,7 @@ static int cyapa_gen5_read_panel_scan_raw_data(struct cyapa *cyapa,
>  		int *raw_data_max, int *raw_data_min, int *raw_data_ave,
>  		u8 *buffer)
>  {
> -	struct gen5_app_cmd_head *app_cmd_head;
> +	struct pip_app_cmd_head *app_cmd_head;
>  	struct gen5_retrieve_panel_scan_data *panel_sacn_data;
>  	u8 cmd[12];
>  	u8 resp_data[256];  /* Max bytes can transfer one time. */
> @@ -2166,10 +2106,10 @@ static int cyapa_gen5_read_panel_scan_raw_data(struct cyapa *cyapa,
>  	/* Assume max element size is 4 currently. */
>  	read_elements = (256 - GEN5_RESP_DATA_STRUCTURE_OFFSET) / 4;
>  	read_len = read_elements * 4;
> -	app_cmd_head = (struct gen5_app_cmd_head *)cmd;
> -	put_unaligned_le16(GEN5_OUTPUT_REPORT_ADDR, &app_cmd_head->addr);
> +	app_cmd_head = (struct pip_app_cmd_head *)cmd;
> +	put_unaligned_le16(PIP_OUTPUT_REPORT_ADDR, &app_cmd_head->addr);
>  	put_unaligned_le16(sizeof(cmd) - 2, &app_cmd_head->length);
> -	app_cmd_head->report_id = GEN5_APP_CMD_REPORT_ID;
> +	app_cmd_head->report_id = PIP_APP_CMD_REPORT_ID;
>  	app_cmd_head->cmd_code = cmd_code;
>  	panel_sacn_data = (struct gen5_retrieve_panel_scan_data *)
>  			app_cmd_head->parameter_data;
> @@ -2183,10 +2123,10 @@ static int cyapa_gen5_read_panel_scan_raw_data(struct cyapa *cyapa,
>  		error = cyapa_i2c_pip_cmd_irq_sync(cyapa,
>  			cmd, sizeof(cmd),
>  			resp_data, &resp_len,
> -			500, cyapa_gen5_sort_tsg_pip_app_resp_data, true);
> +			500, cyapa_sort_tsg_pip_app_resp_data, true);
>  		if (error || resp_len < GEN5_RESP_DATA_STRUCTURE_OFFSET ||
>  				!VALID_CMD_RESP_HEADER(resp_data, cmd_code) ||
> -				!GEN5_CMD_COMPLETE_SUCCESS(resp_data[5]) ||
> +				!PIP_CMD_COMPLETE_SUCCESS(resp_data) ||
>  				resp_data[6] != raw_data_type)
>  			return error ? error : -EAGAIN;
>  
> @@ -2245,11 +2185,11 @@ static ssize_t cyapa_gen5_show_baseline(struct device *dev,
>  	int error, resume_error;
>  	int size;
>  
> -	if (cyapa->state != CYAPA_STATE_GEN5_APP)
> +	if (!cyapa_is_pip_app_mode(cyapa))
>  		return -EBUSY;
>  
>  	/* 1. Suspend Scanning*/
> -	error = cyapa_gen5_suspend_scanning(cyapa);
> +	error = cyapa_pip_suspend_scanning(cyapa);
>  	if (error)
>  		return error;
>  
> @@ -2270,7 +2210,7 @@ static ssize_t cyapa_gen5_show_baseline(struct device *dev,
>  	if (error)
>  		goto resume_scanning;
>  
> -	/* 4. Execuate panel scan. It must be executed before read data. */
> +	/* 4. Execute panel scan. It must be executed before read data. */
>  	error = cyapa_gen5_execute_panel_scan(cyapa);
>  	if (error)
>  		goto resume_scanning;
> @@ -2343,7 +2283,7 @@ static ssize_t cyapa_gen5_show_baseline(struct device *dev,
>  
>  resume_scanning:
>  	/* 11. Resume Scanning*/
> -	resume_error = cyapa_gen5_resume_scanning(cyapa);
> +	resume_error = cyapa_pip_resume_scanning(cyapa);
>  	if (resume_error || error)
>  		return resume_error ? resume_error : error;
>  
> @@ -2364,7 +2304,7 @@ resume_scanning:
>  	return size;
>  }
>  
> -static bool cyapa_gen5_sort_system_info_data(struct cyapa *cyapa,
> +bool cyapa_pip_sort_system_info_data(struct cyapa *cyapa,
>  		u8 *buf, int len)
>  {
>  	/* Check the report id and command code */
> @@ -2376,20 +2316,17 @@ static bool cyapa_gen5_sort_system_info_data(struct cyapa *cyapa,
>  
>  static int cyapa_gen5_bl_query_data(struct cyapa *cyapa)
>  {
> -	u8 bl_query_data_cmd[] = { 0x04, 0x00, 0x0b, 0x00, 0x40, 0x00,
> -		0x01, 0x3c, 0x00, 0x00, 0xb0, 0x42, 0x17
> -	};
> -	u8 resp_data[GEN5_BL_READ_APP_INFO_RESP_LEN];
> +	u8 resp_data[PIP_BL_APP_INFO_RESP_LENGTH];
>  	int resp_len;
>  	int error;
>  
> -	resp_len = GEN5_BL_READ_APP_INFO_RESP_LEN;
> +	resp_len = sizeof(resp_data);
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa,
> -			bl_query_data_cmd, sizeof(bl_query_data_cmd),
> +			pip_bl_read_app_info, PIP_BL_READ_APP_INFO_CMD_LENGTH,
>  			resp_data, &resp_len,
> -			500, cyapa_gen5_sort_tsg_pip_bl_resp_data, false);
> -	if (error || resp_len != GEN5_BL_READ_APP_INFO_RESP_LEN ||
> -		!GEN5_CMD_COMPLETE_SUCCESS(resp_data[5]))
> +			500, cyapa_sort_tsg_pip_bl_resp_data, false);
> +	if (error || resp_len < PIP_BL_APP_INFO_RESP_LENGTH ||
> +		!PIP_CMD_COMPLETE_SUCCESS(resp_data))
>  		return error ? error : -EIO;
>  
>  	memcpy(&cyapa->product_id[0], &resp_data[8], 5);
> @@ -2407,25 +2344,22 @@ static int cyapa_gen5_bl_query_data(struct cyapa *cyapa)
>  
>  static int cyapa_gen5_get_query_data(struct cyapa *cyapa)
>  {
> -	u8 get_system_information[] = {
> -		0x04, 0x00, 0x05, 0x00, 0x2f, 0x00, 0x02
> -	};
> -	u8 resp_data[71];
> +	u8 resp_data[PIP_READ_SYS_INFO_RESP_LENGTH];
>  	int resp_len;
>  	u16 product_family;
>  	int error;
>  
>  	resp_len = sizeof(resp_data);
>  	error = cyapa_i2c_pip_cmd_irq_sync(cyapa,
> -			get_system_information, sizeof(get_system_information),
> +			pip_read_sys_info, PIP_READ_SYS_INFO_CMD_LENGTH,
>  			resp_data, &resp_len,
> -			2000, cyapa_gen5_sort_system_info_data, false);
> +			2000, cyapa_pip_sort_system_info_data, false);
>  	if (error || resp_len < sizeof(resp_data))
>  		return error ? error : -EIO;
>  
>  	product_family = get_unaligned_le16(&resp_data[7]);
> -	if ((product_family & GEN5_PRODUCT_FAMILY_MASK) !=
> -		GEN5_PRODUCT_FAMILY_TRACKPAD)
> +	if ((product_family & PIP_PRODUCT_FAMILY_MASK) !=
> +		PIP_PRODUCT_FAMILY_TRACKPAD)
>  		return -EINVAL;
>  
>  	cyapa->fw_maj_ver = resp_data[15];
> @@ -2472,9 +2406,9 @@ static int cyapa_gen5_do_operational_check(struct cyapa *cyapa)
>  
>  	switch (cyapa->state) {
>  	case CYAPA_STATE_GEN5_BL:
> -		error = cyapa_gen5_bl_exit(cyapa);
> +		error = cyapa_pip_bl_exit(cyapa);
>  		if (error) {
> -			/* Rry to update trackpad product information. */
> +			/* Try to update trackpad product information. */
>  			cyapa_gen5_bl_query_data(cyapa);
>  			goto out;
>  		}
> @@ -2486,7 +2420,7 @@ static int cyapa_gen5_do_operational_check(struct cyapa *cyapa)
>  		 * If trackpad device in deep sleep mode,
>  		 * the app command will fail.
>  		 * So always try to reset trackpad device to full active when
> -		 * the device state is requeried.
> +		 * the device state is required.
>  		 */
>  		error = cyapa_gen5_set_power_mode(cyapa,
>  				PWR_MODE_FULL_ACTIVE, 0);
> @@ -2518,14 +2452,14 @@ out:
>   * Return false, do not continue process
>   * Return true, continue process.
>   */
> -static bool cyapa_gen5_irq_cmd_handler(struct cyapa *cyapa)
> +bool cyapa_pip_irq_cmd_handler(struct cyapa *cyapa)
>  {
> -	struct cyapa_gen5_cmd_states *gen5_pip = &cyapa->cmd_states.gen5;
> +	struct cyapa_pip_cmd_states *pip = &cyapa->cmd_states.pip;
>  	int length;
>  
> -	if (atomic_read(&gen5_pip->cmd_issued)) {
> +	if (atomic_read(&pip->cmd_issued)) {
>  		/* Polling command response data. */
> -		if (gen5_pip->is_irq_mode == false)
> +		if (pip->is_irq_mode == false)
>  			return false;
>  
>  		/*
> @@ -2533,59 +2467,64 @@ static bool cyapa_gen5_irq_cmd_handler(struct cyapa *cyapa)
>  		 * these output data may caused by user put finger on
>  		 * trackpad when host waiting the command response.
>  		 */
> -		cyapa_i2c_pip_read(cyapa, gen5_pip->irq_cmd_buf,
> -			GEN5_RESP_LENGTH_SIZE);
> -		length = get_unaligned_le16(gen5_pip->irq_cmd_buf);
> -		length = (length <= GEN5_RESP_LENGTH_SIZE) ?
> -				GEN5_RESP_LENGTH_SIZE : length;
> -		if (length > GEN5_RESP_LENGTH_SIZE)
> +		cyapa_i2c_pip_read(cyapa, pip->irq_cmd_buf,
> +			PIP_RESP_LENGTH_SIZE);
> +		length = get_unaligned_le16(pip->irq_cmd_buf);
> +		length = (length <= PIP_RESP_LENGTH_SIZE) ?
> +				PIP_RESP_LENGTH_SIZE : length;
> +		if (length > PIP_RESP_LENGTH_SIZE)
>  			cyapa_i2c_pip_read(cyapa,
> -				gen5_pip->irq_cmd_buf, length);
> -
> -		if (!(gen5_pip->resp_sort_func &&
> -			gen5_pip->resp_sort_func(cyapa,
> -				gen5_pip->irq_cmd_buf, length))) {
> +				pip->irq_cmd_buf, length);
> +		if (!(pip->resp_sort_func &&
> +			pip->resp_sort_func(cyapa,
> +				pip->irq_cmd_buf, length))) {
>  			/*
> -			 * Work around the Gen5 V1 firmware
> -			 * that does not assert interrupt signalling
> -			 * that command response is ready if user
> -			 * keeps touching the trackpad while command
> -			 * is sent to the device.
> +			 * Cover the Gen5 V1 firmware issue.
> +			 * The issue is no interrupt would be asserted from
> +			 * trackpad device to host for the command response
> +			 * ready event. Because when there was a finger touch
> +			 * on trackpad device, and the firmware output queue
> +			 * won't be empty (always with touch report data), so
> +			 * the interrupt signal won't be asserted again until
> +			 * the output queue was previous emptied.
> +			 * This issue would happen in the scenario that
> +			 * user always has his/her fingers touched on the
> +			 * trackpad device during system booting/rebooting.
>  			 */
>  			length = 0;
> -			if (gen5_pip->resp_len)
> -				length = *gen5_pip->resp_len;
> +			if (pip->resp_len)
> +				length = *pip->resp_len;
>  			cyapa_empty_pip_output_data(cyapa,
> -					gen5_pip->resp_data,
> +					pip->resp_data,
>  					&length,
> -					gen5_pip->resp_sort_func);
> -			if (gen5_pip->resp_len && length != 0) {
> -				*gen5_pip->resp_len = length;
> -				atomic_dec(&gen5_pip->cmd_issued);
> -				complete(&gen5_pip->cmd_ready);
> +					pip->resp_sort_func);
> +			if (pip->resp_len && length != 0) {
> +				*pip->resp_len = length;
> +				atomic_dec(&pip->cmd_issued);
> +				complete(&pip->cmd_ready);
>  			}
>  			return false;
>  		}
>  
> -		if (gen5_pip->resp_data && gen5_pip->resp_len) {
> -			*gen5_pip->resp_len = (*gen5_pip->resp_len < length) ?
> -				*gen5_pip->resp_len : length;
> -			memcpy(gen5_pip->resp_data, gen5_pip->irq_cmd_buf,
> -				*gen5_pip->resp_len);
> +		if (pip->resp_data && pip->resp_len) {
> +			*pip->resp_len = (*pip->resp_len < length) ?
> +				*pip->resp_len : length;
> +			memcpy(pip->resp_data, pip->irq_cmd_buf,
> +				*pip->resp_len);
>  		}
> -		atomic_dec(&gen5_pip->cmd_issued);
> -		complete(&gen5_pip->cmd_ready);
> +		atomic_dec(&pip->cmd_issued);
> +		complete(&pip->cmd_ready);
>  		return false;
>  	}
>  
>  	return true;
>  }
>  
> -static void cyapa_gen5_report_buttons(struct cyapa *cyapa,
> -		const struct cyapa_gen5_report_data *report_data)
> +static void cyapa_pip_report_buttons(struct cyapa *cyapa,
> +		const struct cyapa_pip_report_data *report_data)
>  {
>  	struct input_dev *input = cyapa->input;
> -	u8 buttons = report_data->report_head[GEN5_BUTTONS_OFFSET];
> +	u8 buttons = report_data->report_head[PIP_BUTTONS_OFFSET];
>  
>  	buttons = (buttons << CAPABILITY_BTN_SHIFT) & CAPABILITY_BTN_MASK;
>  
> @@ -2605,12 +2544,12 @@ static void cyapa_gen5_report_buttons(struct cyapa *cyapa,
>  	input_sync(input);
>  }
>  
> -static void cyapa_gen5_report_slot_data(struct cyapa *cyapa,
> -		const struct cyapa_gen5_touch_record *touch)
> +static void cyapa_pip_report_slot_data(struct cyapa *cyapa,
> +		const struct cyapa_pip_touch_record *touch)
>  {
>  	struct input_dev *input = cyapa->input;
> -	u8 event_id = GEN5_GET_EVENT_ID(touch->touch_tip_event_id);
> -	int slot = GEN5_GET_TOUCH_ID(touch->touch_tip_event_id);
> +	u8 event_id = PIP_GET_EVENT_ID(touch->touch_tip_event_id);
> +	int slot = PIP_GET_TOUCH_ID(touch->touch_tip_event_id);
>  	int x, y;
>  
>  	if (event_id == RECORD_EVENT_LIFTOFF)
> @@ -2621,10 +2560,10 @@ static void cyapa_gen5_report_slot_data(struct cyapa *cyapa,
>  	x = (touch->x_hi << 8) | touch->x_lo;
>  	if (cyapa->x_origin)
>  		x = cyapa->max_abs_x - x;
> -	input_report_abs(input, ABS_MT_POSITION_X, x);
>  	y = (touch->y_hi << 8) | touch->y_lo;
>  	if (cyapa->y_origin)
>  		y = cyapa->max_abs_y - y;
> +	input_report_abs(input, ABS_MT_POSITION_X, x);
>  	input_report_abs(input, ABS_MT_POSITION_Y, y);
>  	input_report_abs(input, ABS_MT_PRESSURE,
>  		touch->z);
> @@ -2642,50 +2581,49 @@ static void cyapa_gen5_report_slot_data(struct cyapa *cyapa,
>  		touch->orientation);
>  }
>  
> -static void cyapa_gen5_report_touches(struct cyapa *cyapa,
> -		const struct cyapa_gen5_report_data *report_data)
> +static void cyapa_pip_report_touches(struct cyapa *cyapa,
> +		const struct cyapa_pip_report_data *report_data)
>  {
>  	struct input_dev *input = cyapa->input;
>  	unsigned int touch_num;
>  	int i;
>  
> -	touch_num = report_data->report_head[GEN5_NUMBER_OF_TOUCH_OFFSET] &
> -			GEN5_NUMBER_OF_TOUCH_MASK;
> +	touch_num = report_data->report_head[PIP_NUMBER_OF_TOUCH_OFFSET] &
> +			PIP_NUMBER_OF_TOUCH_MASK;
>  
>  	for (i = 0; i < touch_num; i++)
> -		cyapa_gen5_report_slot_data(cyapa,
> +		cyapa_pip_report_slot_data(cyapa,
>  			&report_data->touch_records[i]);
>  
>  	input_mt_sync_frame(input);
>  	input_sync(input);
>  }
>  
> -static int cyapa_gen5_irq_handler(struct cyapa *cyapa)
> +int cyapa_pip_irq_handler(struct cyapa *cyapa)
>  {
>  	struct device *dev = &cyapa->client->dev;
> -	struct cyapa_gen5_report_data report_data;
> -	int ret;
> -	u8 report_id;
> +	struct cyapa_pip_report_data report_data;
>  	unsigned int report_len;
> +	u8 report_id;
> +	int ret;
>  
> -	if (cyapa->gen != CYAPA_GEN5 ||
> -		cyapa->state != CYAPA_STATE_GEN5_APP) {
> +	if (!cyapa_is_pip_app_mode(cyapa)) {
>  		dev_err(dev, "invalid device state, gen=%d, state=0x%02x\n",
>  			cyapa->gen, cyapa->state);
>  		return -EINVAL;
>  	}
>  
>  	ret = cyapa_i2c_pip_read(cyapa, (u8 *)&report_data,
> -			GEN5_RESP_LENGTH_SIZE);
> -	if (ret != GEN5_RESP_LENGTH_SIZE) {
> +			PIP_RESP_LENGTH_SIZE);
> +	if (ret != PIP_RESP_LENGTH_SIZE) {
>  		dev_err(dev, "failed to read length bytes, (%d)\n", ret);
>  		return -EINVAL;
>  	}
>  
>  	report_len = get_unaligned_le16(
> -			&report_data.report_head[GEN5_RESP_LENGTH_OFFSET]);
> -	if (report_len < GEN5_RESP_LENGTH_SIZE) {
> -		/* Invliad length or internal reset happened. */
> +			&report_data.report_head[PIP_RESP_LENGTH_OFFSET]);
> +	if (report_len < PIP_RESP_LENGTH_SIZE) {
> +		/* Invalid length or internal reset happened. */
>  		dev_err(dev, "invalid report_len=%d. bytes: %02x %02x\n",
>  			report_len, report_data.report_head[0],
>  			report_data.report_head[1]);
> @@ -2693,7 +2631,7 @@ static int cyapa_gen5_irq_handler(struct cyapa *cyapa)
>  	}
>  
>  	/* Idle, no data for report. */
> -	if (report_len == GEN5_RESP_LENGTH_SIZE)
> +	if (report_len == PIP_RESP_LENGTH_SIZE)
>  		return 0;
>  
>  	ret = cyapa_i2c_pip_read(cyapa, (u8 *)&report_data, report_len);
> @@ -2703,70 +2641,71 @@ static int cyapa_gen5_irq_handler(struct cyapa *cyapa)
>  		return -EINVAL;
>  	}
>  
> -	report_id = report_data.report_head[GEN5_RESP_REPORT_ID_OFFSET];
> -	if (report_id == GEN5_WAKEUP_EVENT_REPORT_ID &&
> -			report_len == GEN5_WAKEUP_EVENT_SIZE) {
> +	report_id = report_data.report_head[PIP_RESP_REPORT_ID_OFFSET];
> +	if (report_id == PIP_WAKEUP_EVENT_REPORT_ID &&
> +			report_len == PIP_WAKEUP_EVENT_SIZE) {
>  		/*
>  		 * Device wake event from deep sleep mode for touch.
>  		 * This interrupt event is used to wake system up.
>  		 */
>  		return 0;
> -	} else if (report_id != GEN5_TOUCH_REPORT_ID &&
> -			report_id != GEN5_BTN_REPORT_ID &&
> +	} else if (report_id != PIP_TOUCH_REPORT_ID &&
> +			report_id != PIP_BTN_REPORT_ID &&
>  			report_id != GEN5_OLD_PUSH_BTN_REPORT_ID &&
> -			report_id != GEN5_PUSH_BTN_REPORT_ID) {
> +			report_id != PIP_PUSH_BTN_REPORT_ID) {
>  		/* Running in BL mode or unknown response data read. */
>  		dev_err(dev, "invalid report_id=0x%02x\n", report_id);
>  		return -EINVAL;
>  	}
>  
> -	if (report_id == GEN5_TOUCH_REPORT_ID &&
> -		(report_len < GEN5_TOUCH_REPORT_HEAD_SIZE ||
> -			report_len > GEN5_TOUCH_REPORT_MAX_SIZE)) {
> +	if (report_id == PIP_TOUCH_REPORT_ID &&
> +		(report_len < PIP_TOUCH_REPORT_HEAD_SIZE ||
> +			report_len > PIP_TOUCH_REPORT_MAX_SIZE)) {
>  		/* Invalid report data length for finger packet. */
>  		dev_err(dev, "invalid touch packet length=%d\n", report_len);
>  		return 0;
>  	}
>  
> -	if ((report_id == GEN5_BTN_REPORT_ID ||
> +	if ((report_id == PIP_BTN_REPORT_ID ||
>  			report_id == GEN5_OLD_PUSH_BTN_REPORT_ID ||
> -			report_id == GEN5_PUSH_BTN_REPORT_ID) &&
> -		(report_len < GEN5_BTN_REPORT_HEAD_SIZE ||
> -			report_len > GEN5_BTN_REPORT_MAX_SIZE)) {
> +			report_id == PIP_PUSH_BTN_REPORT_ID) &&
> +		(report_len < PIP_BTN_REPORT_HEAD_SIZE ||
> +			report_len > PIP_BTN_REPORT_MAX_SIZE)) {
>  		/* Invalid report data length of button packet. */
>  		dev_err(dev, "invalid button packet length=%d\n", report_len);
>  		return 0;
>  	}
>  
> -	if (report_id == GEN5_TOUCH_REPORT_ID)
> -		cyapa_gen5_report_touches(cyapa, &report_data);
> +	if (report_id == PIP_TOUCH_REPORT_ID)
> +		cyapa_pip_report_touches(cyapa, &report_data);
>  	else
> -		cyapa_gen5_report_buttons(cyapa, &report_data);
> +		cyapa_pip_report_buttons(cyapa, &report_data);
>  
>  	return 0;
>  }
>  
> -static int cyapa_gen5_bl_activate(struct cyapa *cyapa) { return 0; }
> -static int cyapa_gen5_bl_deactivate(struct cyapa *cyapa) { return 0; }
> +int cyapa_pip_bl_activate(struct cyapa *cyapa) { return 0; }
> +int cyapa_pip_bl_deactivate(struct cyapa *cyapa) { return 0; }
> +
>  
>  const struct cyapa_dev_ops cyapa_gen5_ops = {
> -	.check_fw = cyapa_gen5_check_fw,
> -	.bl_enter = cyapa_gen5_bl_enter,
> -	.bl_initiate = cyapa_gen5_bl_initiate,
> -	.update_fw = cyapa_gen5_do_fw_update,
> -	.bl_activate = cyapa_gen5_bl_activate,
> -	.bl_deactivate = cyapa_gen5_bl_deactivate,
> +	.check_fw = cyapa_pip_check_fw,
> +	.bl_enter = cyapa_pip_bl_enter,
> +	.bl_initiate = cyapa_pip_bl_initiate,
> +	.update_fw = cyapa_pip_do_fw_update,
> +	.bl_activate = cyapa_pip_bl_activate,
> +	.bl_deactivate = cyapa_pip_bl_deactivate,
>  
>  	.show_baseline = cyapa_gen5_show_baseline,
> -	.calibrate_store = cyapa_gen5_do_calibrate,
> +	.calibrate_store = cyapa_pip_do_calibrate,
>  
> -	.initialize = cyapa_gen5_initialize,
> +	.initialize = cyapa_pip_cmd_state_initialize,
>  
>  	.state_parse = cyapa_gen5_state_parse,
>  	.operational_check = cyapa_gen5_do_operational_check,
>  
> -	.irq_handler = cyapa_gen5_irq_handler,
> -	.irq_cmd_handler = cyapa_gen5_irq_cmd_handler,
> +	.irq_handler = cyapa_pip_irq_handler,
> +	.irq_cmd_handler = cyapa_pip_irq_cmd_handler,
>  	.sort_empty_output_data = cyapa_empty_pip_output_data,
>  	.set_power_mode = cyapa_gen5_set_power_mode,
>  };
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
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Anirudh Ghayal <aghayal@codeaurora.org>
Subject: Re: [rtc-linux] Re: [RFC v1 PATCH 2/6] input: pm8058_keypad: Qualcomm
 PMIC8058 keypad controller driver
Date: Thu, 06 Jan 2011 17:26:39 +0530
Message-ID: <4D25ADF7.7010901@codeaurora.org>
References: <1289393281-4459-1-git-send-email-tsoni@codeaurora.org> <1289393281-4459-3-git-send-email-tsoni@codeaurora.org> <20101206181427.GA18567@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20101206181427.GA18567@core.coreip.homeip.net>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Trilok Soni <tsoni@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dimitry,

On 12/6/2010 11:44 PM, Dmitry Torokhov wrote:
> Hi Trilok,
>
> On Wed, Nov 10, 2010 at 06:17:57PM +0530, Trilok Soni wrote:
>> Add Qualcomm PMIC8058 based keypad controller driver
>> supporting upto 18x8 matrix configuration.
>>
>
> Looks very good, just a couple of small things:
>
>> +
>> +#include<linux/input/pmic8058-keypad.h>
>
> Move to MFD directory with the rest of pmic8058 definitions?
>
>> + */
>> +struct pmic8058_kp {
>> +	const struct pmic8058_keypad_data *pdata;
>> +	struct input_dev *input;
>> +	int key_sense_irq;
>> +	int key_stuck_irq;
>> +
>> +	unsigned short *keycodes;
>
> I'd pull the keycodes into this structure (at the end) so it can be
> allocated in one shot. Hmm it even appears to be constant-sized. So just
> declare it right here and be done with it.
>
>> +
>> +static int pmic8058_detect_ghost_keys(struct pmic8058_kp *kp, u16 *new_state)
>
> bool
>
>> +{
>> +	int row, found_first = -1;
>> +	u16 check, row_state;
>> +
>> +	check = 0;
>> +	for (row = 0; row<  kp->pdata->num_rows; row++) {
>> +		row_state = (~new_state[row])&
>> +				 ((1<<  kp->pdata->num_cols) - 1);
>> +
>> +		if (hweight16(row_state)>  1) {
>> +			if (found_first == -1)
>> +				found_first = row;
>> +			if (check&  row_state) {
>> +				dev_dbg(kp->dev, "detected ghost key on row[%d]"
>> +					 " and row[%d]\n", found_first, row);
>> +				return 1;
>
> true
>
>> +			}
>> +		}
>> +		check |= row_state;
>> +	}
>> +	return 0;
>
> false
>
>> +
>> +static int pmic8058_kpd_init(struct pmic8058_kp *kp)
>> +{
>> +	int bits, rc, cycles;
>> +	u8 scan_val = 0, ctrl_val = 0;
>> +	static u8 row_bits[] = {
>
> const?
>
>> +		0, 1, 2, 3, 4, 4, 5, 5, 6, 6, 6, 7, 7, 7,
>> +	};
>> +
>> +}
>> +
>> +static int pmic8058_kp_enable(struct pmic8058_kp *kp)
>> +{
>> +	int rc;
>> +
>> +	kp->ctrl_reg |= KEYP_CTRL_KEYP_EN;
>> +
>> +	rc = pmic8058_kp_write_u8(kp, kp->ctrl_reg, KEYP_CTRL);
>> +	if (rc<  0)
>> +		return rc;
>> +
>> +	enable_irq(kp->key_sense_irq);
>> +	enable_irq(kp->key_stuck_irq);
>> +
>> +	return rc;
>> +}
>> +
>> +static int pmic8058_kp_disable(struct pmic8058_kp *kp)
>> +{
>> +	int rc;
>> +
>> +	kp->ctrl_reg&= ~KEYP_CTRL_KEYP_EN;
>> +
>> +	rc = pmic8058_kp_write_u8(kp, kp->ctrl_reg, KEYP_CTRL);
>> +	if (rc<  0)
>> +		return rc;
>> +
>> +	disable_irq(kp->key_sense_irq);
>> +	disable_irq(kp->key_stuck_irq);
>> +
>> +	return rc;
>> +}
>> +
>> +static int pmic8058_kp_open(struct input_dev *dev)
>> +{
>> +	struct pmic8058_kp *kp = input_get_drvdata(dev);
>> +
>> +	return pmic8058_kp_enable(kp);
>> +}
>> +
>> +static void pmic8058_kp_close(struct input_dev *dev)
>> +{
>> +	struct pmic8058_kp *kp = input_get_drvdata(dev);
>> +
>> +	pmic8058_kp_disable(kp);
>> +}
>> +
>
> You need to protect suspend/resume from racing with open_close. Take
> dev->mutex and act depending on whether there are users of the device.

In our case, we can only disable/enable the keypad in suspend/resume if 
the device is not configured as wakeup. The call pmic8058_kp_disable(kp) 
disables the keypad totally rather than placing it in the low power mode 
(the hardware does support this capability). So, we plan to add the race 
check only if the device is not configured as wakeup capable.

>
>> +	if (pdata->rows_gpio_start<  0 || pdata->cols_gpio_start<  0) {
>> +		dev_err(&pdev->dev, "invalid gpio_start platform data\n");
>> +		return -EINVAL;
>
> These are declared as unsigned. Hmm, doesn't sparse catch it?
>
> Thanks.
>

Thanks,
Anirudh

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

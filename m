From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH] HID: rmi: Write updated F11 control registers after reset
Date: Fri, 10 Jul 2015 13:47:51 +0200
Message-ID: <3593705.ueTqWlprC3@xps13>
References: <1436480057-23774-1-git-send-email-aduggan@synaptics.com> <2172572.685fORisNy@xps13> <559F14B8.6010705@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:34524 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbbGJLrz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jul 2015 07:47:55 -0400
In-Reply-To: <559F14B8.6010705@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thursday 09 July 2015 17:41:28 Andrew Duggan wrote:
> On 07/09/2015 03:40 PM, Gabriele Mazzotta wrote:
> > On Thursday 09 July 2015 15:14:17 Andrew Duggan wrote:
> >> When a device is reset the values of control registers will be reset to
> >> the defaults. This patch reapplies the control register values set for F11
> >> by the driver.
> > Hi,
> >
> > thanks for this, it works as intended. I just added a couple of
> > comments here below, but other than that
> >
> > Tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> 
> Thanks for testing!
> 
> >> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> >> ---
> >>   drivers/hid/hid-rmi.c | 41 ++++++++++++++++++++++++++++++++++-------
> >>   1 file changed, 34 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> >> index af191a2..80c068f 100644
> >> --- a/drivers/hid/hid-rmi.c
> >> +++ b/drivers/hid/hid-rmi.c
> >> @@ -40,6 +40,8 @@
> >>   #define RMI_DEVICE			BIT(0)
> >>   #define RMI_DEVICE_HAS_PHYS_BUTTONS	BIT(1)
> >>   
> >> +#define RMI_F11_CTRL_REG_COUNT		12
> >> +
> >>   enum rmi_mode_type {
> >>   	RMI_MODE_OFF			= 0,
> >>   	RMI_MODE_ATTN_REPORTS		= 1,
> >> @@ -116,6 +118,8 @@ struct rmi_data {
> >>   	unsigned int max_y;
> >>   	unsigned int x_size_mm;
> >>   	unsigned int y_size_mm;
> >> +	bool read_f11_ctrl_regs;
> >> +	u8 f11_ctrl_regs[RMI_F11_CTRL_REG_COUNT];
> >>   
> >>   	unsigned int gpio_led_count;
> >>   	unsigned int button_count;
> >> @@ -557,6 +561,15 @@ static int rmi_set_sleep_mode(struct hid_device *hdev, int sleep_mode)
> >>   
> >>   static int rmi_suspend(struct hid_device *hdev, pm_message_t message)
> >>   {
> >> +	struct rmi_data *data = hid_get_drvdata(hdev);
> >> +	int ret;
> >> +
> >> +	ret = rmi_read_block(hdev, data->f11.control_base_addr,
> >> +			data->f11_ctrl_regs, RMI_F11_CTRL_REG_COUNT);
> >> +	if (ret)
> >> +		hid_warn(hdev, "can not read F11 control registers\n");
> > It seems that rmi_read_block() can fail because of timeouts after it
> > has started filling the buffer, so isn't it better to set
> > read_f11_ctrl_regs to false when it happens?
> >
> 
> Another option would be to create a local buffer for the read and only 
> copy it to data->f11_ctrl_regs if we get all of the bytes. That way we 
> can ensure that rmi_post_reset will have a valid set of registers to 
> restore. Or we could also just remove the read from the suspend callback 
> altogether and just write the values we set in rmi_populate_f11 and not 
> worry about changes made outside the driver.

The first solution you propose is what I did in my early changes before
I reported the problem. Even if I doubt that there are many users out
there changing the configuration with extrnal tools, I think that
saving and restoring the configuration is better.

> >> +
> >> +
> >>   	if (!device_may_wakeup(hdev->dev.parent))
> >>   		return rmi_set_sleep_mode(hdev, RMI_SLEEP_DEEP_SLEEP);
> >>   
> >> @@ -565,6 +578,7 @@ static int rmi_suspend(struct hid_device *hdev, pm_message_t message)
> >>   
> >>   static int rmi_post_reset(struct hid_device *hdev)
> >>   {
> >> +	struct rmi_data *data = hid_get_drvdata(hdev);
> >>   	int ret;
> >>   
> >>   	ret = rmi_set_mode(hdev, RMI_MODE_ATTN_REPORTS);
> >> @@ -573,6 +587,14 @@ static int rmi_post_reset(struct hid_device *hdev)
> >>   		return ret;
> >>   	}
> >>   
> >> +	if (data->read_f11_ctrl_regs) {
> >> +		ret = rmi_write_block(hdev, data->f11.control_base_addr,
> >> +				data->f11_ctrl_regs, RMI_F11_CTRL_REG_COUNT);
> >> +		if (ret)
> >> +			hid_warn(hdev,
> >> +				"can not write F11 control registers after reset\n");
> >> +	}
> >> +
> >>   	if (!device_may_wakeup(hdev->dev.parent)) {
> >>   		ret = rmi_set_sleep_mode(hdev, RMI_SLEEP_NORMAL);
> >>   		if (ret) {
> >> @@ -963,18 +985,23 @@ static int rmi_populate_f11(struct hid_device *hdev)
> >>   	 * and there is no way to know if the first 20 bytes are here or not.
> >>   	 * We use only the first 12 bytes, so get only them.
> >>   	 */
> > Just a suggestion here. What about moving this comment right above the
> > definition of RMI_F11_CTRL_REG_COUNT?
> 
> That makes sense. I can make this change in my v2.
> 
> >> -	ret = rmi_read_block(hdev, data->f11.control_base_addr, buf, 12);
> >> +	ret = rmi_read_block(hdev, data->f11.control_base_addr,
> >> +			data->f11_ctrl_regs, RMI_F11_CTRL_REG_COUNT);
> >>   	if (ret) {
> >>   		hid_err(hdev, "can not read ctrl block of size 11: %d.\n", ret);
> >>   		return ret;
> >>   	}
> >>   
> >> -	data->max_x = buf[6] | (buf[7] << 8);
> >> -	data->max_y = buf[8] | (buf[9] << 8);
> >> +	/* data->f11_ctrl_regs now contains valid register data */
> >> +	data->read_f11_ctrl_regs = true;
> >> +
> >> +	data->max_x = data->f11_ctrl_regs[6] | (data->f11_ctrl_regs[7] << 8);
> >> +	data->max_y = data->f11_ctrl_regs[8] | (data->f11_ctrl_regs[9] << 8);
> >>   
> >>   	if (has_dribble) {
> >> -		buf[0] = buf[0] & ~BIT(6);
> >> -		ret = rmi_write(hdev, data->f11.control_base_addr, buf);
> >> +		data->f11_ctrl_regs[0] = data->f11_ctrl_regs[0] & ~BIT(6);
> >> +		ret = rmi_write(hdev, data->f11.control_base_addr,
> >> +				data->f11_ctrl_regs);
> >>   		if (ret) {
> >>   			hid_err(hdev, "can not write to control reg 0: %d.\n",
> >>   				ret);
> >> @@ -983,9 +1010,9 @@ static int rmi_populate_f11(struct hid_device *hdev)
> >>   	}
> >>   
> >>   	if (has_palm_detect) {
> >> -		buf[11] = buf[11] & ~BIT(0);
> >> +		data->f11_ctrl_regs[11] = data->f11_ctrl_regs[11] & ~BIT(0);
> >>   		ret = rmi_write(hdev, data->f11.control_base_addr + 11,
> >> -				&buf[11]);
> >> +				&data->f11_ctrl_regs[11]);
> >>   		if (ret) {
> >>   			hid_err(hdev, "can not write to control reg 11: %d.\n",
> >>   				ret);
> >>
> Andrew


From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH 07/11] Input: synaptics-rmi4 - f30/f03: Forward mechanical
 buttons on buttonpads to PS/2 guest
Date: Tue, 30 Aug 2016 12:16:11 -0700
Message-ID: <1804230c-d742-9454-d2e0-c349e566414d@synaptics.com>
References: <1471512289-10648-1-git-send-email-benjamin.tissoires@redhat.com>
 <1471512289-10648-8-git-send-email-benjamin.tissoires@redhat.com>
 <c6479b09-9808-6f86-2c6b-e420b83b26d6@synaptics.com>
 <20160830151312.GF21864@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:60560 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753990AbcH3TQM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 Aug 2016 15:16:12 -0400
In-Reply-To: <20160830151312.GF21864@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lyude Paul <thatslyude@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On 08/30/2016 08:13 AM, Benjamin Tissoires wrote:
> Hi Andrew,
>
> On Aug 26 2016 or thereabouts, Andrew Duggan wrote:
>> Resending as plain text
>>
>> Hi Benjamin,
>>
>> This patch causes standard clickpads without extended buttons to not work.
>> I'll explain some more below.
>>
>> On 08/18/2016 02:24 AM, Benjamin Tissoires wrote:
>>> From: Lyude Paul <thatslyude@gmail.com>
>>>
>>> On the latest series of ThinkPads, the button events for the TrackPoint
>>> are reported through the touchpad itself as opposed to the TrackPoint
>>> device. In order to report these buttons properly, we need to forward
>>> them to the TrackPoint device and send the button presses/releases
>>> through there instead.
>>>
>>> Signed-off-by: Lyude Paul <thatslyude@gmail.com>
>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>> ---
>>> drivers/input/rmi4/rmi_driver.h | 13 +++++++++
>>> drivers/input/rmi4/rmi_f03.c    | 28 ++++++++++++++++++
>>> drivers/input/rmi4/rmi_f30.c    | 64 +++++++++++++++++++++++++++++++++++------
>>> 3 files changed, 97 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
>>> index e4be773..a0b1978 100644
>>> --- a/drivers/input/rmi4/rmi_driver.h
>>> +++ b/drivers/input/rmi4/rmi_driver.h
>>> @@ -99,6 +99,19 @@ struct rmi_function *rmi_find_function(struct rmi_device *rmi_dev, u8 number);
>>>
>>> char *rmi_f01_get_product_ID(struct rmi_function *fn);
>>>
>>> +#ifdef CONFIG_RMI4_F03
>>> +int rmi_f03_overwrite_button(struct rmi_function *fn, unsigned int button,
>>> +			     int value);
>>> +void rmi_f03_commit_buttons(struct rmi_function *fn);
>>> +#else
>>> +static inline int rmi_f03_overwrite_button(struct rmi_function *fn,
>>> +					   unsigned int button, int value)
>>> +{
>>> +	return 0;
>>> +}
>>> +static inline void rmi_f03_commit_buttons(struct rmi_function *fn) {}
>>> +#endif
>>> +
>>> extern struct rmi_function_handler rmi_f01_handler;
>>> extern struct rmi_function_handler rmi_f03_handler;
>>> extern struct rmi_function_handler rmi_f11_handler;
>>> diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
>>> index daae1c95..535f426 100644
>>> --- a/drivers/input/rmi4/rmi_f03.c
>>> +++ b/drivers/input/rmi4/rmi_f03.c
>>> @@ -37,6 +37,34 @@ struct f03_data {
>>> 	u8 rx_queue_length;
>>> };
>>>
>>> +int rmi_f03_overwrite_button(struct rmi_function *fn, unsigned int button,
>>> +			     int value)
>>> +{
>>> +	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
>>> +	unsigned int bit = BIT(button);
>>> +
>>> +	if (button > 2)
>>> +		return -EINVAL;
>>> +
>>> +	if (value)
>>> +		f03->overwrite_buttons |= bit;
>>> +	else
>>> +		f03->overwrite_buttons &= ~bit;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +void rmi_f03_commit_buttons(struct rmi_function *fn)
>>> +{
>>> +	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
>>> +	int i;
>>> +
>>> +	f03->serio->extra_byte = f03->overwrite_buttons;
>>> +
>>> +	for (i = 0; i < 3; i++)
>>> +		serio_interrupt(f03->serio, 0x00, 0x00);
>>> +}
>>> +
>>> static int rmi_f03_pt_write(struct serio *id, unsigned char val)
>>> {
>>> 	struct f03_data *f03 = id->port_data;
>>> diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
>>> index 7990bb0..14e3221 100644
>>> --- a/drivers/input/rmi4/rmi_f30.c
>>> +++ b/drivers/input/rmi4/rmi_f30.c
>>> @@ -74,8 +74,11 @@ struct f30_data {
>>>
>>> 	u8 data_regs[RMI_F30_CTRL_MAX_BYTES];
>>> 	u16 *gpioled_key_map;
>>> +	u16 *gpio_passthrough_key_map;
>>>
>>> 	struct input_dev *input;
>>> +	bool trackstick_buttons;
>>> +	struct rmi_function *f03;
>>> };
>>>
>>> static int rmi_f30_read_control_parameters(struct rmi_function *fn,
>>> @@ -108,6 +111,13 @@ static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
>>> 	if (!f30->input)
>>> 		return 0;
>>>
>>> +	if (f30->trackstick_buttons && !f30->f03) {
>>> +		f30->f03 = rmi_find_function(rmi_dev, 3);
>>> +
>>> +		if (!f30->f03)
>>> +			return -EBUSY;
>>> +	}
>>> +
>>> 	/* Read the gpi led data. */
>>> 	if (rmi_dev->xport->attn_data) {
>>> 		memcpy(f30->data_regs, rmi_dev->xport->attn_data,
>>> @@ -128,23 +138,29 @@ static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
>>> 	for (reg_num = 0; reg_num < f30->register_count; ++reg_num) {
>>> 		for (i = 0; gpiled < f30->gpioled_count && i < 8; ++i,
>>> 			++gpiled) {
>>> -			if (f30->gpioled_key_map[gpiled] != 0) {
>>> -				/* buttons have pull up resistors */
>>> -				value = (((f30->data_regs[reg_num] >> i) & 0x01)
>>> -									== 0);
>>> +			/* buttons have pull up resistors */
>>> +			value = (((f30->data_regs[reg_num] >> i) & 0x01) == 0);
>>>
>>> +			if (f30->gpioled_key_map[gpiled] != 0) {
>>> 				rmi_dbg(RMI_DEBUG_FN, &fn->dev,
>>> 					"%s: call input report key (0x%04x) value (0x%02x)",
>>> 					__func__,
>>> 					f30->gpioled_key_map[gpiled], value);
>>> +
>>> 				input_report_key(f30->input,
>>> 						 f30->gpioled_key_map[gpiled],
>>> 						 value);
>>> +			} else if (f30->gpio_passthrough_key_map[gpiled]) {
>>> +				rmi_f03_overwrite_button(f30->f03,
>>> +						f30->gpio_passthrough_key_map[gpiled] - BTN_LEFT,
>>> +						value);
>>> 			}
>>> -
>>> 		}
>>> 	}
>>>
>>> +	if (f30->trackstick_buttons)
>>> +		rmi_f03_commit_buttons(f30->f03);
>>> +
>>> 	return 0;
>>> }
>>>
>>> @@ -242,10 +258,10 @@ static inline int rmi_f30_initialize(struct rmi_function *fn)
>>> 	int retval = 0;
>>> 	int control_address;
>>> 	int i;
>>> -	int button;
>>> +	int button, extra_button;
>>> 	u8 buf[RMI_F30_QUERY_SIZE];
>>> 	u8 *ctrl_reg;
>>> -	u8 *map_memory;
>>> +	u8 *map_memory, *pt_memory;
>>>
>>> 	f30 = devm_kzalloc(&fn->dev, sizeof(struct f30_data),
>>> 			   GFP_KERNEL);
>>> @@ -343,15 +359,47 @@ static inline int rmi_f30_initialize(struct rmi_function *fn)
>>> 	map_memory = devm_kzalloc(&fn->dev,
>>> 				  (f30->gpioled_count * (sizeof(u16))),
>>> 				  GFP_KERNEL);
>>> -	if (!map_memory) {
>>> +	pt_memory = devm_kzalloc(&fn->dev,
>>> +				 (f30->gpioled_count * (sizeof(u16))),
>>> +				 GFP_KERNEL);
>>> +	if (!map_memory || !pt_memory) {
>>> 		dev_err(&fn->dev, "Failed to allocate gpioled map memory.\n");
>>> 		return -ENOMEM;
>>> 	}
>>>
>>> 	f30->gpioled_key_map = (u16 *)map_memory;
>>> +	f30->gpio_passthrough_key_map = (u16 *)pt_memory;
>>>
>>> 	pdata = rmi_get_platform_data(rmi_dev);
>>> 	if (pdata && f30->has_gpio) {
>> This existing check of pdata is not needed because pdata is embedded in the
>> transport device and will never be NULL. That means that in this patch the
>> else case will never be called.
> oops. Good catch
>
>>> +		/*
>>> +		 * For touchpads the buttons are mapped as:
>>> +		 * - bit 0 = Left, bit 1 = right, bit 2 = middle / clickbutton
>>> +		 * - 3, 4, 5 are extended buttons and
>>> +		 * - 6 and 7 are other sorts of GPIOs
>>> +		 */
>>> +		button = BTN_LEFT;
>>> +		extra_button = BTN_LEFT;
>>> +		for (i = 0; i < f30->gpioled_count - 2 && i < 3; i++) {
>> Subtracting 2 from gpioled_count does not have the intended affect. The name
>> gpioled_count comes from the spec, but that byte is really a bit map. On a
>> typical clickpad bit two is set as mentioned in the new comment. The result
> I really doubt this is a bit map. On the T450s, only bit 3 (the 4th bit
> then) is set and this corresponds to the numerical value "8". If it were
> a bit map, I would expect bits 0-7 to be set -> 0xFF.
>
> Aren't you mixing the gpioled_count and the gpioled_key_map? Because bit
> 2 set on gpioled_count would be 4, and I can't figure out a proper use
> of this number :)

Yes, I was confused and that last email from me needs to be deleted from 
the internet. I remembered that gpioled_count doesn't work the way I 
expect it to, but I confused a few things when trying to explain why 
subtracting 2 from gpioled_count doesn't work. So let me try this again. 
The gpioled_count is the number of bits used to represent gpios or leds 
in ctrl 2 and ctrl 3. On a standard clickpad the gpioled_count is set to 
3 which means the first 3 bits of ctrl 2 and ctrl 3 need to be checked. 
This is because the click button is defined in bit 2 (like the comment 
above).

The Lenovos have more GPIOs so the count is 8. Which means all 8 bits 
need to be checked since gpios are defined up to bit 7.

>> is that this for loop only runs once and it only checks the first bit of
>> ctrl 2 and ctrl 3 for a valid button. Since bit 0 is not set then no valid
>> buttons are reported for the clickpad.
>>
>> It looks like the Lenovo systems which this patch is targeting actually have
>> 6 gpios defined (bits 2 - 7 are set) so this code works on those system
> Yes, the conditions in the for loops are wrong. I think they could
> be fixed easily by having one case for (f30->has_gpio &&
> f30->trackstick_buttons) and one other when f30->trackstick_buttons is
> not set. In the trackstick button case, I should also only take into
> account the first 6 buttons (it's a special case after all :-P ).
>
>> since the "count" is sufficiently large. Also, maybe it's time to rename
>> gpioled_count to something like gpioled_map.
>>
>>> +			if (rmi_f30_is_valid_button(i, f30->ctrl))
>>> +				f30->gpioled_key_map[i] = button++;
>>> +		}
>>> +
>>> +		f30->trackstick_buttons = pdata &&
>>> +				pdata->f30_data.trackstick_buttons;
>>> +
>>> +		if (f30->trackstick_buttons) {
>>> +			for (i = 3; i < f30->gpioled_count - 2; i++) {
>>> +				if (rmi_f30_is_valid_button(i, f30->ctrl))
>>> +					f30->gpio_passthrough_key_map[i] = extra_button++;
>>> +			}
>>> +		} else {
>>> +			for (i = 3; i < f30->gpioled_count - 2; i++) {
>>> +				if (rmi_f30_is_valid_button(i, f30->ctrl))
>>> +					f30->gpioled_key_map[i] = button++;
>>> +			}
>>> +		}
>>> +	} else if (f30->has_gpio) {
>> As noted above this else block is never called.
> Yep :(
>
> Thanks for the other reviews BTW. I amended the patches locally and will
> resubmit this week or the week after if there are more reviews coming
> in.

I'll take a look at the rest of the patches in the series when I have a 
chance. But, this was the only patch which caused an issue for me.

Thanks,
Andrew

> Cheers,
> Benjamin
>
>> Andrew
>>
>>> 		button = BTN_LEFT;
>>> 		for (i = 0; i < f30->gpioled_count; i++) {
>>> 			if (rmi_f30_is_valid_button(i, f30->ctrl)) {
>>>


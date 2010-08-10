From: <Rezwanul_Kabir@Dell.com>
Subject: RE: [Patch]: Add support for Intellimouse Mode in ALPS touchpad on
 Dell E2 series Laptops
Date: Tue, 10 Aug 2010 16:56:41 -0500
Message-ID: <57DF5FDC2DC0634FA2A310BC5B81A68D01E7EBD964@AUSX7MCPC108.AMER.DELL.COM>
References: <1281376658-13366-1-git-send-email-Rezwanul_Kabir@dell.com>
 <20100809193114.GA10408@lovely.krouter>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausxippc101.us.dell.com ([143.166.85.207]:47159 "EHLO
	ausxippc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab0HJV4q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Aug 2010 17:56:46 -0400
In-Reply-To: <20100809193114.GA10408@lovely.krouter>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chf.fritz@googlemail.com
Cc: linux-input@vger.kernel.org, sebastian_kapfer@gmx.net, dmitry.torokhov@gmail.com, vojtech@suse.cz



>-----Original Message-----
>From: Christoph Fritz [mailto:chf.fritz@googlemail.com] 
>Sent: Monday, August 09, 2010 2:31 PM
>To: Kabir, Rezwanul
>Cc: linux-input@vger.kernel.org; sebastian_kapfer@gmx.net; 
>dmitry.torokhov@gmail.com; vojtech@suse.cz
>Subject: Re: [Patch]: Add support for Intellimouse Mode in 
>ALPS touchpad on Dell E2 series Laptops
>
>On Mon, Aug 09, 2010 at 12:57:38PM -0500, Rezwanul Kabir wrote:
>> Dell E2 series laptops ( M4500, E6510, E6410 etc.) have ALPS 
>touchpads 
>> which are enabled by default as 3-byte generic PS/2 mouse mode. This 
>> patch enables the 4-byte "Intellimouse Mode" ( e.g scrolling 
>support).
>> 
>> 
>> Signed-off-by: Rezwanul Kabir <Rezwanul_Kabir@dell.com>
>> ---
>> 
>> diff -urNp a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> --- a/drivers/input/mouse/alps.c	2010-08-06 
>12:43:11.000000000 -0500
>> +++ b/drivers/input/mouse/alps.c	2010-08-08 
>08:03:34.000000000 -0500
>> @@ -63,6 +63,8 @@ static const struct alps_model_info alps
>>  	/* Dell Latitude E5500, E6400, E6500, Precision M4400 */
>>  	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf,
>>  		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
>> +	/* Dell Precision 4500 */
>> +	{ { 0x73, 0x02, 0x64 }, 0x80, 0x80, 0 },
>>  	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS 
>},	  /* Dell Vostro 1400 */
>>  	{ { 0x52, 0x01, 0x14 }, 0xff, 0xff,
>>  		ALPS_PASS | ALPS_DUALPOINT | 
>ALPS_PS2_INTERLEAVED },	  /* Toshiba Tecra A11-11L */
>> @@ -111,6 +113,33 @@ static const struct alps_model_info alps
>>   * on a dualpoint, etc.
>>   */
>>  
>> +
>> +static int dell_e2_setup_intellimouse_mode(void *data);
>> +
>
>I see you don't want the whole function at the top of the 
>file. But why?

  Sorry, this was a remnant from something else that I was trying before. I will
fix it.


>> +static struct alps_model_quirk alps_model_init_quirk_tbl[] = {
>> +
>> +	{ {0x73, 0x02, 0x64}, dell_e2_setup_intellimouse_mode },
>> +	{}
>> +};
>> +
>> +static int alps_model_init_quirk(struct psmouse *psmouse,
>> +					const struct 
>alps_model_info *model) {
>> +
>
>empty line

   Okay, will fix it.

>> +	int rc = 1;
>> +	struct alps_model_quirk *d = alps_model_init_quirk_tbl;
>> +
>> +	for (d = alps_model_init_quirk_tbl; d; d++) {
>> +		if (!memcmp(model->signature, d->signature,
>> +			    sizeof(d->signature))) {
>> +			rc = d->callback(psmouse);
>> +			break;
>> +		}
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>>  static bool alps_is_valid_first_byte(const struct 
>alps_model_info *model,
>>  				     unsigned char data)
>>  {
>> @@ -651,6 +680,53 @@ static void alps_disconnect(struct psmou
>>  	kfree(priv);
>>  }
>>  
>> +/* Magic Sequence to enable Intellimouse Mode on Dell E2 Touchpads*/
>> +
>> +static int dell_e2_setup_intellimouse_mode(void *data) {
>> +	struct psmouse *psmouse = (struct psmouse *)(data);
>> +	struct ps2dev *ps2dev = &psmouse->ps2dev;
>> +	struct input_dev *dev = psmouse->dev;
>> +	unsigned char param[3] = {0, 0, 0};
>
>wouldn't be param[] = ... be enough?
>

Okay will fix it.

>> +
>> +	if (ps2_command(ps2dev, param, 0x00f5) ||
>> +		ps2_command(ps2dev, param, 0x00ea) ||
>> +		ps2_command(ps2dev, param, 0x00ec) ||
>> +		ps2_command(ps2dev, param, 0x00ec) ||
>> +		ps2_command(ps2dev, param, 0x00ec) ||
>> +		ps2_command(ps2dev, param, 0x03e9))
>> +			return -1;
>> +
>> +	dbg("alps:dell_e2_setup: param[0]: %x,"
>> +		"param[1]: %x, param[2]: %x\n", param[0],
>> +					param[1], param[2]);
>> +/* Check for supported model to continue */
>> +
>> +	if (!((param[0] == 0x88) && (param[1] == 0x07)
>> +		&& ((param[2] == 0x9D) || (param[2] == 0x9B))))
>> +		return -1;
>> +
>> +	if (ps2_command(ps2dev, NULL, 0x00ec) ||
>> +		ps2_command(ps2dev, NULL, 0x00f0) ||
>> +		ps2_command(ps2dev, NULL, 0x00f0) ||
>> +		ps2_command(ps2dev, NULL, 0x00f0) ||
>> +		ps2_command(ps2dev, NULL, 0x00f3) ||
>> +		ps2_command(ps2dev, NULL, 0x0028) ||
>> +		ps2_command(ps2dev, NULL, 0x00f0) ||
>> +		ps2_command(ps2dev, NULL, 0x00f6) ||
>> +		ps2_command(ps2dev, NULL, 0x00ea) ||
>> +		ps2_command(ps2dev, NULL, 0x00f4))
>> +			return -1;
>> +
>> +	__set_bit(BTN_MIDDLE, dev->keybit);
>> +	__set_bit(REL_WHEEL, dev->relbit);
>> +
>> +	psmouse->pktsize = 4;
>> +	psmouse->type = PSMOUSE_IMPS;
>> +
>> +	return 0;
>> +}
>> +
>>  int alps_init(struct psmouse *psmouse)  {
>>  	struct alps_data *priv;
>> @@ -677,6 +753,14 @@ int alps_init(struct psmouse *psmouse)
>>  	if (alps_hw_init(psmouse))
>>  		goto init_fail;
>>  
>> +	if (!alps_model_init_quirk(psmouse, model)) {
>> +		printk(KERN_WARNING "alps.c: Enabled hardware 
>quirk, falling back to psmouse-core\n");
>> +		input_free_device(dev2);
>> +		kfree(priv);
>> +		psmouse->private = NULL;
>> +		return 0;
>> +	}
>
>goto init_fail; ?
>Do you need to skip psmouse_reset(psmouse)?
>

   Yes, reset will destroy the Intellimouse settings.
   Thanks for the feedback, I will resend the patch with the suggestions
     --rez


>> +
>>  	/*
>>  	 * Undo part of setup done for us by psmouse core since touchpad
>>  	 * is not a relative device.
>> diff -urNp a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
>> --- a/drivers/input/mouse/alps.h	2010-08-06 
>12:43:06.000000000 -0500
>> +++ b/drivers/input/mouse/alps.h	2010-08-06 
>12:43:46.000000000 -0500
>> @@ -26,6 +26,11 @@ struct alps_data {
>>  	struct timer_list timer;
>>  };
>>  
>> +struct alps_model_quirk {
>> +unsigned char signature[3];
>> +int (*callback)(void *data);
>> +};
>> +
>>  #ifdef CONFIG_MOUSE_PS2_ALPS
>>  int alps_detect(struct psmouse *psmouse, bool set_properties);  int 
>> alps_init(struct psmouse *psmouse); diff -urNp 
>> a/drivers/input/mouse/psmouse-base.c 
>b/drivers/input/mouse/psmouse-base.c
>> --- a/drivers/input/mouse/psmouse-base.c	2010-08-06 
>12:42:57.000000000 -0500
>> +++ b/drivers/input/mouse/psmouse-base.c	2010-08-08 
>21:02:43.000000000 -0500
>> @@ -659,7 +659,8 @@ static int psmouse_extensions(struct psm
>>  		ps2_command(&psmouse->ps2dev, NULL, 
>PSMOUSE_CMD_RESET_DIS);
>>  		if (alps_detect(psmouse, set_properties) == 0) {
>>  			if (!set_properties || alps_init(psmouse) == 0)
>> -				return PSMOUSE_ALPS;
>> +	/*If ALPS model quirk was applied, don't change the settings*/
>
>just for cosmetic, please use space at the beginning of a comment
>
>> +				return psmouse->type ? 
>psmouse->type : PSMOUSE_ALPS;
>>  /*
>>   * Init failed, try basic relative protocols
>>   */
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-input" 
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
>
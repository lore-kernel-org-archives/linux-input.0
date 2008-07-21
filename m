From: Alexey Torkhov <atorkhov@gmail.com>
Subject: Re: Problem with Genius Ergomedia 700
Date: Mon, 21 Jul 2008 17:51:32 +0400
Message-ID: <48849464.8040705@gmail.com>
References: <4790713A.9@gmail.com> <Pine.LNX.4.64.0801181208380.15647@twin.jikos.cz> <4790B634.5040701@gmail.com> <479203AA.7010607@gmail.com> <Pine.LNX.4.64.0802112232360.7699@twin.jikos.cz> <47B35742.7010305@gmail.com> <Pine.LNX.4.64.0802191359390.30955@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:38335 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbYGUOKF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2008 10:10:05 -0400
Received: by fk-out-0910.google.com with SMTP id 18so918745fkq.5
        for <linux-input@vger.kernel.org>; Mon, 21 Jul 2008 07:10:03 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0802191359390.30955@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi.

Sorry, I forgot about this as I don't have access to that keyboard
anymore. What's the status of this patch? If it's still not applied
then, I think, it will work and could be merged.

Alex.

Jiri Kosina wrote:
> On Wed, 13 Feb 2008, Alexey Torkhov wrote:
> 
>>>   as a key to input.h right now, sorry; if you have any idea for
>>>   alternatives that it would make sense to map them, please let me know
>> It could be mapped to AL Logon/Logoff (19D) - if I remember, it doesn't
>> written what it should logon or logoff - user session or any other thing like
>> IM client.
> 
> Could you please try the patch below and report back whether it makes all 
> the buttons behave correctly? If so, I'd ask Dmitry for ACK with respect 
> to adding new KEY_ definitions.
> 
> diff --git a/drivers/hid/hid-input-quirks.c b/drivers/hid/hid-input-quirks.c
> index a870ba5..1db3a36 100644
> --- a/drivers/hid/hid-input-quirks.c
> +++ b/drivers/hid/hid-input-quirks.c
> @@ -276,6 +276,24 @@ static int quirk_btc_8193(struct hid_usage *usage, struct input_dev *input,
>  	return 1;
>  }
>  
> +static int quirk_genius_ergomedia_700(struct hid_usage *usage, struct input_dev *input,
> +			      unsigned long **bit, int *max)
> +{
> +	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER)
> +		return 0;
> +
> +	switch (usage->hid & HID_USAGE) {
> +		case 0x029d: map_key_clear(KEY_PROG1);		break;
> +		case 0x029e: map_key_clear(KEY_PROG2);		break;
> +		case 0x029f: map_key_clear(KEY_PROG3);		break;
> +		case 0x02a1: map_key_clear(KEY_LOGON_LOGOFF);	break;
> +		case 0x02a2: map_key_clear(KEY_CAMERA);		break;
> +		case 0x02a3: map_key_clear(KEY_DOCUMENTS);	break;
> +		case 0x02a4: map_key_clear(KEY_AUDIO);		break;
> +		case 0x02a5: map_key_clear(KEY_PRESENTATION);	break;
> +
> +}
> +
>  #define VENDOR_ID_BELKIN			0x1020
>  #define DEVICE_ID_BELKIN_WIRELESS_KEYBOARD	0x0006
>  
> @@ -306,6 +324,9 @@ static int quirk_btc_8193(struct hid_usage *usage, struct input_dev *input,
>  #define VENDOR_ID_PETALYNX			0x18b1
>  #define DEVICE_ID_PETALYNX_MAXTER_REMOTE	0x0037
>  
> +#define VENDOR_ID_SUPERGATE			0x05d5
> +#define DEVICE_ID_GENIUS_ERGOMEDIA_700		0x8001
> +
>  static const struct hid_input_blacklist {
>  	__u16 idVendor;
>  	__u16 idProduct;
> @@ -332,7 +353,9 @@ static const struct hid_input_blacklist {
>  	{ VENDOR_ID_MONTEREY, DEVICE_ID_GENIUS_KB29E, quirk_cherry_genius_29e },
>  
>  	{ VENDOR_ID_PETALYNX, DEVICE_ID_PETALYNX_MAXTER_REMOTE, quirk_petalynx_remote },
> -	
> +
> +	{ VENDOR_ID_SUPERGATE, DEVICE_ID_GENIUS_ERGOMEDIA_700, quirk_genius_ergomedia_700 },
> +
>  	{ 0, 0, 0 }
>  };
>  
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 5325d98..ef4e472 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -635,8 +635,11 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  				case 0x192: map_key_clear(KEY_CALC);		break;
>  				case 0x194: map_key_clear(KEY_FILE);		break;
>  				case 0x196: map_key_clear(KEY_WWW);		break;
> +				case 0x19b: map_key_clear(KEY_LOGON);		break;
>  				case 0x19c: map_key_clear(KEY_LOGOFF);		break;
> +				case 0x19d: map_key_clear(KEY_LOGON_LOGOFF);	break;
>  				case 0x19e: map_key_clear(KEY_COFFEE);		break;
> +				case 0x1a2: map_key_clear(KEY_TASKSELECT);	break;
>  				case 0x1a6: map_key_clear(KEY_HELP);		break;
>  				case 0x1a7: map_key_clear(KEY_DOCUMENTS);	break;
>  				case 0x1ab: map_key_clear(KEY_SPELLCHECK);	break;
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 1bdc39a..cc322a5 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -536,6 +536,9 @@ struct input_absinfo {
>  #define KEY_FRAMEFORWARD	0x1b5
>  
>  #define KEY_CONTEXT_MENU	0x1b6	/* GenDesc - system context menu */
> +#define KEY_TASKSELECT		0x1b7	/* Consumer - AL select task */
> +#define KEY_LOGON_LOGOFF	0x1b8	/* Consumer - AL Logon/Logoff */
> +#define KEY_LOGON		0x1b9	/* Consumer - AL Logon */
>  
>  #define KEY_DEL_EOL		0x1c0
>  #define KEY_DEL_EOS		0x1c1
> 




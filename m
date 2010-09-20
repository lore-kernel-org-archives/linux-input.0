From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 2/3] hid: 3m: Convert to MT slots
Date: Mon, 20 Sep 2010 21:43:37 +0200
Message-ID: <FF722ED6-6568-47D0-82D1-99B9E9D5AEAF@enac.fr>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se> <1283005748-3293-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283005748-3293-2-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Le 28 ao=FBt 10 =E0 16:29, Henrik Rydberg a =E9crit :

> The Microtouch controller is capable of doing finger tracking on
> up to 60 fingers. To reduce bandwidth and cpu usage, convert the
> driver to use the MT slots protocol.

As I understand it, this patch actually has three roles:
  1. improving the evdev parameters of the device
  2. cleaning the protocol to get rid of useless MISC/SCANCODE messages
  3. convert the protocol to MT slots


> +#define SN_MOVE			2048
> +#define SN_WIDTH		128
>

In the long run, it might be useful to comment these signal/noise =20
constants



>  			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
> +			input_set_capability(hi->input, EV_KEY, BTN_TOUCH);

>  {
> +	/* tell hid-input to skip setup of these event types */
>  	if (usage->type =3D=3D EV_KEY || usage->type =3D=3D EV_ABS)
> -		clear_bit(usage->code, *bit);
> -
> -	return 0;
> +		set_bit(usage->type, hi->input->evbit);
> +	return -1;
>  }
>

I understand this as a trick to get rid of MISC/SCANCODEs that are =20
added for every EV_KEY message, consequence of a rule in hid-input.c. =20
Wouldn't it be simpler to improve the rule than to work around it?

Cheers,

St.

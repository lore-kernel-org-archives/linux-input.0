From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Reset ps/2 port  should psmouse_probe fail before
	retrying
Date: Sun, 02 May 2010 09:41:25 +0200
Message-ID: <1272786085.3621.1.camel@lovely>
References: <1271723857.6652.6.camel@lovely>
	 <20100422215517.GB28213@core.coreip.homeip.net>
	 <1271983668.16254.44.camel@lovely>
	 <201004230953.52447.dmitry.torokhov@gmail.com>
	 <4BD1EB1C.1070200@canonical.com>
	 <20100428170721.GA6608@core.coreip.homeip.net>
	 <4BD897D4.4060405@canonical.com> <1272560268.3987.12.camel@lovely>
	 <4BDB5BA0.1080104@canonical.com>  <1272769662.3315.36.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:65328 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab0EBHfe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 May 2010 03:35:34 -0400
Received: by bwz19 with SMTP id 19so787198bwz.21
        for <linux-input@vger.kernel.org>; Sun, 02 May 2010 00:35:33 -0700 (PDT)
In-Reply-To: <1272769662.3315.36.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, rubini <rubini@cvml.unipv.it>, Christopher Heiny <cheiny@synaptics.com>

On Sun, 2010-05-02 at 05:07 +0200, Christoph Fritz wrote:
> Am Freitag, den 30.04.2010, 18:37 -0400 schrieb Peter M. Petrakis:
> > Christoph,
> > 
> > The setres cmds don't seem to be working. We end up falling
> > back to the generic driver again and failing in psmouse_probe.
> > Logs attached with some instrumentation and i8042.debug enabled.
> 
> As Dmitry already told, this "E8 02 E8 02 E8 02 E8 02 E9" is nonsene. I
> missed part 4.4 in the docu. There was no need to test, sorry to not
> making this more clear.
> 
> At the moment there are two open questions:
> 
>  1. Why does the device report itself as 0x73

0x00, shouldn't write emails that late...

>  when we expect 0x47 to
> special query 0x02? Christopher from Synaptics has been already asked.
>   By the way, this 0x73

0x00

>  is the cause why your device falls back to ps2
> driver. It's the root of your suspend problem: synaptics driver does,
> psmouse-base does no reset in reconnect().
> 
>  2. Should we do a reset in psmouse-base too? If yes, only for these
> "fall-back-synaptic-touchpads" or should all generic ps2 devices get a
> reset?
> 
> Here I missused the model entry, but it's not that fine:
> 
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index d8c0c8d..5e726df 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -597,7 +597,6 @@ static int cortron_detect(struct psmouse *psmouse, bool set_properties)
>  static int psmouse_extensions(struct psmouse *psmouse,
>  			      unsigned int max_proto, bool set_properties)
>  {
> -	bool synaptics_hardware = false;
>  
>  /*
>   * We always check for lifebook because it does not disturb mouse
> @@ -621,10 +620,10 @@ static int psmouse_extensions(struct psmouse *psmouse,
>  /*
>   * Try Synaptics TouchPad. Note that probing is done even if Synaptics protocol
>   * support is disabled in config - we need to know if it is synaptics so we
> - * can reset it properly after probing for intellimouse.
> + * can reset it properly at reconnect and after probing for intellimouse.
>   */
>  	if (max_proto > PSMOUSE_PS2 && synaptics_detect(psmouse, set_properties) == 0) {
> -		synaptics_hardware = true;
> +		psmouse->model = PSMOUSE_MODEL_NEEDRESET;
>  
>  		if (max_proto > PSMOUSE_IMEX) {
>  /*
> @@ -740,7 +739,7 @@ static int psmouse_extensions(struct psmouse *psmouse,
>   */
>  	ps2bare_detect(psmouse, set_properties);
>  
> -	if (synaptics_hardware) {
> +	if (psmouse->model == PSMOUSE_MODEL_NEEDRESET) {
>  /*
>   * We detected Synaptics hardware but it did not respond to IMPS/2 probes.
>   * We need to reset the touchpad because if there is a track point on the
> @@ -1401,10 +1400,14 @@ static int psmouse_reconnect(struct serio *serio)
>  	if (psmouse->reconnect) {
>  		if (psmouse->reconnect(psmouse))
>  			goto out;
> -	} else if (psmouse_probe(psmouse) < 0 ||
> +	} else {
> +		if (psmouse->model == PSMOUSE_MODEL_NEEDRESET)
> +			psmouse_reset(psmouse);
> +		if (psmouse_probe(psmouse) < 0 ||
>  		   psmouse->type != psmouse_extensions(psmouse,
>  						psmouse_max_proto, false)) {
> -		goto out;
> +			goto out;
> +		}
>  	}
>  
>  	/* ok, the device type (and capabilities) match the old one,
> diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
> index e053bdd..c45b5ef 100644
> --- a/drivers/input/mouse/psmouse.h
> +++ b/drivers/input/mouse/psmouse.h
> @@ -20,6 +20,9 @@
>  #define PSMOUSE_RET_ACK		0xfa
>  #define PSMOUSE_RET_NAK		0xfe
>  
> +#define PSMOUSE_MODEL_UNKNOWN		0x00
> +#define PSMOUSE_MODEL_NEEDRESET	0x01
> +
>  enum psmouse_state {
>  	PSMOUSE_IGNORE,
>  	PSMOUSE_INITIALIZING,
> 
> 


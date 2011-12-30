From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [PATCH] only assign psmouse handlers on successful return from
 fsp_init()
Date: Fri, 30 Dec 2011 18:36:21 +0800 (CST)
Message-ID: <111230183353F.21736@cnaqrzbavhz.fragryvp.pbz>
References: <2424.1325103106@foxharp.boston.ma.us> <111229093848B.21736@cnaqrzbavhz.fragryvp.pbz>
 <20111230082344.GE17850@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:40319 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab1L3Knr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Dec 2011 05:43:47 -0500
In-Reply-To: <20111230082344.GE17850@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Fox <pgf@laptop.org>, linux-input@vger.kernel.org

On Fri, 30 Dec 2011, Dmitry Torokhov wrote:

> On Thu, Dec 29, 2011 at 09:40:30AM +0800, Tai-hwa Liang wrote:
> > On Wed, 28 Dec 2011, Paul Fox wrote:
> > >the psmouse action routines were being initialized before all
> > >possible error conditions had been considered.  a subsequent
> > >failure would leave these handlers set, and later touchpad
> > >traffic or psmouse driver actions could cause them to be called,
> > >even though fsp_init() had failed.
> > >
> > >Signed-off-by: Paul Fox <pgf@laptop.org>
> > 
> > Acked-by: Tai-hwa Liang <avatar@sentelic.com>
> 
> Hmm, I think we should do more as we might leave stale methods not only
> due to initialization failure but also due to protocol switch that may
> happen for one reason or another.
> 
> How does the patch below look to you?

   Looks good to me.  Thank you.

Acked-by: Tai-hwa Liang <avatar@sentelic.com>

> -- 
> Dmitry
> 
> Input: psmouse - make sure we do not use stale methods
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Several protocol initialization routines can fail after they set up
> psmouse methods, such as reconnect and disconnect. This may lead to
> these stale methods used with different protocol that they were
> intended to be used for and may cause unpredictavle behavior and/or
> crashes.
> 
> Make sure we start with a clean slate before executing each and every
> protocol detection and/or initialization routine.
> 
> Reported-by: Paul Fox <pgf@laptop.org>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
>  drivers/input/mouse/psmouse-base.c |  193 +++++++++++++++++++++++-------------
>  1 files changed, 124 insertions(+), 69 deletions(-)
> 
> 
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index 200be9c..de7e8bc 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -418,6 +418,49 @@ int psmouse_reset(struct psmouse *psmouse)
>  	return 0;
>  }
> 
> +/*
> + * Here we set the mouse resolution.
> + */
> +
> +void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution)
> +{
> +	static const unsigned char params[] = { 0, 1, 2, 2, 3 };
> +	unsigned char p;
> +
> +	if (resolution == 0 || resolution > 200)
> +		resolution = 200;
> +
> +	p = params[resolution / 50];
> +	ps2_command(&psmouse->ps2dev, &p, PSMOUSE_CMD_SETRES);
> +	psmouse->resolution = 25 << p;
> +}
> +
> +/*
> + * Here we set the mouse report rate.
> + */
> +
> +static void psmouse_set_rate(struct psmouse *psmouse, unsigned int rate)
> +{
> +	static const unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
> +	unsigned char r;
> +	int i = 0;
> +
> +	while (rates[i] > rate) i++;
> +	r = rates[i];
> +	ps2_command(&psmouse->ps2dev, &r, PSMOUSE_CMD_SETRATE);
> +	psmouse->rate = r;
> +}
> +
> +/*
> + * psmouse_poll() - default poll handler. Everyone except for ALPS uses it.
> + */
> +
> +static int psmouse_poll(struct psmouse *psmouse)
> +{
> +	return ps2_command(&psmouse->ps2dev, psmouse->packet,
> +			   PSMOUSE_CMD_POLL | (psmouse->pktsize << 8));
> +}
> +
>
>  /*
>   * Genius NetMouse magic init.
> @@ -603,6 +646,56 @@ static int cortron_detect(struct psmouse *psmouse, bool set_properties)
>  }
>
>  /*
> + * Apply default settings to the psmouse structure. Most of them will
> + * be overridden by individual protocol initialization routines.
> + */
> +
> +static void psmouse_apply_defaults(struct psmouse *psmouse)
> +{
> +	struct input_dev *input_dev = psmouse->dev;
> +
> +	memset(input_dev->evbit, 0, sizeof(input_dev->evbit));
> +	memset(input_dev->keybit, 0, sizeof(input_dev->keybit));
> +	memset(input_dev->relbit, 0, sizeof(input_dev->relbit));
> +	memset(input_dev->absbit, 0, sizeof(input_dev->absbit));
> +	memset(input_dev->mscbit, 0, sizeof(input_dev->mscbit));
> +
> +	__set_bit(EV_KEY, input_dev->evbit);
> +	__set_bit(EV_REL, input_dev->evbit);
> +
> +	__set_bit(BTN_LEFT, input_dev->keybit);
> +	__set_bit(BTN_RIGHT, input_dev->keybit);
> +
> +	__set_bit(REL_X, input_dev->relbit);
> +	__set_bit(REL_Y, input_dev->relbit);
> +
> +	psmouse->set_rate = psmouse_set_rate;
> +	psmouse->set_resolution = psmouse_set_resolution;
> +	psmouse->poll = psmouse_poll;
> +	psmouse->protocol_handler = psmouse_process_byte;
> +	psmouse->pktsize = 3;
> +	psmouse->reconnect = NULL;
> +	psmouse->disconnect = NULL;
> +	psmouse->cleanup = NULL;
> +	psmouse->pt_activate = NULL;
> +	psmouse->pt_deactivate = NULL;
> +}
> +
> +/*
> + * Apply default settings to the psmouse structure and call specified
> + * protocol detection or initialization routine.
> + */
> +static int psmouse_do_detect(int (*detect)(struct psmouse *psmouse,
> +					   bool set_properties),
> +			     struct psmouse *psmouse, bool set_properties)
> +{
> +	if (set_properties)
> +		psmouse_apply_defaults(psmouse);
> +
> +	return detect(psmouse, set_properties);
> +}
> +
> +/*
>   * psmouse_extensions() probes for any extensions to the basic PS/2 protocol
>   * the mouse may have.
>   */
> @@ -616,7 +709,7 @@ static int psmouse_extensions(struct psmouse *psmouse,
>   * We always check for lifebook because it does not disturb mouse
>   * (it only checks DMI information).
>   */
> -	if (lifebook_detect(psmouse, set_properties) == 0) {
> +	if (psmouse_do_detect(lifebook_detect, psmouse, set_properties) == 0) {
>  		if (max_proto > PSMOUSE_IMEX) {
>  			if (!set_properties || lifebook_init(psmouse) == 0)
>  				return PSMOUSE_LIFEBOOK;
> @@ -628,15 +721,18 @@ static int psmouse_extensions(struct psmouse *psmouse,
>   * upsets the thinkingmouse).
>   */
> 
> -	if (max_proto > PSMOUSE_IMEX && thinking_detect(psmouse, set_properties) == 0)
> +	if (max_proto > PSMOUSE_IMEX &&
> +	    psmouse_do_detect(thinking_detect, psmouse, set_properties) == 0) {
>  		return PSMOUSE_THINKPS;
> +	}
>
>  /*
>   * Try Synaptics TouchPad. Note that probing is done even if Synaptics protocol
>   * support is disabled in config - we need to know if it is synaptics so we
>   * can reset it properly after probing for intellimouse.
>   */
> -	if (max_proto > PSMOUSE_PS2 && synaptics_detect(psmouse, set_properties) == 0) {
> +	if (max_proto > PSMOUSE_PS2 &&
> +	    psmouse_do_detect(synaptics_detect, psmouse, set_properties) == 0) {
>  		synaptics_hardware = true;
>
>  		if (max_proto > PSMOUSE_IMEX) {
> @@ -667,7 +763,8 @@ static int psmouse_extensions(struct psmouse *psmouse,
>   */
>  	if (max_proto > PSMOUSE_IMEX) {
>  		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
> -		if (alps_detect(psmouse, set_properties) == 0) {
> +		if (psmouse_do_detect(alps_detect,
> +				      psmouse, set_properties) == 0) {
>  			if (!set_properties || alps_init(psmouse) == 0)
>  				return PSMOUSE_ALPS;
>  /*
> @@ -681,7 +778,7 @@ static int psmouse_extensions(struct psmouse *psmouse,
>   * Try OLPC HGPK touchpad.
>   */
>  	if (max_proto > PSMOUSE_IMEX &&
> -			hgpk_detect(psmouse, set_properties) == 0) {
> +	    psmouse_do_detect(hgpk_detect, psmouse, set_properties) == 0) {
>  		if (!set_properties || hgpk_init(psmouse) == 0)
>  			return PSMOUSE_HGPK;
>  /*
> @@ -694,7 +791,7 @@ static int psmouse_extensions(struct psmouse *psmouse,
>   * Try Elantech touchpad.
>   */
>  	if (max_proto > PSMOUSE_IMEX &&
> -			elantech_detect(psmouse, set_properties) == 0) {
> +	    psmouse_do_detect(elantech_detect, psmouse, set_properties) == 0) {
>  		if (!set_properties || elantech_init(psmouse) == 0)
>  			return PSMOUSE_ELANTECH;
>  /*
> @@ -703,18 +800,21 @@ static int psmouse_extensions(struct psmouse *psmouse,
>  		max_proto = PSMOUSE_IMEX;
>  	}
> 
> -
>  	if (max_proto > PSMOUSE_IMEX) {
> -		if (genius_detect(psmouse, set_properties) == 0)
> +		if (psmouse_do_detect(genius_detect,
> +				      psmouse, set_properties) == 0)
>  			return PSMOUSE_GENPS;
> 
> -		if (ps2pp_init(psmouse, set_properties) == 0)
> +		if (psmouse_do_detect(ps2pp_init,
> +				      psmouse, set_properties) == 0)
>  			return PSMOUSE_PS2PP;
> 
> -		if (trackpoint_detect(psmouse, set_properties) == 0)
> +		if (psmouse_do_detect(trackpoint_detect,
> +				      psmouse, set_properties) == 0)
>  			return PSMOUSE_TRACKPOINT;
> 
> -		if (touchkit_ps2_detect(psmouse, set_properties) == 0)
> +		if (psmouse_do_detect(touchkit_ps2_detect,
> +				      psmouse, set_properties) == 0)
>  			return PSMOUSE_TOUCHKIT_PS2;
>  	}
> 
> @@ -723,7 +823,8 @@ static int psmouse_extensions(struct psmouse *psmouse,
>   * Trackpoint devices (causing TP_READ_ID command to time out).
>   */
>  	if (max_proto > PSMOUSE_IMEX) {
> -		if (fsp_detect(psmouse, set_properties) == 0) {
> +		if (psmouse_do_detect(fsp_detect,
> +				      psmouse, set_properties) == 0) {
>  			if (!set_properties || fsp_init(psmouse) == 0)
>  				return PSMOUSE_FSP;
>  /*
> @@ -741,17 +842,23 @@ static int psmouse_extensions(struct psmouse *psmouse,
>  	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
>  	psmouse_reset(psmouse);
> 
> -	if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse, set_properties) == 0)
> +	if (max_proto >= PSMOUSE_IMEX &&
> +	    psmouse_do_detect(im_explorer_detect,
> +			      psmouse, set_properties) == 0) {
>  		return PSMOUSE_IMEX;
> +	}
> 
> -	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse, set_properties) == 0)
> +	if (max_proto >= PSMOUSE_IMPS &&
> +	    psmouse_do_detect(intellimouse_detect,
> +			      psmouse, set_properties) == 0) {
>  		return PSMOUSE_IMPS;
> +	}
>
>  /*
>   * Okay, all failed, we have a standard mouse here. The number of the buttons
>   * is still a question, though. We assume 3.
>   */
> -	ps2bare_detect(psmouse, set_properties);
> +	psmouse_do_detect(ps2bare_detect, psmouse, set_properties);
>
>  	if (synaptics_hardware) {
>  /*
> @@ -965,39 +1072,6 @@ static int psmouse_probe(struct psmouse *psmouse)
>  }
>
>  /*
> - * Here we set the mouse resolution.
> - */
> -
> -void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution)
> -{
> -	static const unsigned char params[] = { 0, 1, 2, 2, 3 };
> -	unsigned char p;
> -
> -	if (resolution == 0 || resolution > 200)
> -		resolution = 200;
> -
> -	p = params[resolution / 50];
> -	ps2_command(&psmouse->ps2dev, &p, PSMOUSE_CMD_SETRES);
> -	psmouse->resolution = 25 << p;
> -}
> -
> -/*
> - * Here we set the mouse report rate.
> - */
> -
> -static void psmouse_set_rate(struct psmouse *psmouse, unsigned int rate)
> -{
> -	static const unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
> -	unsigned char r;
> -	int i = 0;
> -
> -	while (rates[i] > rate) i++;
> -	r = rates[i];
> -	ps2_command(&psmouse->ps2dev, &r, PSMOUSE_CMD_SETRATE);
> -	psmouse->rate = r;
> -}
> -
> -/*
>   * psmouse_initialize() initializes the mouse to a sane state.
>   */
> 
> @@ -1042,16 +1116,6 @@ static void psmouse_deactivate(struct psmouse *psmouse)
>  	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
>  }
> 
> -/*
> - * psmouse_poll() - default poll handler. Everyone except for ALPS uses it.
> - */
> -
> -static int psmouse_poll(struct psmouse *psmouse)
> -{
> -	return ps2_command(&psmouse->ps2dev, psmouse->packet,
> -			   PSMOUSE_CMD_POLL | (psmouse->pktsize << 8));
> -}
> -
>
>  /*
>   * psmouse_resync() attempts to re-validate current protocol.
> @@ -1252,18 +1316,9 @@ static int psmouse_switch_protocol(struct psmouse *psmouse,
>
>  	input_dev->dev.parent = &psmouse->ps2dev.serio->dev;
> 
> -	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
> -	input_dev->keybit[BIT_WORD(BTN_MOUSE)] =
> -				BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_RIGHT);
> -	input_dev->relbit[0] = BIT_MASK(REL_X) | BIT_MASK(REL_Y);
> -
> -	psmouse->set_rate = psmouse_set_rate;
> -	psmouse->set_resolution = psmouse_set_resolution;
> -	psmouse->poll = psmouse_poll;
> -	psmouse->protocol_handler = psmouse_process_byte;
> -	psmouse->pktsize = 3;
> -
>  	if (proto && (proto->detect || proto->init)) {
> +		psmouse_apply_defaults(psmouse);
> +
>  		if (proto->detect && proto->detect(psmouse, true) < 0)
>  			return -1;

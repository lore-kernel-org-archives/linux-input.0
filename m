From: Vojtech Pavlik <vojtech@ucw.cz>
Subject: Re: [PATCH] Input: joystick: analog - change msleep to usleep_range
 for small msecs
Date: Tue, 29 Nov 2016 07:51:25 +0100
Message-ID: <20161129065125.GC10549@suse.com>
References: <1480362091-4768-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jablonecka.jablonka.cz ([91.219.244.36]:32997 "EHLO
        jablonecka.jablonka.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755641AbcK2Gv0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 01:51:26 -0500
Content-Disposition: inline
In-Reply-To: <1480362091-4768-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, s.samuel@samsung.com, r.mahale@samsung.com, aniroop.mathur@gmail.com

On Tue, Nov 29, 2016 at 01:11:31AM +0530, Aniroop Mathur wrote:

> msleep(1~20) may not do what the caller intends, and will often sleep longer.
> (~20 ms actual sleep for any value given in the 1~20ms range)
> This is not the desired behaviour for many cases like device resume time,
> device suspend time, device enable time, connection time, probe time,
> loops, retry logic, etc
> msleep is built on jiffies / legacy timers which are not precise whereas
> usleep_range is build on top of hrtimers so the wakeups are precise.
> Thus, change msleep to usleep_range for precise wakeups.
> 
> For example:
> On a machine with tick rate / HZ as 100, msleep(3) will make the process to
> sleep for a minimum period of 10 ms whereas usleep_range(3000, 3100) will make
> sure that the process does not sleep for more than 3100 us or 3.1ms

Again, not needed, if the MAX_TIME sleeps are longer, nobody cares.

> 
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/joystick/analog.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
> index 3d8ff09..2891704 100644
> --- a/drivers/input/joystick/analog.c
> +++ b/drivers/input/joystick/analog.c
> @@ -88,7 +88,7 @@ MODULE_PARM_DESC(map, "Describes analog joysticks type/capabilities");
>  #define ANALOG_EXTENSIONS	0x7ff00
>  #define ANALOG_GAMEPAD		0x80000
>  
> -#define ANALOG_MAX_TIME		3	/* 3 ms */
> +#define ANALOG_MAX_TIME		3000	/* 3000 us */
>  #define ANALOG_LOOP_TIME	2000	/* 2 * loop */
>  #define ANALOG_SAITEK_DELAY	200	/* 200 us */
>  #define ANALOG_SAITEK_TIME	2000	/* 2000 us */
> @@ -257,7 +257,7 @@ static int analog_cooked_read(struct analog_port *port)
>  	int i, j;
>  
>  	loopout = (ANALOG_LOOP_TIME * port->loop) / 1000;
> -	timeout = ANALOG_MAX_TIME * port->speed;
> +	timeout = (ANALOG_MAX_TIME / 1000) * port->speed;
>  
>  	local_irq_save(flags);
>  	gameport_trigger(gameport);
> @@ -625,20 +625,20 @@ static int analog_init_port(struct gameport *gameport, struct gameport_driver *d
>  
>  		gameport_trigger(gameport);
>  		t = gameport_read(gameport);
> -		msleep(ANALOG_MAX_TIME);
> +		usleep_range(ANALOG_MAX_TIME, ANALOG_MAX_TIME + 100);
>  		port->mask = (gameport_read(gameport) ^ t) & t & 0xf;
>  		port->fuzz = (port->speed * ANALOG_FUZZ_MAGIC) / port->loop / 1000 + ANALOG_FUZZ_BITS;
>  
>  		for (i = 0; i < ANALOG_INIT_RETRIES; i++) {
>  			if (!analog_cooked_read(port))
>  				break;
> -			msleep(ANALOG_MAX_TIME);
> +			usleep_range(ANALOG_MAX_TIME, ANALOG_MAX_TIME + 100);
>  		}
>  
>  		u = v = 0;
>  
> -		msleep(ANALOG_MAX_TIME);
> -		t = gameport_time(gameport, ANALOG_MAX_TIME * 1000);
> +		usleep_range(ANALOG_MAX_TIME, ANALOG_MAX_TIME + 100);
> +		t = gameport_time(gameport, ANALOG_MAX_TIME);
>  		gameport_trigger(gameport);
>  		while ((gameport_read(port->gameport) & port->mask) && (u < t))
>  			u++;
> -- 
> 2.6.2
> 

-- 
Vojtech Pavlik

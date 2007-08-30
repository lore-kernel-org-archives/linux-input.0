From: Satyam Sharma <satyam@infradead.org>
Subject: Re: [PATCH] input: Silence 'unused variable' warning in iforce
 joystick driver
Date: Fri, 31 Aug 2007 04:27:13 +0530 (IST)
Message-ID: <alpine.LFD.0.999.0708310422200.31519@enigma.security.iitk.ac.in>
References: <200708310013.12347.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200708310013.12347.jesper.juhl@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com>, dtor@mail.ru, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,


On Fri, 31 Aug 2007, Jesper Juhl wrote:

> In the iforce driver we currently get this warning
> 
>  drivers/input/joystick/iforce/iforce-packets.c: In function 'iforce_get_id_packet':
>  drivers/input/joystick/iforce/iforce-packets.c:249: warning: unused variable 'status'
> 
> if CONFIG_JOYSTICK_IFORCE_USB is not defined.
> 
> The warning is easy to avoid by simply moving the variable inside 
> the only case in the switch that actually use it.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
> diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
> index 3154ccd..48d4a86 100644
> --- a/drivers/input/joystick/iforce/iforce-packets.c
> +++ b/drivers/input/joystick/iforce/iforce-packets.c
> @@ -246,13 +246,12 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
>  
>  int iforce_get_id_packet(struct iforce *iforce, char *packet)
>  {
> -	int status;
> -
>  	switch (iforce->bus) {
>  
>  	case IFORCE_USB:
> -
>  #ifdef CONFIG_JOYSTICK_IFORCE_USB
> +		int status;
> +
>  		iforce->cr.bRequest = packet[0];
>  		iforce->ctrl->dev = iforce->usbdev;

Hmm, would this not still give a warning when JOYSTICK_IFORCE_USB=y?
[ I didn't know mixing code and declarations (not at top of statement
  block) was accepted style in the kernel ... ]

IMHO either you should at least wrap that case inside a {} of its
own (so that the int status; is at top of a statement block), or else,
preferably, just add "__maybe_unused" to the first declaration that you
removed just now.


Satyam

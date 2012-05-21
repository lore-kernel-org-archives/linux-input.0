From: Nicola Alessi <nialessi@gmx.com>
Subject: Re: Elantech touchpad detected as Logitech PS2 Wheel Mouse
Date: Mon, 21 May 2012 15:45:40 +0200
Message-ID: <4FBA4704.5070803@gmx.com>
References: <4FB939B5.4000309@gmx.com> <20120520192052.GA3959@burratino> <4FB951A0.6020102@gmx.com> <20120521051825.GB3840@burratino> <877gw655mi.fsf@emc.com.tw> <20120521082809.GA5304@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-eu.gmx.com ([213.165.64.42]:45372 "HELO
	mailout-eu.gmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755863Ab2EUNpo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 May 2012 09:45:44 -0400
In-Reply-To: <20120521082809.GA5304@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org

Hi,

I'd like to thank you all for the time you dedicated to this problem.
I'll try to experiment with the patch and I'll report if something
interesting happens.

@Jonathan: there are two things that make me think to have a elantech
touchpad. First, a sticker from the manufacturer below laptop's battery
pack (in the slot, you can see it only if you remove the battery)
labeled "ELANTEK". Second, I think more important, I've played around
(about two months ago) with dkms and patches to psmouse. More in detail,
I tried the patch from Seth Forshee (see
https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-video-intel/+bug/681904/comments/111).
Through it didn't fix the issue (the touchpad was totally unusable due
to continuous "sync lost" messages) the touchpad was recognized as an
elantech (I don't remember the details, but I could try to build the
module again and mail some info).

Thanks again,

Nicola

Il 21/05/12 10:28, Jonathan Nieder ha scritto:
> JJ Ding wrote:
> 
>> We used to have a "force_elantech" module param to force the TP to be
>> detected as Elan, but I removed it when I was updating elantech.c to
>> support newer models. Maybe you can convince Dmitry to add it back, but
>> still, this kind of Elan touchpads is not supported as multi-touch
>> pointing device, so I wouldn't recommand it.
> 
> Neat.
> 
>> I hope this helps.
> 
> Definitely; thanks for explaining.  Nicola, I'm still curious about
> the following:
> 
>>> E.g., is there another OS with a driver that detects it as Elantech?
> 
> If another OS offers more functionality, then we would know the
> hardware is capable of it.
> 
> The patch JJ described follows, in case you want to experiment.
> 
> -- >8 --
> Subject: Input: elantech - allow forcing Elantech protocol when knock fails
> 
> This does not quite revert 4af61e90270e35bafa9e99a3c48fb3f363da592d
> ("Input: elantech - remove module parameter force_elantech") --- the
> old force_elantech parameter was about ignoring an unrecognized
> response to ETP_FW_VERSION_QUERY, while this one is about ignoring
> unrecognized responses to the magic knock.
> 
> This patch is just for experimentation and is not meant for inclusion.
> ---
>  drivers/input/mouse/elantech.c |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index d2c0db159b18..55ac1aa5e943 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -27,6 +27,10 @@
>  					fmt, ##__VA_ARGS__);		\
>  	} while (0)
>  
> +static bool force_elantech;
> +module_param_named(force_elantech, force_elantech, bool, 0644);
> +MODULE_PARM_DESC(force_elantech, "Force the Elantech PS/2 protocol extension to be used, 1 = enabled, 0 = disabled (default).");
> +
>  /*
>   * Send a Synaptics style sliced query command
>   */
> @@ -1195,10 +1199,14 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
>  	 */
>  	if (param[0] != 0x3c || param[1] != 0x03 ||
>  	    (param[2] != 0xc8 && param[2] != 0x00)) {
> -		psmouse_dbg(psmouse,
> -			    "unexpected magic knock result 0x%02x, 0x%02x, 0x%02x.\n",
> -			    param[0], param[1], param[2]);
> -		return -1;
> +		if (!force_elantech) {
> +			psmouse_dbg(psmouse,
> +				    "unexpected magic knock result 0x%02x, 0x%02x, 0x%02x.\n",
> +				    param[0], param[1], param[2]);
> +			return -1;
> +		}
> +		psmouse_warning(psmouse, "Unexpected magic knock result.\n");
> +		psmouse_info(psmouse, "Enabling anyway due to force_elantech.\n");
>  	}
>  
>  	/*


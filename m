From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 1/3] sound: ac97: Add GPIO manipulation hooks
Date: Tue, 15 Jun 2010 17:02:53 +0100
Message-ID: <20100615160253.GK14510@rakim.wolfsonmicro.main>
References: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
 <1276617347-3522-2-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51858 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752850Ab0FOQCz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jun 2010 12:02:55 -0400
Content-Disposition: inline
In-Reply-To: <1276617347-3522-2-git-send-email-manuel.lauss@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: alsa-devel@vger.kernel.org, linux-input@vger.kernel.org, Takasi Iwai <tiwai@suse.de>

On Tue, Jun 15, 2010 at 05:55:45PM +0200, Manuel Lauss wrote:
> Add callbacks to struct snd_ac97 to set and retrieve ac97 codec
> GPIO status.

> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>

CCing in Takashi since this is generic AC'97 stuff.

> ---
>  include/sound/ac97_codec.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
> index 4940045..db3aee1 100644
> --- a/include/sound/ac97_codec.h
> +++ b/include/sound/ac97_codec.h
> @@ -437,6 +437,8 @@ struct snd_ac97_bus_ops {
>  	unsigned short (*read) (struct snd_ac97 *ac97, unsigned short reg);
>  	void (*wait) (struct snd_ac97 *ac97);
>  	void (*init) (struct snd_ac97 *ac97);
> +	void (*setgpio) (struct snd_ac97 *ac97, unsigned short gpio);
> +	unsigned short (*getgpio) (struct snd_ac97 *ac97);
>  };
>  
>  struct snd_ac97_bus {
> -- 
> 1.7.1
> 

So, I'd kind of expect some sort of interaction with gpiolib somewhere
if we do support GPIOs (I know the WM97xx custom stuff doesn't currently
use GPIOs but...).

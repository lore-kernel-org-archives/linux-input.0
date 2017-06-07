From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics_rmi4 - register F03 port as
 pass-through serio
Date: Wed, 7 Jun 2017 09:02:55 +0200
Message-ID: <20170607070255.GA16591@mail.corp.redhat.com>
References: <20170607065128.GA31686@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170607065128.GA31686@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Damjan Georgievski <gdamjan@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Jun 06 2017 or thereabouts, Dmitry Torokhov wrote:
> The 5th generation Thinkpad X1 Carbons use Synaptics touchpads accessible
> over SMBus/RMI, combined with ALPS or Elantech trackpoint devices instead
> of classic IBM/Lenovo trackpoints. Unfortunately there is no way for ALPS
> driver to detect whether it is dealing with touchpad + trackpoint
> combination or just a trackpoint, so we end up with a "phantom" dualpoint
> ALPS device in addition to real touchpad and trackpoint.
> 
> Given that we do not have any special advanced handling for ALPS or
> Elantech trackpoints (unlike IBM trackpoints that have separate driver and
> a host of options) we are better off keeping the trackpoints in PS/2
> emulation mode. We achieve that by setting serio type to SERIO_PS_PSTHRU,
> which will limit number of protocols psmouse driver will try. In addition
> to getting rid of the "phantom" touchpads, this will also speed up probing
> of F03 pass-through port.
> 
> Reported-by: Damjan Georgievski <gdamjan@gmail.com>
> Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Thanks for the extensive commit message :)

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

(tested on a t450s without problems).

Cheers,
Benjamin

>  drivers/input/rmi4/rmi_f03.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
> index 77dad045a468..ad71a5e768dc 100644
> --- a/drivers/input/rmi4/rmi_f03.c
> +++ b/drivers/input/rmi4/rmi_f03.c
> @@ -146,7 +146,7 @@ static int rmi_f03_register_pt(struct f03_data *f03)
>  	if (!serio)
>  		return -ENOMEM;
>  
> -	serio->id.type = SERIO_8042;
> +	serio->id.type = SERIO_PS_PSTHRU;
>  	serio->write = rmi_f03_pt_write;
>  	serio->port_data = f03;
>  
> -- 
> 2.13.0.506.g27d5fe0cd-goog
> 
> 
> -- 
> Dmitry

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - Fix a typo - synpatics --> synaptics
Date: Fri, 9 Aug 2019 09:45:44 -0700
Message-ID: <20190809164544.GM178933@dtor-ws>
References: <20190809150814.24793-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190809150814.24793-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: benjamin.tissoires@redhat.com, grawity@gmail.com, dev@pp3345.net, lyude@redhat.com, teika@gmx.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 09, 2019 at 05:08:14PM +0200, Christophe JAILLET wrote:
> This should be 'synaptics', not 'synpatics'
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.

> ---
>  drivers/input/mouse/synaptics.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index b6da0c1267e3..bbd799c7b058 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -191,7 +191,7 @@ static const char * const forcepad_pnp_ids[] = {
>  };
>  
>  /*
> - * Send a command to the synpatics touchpad by special commands
> + * Send a command to the synaptics touchpad by special commands
>   */
>  static int synaptics_send_cmd(struct psmouse *psmouse, u8 cmd, u8 *param)
>  {
> -- 
> 2.20.1
> 

-- 
Dmitry

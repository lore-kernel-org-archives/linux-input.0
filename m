From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: [PATCH v2] input/mouse/elantech.c: Fix Lenovo version typo
Date: Mon, 3 Oct 2016 20:36:54 -0300
Message-ID: <20161003233654.GA9991@xfiles>
References: <1471913792-5767-1-git-send-email-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471913792-5767-1-git-send-email-marcos.souza.org@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, ulrik.debie-os@e2big.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

ping?

On Mon, Aug 22, 2016 at 09:56:32PM -0300, Marcos Paulo de Souza wrote:
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> Reviewed-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
> 
> ---
> Just forgot to add the SoB in the first version.
> 
>  drivers/input/mouse/elantech.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 08e252a..1b51961 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1134,7 +1134,7 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
>   * System76 Pangolin       0x250f01        ?               2 hw buttons
>   * (*) + 3 trackpoint buttons
>   * (**) + 0 trackpoint buttons
> - * Note: Lenovo L430 and Lenovo L430 have the same fw_version/caps
> + * Note: Lenovo L430 and Lenovo L530 have the same fw_version/caps
>   */
>  static void elantech_set_buttonpad_prop(struct psmouse *psmouse)
>  {
> -- 
> 2.7.4
> 

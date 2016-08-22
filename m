From: ulrik.debie-os@e2big.org
Subject: Re: [PATCH] input/mouse/elantech.c: Fix Lenovo version typo
Date: Mon, 22 Aug 2016 22:48:09 +0200
Message-ID: <20160822204809.GA14500@lantern>
References: <1471862832-4631-1-git-send-email-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:52604 "EHLO e2big.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751640AbcHVV2C (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 Aug 2016 17:28:02 -0400
Content-Disposition: inline
In-Reply-To: <1471862832-4631-1-git-send-email-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Marcos,


You're missing the Signed-off-by: line; see
https://www.kernel.org/doc/Documentation/SubmittingPatches

But besides that, indeed this was a typo by me and your patch results in what it should have been in the first place.

Reviewed-by: Ulrik De Bie <ulrik.debie-os@e2big.org>


Thanks,
Ulrik
On Mon, Aug 22, 2016 at 07:47:12AM -0300, Marcos Paulo de Souza wrote:
> Date:   Mon, 22 Aug 2016 07:47:12 -0300
> From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> To: linux-input@vger.kernel.org
> Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> Subject: [PATCH] input/mouse/elantech.c: Fix Lenovo version typo
> X-Mailer: git-send-email 2.7.4
> X-Mailing-List: linux-input@vger.kernel.org
> 
> ---
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

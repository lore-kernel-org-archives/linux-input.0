From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: [PATCH v2] input/mouse/elantech.c: Fix Lenovo version typo
Date: Sun, 25 Sep 2016 08:21:56 -0300
Message-ID: <20160925112156.GA4990@xfiles>
References: <1471913792-5767-1-git-send-email-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36335 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965943AbcIYLWH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 25 Sep 2016 07:22:07 -0400
Received: by mail-qk0-f196.google.com with SMTP id m184so1996016qkb.3
        for <linux-input@vger.kernel.org>; Sun, 25 Sep 2016 04:22:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1471913792-5767-1-git-send-email-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, ulrik.debie-os@e2big.org

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

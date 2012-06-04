From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/1] input: mt: Fix null pointer warning
Date: Mon, 4 Jun 2012 16:37:22 +0200
Message-ID: <20120604143722.GA30505@polaris.bitmath.org>
References: <1338807528-1171-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:47348 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2FDOgS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jun 2012 10:36:18 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id ED825C03F
	for <linux-input@vger.kernel.org>; Mon,  4 Jun 2012 16:36:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1338807528-1171-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, patches@linaro.org

On Mon, Jun 04, 2012 at 04:28:48PM +0530, Sachin Kamat wrote:
> Fixes the following sparse warning:
> drivers/input/input-mt.c:138:40: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/input/input-mt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
> index f658086..70a16c7 100644
> --- a/drivers/input/input-mt.c
> +++ b/drivers/input/input-mt.c
> @@ -135,7 +135,7 @@ EXPORT_SYMBOL(input_mt_report_finger_count);
>   */
>  void input_mt_report_pointer_emulation(struct input_dev *dev, bool use_count)
>  {
> -	struct input_mt_slot *oldest = 0;
> +	struct input_mt_slot *oldest = NULL;
>  	int oldid = dev->trkid;
>  	int count = 0;
>  	int i;
> -- 
> 1.7.4.1
> 

Applied, thank you.

Henrik

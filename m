From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] lm8333: Fix check ordering
Date: Wed, 27 Jun 2012 17:36:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1206271735570.17549@pobox.suse.cz>
References: <20120627110156.5587.52764.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38630 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564Ab2F0PgM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jun 2012 11:36:12 -0400
In-Reply-To: <20120627110156.5587.52764.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org

On Wed, 27 Jun 2012, Alan Cox wrote:

> From: Alan Cox <alan@linux.intel.com>
> 
> Fix harmless reference off end of array
> 
> Reported-by: <dcb314@hotmail.com>
> Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?43861
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/input/keyboard/lm8333.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
> index ca168a6..081fd9e 100644
> --- a/drivers/input/keyboard/lm8333.c
> +++ b/drivers/input/keyboard/lm8333.c
> @@ -91,7 +91,7 @@ static void lm8333_key_handler(struct lm8333 *lm8333)
>  		return;
>  	}
>  
> -	for (i = 0; keys[i] && i < LM8333_FIFO_TRANSFER_SIZE; i++) {
> +	for (i = 0; i < LM8333_FIFO_TRANSFER_SIZE && keys[i]; i++) {
>  		pressed = keys[i] & 0x80;
>  		code = keys[i] & 0x7f;
>  

Applied to trivial, thanks Alan.

-- 
Jiri Kosina
SUSE Labs

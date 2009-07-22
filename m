From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] trivial: fix typo s/ketymap/keymap/ in comment
Date: Wed, 22 Jul 2009 10:27:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0907221026470.11648@wotan.suse.de>
References: <1248202667-14107-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36094 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540AbZGVI1G (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2009 04:27:06 -0400
In-Reply-To: <1248202667-14107-1-git-send-email-cascardo@holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: giel@caffeinetrip.com, dtor@mail.ru, linux-input@vger.kernel.org

On Tue, 21 Jul 2009, Thadeu Lima de Souza Cascardo wrote:

> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> ---
>  drivers/input/keyboard/atkbd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index 809a7dd..8e8ddf7 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -227,7 +227,7 @@ struct atkbd {
>  };
>  
>  /*
> - * System-specific ketymap fixup routine
> + * System-specific keymap fixup routine
>   */

Applied to trivial queue, thanks.

-- 
Jiri Kosina
SUSE Labs

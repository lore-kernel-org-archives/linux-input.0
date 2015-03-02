From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: cyapa: fix unaligned functions redefinition error
Date: Mon, 2 Mar 2015 09:38:51 -0800
Message-ID: <20150302173851.GC17094@dtor-ws>
References: <1425276278-12298-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:37074 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbbCBRi4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2015 12:38:56 -0500
Content-Disposition: inline
In-Reply-To: <1425276278-12298-1-git-send-email-dudl@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: jmmahler@gmail.com, rydberg@euromail.se, bleung@google.com, kbuild-all@01.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 02, 2015 at 02:04:38PM +0800, Dudley Du wrote:
> Use asm/unaligned.h instead of linux/unaligned/access_ok.h head file to
> fix compiling issues such as following while doing cross platform compiling.
> "include/linux/unaligned/access_ok.h:7:19: error: redefinition of
>  'get_unaligned_le16'
> ...
> include/linux/unaligned/le_struct.h:6:19: note: previous definition of
>  'get_unaligned_le16' was here".
> 
> Reported-by: kbuild test robot <kbuild-all@01.org>
> Signed-off-by: Dudley Du <dudl@cypress.com>

Applied, thank you.

> ---
>  drivers/input/mouse/cyapa_gen3.c | 2 +-
>  drivers/input/mouse/cyapa_gen5.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
> index 77e9d70..1e2291c 100644
> --- a/drivers/input/mouse/cyapa_gen3.c
> +++ b/drivers/input/mouse/cyapa_gen3.c
> @@ -20,7 +20,7 @@
>  #include <linux/input/mt.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> -#include <linux/unaligned/access_ok.h>
> +#include <asm/unaligned.h>
>  #include "cyapa.h"
>  
>  
> diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
> index ddf5393..aa68edd 100644
> --- a/drivers/input/mouse/cyapa_gen5.c
> +++ b/drivers/input/mouse/cyapa_gen5.c
> @@ -17,7 +17,7 @@
>  #include <linux/mutex.h>
>  #include <linux/completion.h>
>  #include <linux/slab.h>
> -#include <linux/unaligned/access_ok.h>
> +#include <asm/unaligned.h>
>  #include <linux/crc-itu-t.h>
>  #include "cyapa.h"
>  
> -- 
> 1.9.1
> 

-- 
Dmitry

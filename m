From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 16/16] HID: wiimote: Enable NO_INIT_REPORTS quirk
Date: Wed, 16 Nov 2011 18:05:54 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111161805250.15187@pobox.suse.cz>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com> <1321190839-3517-17-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39985 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754215Ab1KPRFz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 12:05:55 -0500
In-Reply-To: <1321190839-3517-17-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

On Sun, 13 Nov 2011, David Herrmann wrote:

> Newer bluetooth core supports the NO_INIT_REPORTS quirk. We need this for the
> wiimote as it does not support report-initialization.
> Also bump version level as we are almost feature complete now.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/hid/hid-wiimote-core.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
> index 745667e..7ea8754 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -22,7 +22,7 @@
>  #include "hid-ids.h"
>  #include "hid-wiimote.h"
>  
> -#define WIIMOTE_VERSION "0.2"
> +#define WIIMOTE_VERSION "0.3"

Do we really need this?

I generally prefer not having any file versioning for the files that are 
implicitly tracked by kernel git.

Thanks,

-- 
Jiri Kosina
SUSE Labs

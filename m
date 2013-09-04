From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 14/14] HID: check for NULL field when setting values
Date: Wed, 4 Sep 2013 12:05:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309041205320.3684@pobox.suse.cz>
References: <alpine.LNX.2.00.1308282223090.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48206 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843Ab3IDKFj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 06:05:39 -0400
In-Reply-To: <alpine.LNX.2.00.1308282223090.22181@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>

On Wed, 28 Aug 2013, Jiri Kosina wrote:

> From: Kees Cook <keescook@chromium.org>
> 
> Defensively check that the field to be worked on is not NULL.

Applied.

> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org
> ---
>  drivers/hid/hid-core.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 55798b2..192be6b 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1206,7 +1206,12 @@ EXPORT_SYMBOL_GPL(hid_output_report);
>  
>  int hid_set_field(struct hid_field *field, unsigned offset, __s32 value)
>  {
> -	unsigned size = field->report_size;
> +	unsigned size;
> +
> +	if (!field)
> +		return -1;
> +
> +	size = field->report_size;
>  
>  	hid_dump_input(field->report->device, field->usage + offset, value);
>  
> -- 
> Jiri Kosina
> SUSE Labs
> 

-- 
Jiri Kosina
SUSE Labs

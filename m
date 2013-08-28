From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 13/14] HID: picolcd_core: validate output report details
Date: Wed, 28 Aug 2013 23:00:20 +0200
Message-ID: <20130828230020.6b655bb9@neptune.home>
References: <alpine.LNX.2.00.1308282222460.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:35776 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab3H1VIa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Aug 2013 17:08:30 -0400
In-Reply-To: <alpine.LNX.2.00.1308282222460.22181@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Kees Cook <keescook@chromium.org>

On Wed, 28 August 2013 Jiri Kosina <jkosina@suse.cz> wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> A HID device could send a malicious output report that would cause the
> picolcd HID driver to trigger a NULL dereference during attr file writing.
> 
> CVE-2013-2899
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org
> ---
>  drivers/hid/hid-picolcd_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
> index b48092d..72bba1e 100644
> --- a/drivers/hid/hid-picolcd_core.c
> +++ b/drivers/hid/hid-picolcd_core.c
> @@ -290,7 +290,7 @@ static ssize_t picolcd_operation_mode_store(struct device *dev,
>  		buf += 10;
>  		cnt -= 10;
>  	}
> -	if (!report)
> +	if (!report || report->maxfield < 1)
>  		return -EINVAL;
>  
>  	while (cnt > 0 && (buf[cnt-1] == '\n' || buf[cnt-1] == '\r'))

I will check tomorrow or Friday evening what the documentation I have
says for this report and test, might be a report->maxfield != 1 would
be even better suited.

Too late today for looking into it.

Bruno

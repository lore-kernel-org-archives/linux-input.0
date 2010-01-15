From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid-debug.c: make local symbols static
Date: Fri, 15 Jan 2010 11:36:25 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001151135540.30977@pobox.suse.cz>
References: <201001141910.08225.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44999 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab0AOKg0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2010 05:36:26 -0500
In-Reply-To: <201001141910.08225.hartleys@visionengravers.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Thu, 14 Jan 2010, H Hartley Sweeten wrote:

> hid-debug.c: make local symbols static
> 
> The symbols hid_resolv_event and hid_dump_input_mapping
> are only used locally in this file. Make them static to prevent
> the following sparse warnings:
> 
> warning: symbol 'hid_resolv_event' was not declared. Should it be static?
> warning: symbol 'hid_dump_input_mapping' was not declared. Should it be static?
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> 
> ---
> 
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index 6abd036..cd4ece6 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -864,13 +864,13 @@ static const char **names[EV_MAX + 1] = {
>  	[EV_SND] = sounds,			[EV_REP] = repeats,
>  };
>  
> -void hid_resolv_event(__u8 type, __u16 code, struct seq_file *f) {
> -
> +static void hid_resolv_event(__u8 type, __u16 code, struct seq_file *f)
> +{
>  	seq_printf(f, "%s.%s", events[type] ? events[type] : "?",
>  		names[type] ? (names[type][code] ? names[type][code] : "?") : "?");
>  }
>  
> -void hid_dump_input_mapping(struct hid_device *hid, struct seq_file *f)
> +static void hid_dump_input_mapping(struct hid_device *hid, struct seq_file *f)
>  {
>  	int i, j, k;
>  	struct hid_report *report;

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

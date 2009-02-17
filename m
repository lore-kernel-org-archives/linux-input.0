From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: fix bus handling in scripts/mod/file2alias.c
Date: Tue, 17 Feb 2009 14:04:30 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0902171403090.18110@jikos.suse.cz>
References: <1234870528-24562-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:50373 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbZBQNEd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2009 08:04:33 -0500
In-Reply-To: <1234870528-24562-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, nyet@mrv.com, linux-kernel@vger.kernel.org

On Tue, 17 Feb 2009, jirislaby@gmail.com wrote:

> From: Jiri Slaby <jirislaby@gmail.com>
> 
> Fix endianness of bus member of hid_device_id in modpost.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> Reported-by: Nye Liu <nyet@mrv.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> ---
>  scripts/mod/file2alias.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 82a1011..a334428 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -210,6 +210,7 @@ static void do_usb_table(void *symval, unsigned long size,
>  static int do_hid_entry(const char *filename,
>  			     struct hid_device_id *id, char *alias)
>  {
> +	id->bus = TO_NATIVE(id->bus);
>  	id->vendor = TO_NATIVE(id->vendor);
>  	id->product = TO_NATIVE(id->product);

Good catch, applied, thanks.

-- 
Jiri Kosina
SUSE Labs

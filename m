From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] drivers/hid: Drop NULL test on list_entry result
Date: Tue, 14 Jul 2009 17:18:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0907141717050.813@wotan.suse.de>
References: <Pine.LNX.4.64.0907120942070.17416@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753895AbZGNPSY@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0907120942070.17416@ask.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: linux-input@vger.kernel.org, gregkh@suse.de, jirislaby@gmail.com, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 12 Jul 2009, Julia Lawall wrote:

> diff --git a/drivers/hid/hid-lgff.c b/drivers/hid/hid-lgff.c
> index 95835ea..987abeb 100644
> --- a/drivers/hid/hid-lgff.c
> +++ b/drivers/hid/hid-lgff.c
> @@ -151,11 +151,6 @@ int lgff_init(struct hid_device* hid)
>  
>  	/* Check that the report looks ok */
>  	report = list_entry(report_list->next, struct hid_report, list);
> -	if (!report) {
> -		err_hid("NULL output report");
> -		return -1;
> -	}
> -
>  	field = report->field[0];
>  	if (!field) {
>  		err_hid("NULL field");
> 

Applied, thanks Julia.

-- 
Jiri Kosina
SUSE Labs

From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [patch] HID: uclogic: fix limit in uclogic_tablet_enable()
Date: Wed, 29 Jul 2015 13:27:51 +0300
Message-ID: <55B8AAA7.6010708@gmail.com>
References: <20150729101606.GA12100@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:32925 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbbG2K14 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 06:27:56 -0400
In-Reply-To: <20150729101606.GA12100@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Jiri Kosina <jkosina@suse.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On 07/29/2015 01:16 PM, Dan Carpenter wrote:
> The limit should be ARRAY_SIZE(params) (5 elements) here instead of
> sizeof(params) (20 bytes).
>
> Fixes: 08177f40bd00 ('HID: uclogic: merge hid-huion driver in hid-uclogic')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
> index 9416731..b905d50 100644
> --- a/drivers/hid/hid-uclogic.c
> +++ b/drivers/hid/hid-uclogic.c
> @@ -858,7 +858,7 @@ static int uclogic_tablet_enable(struct hid_device *hdev)
>   	for (p = drvdata->rdesc;
>   	     p <= drvdata->rdesc + drvdata->rsize - 4;) {
>   		if (p[0] == 0xFE && p[1] == 0xED && p[2] == 0x1D &&
> -		    p[3] < sizeof(params)) {
> +		    p[3] < ARRAY_SIZE(params)) {
>   			v = params[p[3]];
>   			put_unaligned(cpu_to_le32(v), (s32 *)p);
>   			p += 4;

Argh, that's embarrassing. Thanks, Dan!

Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>

Nick

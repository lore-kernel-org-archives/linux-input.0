From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] HID: roccat: Fixing race condition on initialization
Date: Sat, 28 Aug 2010 20:18:17 +0200
Message-ID: <4C7952E9.5030608@gmail.com>
References: <1283000268.4789.1.camel@neuromancer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40558 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095Ab0H1SSV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Aug 2010 14:18:21 -0400
In-Reply-To: <1283000268.4789.1.camel@neuromancer>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: erazor_de@users.sourceforge.net
Cc: Jiri Kosina <jkosina@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/28/2010 02:57 PM, Stefan Achatz wrote:
> Fixed raced condition where event occurs before drvdata is set.
> 
> Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
> ---
>  drivers/hid/hid-roccat-kone.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
> index f776957..cfeab56 100644
> --- a/drivers/hid/hid-roccat-kone.c
> +++ b/drivers/hid/hid-roccat-kone.c
> @@ -966,6 +966,10 @@ static int kone_raw_event(struct hid_device *hdev, struct hid_report *report,
>  	struct kone_device *kone = hid_get_drvdata(hdev);
>  	struct kone_mouse_event *event = (struct kone_mouse_event *)data;
>  
> +	/* possible race condition on initialization */
> +	if (!kone)
> +		return 0;

This kind of "protection" caused much headache in the tty layer in the
past. If there is such a problem, please fix the initialization code
instead.

What sort of problems you are seeing?

thanks,
-- 
js

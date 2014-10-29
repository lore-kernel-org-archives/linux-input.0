From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: input: Fix TransducerSerialNumber implementation
Date: Wed, 29 Oct 2014 11:00:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1410291100250.20256@pobox.suse.cz>
References: <Message-ID: <6B3C86448604A642A31AAD3F8C07EA7724F0B8CD@Exchange1.wacom.com> <1411495768-5956-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35904 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932228AbaJ2KAo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Oct 2014 06:00:44 -0400
In-Reply-To: <1411495768-5956-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "pinglinux@gmail.com" <pinglinux@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Tue, 23 Sep 2014, Jason Gerecke wrote:

> The commit which introduced TransducerSerialNumber (368c966) is missing
> two crucial implementation details. Firstly, the commit does not set the
> type/code/bit/max fields as expected later down the code which can cause
> the driver to crash when a tablet with this usage is connected. Secondly,
> the call to 'set_bit' causes MSC_PULSELED to be sent instead of the
> expected MSC_SERIAL. This commit addreses both issues.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
>  drivers/hid/hid-input.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 2619f7f..cb1b3fa 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -689,7 +689,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  			break;
>  
>  		case 0x5b: /* TransducerSerialNumber */
> -			set_bit(MSC_SERIAL, input->mscbit);
> +			usage->type = EV_MSC;
> +			usage->code = MSC_SERIAL;
> +			bit = input->mscbit;
> +			max = MSC_MAX;
>  			break;
>  

Apologizes for the delay. I have now queued this for 3.18 still.

-- 
Jiri Kosina
SUSE Labs

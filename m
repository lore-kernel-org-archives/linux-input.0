From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH resend] bcm5974: Add pointer and buttonpad properties
Date: Tue, 14 Feb 2012 16:19:03 +0100
Message-ID: <20120214151903.GA5616@polaris.bitmath.org>
References: <1329193448-15219-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:56319 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab2BNPQx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Feb 2012 10:16:53 -0500
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id B7A07C50F
	for <linux-input@vger.kernel.org>; Tue, 14 Feb 2012 16:16:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1329193448-15219-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Chase,

On Mon, Feb 13, 2012 at 08:24:08PM -0800, Chase Douglas wrote:
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---
> I sent to the wrong mailing list address the first time. Sorry!
> 
>  drivers/input/mouse/bcm5974.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index 5ec617e..9faa049 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -434,6 +434,9 @@ static void setup_events_to_report(struct input_dev *input_dev,
>  	__set_bit(BTN_LEFT, input_dev->keybit);
>  
>  	input_set_events_per_packet(input_dev, 60);
> +
> +	__set_bit(INPUT_PROP_POINTER, input->propbit);
> +	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
>  }
>  
>  /* report button data as logical button state */
> -- 
> 1.7.9
>

I can take this for 3.4, but the patch needs a commit message. "In
order to move userspace in the direction of simpler and more accurate
device setup, emit device properties..."?

Thanks,
Henrik


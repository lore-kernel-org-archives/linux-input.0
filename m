From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] bcm5974: Add pointer and buttonpad properties
Date: Tue, 14 Feb 2012 19:52:16 +0100
Message-ID: <20120214185216.GA28060@polaris.bitmath.org>
References: <1329233199-7424-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:44715 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756934Ab2BNSuG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Feb 2012 13:50:06 -0500
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 767FECAFF
	for <linux-input@vger.kernel.org>; Tue, 14 Feb 2012 19:50:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1329233199-7424-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmity Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Chase,

On Tue, Feb 14, 2012 at 07:26:39AM -0800, Chase Douglas wrote:
> In order to inform userspace of physical properties of the device.
> 
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---
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

Applied, with fixes. The patch did not apply, and once resolved, did
not compile. I trust you will test also the trivial patches in the future.

Thanks.
Henrik

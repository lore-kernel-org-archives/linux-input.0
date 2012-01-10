From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] Set buttonpad property on those bcm5974 devices that
 have a physical button.
Date: Tue, 10 Jan 2012 11:22:11 +0100
Message-ID: <20120110102211.GA7682@polaris.bitmath.org>
References: <20120110094520.GA7582@polaris.bitmath.org>
 <1326190110-6991-1-git-send-email-jussi.pakkanen@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:35639 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965Ab2AJKWL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jan 2012 05:22:11 -0500
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 67143CE12
	for <linux-input@vger.kernel.org>; Tue, 10 Jan 2012 11:22:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326190110-6991-1-git-send-email-jussi.pakkanen@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Tue, Jan 10, 2012 at 12:08:30PM +0200, Jussi Pakkanen wrote:
> ---
>  drivers/input/mouse/bcm5974.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index 5ec617e..88fabfb 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -434,6 +434,10 @@ static void setup_events_to_report(struct input_dev *input_dev,
>  	__set_bit(BTN_LEFT, input_dev->keybit);
>  
>  	input_set_events_per_packet(input_dev, 60);
> +
> +	if (cfg->caps & HAS_INTEGRATED_BUTTON) {
> +		__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
> +	}
>  }
>  
>  /* report button data as logical button state */
> -- 
> 1.7.5.4
> 

Please move the lines above input_set_events_per_packet(), since that
function may depend on the device properties in the future. Also,
please remove the braces. The subject does not say why the change is
made, and you are also missing the signed-off-by line. Please run
checkpatch before submitting.

Henrik

From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] bcm5974: Set BUTTONPAD property
Date: Tue, 10 Jan 2012 12:42:12 +0100
Message-ID: <20120110114212.GA2142@polaris.bitmath.org>
References: <20120110102211.GA7682@polaris.bitmath.org>
 <1326193009-7361-1-git-send-email-jussi.pakkanen@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:40765 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab2AJLYV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jan 2012 06:24:21 -0500
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id CED78E6B8
	for <linux-input@vger.kernel.org>; Tue, 10 Jan 2012 12:24:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326193009-7361-1-git-send-email-jussi.pakkanen@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Tue, Jan 10, 2012 at 12:56:49PM +0200, Jussi Pakkanen wrote:
> Some bcm5974 trackpads have a physical button beneath the physical surface.
> This patch sets the property bit so user space applications can
> detect the trackpad type and act accordingly.
> 
> Signed-off-by: Jussi Pakkanen <jussi.pakkanen@canonical.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/input/mouse/bcm5974.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index 5ec617e..913e9fa 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -433,6 +433,9 @@ static void setup_events_to_report(struct input_dev *input_dev,
>  	__set_bit(BTN_TOOL_QUADTAP, input_dev->keybit);
>  	__set_bit(BTN_LEFT, input_dev->keybit);
>  
> +	if (cfg->caps & HAS_INTEGRATED_BUTTON)
> +		__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
> +
>  	input_set_events_per_packet(input_dev, 60);
>  }
>  
> -- 
> 1.7.5.4
> 

    Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik

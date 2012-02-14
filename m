From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH resend] bcm5974: Add pointer and buttonpad properties
Date: Tue, 14 Feb 2012 13:07:39 +0800
Message-ID: <4F39EC1B.5070605@cn.fujitsu.com>
References: <1329193448-15219-1-git-send-email-chase.douglas@canonical.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:58158 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750744Ab2BNFIi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Feb 2012 00:08:38 -0500
In-Reply-To: <1329193448-15219-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On 02/14/2012 12:24 PM, Chase Douglas wrote:

> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---
> I sent to the wrong mailing list address the first time. Sorry!


Please add some comments here.
This shouldn't be the change log of this patch.

Thanks
-Wanlong Gao

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



From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] USB: gtco: remove unnecessary variable assignments
Date: Wed, 14 Jun 2017 22:00:48 -0700
Message-ID: <1497502848.14396.2.camel@perches.com>
References: <20170615015029.GA5601@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:33696 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750774AbdFOFAw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Jun 2017 01:00:52 -0400
In-Reply-To: <20170615015029.GA5601@embeddedgus>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2017-06-14 at 20:50 -0500, Gustavo A. R. Silva wrote:
> Remove unnecessary variable assignments.
> Variable _val_ is overwritten before the value stored in it can be used.
> 
> Addresses-Coverity-ID: 1397695
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/input/tablet/gtco.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
> index b796e89..d9de13c 100644
> --- a/drivers/input/tablet/gtco.c
> +++ b/drivers/input/tablet/gtco.c
> @@ -652,8 +652,6 @@ static void gtco_urb_callback(struct urb *urbinfo)
>  		switch (device->buffer[0]) {
>  		case 5:
>  			/* Pressure is 9 bits */
> -			val = ((u16)(device->buffer[8]) << 1);
> -			val |= (u16)(device->buffer[7] >> 7);
>  			input_report_abs(inputdev, ABS_PRESSURE,
>  					 device->buffer[8]);

Perhaps more likely to be

			input_report_abs(inputdev, ABS_PRESSURE, val);


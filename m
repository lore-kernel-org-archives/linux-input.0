From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH v2 8/8] Input: synaptics-rmi4: Use the RMI_F11_REL_BYTES
 define in rmi_f11_rel_pos_report
Date: Tue, 5 Jul 2016 11:01:09 +0100
Message-ID: <c23a4ffe-cab6-712d-0741-24e8de84e178@itdev.co.uk>
References: <1466813992-16085-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zencphosting06.zen.co.uk ([82.71.204.9]:49932 "EHLO
	zencphosting06.zen.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbcGEKBW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2016 06:01:22 -0400
In-Reply-To: <1466813992-16085-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>

On 25/06/2016 01:19, Andrew Duggan wrote:
> The size of relative data in F11 is already defined by RMI_F11_REL_BYTES.
> Use the define in rmi_f11_rel_pos_report() to be consistent.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Reviewed-by: Nick Dyer <nick@shmanahar.org>

> ---
>  drivers/input/rmi4/rmi_f11.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index 3fda75b..cce82a1 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -530,8 +530,8 @@ static void rmi_f11_rel_pos_report(struct f11_data *f11, u8 n_finger)
>  	struct f11_2d_data *data = &f11->data;
>  	s8 x, y;
>  
> -	x = data->rel_pos[n_finger * 2];
> -	y = data->rel_pos[n_finger * 2 + 1];
> +	x = data->rel_pos[n_finger * RMI_F11_REL_BYTES];
> +	y = data->rel_pos[n_finger * RMI_F11_REL_BYTES + 1];
>  
>  	rmi_2d_sensor_rel_report(sensor, x, y);
>  }
> 

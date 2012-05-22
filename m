From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] Input: synaptics - reject out of range position values
Date: Tue, 22 May 2012 15:00:57 -0500
Message-ID: <20120522200057.GC31347@thinkpad-t410>
References: <1337353224-12333-1-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55410 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab2EVUBB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 May 2012 16:01:01 -0400
Content-Disposition: inline
In-Reply-To: <1337353224-12333-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, May 18, 2012 at 10:00:24AM -0500, Seth Forshee wrote:
> The synaptics touchpad on the Acer Aspire One D250 will report y
> coordinate values in excess of 8000 near the bottom of the touchpad,
> well outside of the range of values that the synaptics documentation
> says should be reported.
> 
> In addition, the y values abruptly change from very low values to these
> very high values. After the calculation to invert the y coordinates,
> userspace gets y coordinates that can jump suddenly between large
> positive and moderately large negative values, causing sudden jumps in
> the pointer position.
> 
> To work around this odd behavior, reject any coordinates with values
> outside of absolute limits specified by Synaptics, which is 6143 for
> both axes.
> 
> BugLink: http://bugs.launchpad.net/bugs/1001251
> Cc: stable@vger.kernel.org
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---
> I'm not sure whether the limits here should be the hard-coded value or
> the coordinates reported by the device when that's supported (i.e.
> whether the coordinates reported by the device are always within the
> range of 0 to 6143). If the latter is more appropriate I can modify the
> patch to use the device-reported values and fall back to the hard-coded
> values.

Dmitry,

Is there someone else I should Cc who might know the answer?

Thanks,
Seth

> 
>  drivers/input/mouse/synaptics.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index e07eb9b..f62299d 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -40,6 +40,8 @@
>   * Note that newer firmware allows querying device for maximum useable
>   * coordinates.
>   */
> +#define XMAX 6143
> +#define YMAX 6143
>  #define XMIN_NOMINAL 1472
>  #define XMAX_NOMINAL 5472
>  #define YMIN_NOMINAL 1408
> @@ -555,6 +557,9 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
>  		hw->right = (buf[0] & 0x02) ? 1 : 0;
>  	}
>  
> +	if (hw->x > XMAX || hw->y > YMAX)
> +		return 1;
> +
>  	return 0;
>  }
>  
> -- 
> 1.7.9.5
> 

From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCHv2 7/7] input/cma3000_d0x: Match comment to name of struct
Date: Tue, 18 Oct 2011 14:16:42 +0100
Message-ID: <4E9D7C3A.1020309@cam.ac.uk>
References: <1318939596-27330-1-git-send-email-ricardo.ribalda@gmail.com> <1318939596-27330-8-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:58879 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968Ab1JRNQj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 09:16:39 -0400
In-Reply-To: <1318939596-27330-8-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/18/11 13:06, Ricardo Ribalda Delgado wrote:
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  include/linux/input/cma3000.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/input/cma3000.h b/include/linux/input/cma3000.h
> index cbbaac2..e8c28e8 100644
> --- a/include/linux/input/cma3000.h
> +++ b/include/linux/input/cma3000.h
> @@ -33,7 +33,7 @@
>  #define CMARANGE_8G   8000
>  
>  /**
> - * struct cma3000_i2c_platform_data - CMA3000 Platform data
> + * struct cma3000_platform_data - CMA3000 Platform data
>   * @fuzz_x: Noise on X Axis
>   * @fuzz_y: Noise on Y Axis
>   * @fuzz_z: Noise on Z Axis


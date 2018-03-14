From: Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v5 21/36] drm/bridge: analogix_dp: Fix timeout of video
 streamclk config
Date: Wed, 14 Mar 2018 12:03:35 +0530
Message-ID: <bc8ae3e2-b100-0515-2fa7-e02ba269f559@codeaurora.org>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-22-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309222327.18689-22-enric.balletbo@collabora.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, inki.dae@samsung.com, thierry.reding@gmail.com, hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie, tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org, a.hajda@samsung.com, ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com, rydberg@bitmath.org, krzk@kernel.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com, jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com, hshi@chromium.org
List-Id: linux-input@vger.kernel.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> The STRM_VALID bit in register ANALOGIX_DP_SYS_CTL_3 may be unstable,
> so we may hit the error log "Timeout of video streamclk ok" since
> checked this unstable bit.
> In fact, we can go continue and the streamclk is ok if we wait enough time,
> it does no effect on display.
> Let's change this error to warn.

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 1f1cb624414d..d76e1652b1fd 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -921,8 +921,9 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
>   			done_count = 0;
>   		}
>   		if (timeout_loop > DP_TIMEOUT_LOOP_COUNT) {
> -			dev_err(dp->dev, "Timeout of video streamclk ok\n");
> -			return -ETIMEDOUT;
> +			dev_warn(dp->dev,
> +				 "Ignoring timeout of video streamclk ok\n");
> +			break;
>   		}
>   
>   		usleep_range(1000, 1001);
> 

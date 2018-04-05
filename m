From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v6 08/30] drm/bridge: analogix_dp: Extend hpd check time to 100ms
Date: Thu,  5 Apr 2018 11:49:38 +0200
Message-ID: <20180405095000.9756-9-enric.balletbo@collabora.com>
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180405095000.9756-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com, hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie, tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org, a.hajda@samsung.com, ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com, rydberg@bitmath.org, krzk@kernel.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com, jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com, hshi@chromium.org, =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-input@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

There was a 1ms delay to detect the hpd signal, which is too short to
detect a short pulse. This patch extends this delay to 100ms.

Cc: Stéphane Marchesin <marcheu@chromium.org>
Cc: 征增 王 <wzz@rock-chips.com>
Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 5957e2338071..1f4f34149019 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -76,7 +76,7 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
 			return 0;
 
 		timeout_loop++;
-		usleep_range(10, 11);
+		usleep_range(1000, 1100);
 	}
 
 	/*
-- 
2.16.3

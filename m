From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v5 03/36] drm/bridge: analogix_dp: Don't change psr while
 bridge is disabled
Date: Fri,  9 Mar 2018 23:22:54 +0100
Message-ID: <20180309222327.18689-4-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180309222327.18689-1-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hjc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kernel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, orjan.eide-5wv7dgnIgG8@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wzz-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, kuankuan.y-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hshi-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-input@vger.kernel.org

From: zain wang <wzz-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

There is a race between AUX CH bring-up and enabling bridge which will
cause link training to fail. To avoid hitting it, don't change psr state
while enabling the bridge.

Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: zain wang <wzz-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
[seanpaul fixed up the commit message a bit and renamed *_supported to *_enabled]
Signed-off-by: Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Thierry Escande <thierry.escande-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Tested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 15 ++++++++-------
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  2 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  2 +-
 include/drm/bridge/analogix_dp.h                   |  2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index e738aa6de1af..ee00d3d920e0 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -98,18 +98,18 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
 	return 0;
 }
 
-int analogix_dp_psr_supported(struct analogix_dp_device *dp)
+int analogix_dp_psr_enabled(struct analogix_dp_device *dp)
 {
 
-	return dp->psr_support;
+	return dp->psr_enable;
 }
-EXPORT_SYMBOL_GPL(analogix_dp_psr_supported);
+EXPORT_SYMBOL_GPL(analogix_dp_psr_enabled);
 
 int analogix_dp_enable_psr(struct analogix_dp_device *dp)
 {
 	struct edp_vsc_psr psr_vsc;
 
-	if (!dp->psr_support)
+	if (!dp->psr_enable)
 		return 0;
 
 	/* Prepare VSC packet as per EDP 1.4 spec, Table 6.9 */
@@ -131,7 +131,7 @@ int analogix_dp_disable_psr(struct analogix_dp_device *dp)
 	struct edp_vsc_psr psr_vsc;
 	int ret;
 
-	if (!dp->psr_support)
+	if (!dp->psr_enable)
 		return 0;
 
 	/* Prepare VSC packet as per EDP 1.4 spec, Table 6.9 */
@@ -871,8 +871,8 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 	/* Enable video */
 	analogix_dp_start_video(dp);
 
-	dp->psr_support = analogix_dp_detect_sink_psr(dp);
-	if (dp->psr_support)
+	dp->psr_enable = analogix_dp_detect_sink_psr(dp);
+	if (dp->psr_enable)
 		analogix_dp_enable_sink_psr(dp);
 }
 
@@ -1117,6 +1117,7 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 	if (ret)
 		DRM_ERROR("failed to setup the panel ret = %d\n", ret);
 
+	dp->psr_enable = false;
 	dp->dpms_mode = DRM_MODE_DPMS_OFF;
 }
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index b039b28d8fcc..e135a42cb19e 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -170,7 +170,7 @@ struct analogix_dp_device {
 	int			dpms_mode;
 	int			hpd_gpio;
 	bool                    force_hpd;
-	bool			psr_support;
+	bool			psr_enable;
 
 	struct mutex		panel_lock;
 	bool			panel_is_modeset;
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 36334839a3f8..3e8bf79bea58 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -82,7 +82,7 @@ static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
 	struct rockchip_dp_device *dp = to_dp(encoder);
 	int ret;
 
-	if (!analogix_dp_psr_supported(dp->adp))
+	if (!analogix_dp_psr_enabled(dp->adp))
 		return;
 
 	DRM_DEV_DEBUG(dp->dev, "%s PSR...\n", enabled ? "Entry" : "Exit");
diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
index 711fff9b6803..e9a1116d2f8e 100644
--- a/include/drm/bridge/analogix_dp.h
+++ b/include/drm/bridge/analogix_dp.h
@@ -41,7 +41,7 @@ struct analogix_dp_plat_data {
 			 struct drm_connector *);
 };
 
-int analogix_dp_psr_supported(struct analogix_dp_device *dp);
+int analogix_dp_psr_enabled(struct analogix_dp_device *dp);
 int analogix_dp_enable_psr(struct analogix_dp_device *dp);
 int analogix_dp_disable_psr(struct analogix_dp_device *dp);
 
-- 
2.16.1

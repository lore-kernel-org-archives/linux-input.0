From: Viresh KUMAR <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V2 48/69] ST SPEAr: replace readl, writel with __raw_readl, __raw_writel in uncompress.h
Date: Fri,  1 Oct 2010 17:26:08 +0530
Message-ID: <10581ee8e7ad68eabb4421cee448b5f7df983adb.1285933332.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
In-Reply-To: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
References: <cover.1285933331.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, shiraz.hashim-qxv4g6HH51o@public.gmane.org, vipin.kumar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, armando.visconti-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org
List-Id: linux-input@vger.kernel.org

readl also calls outer cache maintainance operations which are not available
during Linux uncompression. This patch replaces readl, writel with __raw_readl
and __raw_writel.

Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/plat-spear/include/plat/uncompress.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
index 99ba678..963aa5b 100644
--- a/arch/arm/plat-spear/include/plat/uncompress.h
+++ b/arch/arm/plat-spear/include/plat/uncompress.h
@@ -24,10 +24,10 @@ static inline void putc(int c)
 {
 	void __iomem *base = (void __iomem *)SPEAR_DBG_UART_BASE;
 
-	while (readl(base + UART01x_FR) & UART01x_FR_TXFF)
+	while (__raw_readl(base + UART01x_FR) & UART01x_FR_TXFF)
 		barrier();
 
-	writel(c, base + UART01x_DR);
+	__raw_writel(c, base + UART01x_DR);
 }
 
 static inline void flush(void)
-- 
1.7.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

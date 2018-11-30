From: Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH v7 7/7] regulator: stpmic1: fix regulator_lock usage
Date: Fri, 30 Nov 2018 09:55:51 +0000
Message-ID: <1543571742-17995-8-git-send-email-p.paillet@st.com>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543571742-17995-1-git-send-email-p.paillet@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "axel.lin@ingics.com" <axel.lin@ingics.com>
Cc: Pascal PAILLET-LME <p.paillet@st.com>
List-Id: linux-input@vger.kernel.org

fix a compilation issue due to regulator_lock usage.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
changes in v7: 
* new patch due to rebase on regul/for-next

 drivers/regulator/stpmic1_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index eac0848..16ba029 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -489,7 +489,7 @@ static irqreturn_t stpmic1_curlim_irq_handler(int irq, void *data)
 {
 	struct regulator_dev *rdev = (struct regulator_dev *)data;
 
-	regulator_lock(rdev, NULL);
+	regulator_lock(rdev);
 
 	/* Send an overcurrent notification */
 	regulator_notifier_call_chain(rdev,
-- 
1.9.1

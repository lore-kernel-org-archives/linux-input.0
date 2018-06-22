From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mtk-pmic-keys: Fix probe when no DT node present
Date: Fri, 22 Jun 2018 11:31:14 -0700
Message-ID: <20180622183114.GA92912@dtor-ws>
References: <20180622114228.8619-1-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180622114228.8619-1-matthias.bgg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: chen.zhong@mediatek.com, lee.jones@linaro.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 22, 2018 at 01:42:28PM +0200, Matthias Brugger wrote:
> The drivers gets probed from a mfd devices. So the driver runs
> probe although no DT node exists. This leads to a NULL pointer
> dereference in the probe function. Check if a node exists and
> error out in case none is present.

Hmm, if a cell specifies of_compatible and no such node is present in DT
maybe we should bail out in mfd_add_device() instead of pushing the
check into individual drivers? Something like:

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 94e3f32ce935..36a5fd98000d 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -137,6 +137,18 @@ static inline void mfd_acpi_add_device(const struct mfd_cell *cell,
 }
 #endif
 
+static struct device_node *mfd_get_node_for_cell(struct device *parent,
+						 const struct mfd_cell *cell)
+{
+	struct device_node *np;
+
+	for_each_child_of_node(parent->of_node, np)
+		if (of_device_is_compatible(np, cell->of_compatible))
+			return np;
+
+	return NULL;
+}
+
 static int mfd_add_device(struct device *parent, int id,
 			  const struct mfd_cell *cell, atomic_t *usage_count,
 			  struct resource *mem_base,
@@ -144,7 +156,6 @@ static int mfd_add_device(struct device *parent, int id,
 {
 	struct resource *res;
 	struct platform_device *pdev;
-	struct device_node *np = NULL;
 	int ret = -ENOMEM;
 	int platform_id;
 	int r;
@@ -176,11 +187,11 @@ static int mfd_add_device(struct device *parent, int id,
 		goto fail_res;
 
 	if (parent->of_node && cell->of_compatible) {
-		for_each_child_of_node(parent->of_node, np) {
-			if (of_device_is_compatible(np, cell->of_compatible)) {
-				pdev->dev.of_node = np;
-				break;
-			}
+		pdev->dev.of_node = mfd_get_node_for_cell(parent, cell);
+		if (!pdev->dev.of_node) {
+			dev_err(parent, "unable to locate node for %s (%s)\n",
+				cell->name, cell->of_compatible);
+			goto fail_res;
 		}
 	}
 
Lee?

> 
> Fixes: 3e9f0b3e2b27 ("input: Add MediaTek PMIC keys support")
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 02c67a1749fc..388043e1939c 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -257,6 +257,9 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
>  	const struct of_device_id *of_id =
>  		of_match_device(of_mtk_pmic_keys_match_tbl, &pdev->dev);
>  
> +	if (of_id == NULL)
> +		return -ENODEV;
> +
>  	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
>  	if (!keys)
>  		return -ENOMEM;
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry

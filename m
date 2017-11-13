From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: twl4030-vibra: fix sibling-node lookup
Date: Mon, 13 Nov 2017 13:54:52 -0800
Message-ID: <20171113215452.hqjvxjbef4dt5647@dtor-ws>
References: <20171111154339.16875-1-johan@kernel.org>
 <20171111175059.lwfhw2wdhlj5yxhc@dtor-ws>
 <20171112121235.GO11226@localhost>
 <20171113091144.5oz77shbu4oupoy7@dell>
 <20171113093544.GR11226@localhost>
 <20171113102028.c53rlcnwrjaey2tv@dell>
 <20171113115102.GU11226@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171113115102.GU11226@localhost>
Sender: stable-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Marek Belisko <marek@goldelico.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Nov 13, 2017 at 12:51:02PM +0100, Johan Hovold wrote:
> On Mon, Nov 13, 2017 at 10:20:28AM +0000, Lee Jones wrote:
> > On Mon, 13 Nov 2017, Johan Hovold wrote:
> > 
> > > On Mon, Nov 13, 2017 at 09:11:44AM +0000, Lee Jones wrote:
> > > > On Sun, 12 Nov 2017, Johan Hovold wrote:
> > > > 
> > > > > [ +CC: Lee, Rob and device-tree list ]
> > > > > 
> > > > > On Sat, Nov 11, 2017 at 09:50:59AM -0800, Dmitry Torokhov wrote:
> > > > > > On Sat, Nov 11, 2017 at 04:43:37PM +0100, Johan Hovold wrote:
> > > > > > > A helper purported to look up a child node based on its name was using
> > > > > > > the wrong of-helper and ended up prematurely freeing the parent of-node
> > > > > > > while searching the whole device tree depth-first starting at the parent
> > > > > > > node.
> > > > > > 
> > > > > > Ugh, this all is pretty ugly business. Can we teach MFD to allow
> > > > > > specifying firmware node to be attached to the platform devices it
> > > > > > creates in mfd_add_device() so that the leaf drivers simply call
> > > > > > device_property_read_XXX() on their own device and not be bothered with
> > > > > > weird OF refcount issues or what node they need to locate and parse?
> > > > 
> > > > If a child compatible is provided, we already set the child's
> > > > of_node.  It's then up to the driver (set) author(s) to use it in the
> > > > correct manner. 
> > > > 
> > > > > Yeah, that may have helped. You can actually specify a compatible string
> > > > > in struct mfd_cell today which does make mfd_add_device() associate a
> > > > > matching child node.
> > > > > 
> > > > > Some best practice regarding how to deal with MFD and device tree would
> > > > > be good to determine and document too. For example, when should
> > > > > of_platform_populate() be used in favour of mfd_add_device()?
> > > > 
> > > > When the device supports DT and its entire hierarchical layout, along
> > > > with all of its attributes can be expressed in DT.
> > > 
> > > Ok, a follow up: When there are different variants of an MFD and that
> > > affects the child drivers, then that should be expressed in in the child
> > > node compatibles rather than having the child match on the parent node?
> > > 
> > > I'm asking because this came up recently during review and their seems
> > > to be no precedent for matching on the parent compatible in child
> > > drivers:
> > > 
> > > 	https://lkml.kernel.org/r/20171105154725.GA11226@localhost
> > 
> > Accessing the parent's of_device_id .data directly doesn't sit well
> > with me.  The parent driver should pass this type of configuration
> > though pdata IMHO.
> 
> The child driver is only matching on the parent-node compatible string
> IIRC, and therefore keeps its own table of all parent compatibles with
> its own set of (child) private match data (i.e. the parent compatible
> property is matched first by the parent driver, and then again by the
> child).
> 
> Passing through pdata here is not possible since mfd_add_device() isn't
> used, right? It could of course be described using properties of the
> child node (e.g. by using different child compatible strings).
> 
> > > > > And how best to deal with sibling nodes, which is part of the problem
> > > > > here (I think the mfd should have provided a flag rather than having
> > > > > subdrivers deal with sibling nodes, for example).
> > > > 
> > > > I disagree.  The only properties the MFD (parent) driver is interested
> > > > in is ones which are shared across multiple child devices.
> > > > *Everything* which pertains to only a single child device should be
> > > > handled by its accompanying driver. 
> > > 
> > > Even if that means leaking details of one child driver into a sibling?
> > 
> > Not sure what you mean here.  Could you please elaborate or provide an
> > example?
> 
> I mean that the sibling node needs to be aware of the name, compatible
> string, or other node properties of its sibling node to be able to parse
> sibling nodes itself (rather than the sibling or parent doing so on its
> behalf). But it seems you answer this below.
> 
> > > Isn't it then cleaner to use the parent MFD to coordinate between the
> > > cells, just as we do for IO?
> > > 
> > > In this case a child driver looked up a sibling node based on name, but
> > 
> > This should not be allowed.  If >1 sibling requires access to a
> > particular property, this is normally evidence enough that this
> > property should be shared and handled by the parent.
> > 
> > > that doesn't mean the node is active, that there's a driver bound, or
> > > that the sibling node has some other random property for example. The
> > > parent could be used for such coordination, if only to pass information
> > > from one sibling to another.
> > 
> > Right.
> 
> Ok, it seems we're in agreement here.
> 
> Given that MFD has evolved over time and device-tree support has been
> added retroactively to some drivers, we've ended up with a multitude of
> different ways of dealing with such issues. I think it may still be a
> good idea to jot down some best practices for future driver developers.

FWIW here is the patch allowing attaching fwnode to an MFD cell that is
not using of_compatible (because if historical reasons). Completely
untested as I do not have this hardware.

If this is somewhat acceptable I can untangle core from twl6040
changes.

Thanks.
> 
> Thanks,
> Johan

-- 
Dmitry


Attach fwnode to MFD cells

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/twl6040-vibra.c |   32 ++++++++++----------------------
 drivers/mfd/mfd-core.c             |    2 ++
 drivers/mfd/twl6040.c              |   14 +++++++-------
 include/linux/mfd/core.h           |    6 ++++++
 include/linux/mfd/twl6040.h        |    2 ++
 5 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 5690eb7ff954..bd9507cf5608 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -242,23 +242,13 @@ static SIMPLE_DEV_PM_OPS(twl6040_vibra_pm_ops, twl6040_vibra_suspend, NULL);
 static int twl6040_vibra_probe(struct platform_device *pdev)
 {
 	struct device *twl6040_core_dev = pdev->dev.parent;
-	struct device_node *twl6040_core_node;
 	struct vibra_info *info;
 	int vddvibl_uV = 0;
 	int vddvibr_uV = 0;
 	int error;
 
-	of_node_get(twl6040_core_dev->of_node);
-	twl6040_core_node = of_find_node_by_name(twl6040_core_dev->of_node,
-						 "vibra");
-	if (!twl6040_core_node) {
-		dev_err(&pdev->dev, "parent of node is missing?\n");
-		return -EINVAL;
-	}
-
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info) {
-		of_node_put(twl6040_core_node);
 		dev_err(&pdev->dev, "couldn't allocate memory\n");
 		return -ENOMEM;
 	}
@@ -267,18 +257,16 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 
 	info->twl6040 = dev_get_drvdata(pdev->dev.parent);
 
-	of_property_read_u32(twl6040_core_node, "ti,vibldrv-res",
-			     &info->vibldrv_res);
-	of_property_read_u32(twl6040_core_node, "ti,vibrdrv-res",
-			     &info->vibrdrv_res);
-	of_property_read_u32(twl6040_core_node, "ti,viblmotor-res",
-			     &info->viblmotor_res);
-	of_property_read_u32(twl6040_core_node, "ti,vibrmotor-res",
-			     &info->vibrmotor_res);
-	of_property_read_u32(twl6040_core_node, "ti,vddvibl-uV", &vddvibl_uV);
-	of_property_read_u32(twl6040_core_node, "ti,vddvibr-uV", &vddvibr_uV);
-
-	of_node_put(twl6040_core_node);
+	device_property_read_u32(&pdev->dev, "ti,vibldrv-res",
+				 &info->vibldrv_res);
+	device_property_read_u32(&pdev->dev, "ti,vibrdrv-res",
+				 &info->vibrdrv_res);
+	device_property_read_u32(&pdev->dev, "ti,viblmotor-res",
+				 &info->viblmotor_res);
+	device_property_read_u32(&pdev->dev, "ti,vibrmotor-res",
+				 &info->vibrmotor_res);
+	device_property_read_u32(&pdev->dev, "ti,vddvibl-uV", &vddvibl_uV);
+	device_property_read_u32(&pdev->dev, "ti,vddvibr-uV", &vddvibr_uV);
 
 	if ((!info->vibldrv_res && !info->viblmotor_res) ||
 	    (!info->vibrdrv_res && !info->vibrmotor_res)) {
diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index c57e407020f1..2792fe40e2e4 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -186,6 +186,8 @@ static int mfd_add_device(struct device *parent, int id,
 
 	mfd_acpi_add_device(cell, pdev);
 
+	set_secondary_fwnode(&pdev->dev, cell->fwnode);
+
 	if (cell->pdata_size) {
 		ret = platform_device_add_data(pdev,
 					cell->platform_data, cell->pdata_size);
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index d66502d36ba0..2994a8885c7e 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -97,13 +97,9 @@ static struct reg_sequence twl6040_patch[] = {
 };
 
 
-static bool twl6040_has_vibra(struct device_node *node)
+static struct device_node *twl6040_get_vibra(struct device_node *node)
 {
-#ifdef CONFIG_OF
-	if (of_find_node_by_name(node, "vibra"))
-		return true;
-#endif
-	return false;
+	return node ? of_get_child_by_name(node, "vibra") : NULL;
 }
 
 int twl6040_reg_read(struct twl6040 *twl6040, unsigned int reg)
@@ -766,11 +762,13 @@ static int twl6040_probe(struct i2c_client *client,
 	children++;
 
 	/* Vibra input driver support */
-	if (twl6040_has_vibra(node)) {
+	twl6040->vibra_node = twl6040_get_vibra(node);
+	if (twl6040->vibra_node) {
 		irq = regmap_irq_get_virq(twl6040->irq_data, TWL6040_IRQ_VIB);
 
 		cell = &twl6040->cells[children];
 		cell->name = "twl6040-vibra";
+		cell->fwnode = &twl6040->vibra_node->fwnode;
 		twl6040_vibra_rsrc[0].start = irq;
 		twl6040_vibra_rsrc[0].end = irq;
 		cell->resources = twl6040_vibra_rsrc;
@@ -817,6 +815,8 @@ static int twl6040_remove(struct i2c_client *client)
 
 	mfd_remove_devices(&client->dev);
 
+	of_node_put(twl6040->vibra_node);
+
 	regulator_bulk_disable(TWL6040_NUM_SUPPLIES, twl6040->supplies);
 
 	return 0;
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 99c0395fe1f9..452f9d4de98a 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -58,6 +58,12 @@ struct mfd_cell {
 	/* Matches ACPI */
 	const struct mfd_cell_acpi_match	*acpi_match;
 
+	/*
+	 * Secondary firmware node that should be associated with the
+	 * platform device corresponding to the cell.
+	 */
+	struct fwnode_handle	*fwnode;
+
 	/*
 	 * These resources can be specified relative to the parent device.
 	 * For accessing hardware you should use resources from the platform dev
diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index a2e88761c09f..9eee44c4fc1f 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -232,6 +232,8 @@ struct twl6040 {
 	struct mfd_cell cells[TWL6040_CELLS];
 	struct completion ready;
 
+	struct device_node *vibra_node;
+
 	int audpwron;
 	int power_count;
 	int rev;

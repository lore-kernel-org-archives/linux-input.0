From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 1/2] input: keyboard: Add keys driver for the LPC32xx SoC
Date: Tue, 24 Apr 2012 18:01:10 +0800
Message-ID: <CAF+7xWmHGfGpFo6Wg=ad1Fc_6N56HWfp+YBw_6BeJziF52dCjw@mail.gmail.com>
References: <1335261068-18640-1-git-send-email-stigge@antcom.de>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1335261068-18640-1-git-send-email-stigge@antcom.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roland Stigge <stigge@antcom.de>
Cc: srinivas.bakki@nxp.com, michael.hennerich@analog.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, grant.likely@secretlab.ca, riyer@nvidia.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

> +#ifdef CONFIG_OF
> +static struct lpc32XX_kscan_cfg *lpc32XX_parse_dt(struct device *dev)
> +{
> + =A0 =A0 =A0 struct lpc32XX_kscan_cfg *pdata;
> + =A0 =A0 =A0 struct device_node *np =3D dev->of_node;
> + =A0 =A0 =A0 struct device_node *key_np;
> + =A0 =A0 =A0 int key_count;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "could not allocate memory for=
 platform data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 of_property_read_u32(np, "nxp,matrix-size", &pdata->matrix_=
sz);
> + =A0 =A0 =A0 of_property_read_u32(np, "nxp,debounce-delay-ms", &pdata->d=
eb_clks);
> + =A0 =A0 =A0 of_property_read_u32(np, "nxp,scan-delay-ms", &pdata->scan_=
delay);
> +
> + =A0 =A0 =A0 if (!pdata->matrix_sz || !pdata->deb_clks || !pdata->scan_d=
elay) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "matrix size, debounce or s=
can delay not specified\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 key_count =3D pdata->matrix_sz * pdata->matrix_sz;
> + =A0 =A0 =A0 pdata->keymap =3D devm_kzalloc(dev, sizeof(int) * key_count=
, GFP_KERNEL);
> + =A0 =A0 =A0 if (!pdata->keymap) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "could not allocate memory for=
 keymap\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 i =3D 0;
> + =A0 =A0 =A0 for_each_child_of_node(np, key_np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 key_code;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(key_np, "linux,code", =
&key_code);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->keymap[i++] =3D key_code;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return pdata;
> +out1:
> + =A0 =A0 =A0 devm_kfree(dev, pdata);

Since you are using devm_kzalloc, you don't need to call devm_kfree here.
> + =A0 =A0 =A0 return NULL;
> +}
> +
> +static
> +void lpc32XX_free_dt(struct device *dev, struct lpc32XX_kscan_cfg *pdata)
> +{
> + =A0 =A0 =A0 devm_kfree(dev, pdata->keymap);
> + =A0 =A0 =A0 devm_kfree(dev, pdata);
> +}
The same, you don't need the devm_kfree calls, so you can just kill
lpc32XX_free_dt function.
> +
> +#else
> +static struct lpc32XX_kscan_cfg *lpc32XX_parse_dt(struct device *dev)
> +{
> + =A0 =A0 =A0 return NULL;
> +}
> +
> +static
> +void lpc32XX_free_dt(struct device *dev, struct lpc32XX_kscan_cfg *pdata)
> +{
> +}
> +#endif
> +
> +static int __devinit lpc32xx_kscan_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct lpc32xx_kscan_drv *kscandat;
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 int retval, i, keynum;
> +
> + =A0 =A0 =A0 kscandat =3D kzalloc(sizeof(struct lpc32xx_kscan_drv), GFP_=
KERNEL);
> + =A0 =A0 =A0 if (unlikely(!kscandat)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to allocate mem=
ory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (res =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get platform=
 I/O memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_nores;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 kscandat->kscan_base =3D devm_request_and_ioremap(&pdev->de=
v, res);
> + =A0 =A0 =A0 if (kscandat->kscan_base =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request and =
remap I/O memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_noremap;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Get the key scanner clock */
> + =A0 =A0 =A0 kscandat->clk =3D clk_get(&pdev->dev, NULL);
> + =A0 =A0 =A0 if (IS_ERR(kscandat->clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get clock\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_noclk;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 clk_enable(kscandat->clk);
> +
> + =A0 =A0 =A0 kscandat->irq =3D platform_get_irq(pdev, 0);
> + =A0 =A0 =A0 if ((kscandat->irq < 0) || (kscandat->irq >=3D NR_IRQS)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get platform=
 irq\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_noirq;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 retval =3D request_irq(kscandat->irq, lpc32xx_kscan_irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00, pdev->name, k=
scandat);
> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request irq\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_noirq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 kscandat->input =3D input_allocate_device();
> + =A0 =A0 =A0 if (kscandat->input =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to allocate dev=
ice\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_noalloc;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pdev->dev.of_node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kscandat->kscancfg =3D lpc32XX_parse_dt(&pd=
ev->dev);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kscandat->kscancfg =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct lpc32XX_kscan_cfg *=
)pdev->dev.platform_data;
> + =A0 =A0 =A0 if (!kscandat->kscancfg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get platform=
 data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_nopdata;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, kscandat);
> +
> + =A0 =A0 =A0 /* Setup key input */
> + =A0 =A0 =A0 kscandat->input->evbit[0] =A0 =A0 =A0 =3D BIT_MASK(EV_KEY);
> + =A0 =A0 =A0 kscandat->input->name =A0 =A0 =A0 =A0 =A0 =3D pdev->name;
> + =A0 =A0 =A0 kscandat->input->phys =A0 =A0 =A0 =A0 =A0 =3D "matrix-keys/=
input0";
> + =A0 =A0 =A0 kscandat->input->dev.parent =A0 =A0 =3D =A0&pdev->dev;
> + =A0 =A0 =A0 kscandat->input->id.vendor =A0 =A0 =A0=3D 0x0001;
> + =A0 =A0 =A0 kscandat->input->id.product =A0 =A0 =3D 0x0001;
> + =A0 =A0 =A0 kscandat->input->id.version =A0 =A0 =3D 0x0100;
> + =A0 =A0 =A0 keynum =3D kscandat->kscancfg->matrix_sz * kscandat->kscanc=
fg->matrix_sz;
> + =A0 =A0 =A0 for (i =3D 0; i < keynum; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(kscandat->kscancfg->keymap[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kscandat->input->keybit);
> +
> + =A0 =A0 =A0 input_set_capability(kscandat->input, EV_MSC, MSC_SCAN);
> +
> + =A0 =A0 =A0 retval =3D input_register_device(kscandat->input);
> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to register inp=
ut device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_notregistered;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Configure the key scanner */
> + =A0 =A0 =A0 __raw_writel(kscandat->kscancfg->deb_clks,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 LPC32XX_KS_DEB(kscandat->kscan_base));
> + =A0 =A0 =A0 __raw_writel(kscandat->kscancfg->scan_delay,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 LPC32XX_KS_SCAN_CTL(kscandat->kscan_base));
> + =A0 =A0 =A0 __raw_writel(LPC32XX_KSCAN_FTST_USE32K_CLK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 LPC32XX_KS_FAST_TST(kscandat->kscan_base));
> + =A0 =A0 =A0 __raw_writel(kscandat->kscancfg->matrix_sz,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 LPC32XX_KS_MATRIX_DIM(kscandat->kscan_base)=
);
> + =A0 =A0 =A0 __raw_writel(1, LPC32XX_KS_IRQ(kscandat->kscan_base));
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_notregistered:
> + =A0 =A0 =A0 lpc32XX_free_dt(&pdev->dev, kscandat->kscancfg);
> +err_nopdata:
> + =A0 =A0 =A0 input_free_device(kscandat->input);
> +err_noalloc:
> + =A0 =A0 =A0 free_irq(kscandat->irq, pdev);
> +err_noirq:
> + =A0 =A0 =A0 clk_put(kscandat->clk);
> +err_noclk:
> + =A0 =A0 =A0 iounmap(kscandat->kscan_base);
> +err_noremap:
> + =A0 =A0 =A0 release_mem_region(res->start, resource_size(res));
You are using devm_request_and_ioremap, so the iounmap and
release_mem_region calls
are not necessary.
> +err_nores:
> + =A0 =A0 =A0 kfree(kscandat);
> +
> + =A0 =A0 =A0 return retval;
> +}
> +
> +static int __devexit lpc32xx_kscan_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 struct lpc32xx_kscan_drv *kscandat =3D platform_get_drvdata=
(pdev);
> +
> + =A0 =A0 =A0 free_irq(kscandat->irq, pdev);
> + =A0 =A0 =A0 input_unregister_device(kscandat->input);
> + =A0 =A0 =A0 clk_put(kscandat->clk);
> + =A0 =A0 =A0 iounmap(kscandat->kscan_base);
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 release_mem_region(res->start, resource_size(res));

The same, iounmap and release_mem_region can be removed.
> +
> + =A0 =A0 =A0 kfree(kscandat);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +

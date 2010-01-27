From: =?iso-8859-15?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v3] input: MXC: add mxc-keypad driver to support the Keypad
	Port present in the mxc application processors family.
Date: Wed, 27 Jan 2010 11:33:04 +0100
Message-ID: <19296.5728.557535.920849@ipc1.ka-ro>
References: <1264586106.2463.23.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1264586106.2463.23.camel@realization>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

Alberto Panizzo writes:
[...]
>  arch/arm/plat-mxc/include/mach/mxc_keypad.h |   18 +
>  drivers/input/keyboard/Kconfig              |    9 +
>  drivers/input/keyboard/Makefile             |    1 +
>  drivers/input/keyboard/mxc_keypad.c         |  516 +++++++++++++++++++++=
++++++
>  4 files changed, 544 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/mxc_keypad.h
>  create mode 100644 drivers/input/keyboard/mxc_keypad.c
> =

> diff --git a/arch/arm/plat-mxc/include/mach/mxc_keypad.h b/arch/arm/plat-=
mxc/include/mach/mxc_keypad.h
> new file mode 100644
> index 0000000..4509103
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/mxc_keypad.h
> @@ -0,0 +1,18 @@
> +#ifndef __MACH_MXC_KEYPAD_H
> +#define __MACH_MXC_KEYPAD_H
> +
> +#include <linux/input/matrix_keypad.h>
> +
> +#define MAX_MATRIX_KEY_ROWS	(8)
> +#define MAX_MATRIX_KEY_COLS	(8)
> +#define MATRIX_ROW_SHIFT	(3)
> +
pointless '()'

> +
> +/*
> + * Keypad Controller registers (halfword)
> + */
> +#define KPCR		0x00 /* Keypad Control Register */
> +
> +#define KPSR		0x02 /* Keypad Status Register */
> +#define KBD_STAT_KPKD	(0x1 << 0) /* Key Press Interrupt Status bit */
> +#define KBD_STAT_KPKR	(0x1 << 1) /* Key Release Interrupt Status bit */
> +#define KBD_STAT_KDSC	(0x1 << 2) /* Key Depress Synch Chain Status bit */
> +#define KBD_STAT_KRSS	(0x1 << 3) /* Key Release Synch Status bit */
> +#define KBD_STAT_KDIE	(0x1 << 8) /* Key Depress Interrupt Enable Status =
bit */
> +#define KBD_STAT_KRIE	(0x1 << 9) /* Key Release Interrupt Enable */
> +#define KBD_STAT_KPPEN	(0x1 << 10) /* Keypad Clock Enable */
> +
> +#define KDDR		0x04 /* Keypad Data Direction Register */
> +#define KPDR		0x06 /* Keypad Data Register */
> +
> +#define MAX_MATRIX_KEY_NUM	(MAX_MATRIX_KEY_ROWS * MAX_MATRIX_KEY_COLS)
> +
> +struct mxc_keypad {
> +	struct mxc_keypad_platform_data *pdata;
> +
> +	struct clk *clk;
> +	struct input_dev *input_dev;
> +	void __iomem *mmio_base;
> +
> +	int			irq;
> +	struct timer_list	scan_timer;
> +	struct timer_list	relax_timer;
> +
> +#define MXC_IRQ_KDI		1
> +#define MXC_IRQ_KRI		2
> +	unsigned int		irq_type;
> +	int 			irq_since_last_change;
           ^
SPACE before TAB (emacs can highlight those... ;)
> +
> +	/* Masks for enabled rows/cols */
> +	unsigned short		rows_en_mask;
> +	unsigned short		cols_en_mask;
> +
> +	unsigned short 		keycodes[MAX_MATRIX_KEY_NUM];
                      ^
dto.

> +
> +	/* state row bits of each column scan */
> +	unsigned short 		matrix_key_state[MAX_MATRIX_KEY_COLS];
                      ^
dto.

> +};
> +
> +/* Return 0 if no changes are detected in matrix */
> +static int mxc_keypad_scan_matrix(struct mxc_keypad *keypad)
> +{
> +	struct input_dev *input_dev =3D keypad->input_dev;
> +	int row, col, changed =3D 0;
> +	unsigned short new_state[MAX_MATRIX_KEY_COLS];
> +	unsigned short reg_val;
> +
> +	memset(new_state, 0, sizeof(new_state));
> +
> +	for (col =3D 0; col < MAX_MATRIX_KEY_COLS; col++) {
> +		if ((keypad->cols_en_mask & (1 << col)) =3D=3D 0)
> +			continue;
> +		/* Discharge keypad capacitance:
> +		 * 2. write 1s on column data.
> +		 * 3. configure columns as totem-pole to discharge capacitance.
> +		 * 4. configure columns as open-drain.*/
> +		reg_val =3D readw(keypad->mmio_base + KPDR);
> +		reg_val |=3D 0xff00;
> +		writew(reg_val, keypad->mmio_base + KPDR);
> +
> +		reg_val =3D readw(keypad->mmio_base + KPCR);
> +		reg_val &=3D ~((keypad->cols_en_mask & 0xff) << 8);
> +		writew(reg_val, keypad->mmio_base + KPCR);
> +
> +		udelay(2);
> +
> +		reg_val =3D readw(keypad->mmio_base + KPCR);
> +		reg_val |=3D (keypad->cols_en_mask & 0xff) << 8;
> +		writew(reg_val, keypad->mmio_base + KPCR);
> +
> +		/*
> +		 * 5. Write a single column to 0, others to 1.
> +		 * 6. Sample row inputs and save data.
> +		 * 7. Repeat steps 2 - 6 for remaining columns.
> +		 */
> +		reg_val =3D readw(keypad->mmio_base + KPDR);
> +		reg_val &=3D ~(1 << (8 + col));
> +		writew(reg_val, keypad->mmio_base + KPDR);
> +
> +		/* Delay added to avoid propagating the 0 from column to row
> +		 * when scanning. */
> +		udelay(5);
> +
> +		/* 1s in state detect a key pressure */
> +		new_state[col] =3D (~readw(keypad->mmio_base + KPDR)) & 0x00ff;
> +	}
> +
> +	/* Test the state changes */
> +	for (col =3D 0; col < MAX_MATRIX_KEY_COLS; col++) {
> +		unsigned short bits_changed;
> +		int code;
> +
> +		if ((keypad->cols_en_mask & (1 << col)) =3D=3D 0)
> +			continue;
> +
> +		bits_changed =3D keypad->matrix_key_state[col] ^ new_state[col];
> +		if (bits_changed =3D=3D 0)
> +			continue;
> +
> +		changed =3D 1;
> +		for (row =3D 0; row < MAX_MATRIX_KEY_ROWS; row++) {
> +			if ((keypad->rows_en_mask & (1 << row)) =3D=3D 0)
> +				continue;
> +			if ((bits_changed & (1 << row)) =3D=3D 0)
> +				continue;
> +
> +			code =3D MATRIX_SCAN_CODE(row, col, MATRIX_ROW_SHIFT);
> +			input_event(input_dev, EV_MSC, MSC_SCAN, code);
> +			input_report_key(input_dev, keypad->keycodes[code],
> +					 new_state[col] & (1 << row));
> +			dev_dbg(&input_dev->dev, "Event code: %d, val: %d",
> +					keypad->keycodes[code],
> +					new_state[col] & (1 << row));
> +		}
> +	}
> +	input_sync(input_dev);
> +	memcpy(keypad->matrix_key_state, new_state, sizeof(new_state));
> +
> +	/* Return in standby mode:
> +	 * 9. write 0s to columns */
> +	reg_val =3D readw(keypad->mmio_base + KPDR);
> +	reg_val &=3D 0x00ff;
> +	writew(reg_val, keypad->mmio_base + KPDR);
> +
> +	return changed;
> +}
> +
> +static void mxc_keypad_relax_timer_handler(unsigned long data)
> +{
> +	struct mxc_keypad *keypad =3D (struct mxc_keypad *) data;
> +	unsigned short reg_val;
> +
> +	/* 10. Clear KPKD and KPKR status bits
> +	 *     Set the KPKR sync chain and clear the KPKD sync chain */
> +	reg_val =3D readw(keypad->mmio_base + KPSR);
> +	reg_val |=3D KBD_STAT_KPKD | KBD_STAT_KPKR |
> +		   KBD_STAT_KDSC | KBD_STAT_KRSS;
> +	writew(reg_val, keypad->mmio_base + KPSR);
> +
> +	/* Re enable interrupts and clear sync reset bits.
> +	 * Next KDI is used for detect multiple pressures. */
> +	reg_val =3D readw(keypad->mmio_base + KPSR);
> +	reg_val &=3D ~(KBD_STAT_KDSC | KBD_STAT_KRSS);
> +	writew(reg_val, keypad->mmio_base + KPSR);
> +
> +	reg_val |=3D KBD_STAT_KDIE | KBD_STAT_KRIE;
> +	if (keypad->irq_type =3D=3D MXC_IRQ_KRI)
> +		reg_val &=3D ~KBD_STAT_KRIE;
> +	writew(reg_val, keypad->mmio_base + KPSR);
> +}
> +
> +static void mxc_keypad_scan_timer_handler(unsigned long data)
> +{
> +	struct mxc_keypad *keypad =3D (struct mxc_keypad *) data;
> +	struct input_dev *idev =3D keypad->input_dev;
> +
> +	dev_dbg(&idev->dev, "Handling Interrupt of type %x\n",
> +						keypad->irq_type);
> +
> +	/* Do the scan routine and Keep track for how many time we got
> +	 * interrupt that make no change */
> +	if (mxc_keypad_scan_matrix(keypad))
> +		keypad->irq_since_last_change =3D 0;
> +	else
> +		keypad->irq_since_last_change++;
> +
> +	/* If the key is pressed since too many time, relax the update period */
> +	if (keypad->irq_since_last_change > 2)
> +		mod_timer(&keypad->relax_timer,
> +			  jiffies + msecs_to_jiffies(60));
> +	else
> +		mxc_keypad_relax_timer_handler((unsigned long) keypad);
> +}
> +
> +static irqreturn_t mxc_keypad_irq_handler(int irq, void *dev_id)
> +{
> +	struct mxc_keypad *keypad =3D dev_id;
> +	struct mxc_keypad_platform_data *pdata =3D keypad->pdata;
> +	unsigned short reg_val;
> +
> +	/* Disable every keypad interrupt */
> +	reg_val =3D readw(keypad->mmio_base + KPSR);
> +	reg_val &=3D ~(KBD_STAT_KRIE | KBD_STAT_KDIE);
> +	writew(reg_val, keypad->mmio_base + KPSR);
> +
> +	keypad->irq_type =3D reg_val & KBD_STAT_KPKD ?
> +			   MXC_IRQ_KDI : MXC_IRQ_KRI;
> +
> +	/* Schedule the scanning procedure */
> +	mod_timer(&keypad->scan_timer,
> +		  jiffies + msecs_to_jiffies(pdata->debounce_ms));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void mxc_keypad_config(struct mxc_keypad *keypad)
> +{
> +	unsigned short reg_val;
> +
> +	/* Enable number of rows in keypad (KPCR[7:0])
> +	 * Configure keypad columns as open-drain (KPCR[15:8])
> +	 */
> +	reg_val =3D readw(keypad->mmio_base + KPCR);
> +	reg_val |=3D keypad->rows_en_mask & 0xff;		/* rows */
> +	reg_val |=3D (keypad->cols_en_mask & 0xff) << 8;	/* cols */
> +	writew(reg_val, keypad->mmio_base + KPCR);
> +
> +	/* Write 0's to KPDR[15:8] (Colums)*/
> +	reg_val =3D readw(keypad->mmio_base + KPDR);
> +	reg_val &=3D 0x00ff;
> +	writew(reg_val, keypad->mmio_base + KPDR);
> +
> +	/* Configure columns as output, rows as input (KDDR[15:0]) */
> +	reg_val =3D readw(keypad->mmio_base + KDDR);
> +	reg_val |=3D 0xff00;
> +	reg_val &=3D 0xff00;
>
This is effectively the same as: 'reg_val =3D 0xff00;' which makes the
readw() above pointless. Was this really intended?

> +	writew(reg_val, keypad->mmio_base + KDDR);
> +
> +	/* Clear Key Depress and Key Release status bit.
> +	 * Clear synchronizer chain.
> +	 * */
> +	reg_val =3D readw(keypad->mmio_base + KPSR);
> +	reg_val |=3D KBD_STAT_KPKR | KBD_STAT_KPKD |
> +		   KBD_STAT_KDSC | KBD_STAT_KRSS;
> +	writew(reg_val, keypad->mmio_base + KPSR);
> +
> +	/* Set the KDIE control bit, and clear the KRIE control bit
> +	 * (avoid false release events). */
> +	reg_val |=3D KBD_STAT_KDIE;
> +	reg_val &=3D ~KBD_STAT_KRIE;
> +	writew(reg_val, keypad->mmio_base + KPSR);
> +}
> +
> +static void mxc_keypad_inhibit(struct mxc_keypad *keypad)
> +{
> +	unsigned short reg_val;
> +
> +	/* Colums as open drain and disable rows */
> +	writew(0xff00, keypad->mmio_base + KPCR);
> +
> +	/* Clear the KPKD status flag and synchronizer chain.
> +	 * Clear KDIE control bit and KRIE control bit.
> +	 */
> +	reg_val =3D readw(keypad->mmio_base + KPSR);
> +	reg_val |=3D KBD_STAT_KPKD | KBD_STAT_KDSC;
> +	reg_val &=3D ~(KBD_STAT_KRIE | KBD_STAT_KDIE);
> +	writew(reg_val, keypad->mmio_base + KPSR);
> +}
> +
> +static int mxc_keypad_open(struct input_dev *dev)
> +{
> +	struct mxc_keypad *keypad =3D input_get_drvdata(dev);
> +
> +	dev_dbg(&dev->dev, "%s\n", __func__);
> +
> +	/* Enable unit clock */
> +	clk_enable(keypad->clk);
> +	mxc_keypad_config(keypad);
> +
> +	/* Sanity control, not all the rows must be to 0s now. */
> +	if ((readw(keypad->mmio_base + KPDR) & keypad->rows_en_mask) =3D=3D 0) {
> +		dev_err(&dev->dev, "Too much keys pressed for now, "
> +				"control pins initialisation\n");
>
It helps grepping for a message, if it is not split into multiple
lines.

> +		goto open_err;
> +	}
> +
> +	return 0;
> +
> +open_err:
> +	mxc_keypad_inhibit(keypad);
> +	return -EIO;
> +}
> +
> +static void mxc_keypad_close(struct input_dev *dev)
> +{
> +	struct mxc_keypad *keypad =3D input_get_drvdata(dev);
> +
> +	dev_dbg(&dev->dev, "%s\n", __func__);
> +
> +	mxc_keypad_inhibit(keypad);
> +
> +	/* Disable clock unit */
> +	clk_disable(keypad->clk);
> +}
> +
> +static int __devinit mxc_keypad_probe(struct platform_device *pdev)
> +{
> +	struct mxc_keypad_platform_data *pdata =3D pdev->dev.platform_data;
> +	struct mxc_keypad *keypad;
> +	struct input_dev *input_dev;
> +	struct resource *res;
> +	int irq, error, i;
> +	const struct matrix_keymap_data *keymap_data;
> +
> +	if (pdata =3D=3D NULL) {
> +		dev_err(&pdev->dev, "no platform data defined\n");
> +		return -EINVAL;
> +	}
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "failed to get keypad irq\n");
> +		return -ENXIO;
> +	}
>
This should be -ENODEV.

> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res =3D=3D NULL) {
> +		dev_err(&pdev->dev, "failed to get I/O memory\n");
> +		return -ENXIO;
>
same as above.

> +	}
> +
> +	res =3D request_mem_region(res->start, resource_size(res), pdev->name);
> +	if (res =3D=3D NULL) {
> +		dev_err(&pdev->dev, "failed to request I/O memory\n");
> +		return -EBUSY;
> +	}
> +
> +	input_dev =3D input_allocate_device();
> +	if (!input_dev) {
> +		dev_err(&pdev->dev, "failed to allocate the input device\n");
> +		error =3D -ENOMEM;
> +		goto failed_rel_mem;
> +	}
> +
> +	keypad =3D kzalloc(sizeof(struct mxc_keypad), GFP_KERNEL);
> +	if (!keypad) {
> +		dev_err(&pdev->dev, "not enough memory for driver data\n");
> +		error =3D -ENOMEM;
> +		goto failed_free_input;
> +	}
> +
> +	keypad->pdata =3D pdata;
> +	keypad->input_dev =3D input_dev;
> +	keypad->irq =3D irq;
> +
> +	keypad->mmio_base =3D ioremap(res->start, resource_size(res));
> +	if (keypad->mmio_base =3D=3D NULL) {
> +		dev_err(&pdev->dev, "failed to remap I/O memory\n");
> +		error =3D -ENXIO;
>
-ENOMEM;

> +		goto failed_free_priv;
> +	}
> +
> +	keypad->clk =3D clk_get(NULL, "kpp");
>
clk_get(&pdev->dev, "kpp");

> +	if (IS_ERR(keypad->clk)) {
> +		dev_err(&pdev->dev, "failed to get keypad clock\n");
> +		error =3D PTR_ERR(keypad->clk);
> +		goto failed_unmap;
> +	}
> +
> +	/*
> +	 * Search for rows and cols enabled
> +	 */
> +	keymap_data =3D pdata->keymap_data;
> +	for (i =3D 0; i < keymap_data->keymap_size; i++) {
> +		keypad->rows_en_mask |=3D 1 << KEY_ROW(keymap_data->keymap[i]);
> +		keypad->cols_en_mask |=3D 1 << KEY_COL(keymap_data->keymap[i]);
> +	}
> +
> +	if (keypad->rows_en_mask > ((1 << MAX_MATRIX_KEY_ROWS) - 1) ||
> +	   keypad->cols_en_mask > ((1 << MAX_MATRIX_KEY_COLS) - 1)) {
> +		dev_err(&pdev->dev, "Invalid key data (too rows or colums)\n");
> +		error =3D -EINVAL;
> +		goto failed_clock_put;
> +	}
> +	dev_dbg(&pdev->dev, "enabled rows mask: %x\n", keypad->rows_en_mask);
> +	dev_dbg(&pdev->dev, "enabled cols mask: %x\n", keypad->cols_en_mask);
> +
> +	/* Init Keypad timers */
> +	init_timer(&keypad->scan_timer);
> +	keypad->scan_timer.function =3D mxc_keypad_scan_timer_handler;
> +	keypad->scan_timer.data =3D (unsigned long) keypad;
> +
> +	init_timer(&keypad->relax_timer);
> +	keypad->relax_timer.function =3D mxc_keypad_relax_timer_handler;
> +	keypad->relax_timer.data =3D (unsigned long) keypad;
> +
> +	/* Init the Input device */
> +	input_dev->name =3D pdev->name;
> +	input_dev->id.bustype =3D BUS_HOST;
> +	input_dev->dev.parent =3D &pdev->dev;
> +	input_dev->open =3D mxc_keypad_open;
> +	input_dev->close =3D mxc_keypad_close;
> +	input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> +	input_dev->keycode =3D keypad->keycodes;
> +	input_dev->keycodesize =3D sizeof(keypad->keycodes[0]);
> +	input_dev->keycodemax =3D ARRAY_SIZE(keypad->keycodes);
> +
> +	matrix_keypad_build_keymap(pdata->keymap_data, MATRIX_ROW_SHIFT,
> +				keypad->keycodes, input_dev->keybit);
> +
> +	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> +	input_set_drvdata(input_dev, keypad);
> +
> +	error =3D request_irq(irq, mxc_keypad_irq_handler, IRQF_DISABLED,
> +			pdev->name, keypad);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to request IRQ\n");
> +		goto failed_clock_put;
> +	}
> +
> +	/* Register the input device */
> +	error =3D input_register_device(input_dev);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to register input device\n");
> +		goto failed_free_irq;
> +	}
> +
> +	platform_set_drvdata(pdev, keypad);
> +	device_init_wakeup(&pdev->dev, 1);
> +
> +	dev_info(&pdev->dev, "device probed\n");
> +
> +	return 0;
> +
> +failed_free_irq:
> +	free_irq(irq, pdev);
> +failed_clock_put:
> +	clk_put(keypad->clk);
> +failed_unmap:
> +	iounmap(keypad->mmio_base);
> +failed_free_priv:
> +	kfree(keypad);
> +failed_free_input:
> +	input_free_device(input_dev);
> +failed_rel_mem:
> +	release_mem_region(res->start, resource_size(res));
> +	return error;
> +}
> +
> +static int __devexit mxc_keypad_remove(struct platform_device *pdev)
> +{
> +	struct mxc_keypad *keypad =3D platform_get_drvdata(pdev);
> +	struct resource *res;
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	free_irq(keypad->irq, keypad);
> +	clk_put(keypad->clk);
> +	del_timer_sync(&keypad->scan_timer);
> +	del_timer_sync(&keypad->relax_timer);
> +
> +	input_unregister_device(keypad->input_dev);
> +
> +	iounmap(keypad->mmio_base);
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	release_mem_region(res->start, resource_size(res));
> +
> +	kfree(keypad);
> +
> +	dev_info(&pdev->dev, "device removed\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mxc_keypad_driver =3D {
> +	.driver		=3D {
> +		.name	=3D "mxc-keypad",
> +		.owner	=3D THIS_MODULE,
> +	},
> +	.probe		=3D mxc_keypad_probe,
> +	.remove		=3D __devexit_p(mxc_keypad_remove),
> +};
> +
> +static int __init mxc_keypad_init(void)
> +{
> +	return platform_driver_register(&mxc_keypad_driver);
> +}
> +
> +static void __exit mxc_keypad_exit(void)
> +{
> +	platform_driver_unregister(&mxc_keypad_driver);
> +}
> +
> +module_init(mxc_keypad_init);
> +module_exit(mxc_keypad_exit);
> +
> +MODULE_AUTHOR("Alberto Panizzo <maramaopercheseimorto@gmail.com>");
> +MODULE_DESCRIPTION("MXC Keypad Port Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:mxc-keypad");
> -- =

> 1.6.3.3
> =

> =

> =

> =

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
Lothar Wa=DFmann
-- =

___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=E4ftsf=FChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________

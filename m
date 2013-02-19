From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v4 6/6] Input: Add ChromeOS EC keyboard driver
Date: Tue, 19 Feb 2013 16:36:41 +0800
Message-ID: <1361263001.7859.11.camel@liguang.fnst.cn.fujitsu.com>
References: <1360988172-15380-1-git-send-email-sjg@chromium.org>
	 <1360988172-15380-7-git-send-email-sjg@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:24561 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757736Ab3BSIgm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Feb 2013 03:36:42 -0500
In-Reply-To: <1360988172-15380-7-git-send-email-sjg@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Luigi Semenzato <semenzato@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Mike A. Chan" <mikechan@google.com>, Jun Nakajima <jun.nakajima@intel.com>, Tom Keel <thomas.keel@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org

=E5=9C=A8 2013-02-15=E4=BA=94=E7=9A=84 20:16 -0800=EF=BC=8CSimon Glass=E5=
=86=99=E9=81=93=EF=BC=9A
> Use the key-matrix layer to interpret key scan information from the E=
C
> and inject input based on the FDT-supplied key map. This driver regis=
ters
> itself with the ChromeOS EC driver to perform communications.

[snip ...]
> +/*
> + * Returns true when there is at least one combination of pressed ke=
ys that
> + * results in ghosting.
> + */
> +static bool cros_ec_keyb_has_ghosting(struct cros_ec_keyb *ckdev, ui=
nt8_t *buf)
> +{
> +	int row;
> +
> +	/*
> +	 * Ghosting happens if for any pressed key X there are other keys
> +	 * pressed both in the same row and column of X as, for instance,
> +	 * in the following diagram:
> +	 *
> +	 * . . Y . g .
> +	 * . . . . . .
> +	 * . . . . . .
> +	 * . . X . Z .
> +	 *
> +	 * In this case only X, Y, and Z are pressed, but g appears to be
> +	 * pressed too (see Wikipedia).
> +	 *
> +	 * We can detect ghosting in a single pass (*) over the keyboard st=
ate
> +	 * by maintaining two arrays.  pressed_in_row counts how many press=
ed
> +	 * keys we have found in a row.  row_has_teeth is true if any of th=
e
> +	 * pressed keys for this row has other pressed keys in its column. =
 If
> +	 * at any point of the scan we find that a row has multiple pressed
> +	 * keys, and at least one of them is at the intersection with a col=
umn
> +	 * with multiple pressed keys, we're sure there is ghosting.
> +	 * Conversely, if there is ghosting, we will detect such situation =
for
> +	 * at least one key during the pass.
> +	 *
> +	 * (*) This looks linear in the number of keys, but it's not.  We c=
an
> +	 * cheat because the number of rows is small.
> +	 */
> +	for (row =3D 0; row < ckdev->rows; row++) {
> +		if (cros_ec_keyb_row_has_ghosting(ckdev, buf, row))
> +			return true;
> +	}
> +
> +	return false;
> +}

are you sure your EC's firmware did not do ghost-key detection?
or, did you test ghost-key with/without your own ghost-key detection?
as far as I know, ghost-key should be take care either by keyboard
designer or firmware.

> +
> +/*
> + * Compares the new keyboard state to the old one and produces key
> + * press/release events accordingly.  The keyboard state is 13 bytes=
 (one byte
> + * per column)
> + */
> +static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
> +			 uint8_t *kb_state, int len)
> +{
> +	int col, row;
> +	int new_state;
> +	int num_cols;
> +
> +	num_cols =3D len;
> +
> +	if (ckdev->ghost_filter && cros_ec_keyb_has_ghosting(ckdev, kb_stat=
e)) {
> +		/*
> +		 * Simple-minded solution: ignore this state. The obvious
> +		 * improvement is to only ignore changes to keys involved in
> +		 * the ghosting, but process the other changes.
> +		 */
> +		dev_dbg(ckdev->dev, "ghosting found\n");
> +		return;
> +	}
> +
> +	for (col =3D 0; col < ckdev->cols; col++) {
> +		for (row =3D 0; row < ckdev->rows; row++) {
> +			int code =3D MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
> +
> +			new_state =3D kb_state[col] & (1 << row);
> +			if (!!new_state !=3D test_bit(code, ckdev->idev->key)) {
> +				dev_dbg(ckdev->dev,
> +					"changed: [r%d c%d]: byte %02x\n",
> +					row, col, new_state);
> +
> +				input_report_key(ckdev->idev, code, new_state);
> +			}
> +		}
> +	}
> +	input_sync(ckdev->idev);
> +}
> +
> +static int cros_ec_keyb_open(struct input_dev *dev)
> +{
> +	struct cros_ec_keyb *ckdev =3D input_get_drvdata(dev);
> +
> +	return blocking_notifier_chain_register(&ckdev->ec->event_notifier,
> +						&ckdev->notifier);
> +}
> +
> +static void cros_ec_keyb_close(struct input_dev *dev)
> +{
> +	struct cros_ec_keyb *ckdev =3D input_get_drvdata(dev);
> +
> +	blocking_notifier_chain_unregister(&ckdev->ec->event_notifier,
> +					   &ckdev->notifier);
> +}
> +
> +static int cros_ec_keyb_get_state(struct cros_ec_keyb *ckdev, uint8_=
t *kb_state)
> +{
> +	return ckdev->ec->command_recv(ckdev->ec, EC_CMD_MKBP_STATE,
> +					  kb_state, ckdev->cols);
> +}
> +
> +static int cros_ec_keyb_work(struct notifier_block *nb,
> +		     unsigned long state, void *_notify)
> +{
> +	int ret;
> +	struct cros_ec_keyb *ckdev =3D container_of(nb, struct cros_ec_keyb=
,
> +						    notifier);
> +	uint8_t kb_state[ckdev->cols];
> +
> +	ret =3D cros_ec_keyb_get_state(ckdev, kb_state);
> +	if (ret >=3D 0)
> +		cros_ec_keyb_process(ckdev, kb_state, ret);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +/* Clear any keys in the buffer */
> +static void cros_ec_keyb_clear_keyboard(struct cros_ec_keyb *ckdev)
> +{
> +	uint8_t old_state[ckdev->cols];
> +	uint8_t new_state[ckdev->cols];
> +	unsigned long duration;
> +	int i, ret;
> +
> +	/*
> +	 * Keep reading until we see that the scan state does not change.
> +	 * That indicates that we are done.
> +	 *
> +	 * Assume that the EC keyscan buffer is at most 32 deep.
> +	 */
> +	duration =3D jiffies;
> +	ret =3D cros_ec_keyb_get_state(ckdev, new_state);
> +	for (i =3D 1; !ret && i < 32; i++) {
> +		memcpy(old_state, new_state, sizeof(old_state));
> +		ret =3D cros_ec_keyb_get_state(ckdev, new_state);
> +		if (0 =3D=3D memcmp(old_state, new_state, sizeof(old_state)))
> +			break;
> +	}
> +	duration =3D jiffies - duration;
> +	dev_info(ckdev->dev, "Discarded %d keyscan(s) in %dus\n", i,
> +		jiffies_to_usecs(duration));
> +}
> +
> +static int cros_ec_keyb_probe(struct platform_device *pdev)
> +{
> +	struct cros_ec_device *ec =3D dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev =3D ec->dev;
> +	struct cros_ec_keyb *ckdev =3D NULL;
> +	struct input_dev *idev =3D NULL;
> +	struct device_node *np;
> +	int err;
> +
> +	np =3D pdev->dev.of_node;
> +	if (!np)
> +		return -ENODEV;
> +
> +	ckdev =3D kzalloc(sizeof(*ckdev), GFP_KERNEL);
> +	if (!ckdev) {
> +		dev_err(dev, "cannot allocate memory for ckdev\n");
> +		return -ENOMEM;
> +	}
> +	err =3D matrix_keypad_parse_of_params(&pdev->dev, &ckdev->rows,
> +					    &ckdev->cols);
> +	if (err)
> +		goto fail_alloc_dev;
> +
> +	idev =3D input_allocate_device();
> +	if (!idev) {
> +		err =3D -ENOMEM;
> +		dev_err(dev, "cannot allocate memory for input device\n");
> +		goto fail_alloc_dev;
> +	}
> +
> +	ckdev->ec =3D ec;
> +	ckdev->notifier.notifier_call =3D cros_ec_keyb_work;
> +	ckdev->dev =3D dev;
> +	dev_set_drvdata(&pdev->dev, ckdev);
> +
> +	idev->name =3D ec->get_name(ec);
> +	idev->phys =3D ec->get_phys_name(ec);
> +	__set_bit(EV_REP, idev->evbit);
> +
> +	idev->id.bustype =3D BUS_VIRTUAL;
> +	idev->id.version =3D 1;
> +	idev->id.product =3D 0;
> +	idev->dev.parent =3D &pdev->dev;
> +	idev->open =3D cros_ec_keyb_open;
> +	idev->close =3D cros_ec_keyb_close;
> +
> +	ckdev->ghost_filter =3D of_property_read_bool(np,
> +					"google,needs-ghost-filter");
> +
> +	err =3D matrix_keypad_build_keymap(NULL, NULL, ckdev->rows, ckdev->=
cols,
> +					 NULL, idev);
> +	if (err) {
> +		dev_err(dev, "cannot build key matrix\n");
> +		goto fail_matrix;
> +	}
> +
> +	ckdev->row_shift =3D get_count_order(ckdev->cols);
> +
> +	input_set_capability(idev, EV_MSC, MSC_SCAN);
> +	input_set_drvdata(idev, ckdev);
> +	ckdev->idev =3D idev;
> +	err =3D input_register_device(ckdev->idev);
> +	if (err) {
> +		dev_err(dev, "cannot register input device\n");
> +		goto fail_register;
> +	}
> +
> +	return 0;
> +
> +fail_register:
> +	kfree(idev->keycode);
> +fail_matrix:
> +	input_free_device(idev);
> +fail_alloc_dev:
> +	kfree(ckdev);
> +	return err;
> +}
> +
> +static int cros_ec_keyb_remove(struct platform_device *pdev)
> +{
> +	struct cros_ec_keyb *ckdev =3D platform_get_drvdata(pdev);
> +	struct input_dev *idev =3D ckdev->idev;
> +
> +	input_unregister_device(idev);
> +	kfree(ckdev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int cros_ec_keyb_resume(struct device *dev)
> +{
> +	struct cros_ec_keyb *ckdev =3D dev_get_drvdata(dev);
> +
> +	/*
> +	 * When the EC is not a wake source, then it could not have caused =
the
> +	 * resume, so we clear the EC's key scan buffer. If the EC was a
> +	 * wake source (e.g. the lid is open and the user might press a key=
 to
> +	 * wake) then the key scan buffer should be preserved.
> +	 */
> +	if (ckdev->ec->was_wake_device)
> +		cros_ec_keyb_clear_keyboard(ckdev);
> +
> +	return 0;
> +}
> +
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(cros_ec_keyb_pm_ops, NULL, cros_ec_keyb_res=
ume);
> +
> +static struct platform_driver cros_ec_keyb_driver =3D {
> +	.probe =3D cros_ec_keyb_probe,
> +	.remove =3D cros_ec_keyb_remove,
> +	.driver =3D {
> +		.name =3D "cros-ec-keyb",
> +		.pm	=3D &cros_ec_keyb_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(cros_ec_keyb_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS EC keyboard driver");
> +MODULE_ALIAS("platform:cros-ec-keyb");


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

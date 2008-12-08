From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch 2.6.28-rc6-davinci1 5/6] dm355evm input driver
Date: Mon, 8 Dec 2008 23:41:38 +0200
Message-ID: <20081208214138.GH13076@frodo>
References: <200812071159.50267.david-b@pacbell.net> <20081207202128.GA9629@frodo> <200812071228.38475.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:49227 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbYLHVlr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Dec 2008 16:41:47 -0500
Content-Disposition: inline
In-Reply-To: <200812071228.38475.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, Felipe Balbi <felipebalbi@users.sourceforge.net>

On Sun, Dec 07, 2008 at 12:28:38PM -0800, David Brownell wrote:
> On Sunday 07 December 2008, Felipe Balbi wrote:
> > > +=A0=A0=A0=A0=A0platform_set_drvdata(pdev, keys);
> > > +=A0=A0=A0=A0=A0keys->pdev =3D pdev;
> >=20
> > you could be holding only the device pointer.
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A0keys->dev =3D &pdev->dev;
> >=20
> > then, if you really happen to need the pdev pointer you can use
> >=20
> > to_platform_device(keys->dev);
>=20
> True, that would be a bit simpler; the device handle is what's
> normally needed, e.g. for dev_dbg().  I'd take an update patch;
> but for now I'll avoid a re-test cycle.  :)

Here's an update patch for your input driver:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D cut here =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

diff --git a/drivers/input/keyboard/dm355evm_keys.c b/drivers/input/key=
board/dm355evm_keys.c
index ed36127..0871d9c 100644
--- a/drivers/input/keyboard/dm355evm_keys.c
+++ b/drivers/input/keyboard/dm355evm_keys.c
@@ -33,7 +33,7 @@
 struct dm355evm_keys {
 	struct work_struct	work;
 	struct input_dev	*input;
-	struct platform_device	*pdev;
+	struct device		*dev;
 	int			irq;
 };
=20
@@ -128,7 +128,7 @@ static void dm355evm_keys_work(struct work_struct *=
work)
=20
 		status =3D dm355evm_msp_read(DM355EVM_MSP_INPUT_HIGH);
 		if (status < 0) {
-			dev_dbg(&keys->pdev->dev, "input high err %d\n",
+			dev_dbg(keys->dev, "input high err %d\n",
 					status);
 			break;
 		}
@@ -136,7 +136,7 @@ static void dm355evm_keys_work(struct work_struct *=
work)
=20
 		status =3D dm355evm_msp_read(DM355EVM_MSP_INPUT_LOW);
 		if (status < 0) {
-			dev_dbg(&keys->pdev->dev, "input low err %d\n",
+			dev_dbg(keys->dev, "input low err %d\n",
 					status);
 			break;
 		}
@@ -155,7 +155,7 @@ static void dm355evm_keys_work(struct work_struct *=
work)
 			keycode =3D dm355evm_keys[i].keycode;
 			break;
 		}
-		dev_dbg(&keys->pdev->dev,
+		dev_dbg(keys->dev,
 			"input event 0x%04x--> keycode %d\n",
 			event, keycode);
=20
@@ -200,7 +200,7 @@ static int __devinit dm355evm_keys_probe(struct pla=
tform_device *pdev)
 	if (!keys)
 		goto fail0;
 	platform_set_drvdata(pdev, keys);
-	keys->pdev =3D pdev;
+	keys->dev =3D &pdev->dev;
=20
 	/* ... and input dev ... */
 	input =3D input_allocate_device();
@@ -257,6 +257,7 @@ fail1:
 fail0:
 	kfree(keys);
 	dev_err(&pdev->dev, "can't register, err %d\n", status);
+
 	return status;
 }
=20
@@ -267,6 +268,7 @@ static int __devexit dm355evm_keys_remove(struct pl=
atform_device *pdev)
 	free_irq(keys->irq, keys);
 	input_unregister_device(keys->input);
 	kfree(keys);
+
 	return 0;
 }
=20

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

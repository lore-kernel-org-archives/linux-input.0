From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] input: Add keypad support for w90p910 evb
Date: Thu, 9 Jul 2009 12:46:19 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901A68B96@mi8nycmail19.Mi8.com>
References: <4A546443.9030907@gmail.com>	 <5d5443650907080332t4156cabdu267d28c6c486f372@mail.gmail.com>	 <4A55901B.6070805@gmail.com> <5d5443650907082347i40f5f39bn63e2683046155eb@mail.gmail.com> <4A55B8E0.6020909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og112.obsmtp.com ([64.18.1.29]:53433 "HELO
	exprod6og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759260AbZGIQqW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 12:46:22 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4A55B8E0.6020909@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>, Trilok Soni <soni.trilok@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

On Thursday, July 09, 2009 2:31 AM, Wan ZongShun wrote:
> Dear sirs,
> 
> According to Trilok's suggestion, I fixed up my driver and
> resubmitted it.
> 
> patch text:
> 
> Add w90p910 keypad driver for w90p910 evalution board
> based on w90p910,there is a 4X4 keypad on my board.
> 
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
>
> ---
+
+#define keypad_readl(off)	__raw_readl(keypad->mmio_base + (off))
+#define keypad_writel(off, v)	__raw_writel((v), keypad->mmio_base + (off))
+

You might want to make these two macro's inline functions instead.

Depending on having the local variable 'keypad' is prone to breakage.
See Documentation/CodingStyle, Chapter 12.

+	input_dev->name = pdev->name;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->open = w90p910_keypad_open;
+	input_dev->close = w90p910_keypad_close;
+	input_dev->dev.parent = &pdev->dev;

If you add the following the keymap can be changed from userspace:

	input_dev->keycode = keypad->matrix_keycodes;
	input_dev->keycodesize = sizeof(keypad->matrix_keycodes[0]);
	input_dev->keycodemax = ARRAY_SIZE(keypad->matrix_keycodes);

Regards,
Hartley

From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v3] input: Add keypad driver for w90p910
Date: Mon, 10 Aug 2009 11:44:34 +0800
Message-ID: <e68bb3470908092044x337f2f2ch10c7bdff79a5533c@mail.gmail.com>
References: <4A5C6D2A.7040501@gmail.com>
	 <20090810020638.6B2EE526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:53620 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbZHJDoe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Aug 2009 23:44:34 -0400
Received: by pzk34 with SMTP id 34so2632160pzk.4
        for <linux-input@vger.kernel.org>; Sun, 09 Aug 2009 20:44:34 -0700 (PDT)
In-Reply-To: <20090810020638.6B2EE526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, "Eric.miao" <eric.y.miao@gmail.com>, H Hartley Sweeten <hartleys@visionengravers.com>, Trilok Soni <soni.trilok@gmail.com>

Dear Dmitry,

I have tested this patch, and it work very well.
Thank you for helping me fix my keypad driver and I appreciate this kin=
dness.

2009/8/10 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Wan,
>
> On Tue, Jul 14, 2009 at 07:34:02PM +0800, Wan ZongShun wrote:
>> Dear Dmitry,
>>
>> This is a latest keypad driver, according to your and H Hartley's
>> advice, I fixed up my keypad driver again and merge this header file
>> patch to keypad driver patch.
>>
>
> I was waiting for the matrix_keypad code to settle before applying yo=
ur
> drive; now that it has settled I ajusted w90p910_keypad to use
> definitions from include/linux/input/matrix_keypad.h and I am ready t=
o
> apply it to my tree.
>
> Could you please try the patch below to verify that I did not break
> anything (you'll have to pull the latest Linus tree to get the correc=
t
> bits of matrix_keypad)?
>
> Thanks!
>
> --
> Dmitry
>
> Input: w90p910_keypad - adjust to use definitions from matrix_keypad.=
h
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Also have the driver send MSC_SCAN events as most keyboards do to aid
> in updating keymap from userspace.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =C2=A0.../arm/mach-w90x900/include/mach/w90p910_keypad.h | =C2=A0 =C2=
=A05 -
> =C2=A0drivers/input/keyboard/w90p910_keypad.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0144 +++++++++-----------
> =C2=A02 files changed, 66 insertions(+), 83 deletions(-)
>
>
> diff --git a/arch/arm/mach-w90x900/include/mach/w90p910_keypad.h b/ar=
ch/arm/mach-w90x900/include/mach/w90p910_keypad.h
> index 79462fa..556778e 100644
> --- a/arch/arm/mach-w90x900/include/mach/w90p910_keypad.h
> +++ b/arch/arm/mach-w90x900/include/mach/w90p910_keypad.h
> @@ -6,13 +6,10 @@
> =C2=A0extern void mfp_set_groupi(struct device *dev);
>
> =C2=A0struct w90p910_keypad_platform_data {
> + =C2=A0 =C2=A0 =C2=A0 const struct matrix_keymap_data *keymap_data;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0prescale;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0debounce;
> - =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0matrix_key_rows;
> - =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0matrix_key_cols;
> - =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0*matrix_key_map;
> - =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
matrix_key_map_size;
> =C2=A0};
>
> =C2=A0#endif /* __ASM_ARCH_W90P910_KEYPAD_H */
> diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/=
keyboard/w90p910_keypad.c
> index 472c705..24096cd 100644
> --- a/drivers/input/keyboard/w90p910_keypad.c
> +++ b/drivers/input/keyboard/w90p910_keypad.c
> @@ -41,58 +41,34 @@
> =C2=A0#define KGET_RAW(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((=
(n) & KEY0R) >> 3)
> =C2=A0#define KGET_COLUMN(n) =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((n) & KEY0C=
)
>
> -#define MAX_MATRIX_KEY_NUM =C2=A0 =C2=A0 (8 * 8)
> +#define W90P910_MAX_KEY_NUM =C2=A0 =C2=A0(8 * 8)
> +#define W90P910_ROW_SHIFT =C2=A0 =C2=A0 =C2=A03
>
> =C2=A0struct w90p910_keypad {
> - =C2=A0 =C2=A0 =C2=A0 struct w90p910_keypad_platform_data *pdata;
> + =C2=A0 =C2=A0 =C2=A0 const struct w90p910_keypad_platform_data *pda=
ta;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk *clk;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct input_dev *input_dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *mmio_base;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq;
> - =C2=A0 =C2=A0 =C2=A0 unsigned int matrix_keycodes[MAX_MATRIX_KEY_NU=
M];
> + =C2=A0 =C2=A0 =C2=A0 unsigned short keymap[W90P910_MAX_KEY_NUM];
> =C2=A0};
>
> -static void w90p910_keypad_build_keycode(struct w90p910_keypad *keyp=
ad)
> -{
> - =C2=A0 =C2=A0 =C2=A0 struct w90p910_keypad_platform_data *pdata =3D=
 keypad->pdata;
> - =C2=A0 =C2=A0 =C2=A0 struct input_dev *input_dev =3D keypad->input_=
dev;
> - =C2=A0 =C2=A0 =C2=A0 unsigned int *key;
> - =C2=A0 =C2=A0 =C2=A0 int i;
> -
> - =C2=A0 =C2=A0 =C2=A0 key =3D &pdata->matrix_key_map[0];
> - =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < pdata->matrix_key_map_size; =
i++, key++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int row =3D KEY_RO=
W(*key);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int col =3D KEY_CO=
L(*key);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int code =3D KEY_V=
AL(*key);
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad->matrix_key=
codes[(row << 3) + col] =3D code;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __set_bit(code, in=
put_dev->keybit);
> - =C2=A0 =C2=A0 =C2=A0 }
> -}
> -
> -static inline unsigned int lookup_matrix_keycode(
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct w90p910_key=
pad *keypad, int row, int col)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return keypad->matrix_keycodes[(row << 3) + co=
l];
> -}
> -
> =C2=A0static void w90p910_keypad_scan_matrix(struct w90p910_keypad *k=
eypad,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int sta=
tus)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 unsigned int row, col, val;
> -
> - =C2=A0 =C2=A0 =C2=A0 row =3D KGET_RAW(status);
> - =C2=A0 =C2=A0 =C2=A0 col =3D KGET_COLUMN(status);
> -
> - =C2=A0 =C2=A0 =C2=A0 val =3D lookup_matrix_keycode(keypad, row, col=
);
> -
> - =C2=A0 =C2=A0 =C2=A0 input_report_key(keypad->input_dev, val, 1);
> -
> - =C2=A0 =C2=A0 =C2=A0 input_sync(keypad->input_dev);
> -
> - =C2=A0 =C2=A0 =C2=A0 input_report_key(keypad->input_dev, val, 0);
> -
> - =C2=A0 =C2=A0 =C2=A0 input_sync(keypad->input_dev);
> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *input_dev =3D keypad->input_=
dev;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int row =3D KGET_RAW(status);
> + =C2=A0 =C2=A0 =C2=A0 unsigned int col =3D KGET_COLUMN(status);
> + =C2=A0 =C2=A0 =C2=A0 unsigned int code =3D MATRIX_SCAN_CODE(row, co=
l, W90P910_ROW_SHIFT);
> + =C2=A0 =C2=A0 =C2=A0 unsigned int key =3D keypad->keymap[code];
> +
> + =C2=A0 =C2=A0 =C2=A0 input_event(input_dev, EV_MSC, MSC_SCAN, code)=
;
> + =C2=A0 =C2=A0 =C2=A0 input_report_key(input_dev, key, 1);
> + =C2=A0 =C2=A0 =C2=A0 input_sync(input_dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 input_event(input_dev, EV_MSC, MSC_SCAN, code)=
;
> + =C2=A0 =C2=A0 =C2=A0 input_report_key(input_dev, key, 0);
> + =C2=A0 =C2=A0 =C2=A0 input_sync(input_dev);
> =C2=A0}
>
> =C2=A0static irqreturn_t w90p910_keypad_irq_handler(int irq, void *de=
v_id)
> @@ -113,7 +89,7 @@ static irqreturn_t w90p910_keypad_irq_handler(int =
irq, void *dev_id)
> =C2=A0static int w90p910_keypad_open(struct input_dev *dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct w90p910_keypad *keypad =3D input_ge=
t_drvdata(dev);
> - =C2=A0 =C2=A0 =C2=A0 struct w90p910_keypad_platform_data *pdata =3D=
 keypad->pdata;
> + =C2=A0 =C2=A0 =C2=A0 const struct w90p910_keypad_platform_data *pda=
ta =3D keypad->pdata;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int val, config;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Enable unit clock */
> @@ -142,31 +118,39 @@ static void w90p910_keypad_close(struct input_d=
ev *dev)
>
> =C2=A0static int __devinit w90p910_keypad_probe(struct platform_devic=
e *pdev)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 const struct w90p910_keypad_platform_data *pda=
ta =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 pdev->dev.platform_data;
> + =C2=A0 =C2=A0 =C2=A0 const struct matrix_keymap_data *keymap_data =3D=
 pdata->keymap_data;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct w90p910_keypad *keypad;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct input_dev *input_dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *res;
> - =C2=A0 =C2=A0 =C2=A0 int irq, error;
> -
> - =C2=A0 =C2=A0 =C2=A0 keypad =3D kzalloc(sizeof(struct w90p910_keypa=
d), GFP_KERNEL);
> - =C2=A0 =C2=A0 =C2=A0 if (keypad =3D=3D NULL) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "failed to allocate driver data\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 int irq;
> + =C2=A0 =C2=A0 =C2=A0 int error;
> + =C2=A0 =C2=A0 =C2=A0 int i;
>
> - =C2=A0 =C2=A0 =C2=A0 keypad->pdata =3D pdev->dev.platform_data;
> - =C2=A0 =C2=A0 =C2=A0 if (keypad->pdata =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 if (!pdata) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&pdev-=
>dev, "no platform data defined\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D -EINVAL;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto failed_free;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0irq =3D platform_get_irq(pdev, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (irq < 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&pdev-=
>dev, "failed to get keypad irq\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D -ENXIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENXIO;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 keypad =3D kzalloc(sizeof(struct w90p910_keypa=
d), GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 input_dev =3D input_allocate_device();
> + =C2=A0 =C2=A0 =C2=A0 if (!keypad || !input_dev) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "failed to allocate driver data\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D -ENOMEM;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed_fr=
ee;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 keypad->pdata =3D pdata;
> + =C2=A0 =C2=A0 =C2=A0 keypad->input_dev =3D input_dev;
> + =C2=A0 =C2=A0 =C2=A0 keypad->irq =3D irq;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource(pdev, IORESO=
URCE_MEM, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res =3D=3D NULL) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&pdev-=
>dev, "failed to get I/O memory\n");
> @@ -185,7 +169,7 @@ static int __devinit w90p910_keypad_probe(struct =
platform_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (keypad->mmio_base =3D=3D NULL) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&pdev-=
>dev, "failed to remap I/O memory\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D -ENX=
IO;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto failed_free_m=
em;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto failed_free_r=
es;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0keypad->clk =3D clk_get(&pdev->dev, NULL);
> @@ -195,14 +179,6 @@ static int __devinit w90p910_keypad_probe(struct=
 platform_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed_fr=
ee_io;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 /* Create and register the input driver. */
> - =C2=A0 =C2=A0 =C2=A0 input_dev =3D input_allocate_device();
> - =C2=A0 =C2=A0 =C2=A0 if (!input_dev) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "failed to allocate input device\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D -ENOMEM;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto failed_put_cl=
k;
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set multi-function pin for w90p910 kpi.=
 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mfp_set_groupi(&pdev->dev);
>
> @@ -211,26 +187,37 @@ static int __devinit w90p910_keypad_probe(struc=
t platform_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0input_dev->open =3D w90p910_keypad_open;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0input_dev->close =3D w90p910_keypad_close;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0input_dev->dev.parent =3D &pdev->dev;
> - =C2=A0 =C2=A0 =C2=A0 input_dev->keycode =3D keypad->matrix_keycodes=
;
> - =C2=A0 =C2=A0 =C2=A0 input_dev->keycodesize =3D sizeof(keypad->matr=
ix_keycodes[0]);
> - =C2=A0 =C2=A0 =C2=A0 input_dev->keycodemax =3D ARRAY_SIZE(keypad->m=
atrix_keycodes);
>
> - =C2=A0 =C2=A0 =C2=A0 keypad->input_dev =3D input_dev;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->keycode =3D keypad->keymap;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->keycodesize =3D sizeof(keypad->keym=
ap[0]);
> + =C2=A0 =C2=A0 =C2=A0 input_dev->keycodemax =3D ARRAY_SIZE(keypad->k=
eymap);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0input_set_drvdata(input_dev, keypad);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0input_dev->evbit[0] =3D BIT_MASK(EV_KEY) |=
 BIT_MASK(EV_REP);
> - =C2=A0 =C2=A0 =C2=A0 w90p910_keypad_build_keycode(keypad);
> - =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, keypad);
> + =C2=A0 =C2=A0 =C2=A0 input_set_capability(input_dev, EV_MSC, MSC_SC=
AN);
> +
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < keymap_data->keymap_size; i+=
+) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int key =3D=
 keymap_data->keymap[i];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int row =3D=
 KEY_ROW(key);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int col =3D=
 KEY_COL(key);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned short key=
code =3D KEY_VAL(key);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int scanc=
ode =3D MATRIX_SCAN_CODE(row, col,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0W90P910_ROW_SHIF=
T);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad->keymap[sca=
ncode] =3D keycode;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __set_bit(keycode,=
 input_dev->keybit);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 __clear_bit(KEY_RESERVED, input_dev->keybit);
> +
>
> - =C2=A0 =C2=A0 =C2=A0 error =3D request_irq(irq, w90p910_keypad_irq_=
handler, IRQF_DISABLED,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pdev->name, keypad);
> + =C2=A0 =C2=A0 =C2=A0 error =3D request_irq(keypad->irq, w90p910_key=
pad_irq_handler,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 IRQF_DISABLED, pdev->name, keypad);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (error) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&pdev-=
>dev, "failed to request IRQ\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto failed_free_d=
ev;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto failed_put_cl=
k;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 keypad->irq =3D irq;
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Register the input device */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D input_register_device(input_dev)=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (error) {
> @@ -238,20 +225,19 @@ static int __devinit w90p910_keypad_probe(struc=
t platform_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed_fr=
ee_irq;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, keypad);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> =C2=A0failed_free_irq:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0free_irq(irq, pdev);
> - =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, NULL);
> -failed_free_dev:
> - =C2=A0 =C2=A0 =C2=A0 input_free_device(input_dev);
> =C2=A0failed_put_clk:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_put(keypad->clk);
> =C2=A0failed_free_io:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iounmap(keypad->mmio_base);
> -failed_free_mem:
> +failed_free_res:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0release_mem_region(res->start, resource_si=
ze(res));
> =C2=A0failed_free:
> + =C2=A0 =C2=A0 =C2=A0 input_free_device(input_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(keypad);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return error;
> =C2=A0}
> @@ -268,12 +254,12 @@ static int __devexit w90p910_keypad_remove(stru=
ct platform_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0input_unregister_device(keypad->input_dev)=
;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iounmap(keypad->mmio_base);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource(pdev, IORESO=
URCE_MEM, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0release_mem_region(res->start, resource_si=
ze(res));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(keypad);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
>



--=20
Wan z.s
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

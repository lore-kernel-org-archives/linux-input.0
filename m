From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [RESEND/PATCHv5 1/2] drivers: input: keypad: Add device tree
 support
Date: Fri, 15 Jun 2012 20:23:27 +0530
Message-ID: <CAKdam56hwc7_cbL8OSwhTQ8XgiK28qvSTYy-ZkoxjxvOpt0xoA@mail.gmail.com>
References: <1339152780-25301-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7406619085817663414=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1339152780-25301-1-git-send-email-sourav.poddar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree-discuss@lists.ozlabs.org, Dmitry Torokhov <dtor@mail.ru>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Randy Dunlap <rdunlap@xenotime.net>, Felipe Balbi <balbi@ti.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, sourav.poddar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

--===============7406619085817663414==
Content-Type: multipart/alternative; boundary=000e0cd4bdc892355904c283fab9

--000e0cd4bdc892355904c283fab9
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

Gentle Ping on this...

~Sourav

On Fri, Jun 8, 2012 at 4:22 PM, Sourav Poddar <sourav.poddar@ti.com> wrote:

> Update the Documentation with omap4 keypad device tree
> binding information.
> Add device tree support for omap4 keypad driver.
>
> Tested on omap4430 sdp.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Cc: Randy Dunlap <rdunlap@xenotime.net>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
> changes since v4:
> - Developed it on top of dmitry's 'next' branch due to
> dependency on generic "matrix_keypad_build_keymap" api
> patches queued in that branch
> - Adapted the driver to fill "keymap" in device tree
> using "matrix_keypad_build_keymap" api defined in
> drivers/input/matrix-keymap.c
>  .../devicetree/bindings/input/omap-keypad.txt      |   31 ++++++
>  drivers/input/keyboard/omap4-keypad.c              |  108
> +++++++++++++++-----
>  2 files changed, 111 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/omap-keypad.txt
>
> diff --git a/Documentation/devicetree/bindings/input/omap-keypad.txt
> b/Documentation/devicetree/bindings/input/omap-keypad.txt
> new file mode 100644
> index 0000000..722425b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/omap-keypad.txt
> @@ -0,0 +1,31 @@
> +* TI's Keypad Controller device tree bindings
> +
> +TI's Keypad controller is used to interface a SoC with a matrix-type
> +keypad device. The keypad controller supports multiple row and column
> lines.
> +A key can be placed at each intersection of a unique row and a unique
> column.
> +The keypad controller can sense a key-press and key-release and report the
> +event using a interrupt to the cpu.
> +
> +Required SoC Specific Properties:
> +- compatible: should be one of the following
> +   - "ti,omap4-keypad": For controllers compatible with omap4 keypad
> +      controller.
> +
> +Required Board Specific Properties, in addition to those specified by
> +the shared matrix-keyboard bindings:
> +- keypad,num-rows: Number of row lines connected to the keypad
> +  controller.
> +
> +- keypad,num-columns: Number of column lines connected to the
> +  keypad controller.
> +
> +Optional Properties specific to linux:
> +- linux,keypad-no-autorepeat: do no enable autorepeat feature.
> +
> +Example:
> +        keypad@4ae1c000{
> +                compatible = "ti,omap4-keypad";
> +                keypad,num-rows = <2>;
> +                keypad,num-columns = <8>;
> +               linux,keypad-no-autorepeat;
> +       };
> diff --git a/drivers/input/keyboard/omap4-keypad.c
> b/drivers/input/keyboard/omap4-keypad.c
> index aed5f69..d5a2d1a 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -27,6 +27,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
>  #include <linux/input.h>
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
> @@ -75,6 +76,7 @@ enum {
>
>  struct omap4_keypad {
>        struct input_dev *input;
> +       struct matrix_keymap_data *keymap_data;
>
>        void __iomem *base;
>        unsigned int irq;
> @@ -84,6 +86,7 @@ struct omap4_keypad {
>        u32 reg_offset;
>        u32 irqreg_offset;
>        unsigned int row_shift;
> +       bool no_autorepeat;
>        unsigned char key_state[8];
>        unsigned short keymap[];
>  };
> @@ -208,25 +211,74 @@ static void omap4_keypad_close(struct input_dev
> *input)
>        pm_runtime_put_sync(input->dev.parent);
>  }
>
> +static struct omap4_keypad *omap_keypad_parse_dt(struct device *dev,
> +                               uint32_t rows, uint32_t cols,
> +                               struct input_dev *input_dev)
> +{
> +       struct device_node *np = dev->of_node;
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct omap4_keypad *keypad_data = platform_get_drvdata(pdev);
> +       int error;
> +
> +       error = matrix_keypad_build_keymap(NULL, "linux,keymap",
> +                               rows, cols, keypad_data->keymap,
> input_dev);
> +       if (error) {
> +               dev_err(&pdev->dev, "failed to build keymap\n");
> +               input_free_device(input_dev);
> +       }
> +
> +       if (of_get_property(np, "linux,input-no-autorepeat", NULL))
> +               keypad_data->no_autorepeat = true;
> +
> +       return keypad_data;
> +}
> +
>  static int __devinit omap4_keypad_probe(struct platform_device *pdev)
>  {
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
>        const struct omap4_keypad_platform_data *pdata;
>        struct omap4_keypad *keypad_data;
>        struct input_dev *input_dev;
>        struct resource *res;
>        resource_size_t size;
> -       unsigned int row_shift, max_keys;
> +       unsigned int row_shift = 0, max_keys = 0;
> +       uint32_t num_rows = 0, num_cols = 0;
>        int rev;
>        int irq;
>        int error;
>
>        /* platform data */
>        pdata = pdev->dev.platform_data;
> -       if (!pdata) {
> +       if (np) {
> +               of_property_read_u32(np, "keypad,num-rows", &num_rows);
> +               of_property_read_u32(np, "keypad,num-columns", &num_cols);
> +               if (!num_rows || !num_cols) {
> +                       dev_err(&pdev->dev, "number of keypad rows/columns
> not specified\n");
> +                       return -EINVAL;
> +               }
> +       } else if (pdata) {
> +               num_rows = pdata->rows;
> +               num_cols = pdata->cols;
> +       } else {
>                dev_err(&pdev->dev, "no platform data defined\n");
>                return -EINVAL;
>        }
>
> +       row_shift = get_count_order(num_cols);
> +       max_keys = num_rows << row_shift;
> +
> +       keypad_data = devm_kzalloc(dev, sizeof(struct omap4_keypad) +
> +                       max_keys * sizeof(keypad_data->keymap[0]),
> +                               GFP_KERNEL);
> +
> +       if (!keypad_data) {
> +               dev_err(&pdev->dev, "keypad_data memory allocation
> failed\n");
> +               return -ENOMEM;
> +       }
> +
> +       platform_set_drvdata(pdev, keypad_data);
> +
>        res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>        if (!res) {
>                dev_err(&pdev->dev, "no base address specified\n");
> @@ -239,22 +291,6 @@ static int __devinit omap4_keypad_probe(struct
> platform_device *pdev)
>                return -EINVAL;
>        }
>
> -       if (!pdata->keymap_data) {
> -               dev_err(&pdev->dev, "no keymap data defined\n");
> -               return -EINVAL;
> -       }
> -
> -       row_shift = get_count_order(pdata->cols);
> -       max_keys = pdata->rows << row_shift;
> -
> -       keypad_data = kzalloc(sizeof(struct omap4_keypad) +
> -                               max_keys * sizeof(keypad_data->keymap[0]),
> -                             GFP_KERNEL);
> -       if (!keypad_data) {
> -               dev_err(&pdev->dev, "keypad_data memory allocation
> failed\n");
> -               return -ENOMEM;
> -       }
> -
>        size = resource_size(res);
>
>        res = request_mem_region(res->start, size, pdev->name);
> @@ -271,10 +307,10 @@ static int __devinit omap4_keypad_probe(struct
> platform_device *pdev)
>                goto err_release_mem;
>        }
>
> +       keypad_data->rows = num_rows;
> +       keypad_data->cols = num_cols;
>        keypad_data->irq = irq;
>        keypad_data->row_shift = row_shift;
> -       keypad_data->rows = pdata->rows;
> -       keypad_data->cols = pdata->cols;
>
>        /*
>        * Enable clocks for the keypad module so that we can read
> @@ -322,15 +358,25 @@ static int __devinit omap4_keypad_probe(struct
> platform_device *pdev)
>        input_dev->open = omap4_keypad_open;
>        input_dev->close = omap4_keypad_close;
>
> -       error = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
> -                                          pdata->rows, pdata->cols,
> -                                          keypad_data->keymap, input_dev);
> -       if (error) {
> -               dev_err(&pdev->dev, "failed to build keymap\n");
> -               goto err_free_input;
> +       if (np) {
> +               keypad_data = omap_keypad_parse_dt(&pdev->dev,
> +                               keypad_data->rows, keypad_data->cols,
> +                               input_dev);
> +       } else {
> +               keypad_data->keymap_data =
> +                       (struct matrix_keymap_data *)pdata->keymap_data;
> +               error =
> matrix_keypad_build_keymap(keypad_data->keymap_data,
> +                               NULL, keypad_data->rows, keypad_data->cols,
> +                               keypad_data->keymap, input_dev);
> +               if (error) {
> +                       dev_err(&pdev->dev, "failed to build keymap\n");
> +                       goto err_free_input;
> +               }
>        }
>
> -       __set_bit(EV_REP, input_dev->evbit);
> +       if (!keypad_data->no_autorepeat)
> +               __set_bit(EV_REP, input_dev->evbit);
> +
>        input_set_capability(input_dev, EV_MSC, MSC_SCAN);
>
>        input_set_drvdata(input_dev, keypad_data);
> @@ -351,7 +397,6 @@ static int __devinit omap4_keypad_probe(struct
> platform_device *pdev)
>                goto err_pm_disable;
>        }
>
> -       platform_set_drvdata(pdev, keypad_data);
>        return 0;
>
>  err_pm_disable:
> @@ -392,12 +437,19 @@ static int __devexit omap4_keypad_remove(struct
> platform_device *pdev)
>        return 0;
>  }
>
> +static const struct of_device_id omap_keypad_dt_match[] = {
> +       { .compatible = "ti,omap4-keypad" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, omap_keypad_dt_match);
> +
>  static struct platform_driver omap4_keypad_driver = {
>        .probe          = omap4_keypad_probe,
>        .remove         = __devexit_p(omap4_keypad_remove),
>        .driver         = {
>                .name   = "omap4-keypad",
>                .owner  = THIS_MODULE,
> +               .of_match_table = of_match_ptr(omap_keypad_dt_match),
>        },
>  };
>  module_platform_driver(omap4_keypad_driver);
> --
> 1.7.1
>
>

--000e0cd4bdc892355904c283fab9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,<br><br>Gentle Ping on this... <br><br>~Sourav<br><br><div class=3D"=
gmail_quote">On Fri, Jun 8, 2012 at 4:22 PM, Sourav Poddar <span dir=3D"ltr=
">&lt;<a href=3D"mailto:sourav.poddar@ti.com" target=3D"_blank">sourav.podd=
ar@ti.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Update the Documentation =
with omap4 keypad device tree<br>
binding information.<br>
Add device tree support for omap4 keypad driver.<br>
<br>
Tested on omap4430 sdp.<br>
<br>
Cc: Andrew Morton &lt;<a href=3D"mailto:akpm@linux-foundation.org">akpm@lin=
ux-foundation.org</a>&gt;<br>
Cc: Benoit Cousson &lt;<a href=3D"mailto:b-cousson@ti.com">b-cousson@ti.com=
</a>&gt;<br>
Cc: Rob Herring &lt;<a href=3D"mailto:rob.herring@calxeda.com">rob.herring@=
calxeda.com</a>&gt;<br>
Cc: Grant Likely &lt;<a href=3D"mailto:grant.likely@secretlab.ca">grant.lik=
ely@secretlab.ca</a>&gt;<br>
Cc: Felipe Balbi &lt;<a href=3D"mailto:balbi@ti.com">balbi@ti.com</a>&gt;<b=
r>
Cc: Dmitry Torokhov &lt;<a href=3D"mailto:dtor@mail.ru">dtor@mail.ru</a>&gt=
;<br>
Cc: Randy Dunlap &lt;<a href=3D"mailto:rdunlap@xenotime.net">rdunlap@xenoti=
me.net</a>&gt;<br>
Signed-off-by: Sourav Poddar &lt;<a href=3D"mailto:sourav.poddar@ti.com">so=
urav.poddar@ti.com</a>&gt;<br>
---<br>
changes since v4:<br>
- Developed it on top of dmitry&#39;s &#39;next&#39; branch due to<br>
dependency on generic &quot;matrix_keypad_build_keymap&quot; api<br>
patches queued in that branch<br>
- Adapted the driver to fill &quot;keymap&quot; in device tree<br>
using &quot;matrix_keypad_build_keymap&quot; api defined in<br>
drivers/input/matrix-keymap.c<br>
=A0.../devicetree/bindings/input/omap-keypad.txt =A0 =A0 =A0| =A0 31 ++++++=
<br>
=A0drivers/input/keyboard/omap4-keypad.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A010=
8 +++++++++++++++-----<br>
=A02 files changed, 111 insertions(+), 28 deletions(-)<br>
=A0create mode 100644 Documentation/devicetree/bindings/input/omap-keypad.t=
xt<br>
<br>
diff --git a/Documentation/devicetree/bindings/input/omap-keypad.txt b/Docu=
mentation/devicetree/bindings/input/omap-keypad.txt<br>
new file mode 100644<br>
index 0000000..722425b<br>
--- /dev/null<br>
+++ b/Documentation/devicetree/bindings/input/omap-keypad.txt<br>
@@ -0,0 +1,31 @@<br>
+* TI&#39;s Keypad Controller device tree bindings<br>
+<br>
+TI&#39;s Keypad controller is used to interface a SoC with a matrix-type<b=
r>
+keypad device. The keypad controller supports multiple row and column line=
s.<br>
+A key can be placed at each intersection of a unique row and a unique colu=
mn.<br>
+The keypad controller can sense a key-press and key-release and report the=
<br>
+event using a interrupt to the cpu.<br>
+<br>
+Required SoC Specific Properties:<br>
+- compatible: should be one of the following<br>
+ =A0 - &quot;ti,omap4-keypad&quot;: For controllers compatible with omap4 =
keypad<br>
+ =A0 =A0 =A0controller.<br>
+<br>
+Required Board Specific Properties, in addition to those specified by<br>
+the shared matrix-keyboard bindings:<br>
+- keypad,num-rows: Number of row lines connected to the keypad<br>
+ =A0controller.<br>
+<br>
+- keypad,num-columns: Number of column lines connected to the<br>
+ =A0keypad controller.<br>
+<br>
+Optional Properties specific to linux:<br>
+- linux,keypad-no-autorepeat: do no enable autorepeat feature.<br>
+<br>
+Example:<br>
+ =A0 =A0 =A0 =A0keypad@4ae1c000{<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D &quot;ti,omap4-keypad&quot;=
;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad,num-rows =3D &lt;2&gt;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad,num-columns =3D &lt;8&gt;;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,keypad-no-autorepeat;<br>
+ =A0 =A0 =A0 };<br>
diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard=
/omap4-keypad.c<br>
index aed5f69..d5a2d1a 100644<br>
--- a/drivers/input/keyboard/omap4-keypad.c<br>
+++ b/drivers/input/keyboard/omap4-keypad.c<br>
@@ -27,6 +27,7 @@<br>
=A0#include &lt;linux/platform_device.h&gt;<br>
=A0#include &lt;linux/errno.h&gt;<br>
=A0#include &lt;linux/io.h&gt;<br>
+#include &lt;linux/of.h&gt;<br>
=A0#include &lt;linux/input.h&gt;<br>
=A0#include &lt;linux/slab.h&gt;<br>
=A0#include &lt;linux/pm_runtime.h&gt;<br>
@@ -75,6 +76,7 @@ enum {<br>
<br>
=A0struct omap4_keypad {<br>
 =A0 =A0 =A0 =A0struct input_dev *input;<br>
+ =A0 =A0 =A0 struct matrix_keymap_data *keymap_data;<br>
<br>
 =A0 =A0 =A0 =A0void __iomem *base;<br>
 =A0 =A0 =A0 =A0unsigned int irq;<br>
@@ -84,6 +86,7 @@ struct omap4_keypad {<br>
 =A0 =A0 =A0 =A0u32 reg_offset;<br>
 =A0 =A0 =A0 =A0u32 irqreg_offset;<br>
 =A0 =A0 =A0 =A0unsigned int row_shift;<br>
+ =A0 =A0 =A0 bool no_autorepeat;<br>
 =A0 =A0 =A0 =A0unsigned char key_state[8];<br>
 =A0 =A0 =A0 =A0unsigned short keymap[];<br>
=A0};<br>
@@ -208,25 +211,74 @@ static void omap4_keypad_close(struct input_dev *inpu=
t)<br>
 =A0 =A0 =A0 =A0pm_runtime_put_sync(input-&gt;dev.parent);<br>
=A0}<br>
<br>
+static struct omap4_keypad *omap_keypad_parse_dt(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint32_t rows=
, uint32_t cols,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct input_=
dev *input_dev)<br>
+{<br>
+ =A0 =A0 =A0 struct device_node *np =3D dev-&gt;of_node;<br>
+ =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev);<br>
+ =A0 =A0 =A0 struct omap4_keypad *keypad_data =3D platform_get_drvdata(pde=
v);<br>
+ =A0 =A0 =A0 int error;<br>
+<br>
+ =A0 =A0 =A0 error =3D matrix_keypad_build_keymap(NULL, &quot;linux,keymap=
&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rows, cols, k=
eypad_data-&gt;keymap, input_dev);<br>
+ =A0 =A0 =A0 if (error) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;failed to bu=
ild keymap\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_free_device(input_dev);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (of_get_property(np, &quot;linux,input-no-autorepeat&quot;=
, NULL))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data-&gt;no_autorepeat =3D true;<br>
+<br>
+ =A0 =A0 =A0 return keypad_data;<br>
+}<br>
+<br>
=A0static int __devinit omap4_keypad_probe(struct platform_device *pdev)<br=
>
=A0{<br>
+ =A0 =A0 =A0 struct device *dev =3D &amp;pdev-&gt;dev;<br>
+ =A0 =A0 =A0 struct device_node *np =3D dev-&gt;of_node;<br>
 =A0 =A0 =A0 =A0const struct omap4_keypad_platform_data *pdata;<br>
 =A0 =A0 =A0 =A0struct omap4_keypad *keypad_data;<br>
 =A0 =A0 =A0 =A0struct input_dev *input_dev;<br>
 =A0 =A0 =A0 =A0struct resource *res;<br>
 =A0 =A0 =A0 =A0resource_size_t size;<br>
- =A0 =A0 =A0 unsigned int row_shift, max_keys;<br>
+ =A0 =A0 =A0 unsigned int row_shift =3D 0, max_keys =3D 0;<br>
+ =A0 =A0 =A0 uint32_t num_rows =3D 0, num_cols =3D 0;<br>
 =A0 =A0 =A0 =A0int rev;<br>
 =A0 =A0 =A0 =A0int irq;<br>
 =A0 =A0 =A0 =A0int error;<br>
<br>
 =A0 =A0 =A0 =A0/* platform data */<br>
 =A0 =A0 =A0 =A0pdata =3D pdev-&gt;dev.platform_data;<br>
- =A0 =A0 =A0 if (!pdata) {<br>
+ =A0 =A0 =A0 if (np) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(np, &quot;keypad,num-row=
s&quot;, &amp;num_rows);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(np, &quot;keypad,num-col=
umns&quot;, &amp;num_cols);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!num_rows || !num_cols) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &q=
uot;number of keypad rows/columns not specified\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 } else if (pdata) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_rows =3D pdata-&gt;rows;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_cols =3D pdata-&gt;cols;<br>
+ =A0 =A0 =A0 } else {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&amp;pdev-&gt;dev, &quot;no platfor=
m data defined\n&quot;);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
+ =A0 =A0 =A0 row_shift =3D get_count_order(num_cols);<br>
+ =A0 =A0 =A0 max_keys =3D num_rows &lt;&lt; row_shift;<br>
+<br>
+ =A0 =A0 =A0 keypad_data =3D devm_kzalloc(dev, sizeof(struct omap4_keypad)=
 +<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_keys * sizeof(keypad_data=
-&gt;keymap[0]),<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);<=
br>
+<br>
+ =A0 =A0 =A0 if (!keypad_data) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;keypad_data =
memory allocation failed\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 platform_set_drvdata(pdev, keypad_data);<br>
+<br>
 =A0 =A0 =A0 =A0res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);<br>
 =A0 =A0 =A0 =A0if (!res) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&amp;pdev-&gt;dev, &quot;no base ad=
dress specified\n&quot;);<br>
@@ -239,22 +291,6 @@ static int __devinit omap4_keypad_probe(struct platfor=
m_device *pdev)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
- =A0 =A0 =A0 if (!pdata-&gt;keymap_data) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;no keymap da=
ta defined\n&quot;);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 row_shift =3D get_count_order(pdata-&gt;cols);<br>
- =A0 =A0 =A0 max_keys =3D pdata-&gt;rows &lt;&lt; row_shift;<br>
-<br>
- =A0 =A0 =A0 keypad_data =3D kzalloc(sizeof(struct omap4_keypad) +<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_keys * si=
zeof(keypad_data-&gt;keymap[0]),<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);<br>
- =A0 =A0 =A0 if (!keypad_data) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;keypad_data =
memory allocation failed\n&quot;);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
- =A0 =A0 =A0 }<br>
-<br>
 =A0 =A0 =A0 =A0size =3D resource_size(res);<br>
<br>
 =A0 =A0 =A0 =A0res =3D request_mem_region(res-&gt;start, size, pdev-&gt;na=
me);<br>
@@ -271,10 +307,10 @@ static int __devinit omap4_keypad_probe(struct platfo=
rm_device *pdev)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_release_mem;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
+ =A0 =A0 =A0 keypad_data-&gt;rows =3D num_rows;<br>
+ =A0 =A0 =A0 keypad_data-&gt;cols =3D num_cols;<br>
 =A0 =A0 =A0 =A0keypad_data-&gt;irq =3D irq;<br>
 =A0 =A0 =A0 =A0keypad_data-&gt;row_shift =3D row_shift;<br>
- =A0 =A0 =A0 keypad_data-&gt;rows =3D pdata-&gt;rows;<br>
- =A0 =A0 =A0 keypad_data-&gt;cols =3D pdata-&gt;cols;<br>
<br>
 =A0 =A0 =A0 =A0/*<br>
 =A0 =A0 =A0 =A0* Enable clocks for the keypad module so that we can read<b=
r>
@@ -322,15 +358,25 @@ static int __devinit omap4_keypad_probe(struct platfo=
rm_device *pdev)<br>
 =A0 =A0 =A0 =A0input_dev-&gt;open =3D omap4_keypad_open;<br>
 =A0 =A0 =A0 =A0input_dev-&gt;close =3D omap4_keypad_close;<br>
<br>
- =A0 =A0 =A0 error =3D matrix_keypad_build_keymap(pdata-&gt;keymap_data, N=
ULL,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0pdata-&gt;rows, pdata-&gt;cols,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0keypad_data-&gt;keymap, input_dev);<br>
- =A0 =A0 =A0 if (error) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;failed to bu=
ild keymap\n&quot;);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_input;<br>
+ =A0 =A0 =A0 if (np) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data =3D omap_keypad_parse_dt(&amp;pde=
v-&gt;dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data-&=
gt;rows, keypad_data-&gt;cols,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_dev);<b=
r>
+ =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data-&gt;keymap_data =3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct matrix_keymap_data *)=
pdata-&gt;keymap_data;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D matrix_keypad_build_keymap(keypad_d=
ata-&gt;keymap_data,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, keypad_=
data-&gt;rows, keypad_data-&gt;cols,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data-&=
gt;keymap, input_dev);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &q=
uot;failed to build keymap\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_input;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
 =A0 =A0 =A0 =A0}<br>
<br>
- =A0 =A0 =A0 __set_bit(EV_REP, input_dev-&gt;evbit);<br>
+ =A0 =A0 =A0 if (!keypad_data-&gt;no_autorepeat)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(EV_REP, input_dev-&gt;evbit);<br>
+<br>
 =A0 =A0 =A0 =A0input_set_capability(input_dev, EV_MSC, MSC_SCAN);<br>
<br>
 =A0 =A0 =A0 =A0input_set_drvdata(input_dev, keypad_data);<br>
@@ -351,7 +397,6 @@ static int __devinit omap4_keypad_probe(struct platform=
_device *pdev)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_pm_disable;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
- =A0 =A0 =A0 platform_set_drvdata(pdev, keypad_data);<br>
 =A0 =A0 =A0 =A0return 0;<br>
<br>
=A0err_pm_disable:<br>
@@ -392,12 +437,19 @@ static int __devexit omap4_keypad_remove(struct platf=
orm_device *pdev)<br>
 =A0 =A0 =A0 =A0return 0;<br>
=A0}<br>
<br>
+static const struct of_device_id omap_keypad_dt_match[] =3D {<br>
+ =A0 =A0 =A0 { .compatible =3D &quot;ti,omap4-keypad&quot; },<br>
+ =A0 =A0 =A0 {},<br>
+};<br>
+MODULE_DEVICE_TABLE(of, omap_keypad_dt_match);<br>
+<br>
=A0static struct platform_driver omap4_keypad_driver =3D {<br>
 =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D omap4_keypad_probe,<br>
 =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(omap4_keypad_remove=
),<br>
 =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D &quot;omap4-keypad&quot;,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_match_ptr(omap_keypad_=
dt_match),<br>
 =A0 =A0 =A0 =A0},<br>
=A0};<br>
=A0module_platform_driver(omap4_keypad_driver);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.1<br>
<br>
</font></span></blockquote></div><br>

--000e0cd4bdc892355904c283fab9--


--===============7406619085817663414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7406619085817663414==--

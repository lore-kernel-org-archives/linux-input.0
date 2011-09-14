From: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] input: samsung-keypad: Add device tree support
Date: Wed, 14 Sep 2011 22:19:22 +0530
Message-ID: <CAJuYYwSNaVCnHFTMtW0RZLGLaS+iKBibWYwn5mqNT-0EW31yAQ@mail.gmail.com>
References: <1315916779-21793-1-git-send-email-thomas.abraham@linaro.org>
	<1315916779-21793-2-git-send-email-thomas.abraham@linaro.org>
	<1315916779-21793-3-git-send-email-thomas.abraham@linaro.org>
	<20110914161144.GF3134@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110914161144.GF3134-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dh09.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Grant,

On 14 September 2011 21:41, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> On Tue, Sep 13, 2011 at 05:56:19PM +0530, Thomas Abraham wrote:
>> Add device tree based discovery support for Samsung's keypad controller.
>>
>> Cc: Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Cc: Donghwa Lee <dh09.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>> =A0.../devicetree/bindings/input/samsung-keypad.txt =A0 | =A0 88 +++++++=
+++
>> =A0drivers/input/keyboard/samsung-keypad.c =A0 =A0 =A0 =A0 =A0 =A0| =A01=
77 ++++++++++++++++++--
>> =A02 files changed, 253 insertions(+), 12 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/input/samsung-ke=
ypad.txt
>>
>> diff --git a/Documentation/devicetree/bindings/input/samsung-keypad.txt =
b/Documentation/devicetree/bindings/input/samsung-keypad.txt
>> new file mode 100644
>> index 0000000..e1c7237
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/samsung-keypad.txt
>> @@ -0,0 +1,88 @@
>> +* Samsung's Keypad Controller device tree bindings
>> +
>> +Samsung's Keypad controller is used to interface a SoC with a matrix-ty=
pe
>> +keypad device. The keypad controller supports multiple row and column l=
ines.
>> +A key can be placed at each intersection of a unique row and a unique c=
olumn.
>> +The keypad controller can sense a key-press and key-release and report =
the
>> +event using a interrupt to the cpu.
>> +
>> +Required SoC Specific Properties:
>> +- compatible: should be one of the following
>> + =A0- "samsung,s3c6410-keypad": For controllers compatible with s3c6410=
 keypad
>> + =A0 =A0controller.
>> + =A0- "samsung,s5pv210-keypad": For controllers compatible with s5pv210=
 keypad
>> + =A0 =A0controller.
>> +
>> +- reg: physical base address of the controller and length of memory map=
ped
>> + =A0region.
>> +
>> +- interrupts: The interrupt number to the cpu.
>> +
>> +Required Board Specific Properties:
>> +- samsung,keypad-num-rows: Number of row lines connected to the keypad
>> + =A0controller.
>> +
>> +- samsung,keypad-num-columns: Number of column lines connected to the
>> + =A0keypad controller.
>> +
>> +- row-gpios: List of gpios used as row lines. The gpio specifier for
>> + =A0this property depends on the gpio controller to which these row lin=
es
>> + =A0are connected.
>> +
>> +- col-gpios: List of gpios used as column lines. The gpio specifier for
>> + =A0this property depends on the gpio controller to which these column
>> + =A0lines are connected.
>
> I know we've got overlapping terminology here. =A0When you say GPIOs
> here, does it refer to the pin multiplexing feature of the samsung
> parts, and thus how the keypad controller IO is routed to the pins?
> Or does the driver manipulate GPIO lines manually?

It is intended to mean gpio and not the pinmux. But the way the gpio
specifier is specified in the dts file, it includes information about
both gpio number and the pin-control details. For instance, if 'gpa0'
is a gpio controller (which includes pin-control functionality as well
in the hardware), then the gpio specifier for the keypad would be as
below.

row-gpios =3D <&gpa0 0 3 3 0>,
                 <&gpa0 1 3 3 0>;

The syntax for the gpio specifier is
<[phandle of gpio controller] [pin number within the gpio controller]
[mux function] [pull up/down] [drive strength]>

The keypad driver does not know or use the mux function, pull up/down
and drive strength details. The driver would call of_get_gpio to get
the linux gpio number and then do a gpio_request on that gpio number.
The gpio dt support manges the pin-mux and other settings
transparently for the keypad driver. So even though the gpio specifier
format changes, the dt support code for the driver does not change.

The driver does not manipulate the gpios directly. It just requests
for the gpio number and makes a note of the number to free it when the
driver unbinds.

>
> If it is pin multiplexing, then using the GPIO binding seems rather
> odd. It may be entirely appropriate, but it will need to play well
> with the pinmux stuff that linusw is working on.

When pinmux/pin-ctrl functionality which linusw is developing is used
for this driver, it would be a extension to this patch. The driver
would request for the gpio and then use the pin-ctrl subsystem api to
setup the pin-control. In that case, the gpio-specifier would change
but that change would be break anything which this patch does.

>
>> +
>> +- Keys represented as child nodes: Each key connected to the keypad
>> + =A0controller is represented as a child node to the keypad controller
>> + =A0device node and should include the following properties.
>> + =A0- keypad,row: the row number to which the key is connected.
>> + =A0- keypad,column: the column number to which the key is connected.
>> + =A0- keypad,key-code: the key-code to be reported when the key is pres=
sed
>> + =A0 =A0and released.
>
> What defines the meanings of the key codes?

The key-code could be any value which the system would want the keypad
driver to report when that key is pressed.

>
>> +
>> +Optional Properties specific to linux:
>> +- linux,keypad-no-autorepeat: do no enable autorepeat feature.
>> +- linux,keypad-wakeup: use any event on keypad as wakeup event.
>
> Is this really a linux-specific feature?

Yes, it is a property defined by the linux subsystems. A non-linux
system might not have such features.

>
>> +
>> +
>> +Example:
>> + =A0 =A0 keypad@100A0000 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "samsung,s5pv210-keypad";
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x100A0000 0x100>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <173>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 samsung,keypad-num-rows =3D <2>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 samsung,keypad-num-columns =3D <8>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 linux,input-no-autorepeat;
>> + =A0 =A0 =A0 =A0 =A0 =A0 linux,input-wakeup;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 row-gpios =3D <&gpx2 0 3 3 0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpx2 1 3 3 0>;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 col-gpios =3D <&gpx1 0 3 0 0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpx1 1 3 0 0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpx1 2 3 0 0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpx1 3 3 0 0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpx1 4 3 0 0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpx1 5 3 0 0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpx1 6 3 0 0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpx1 7 3 0 0>;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 key_1 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,row =3D <0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,column =3D <3>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,key-code =3D <2>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 key_2 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,row =3D <0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,column =3D <4>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,key-code =3D <3>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 key_3 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,row =3D <0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,column =3D <5>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,key-code =3D <4>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> + =A0 =A0 };
>> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/key=
board/samsung-keypad.c
>> index f689f49..cf01a56 100644
>> --- a/drivers/input/keyboard/samsung-keypad.c
>> +++ b/drivers/input/keyboard/samsung-keypad.c
>> @@ -21,6 +21,8 @@
>> =A0#include <linux/module.h>
>> =A0#include <linux/platform_device.h>
>> =A0#include <linux/slab.h>
>> +#include <linux/of.h>
>> +#include <linux/of_gpio.h>
>> =A0#include <linux/sched.h>
>> =A0#include <plat/keypad.h>
>>
>> @@ -68,31 +70,26 @@ struct samsung_keypad {
>> =A0 =A0 =A0 wait_queue_head_t wait;
>> =A0 =A0 =A0 bool stopped;
>> =A0 =A0 =A0 int irq;
>> + =A0 =A0 enum samsung_keypad_type type;
>> =A0 =A0 =A0 unsigned int row_shift;
>> =A0 =A0 =A0 unsigned int rows;
>> =A0 =A0 =A0 unsigned int cols;
>> =A0 =A0 =A0 unsigned int row_state[SAMSUNG_MAX_COLS];
>> +#ifdef CONFIG_OF
>> + =A0 =A0 int row_gpios[SAMSUNG_MAX_ROWS];
>> + =A0 =A0 int col_gpios[SAMSUNG_MAX_COLS];
>> +#endif
>> =A0 =A0 =A0 unsigned short keycodes[];
>> =A0};
>>
>> -static int samsung_keypad_is_s5pv210(struct device *dev)
>> -{
>> - =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev);
>> - =A0 =A0 enum samsung_keypad_type type =3D
>> - =A0 =A0 =A0 =A0 =A0 =A0 platform_get_device_id(pdev)->driver_data;
>> -
>> - =A0 =A0 return type =3D=3D KEYPAD_TYPE_S5PV210;
>> -}
>> -
>> =A0static void samsung_keypad_scan(struct samsung_keypad *keypad,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int=
 *row_state)
>> =A0{
>> - =A0 =A0 struct device *dev =3D keypad->input_dev->dev.parent;
>> =A0 =A0 =A0 unsigned int col;
>> =A0 =A0 =A0 unsigned int val;
>>
>> =A0 =A0 =A0 for (col =3D 0; col < keypad->cols; col++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (samsung_keypad_is_s5pv210(dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (keypad->type =3D=3D KEYPAD_TYPE_S5PV210) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D S5PV210_KEYIFCOLEN_M=
ASK;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~(1 << col) << 8;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> @@ -235,6 +232,129 @@ static void samsung_keypad_close(struct input_dev =
*input_dev)
>> =A0 =A0 =A0 samsung_keypad_stop(keypad);
>> =A0}
>>
>> +#ifdef CONFIG_OF
>> +static
>> +struct samsung_keypad_platdata *samsung_keypad_parse_dt(struct device *=
dev)
>
> Nit: keep everything up to the function name on the same line. =A0It is
> more grep-friendly to make line breaks in the parameters list.

Ok. I will change this.

>
>> +{
>> + =A0 =A0 struct samsung_keypad_platdata *pdata;
>> + =A0 =A0 struct matrix_keymap_data *keymap_data;
>> + =A0 =A0 uint32_t *keymap;
>> + =A0 =A0 struct device_node *np =3D dev->of_node, *key_np;
>> + =A0 =A0 unsigned int key_count =3D 0;
>> +
>> + =A0 =A0 pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "could not allocate memory for pl=
atform data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 of_property_read_u32(np, "samsung,keypad-num-rows", &pdata->ro=
ws);
>> + =A0 =A0 of_property_read_u32(np, "samsung,keypad-num-columns", &pdata-=
>cols);
>
> pdata->rows and ->cols needs to be changed to a u32 for this to be
> safe.

Ok.

>
>> + =A0 =A0 if (!pdata->rows || !pdata->cols) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "number of keypad rows/columns no=
t specified\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 keymap_data =3D devm_kzalloc(dev, sizeof(*keymap_data), GFP_KE=
RNEL);
>> + =A0 =A0 if (!keymap_data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "could not allocate memory for ke=
ymap data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>> + =A0 =A0 pdata->keymap_data =3D keymap_data;
>> +
>> + =A0 =A0 for_each_child_of_node(np, key_np)
>> + =A0 =A0 =A0 =A0 =A0 =A0 key_count++;
>> +
>> + =A0 =A0 keymap_data->keymap_size =3D key_count;
>> + =A0 =A0 keymap =3D devm_kzalloc(dev, sizeof(uint32_t) * key_count, GFP=
_KERNEL);
>> + =A0 =A0 if (!keymap) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "could not allocate memory for ke=
ymap\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>> + =A0 =A0 keymap_data->keymap =3D keymap;
>> +
>> + =A0 =A0 for_each_child_of_node(np, key_np) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int row, col, key_code;
>
> These need to be u32

Ok.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(key_np, "keypad,row", &ro=
w);
>> + =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(key_np, "keypad,column", =
&col);
>> + =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(key_np, "keypad,key-code"=
, &key_code);
>> + =A0 =A0 =A0 =A0 =A0 =A0 *keymap++ =3D KEY(row, col, key_code);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (of_get_property(np, "linux,input-no-autorepeat", NULL))
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->no_autorepeat =3D true;
>> + =A0 =A0 if (of_get_property(np, "linux,input-wakeup", NULL))
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->wakeup =3D true;
>> +
>> + =A0 =A0 return pdata;
>> +}
>> +
>> +static void samsung_keypad_parse_dt_gpio(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct samsung=
_keypad *keypad)
>> +{
>> + =A0 =A0 struct device_node *np =3D dev->of_node;
>> + =A0 =A0 int gpio, ret, row, col;
>> +
>> + =A0 =A0 for (row =3D 0; row < keypad->rows; row++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio =3D of_get_named_gpio(np, "row-gpios", ro=
w);
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad->row_gpios[row] =3D gpio;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!gpio_is_valid(gpio)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "keypad row[%d]: =
invalid gpio %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 row, gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_request(gpio, "keypad-row");
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "keypad row[%d] g=
pio request failed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 row);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 for (col =3D 0; col < keypad->cols; col++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio =3D of_get_named_gpio(np, "col-gpios", co=
l);
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad->col_gpios[col] =3D gpio;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!gpio_is_valid(gpio)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "keypad column[%d=
]: invalid gpio %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 col, gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_request(col, "keypad-col");
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "keypad column[%d=
] gpio request failed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 col);
>> + =A0 =A0 }
>> +}
>> +
>> +static void samsung_keypad_dt_gpio_free(struct samsung_keypad *keypad)
>> +{
>> + =A0 =A0 int cnt;
>> +
>> + =A0 =A0 for (cnt =3D 0; cnt < keypad->rows; cnt++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(keypad->row_gpios[cnt]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(keypad->row_gpios[cn=
t]);
>> +
>> + =A0 =A0 for (cnt =3D 0; cnt < keypad->cols; cnt++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(keypad->col_gpios[cnt]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(keypad->col_gpios[cn=
t]);
>> +}
>> +#else
>> +static
>> +struct samsung_keypad_platdata *samsung_keypad_parse_dt(struct device *=
dev)
>> +{
>> + =A0 =A0 return NULL;
>> +}
>> +
>> +static void samsung_keypad_parse_dt_gpio(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct samsung=
_keypad *keypad)
>> +{
>> +}
>> +
>> +static void samsung_keypad_dt_gpio_free(struct samsung_keypad *keypad)
>> +{
>> +}
>> +#endif
>> +
>> =A0static int __devinit samsung_keypad_probe(struct platform_device *pde=
v)
>> =A0{
>> =A0 =A0 =A0 const struct samsung_keypad_platdata *pdata;
>> @@ -246,7 +366,10 @@ static int __devinit samsung_keypad_probe(struct pl=
atform_device *pdev)
>> =A0 =A0 =A0 unsigned int keymap_size;
>> =A0 =A0 =A0 int error;
>>
>> - =A0 =A0 pdata =3D pdev->dev.platform_data;
>> + =A0 =A0 if (pdev->dev.of_node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D samsung_keypad_parse_dt(&pdev->dev);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
>> =A0 =A0 =A0 if (!pdata) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no platform data define=
d\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> @@ -303,6 +426,16 @@ static int __devinit samsung_keypad_probe(struct pl=
atform_device *pdev)
>> =A0 =A0 =A0 keypad->cols =3D pdata->cols;
>> =A0 =A0 =A0 init_waitqueue_head(&keypad->wait);
>>
>> + =A0 =A0 if (pdev->dev.of_node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 samsung_keypad_parse_dt_gpio(&pdev->dev, keypa=
d);
>> +#ifdef CONFIG_OF
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad->type =3D of_device_is_compatible(pdev-=
>dev.of_node,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "samsung,s5pv210-keypad");
>> +#endif
>
> It is odd having the #ifdef around only part of the if() block.

I did not want to do it this way. But any other way would have
increased the number of lines added. If is against the coding rules or
style, I will change it.

>
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad->type =3D platform_get_device_id(pdev)-=
>driver_data;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 input_dev->name =3D pdev->name;
>> =A0 =A0 =A0 input_dev->id.bustype =3D BUS_HOST;
>> =A0 =A0 =A0 input_dev->dev.parent =3D &pdev->dev;
>> @@ -343,12 +476,19 @@ static int __devinit samsung_keypad_probe(struct p=
latform_device *pdev)
>>
>> =A0 =A0 =A0 device_init_wakeup(&pdev->dev, pdata->wakeup);
>> =A0 =A0 =A0 platform_set_drvdata(pdev, keypad);
>> +
>> + =A0 =A0 if (pdev->dev.of_node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 devm_kfree(&pdev->dev, (void *)pdata->keymap_d=
ata->keymap);
>> + =A0 =A0 =A0 =A0 =A0 =A0 devm_kfree(&pdev->dev, (void *)pdata->keymap_d=
ata);
>> + =A0 =A0 =A0 =A0 =A0 =A0 devm_kfree(&pdev->dev, (void *)pdata);
>> + =A0 =A0 }
>
> Don't need to do this. =A0The driver core will take care of freeing the
> devm for you when removed.

Dmitry Torokhov suggested that since the allocated pdata is not used
after the probe, it can be deallocated to save some memory. So this
was added.

>
> A few things that should be fixed up, but otherwise looks pretty good.
>

Thanks for your review and suggestions.

Regards,
Thomas.

[...]

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: FW: [PATCH 1/1] input: keypad controller driver for Intel low
	power Moorestown platform
Date: Thu, 7 May 2009 09:45:21 -0700
Message-ID: <20090507164516.GA6450@dtor-d630.eng.vmware.com>
References: <61563CE63B4F854986A895DA7AD3C177159F83C1@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:29351 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbZEGQpd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2009 12:45:33 -0400
Received: by wa-out-1112.google.com with SMTP id j5so499969wah.21
        for <linux-input@vger.kernel.org>; Thu, 07 May 2009 09:45:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <61563CE63B4F854986A895DA7AD3C177159F83C1@pdsmsx502.ccr.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Ba, Zheng" <zheng.ba@intel.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Zheng,

On Wed, May 06, 2009 at 12:00:35PM +0800, Ba, Zheng wrote:
> Hi Dmitry,
>
> It is Zheng Ba from Intel and I submitted below keypad driver patch
> last week but got no feedback from the community yet.  I just wanted
> to know if the patch was missing accidentally by you and please kindly
> take a look at this which will be of great help for us to integrate
> Moorestown platform based drivers to upstream Linux.
> 

Umm... I usually look on the mailing list after I manage to clear my
INBOX :) so it takes me much longer to get there, sorry...

> 
>           To compile this driver as a module, choose M here: the
>           module will be called sh_keysc.
> +
> +config KEYBOARD_MRST
> +       tristate "Moorestown keypad support"
> +       help
> +         Say Y if you want to use the moorestown keypad
> +         depends on GPIO_MOORESTOWN
> +

Can we have the customary "To compile this driver as a module...",
please?

Hmm, I wonder if somebody need to add MODULENAME to Kconfig and then
have tools print this line automatically for us.

> +
> +#define KEY_HALFSHUTTER                KEY_PROG1
> +#define KEY_FULLSHUTTER                KEY_CAMERA

We had discussion with Kim Kyuwon requesting the new key definition for
half-shutter. Please add KEY_CAMERA_FOCUS/0x1b8 to input.h and use it.

> +
> +static unsigned int mrst_keycode[MAX_MATRIX_KEY_NUM] = {
...
> +/* NumLk key mapping */
> +static unsigned int mrst_keycode_numlck[MAX_MATRIX_KEY_NUM] = {
...
> +/* Fn key mapping */
> +static unsigned int mrst_keycode_fn[MAX_MATRIX_KEY_NUM] = {
...
> +/* direct key map */
> +static unsigned int mrst_direct_keycode[MAX_DIRECT_KEY_NUM] = {
> +       KEY_VOLUMEUP, KEY_VOLUMEDOWN, KEY_HALFSHUTTER, KEY_FULLSHUTTER,
> +};
> +

Having 4 separate key code maps will not allow changing them all form
userspace with EVIOCSKEYCODE... Why don't you combine them all together
(opne array split in 4 "pages")?

> +
> +       int rotary_rel_code[2];
> +       int rotary_up_key[2];
> +       int rotary_down_key[2];
> +
> +       /* Fn key */
> +       int fn;

bool?

> +
> +       /* Number Lock key */
> +       int numlck;

Here too?

> +
> +       /*FIXME IRQ count*/
> +       int count;
> +};
> +
> +static void mrst_keypad_build_keycode(struct mrst_keypad *keypad)
> +{
> +       struct input_dev *input_dev = keypad->input_dev;
> +       unsigned int *key;
> +       int i, code;
> +
> +       keypad->matrix_key_rows = MAX_MATRIX_KEY_ROWS;
> +       keypad->matrix_key_cols = MAX_MATRIX_KEY_COLS;
> +       keypad->matrix_key_map_size = MAX_MATRIX_KEY_NUM;
> +       keypad->debounce_interval = DEBOUNCE_INTERVAL;
> +
> +       /* three sets of keycode here */
> +       if (keypad->fn)
> +               memcpy(keypad->matrix_keycodes, mrst_keycode_fn, \

You don't need escaping newlines here...

> +                      sizeof(keypad->matrix_keycodes));
> +       else if (keypad->numlck)
> +               memcpy(keypad->matrix_keycodes, mrst_keycode_numlck, \
> +                      sizeof(keypad->matrix_keycodes));
> +       else
> +               memcpy(keypad->matrix_keycodes, mrst_keycode, \
> +                      sizeof(keypad->matrix_keycodes));
> +
> +       memcpy(keypad->direct_key_map, mrst_direct_keycode, \
> +              sizeof(keypad->direct_key_map));
> +
> +       key = &keypad->matrix_keycodes[0];
> +       for (i = 0; i < MAX_MATRIX_KEY_NUM; i++, key++) {
> +               code = (*key) & 0xffffff;
> +               set_bit(code, input_dev->keybit);
> +       }
> +
> +       key = &keypad->direct_key_map[0];
> +       for (i = 0; i < MAX_DIRECT_KEY_NUM; i++, key++) {
> +               code = (*key) & 0xffffff;
> +               set_bit(code, input_dev->keybit);
> +       }
> +
> +       keypad->direct_key_num = MAX_DIRECT_KEY_NUM;
> +       keypad->enable_rotary0 = 0;
> +       keypad->enable_rotary1 = 0;
> +
> +}
> +
> +static inline unsigned int lookup_matrix_keycode(
> +               struct mrst_keypad *keypad, int row, int col)
> +{
> +       return keypad->matrix_keycodes[(row << 3) + col];
> +}
> +
> +static void handle_constant_keypress(struct mrst_keypad *keypad,

'Constant'? as in 'persistent' ot 'sticky'?

> +                                    int num, int col, int row,
> +                                    uint32_t *old_state)
> +{
> +       struct input_dev *dev = keypad->input_dev;
> +       int state = old_state[col] & (1 << row);
> +
> +       switch (num) {
> +       case 0:
> +               if (keypad->fn)
> +                       keypad->fn = 0;
> +               /* Manually release special keys (Fn combinations) */
> +               if (!!test_bit(KEY_LEFTBRACE, dev->key))

Why double negation? Also, just release them, input core will not
propagate even if key is not pressed.

> +                       input_report_key(dev, KEY_LEFTBRACE, 0);
> +               if (!!test_bit(KEY_RIGHTBRACE, dev->key))
> +                       input_report_key(dev, KEY_RIGHTBRACE, 0);
> +               if (!!test_bit(KEY_HOME, dev->key))
> +                       input_report_key(dev, KEY_RIGHTBRACE, 0);
> +               if (!!test_bit(KEY_END, dev->key))
> +                       input_report_key(dev, KEY_END, 0);
> +               if (!!test_bit(KEY_PAGEUP, dev->key))
> +                       input_report_key(dev, KEY_RIGHTBRACE, 0);
> +               if (!!test_bit(KEY_PAGEDOWN, dev->key))
> +                       input_report_key(dev, KEY_RIGHTBRACE, 0);
> +
> +               return;
> +
> +       case 1:
> +               /* if Fn pressed */
> +               if (col == 6 && row == 6)
> +                       keypad->fn = 1;
> +               /* key '[' */
> +               else if ((col == 0 && row == 2) && state) {
> +                       keypad->fn = 0;
> +                       set_bit(KEY_EQUAL, dev->key);
> +                       dev->repeat_key = KEY_EQUAL;

And what if I remapped the key?

> +               }
> +               /* key ']' */
> +               else if ((col == 3 && row == 5) && state) {
> +                       keypad->fn = 0;
> +                       set_bit(KEY_SLASH, dev->key);
> +                       dev->repeat_key = KEY_SLASH;
> +               }
> +               /* key '{' */
> +               else if ((col == 4 && row == 5) && state) {
> +                       keypad->fn = 0;
> +                       set_bit(KEY_COMMA, dev->key);
> +                       dev->repeat_key = KEY_COMMA;
> +               }
> +               /* key '}' */
> +               else if ((col == 7 && row == 5) && state) {
> +                       keypad->fn = 0;
> +                       set_bit(KEY_DOT, dev->key);
> +                       dev->repeat_key = KEY_DOT;
> +               }
> +
> +               return;
> +       default:
> +               ;
> +       }
> +}
> +
> +static void mrst_keypad_scan_matrix(struct mrst_keypad *keypad)
> +{
> +       int row, col, num_keys_pressed = 0;
> +       uint32_t new_state[MAX_MATRIX_KEY_COLS];
> +       uint32_t kpas = keypad_readl(KPAS);
> +
> +       num_keys_pressed = KPAS_MUKP(kpas);
> +
> +       memset(new_state, 0, sizeof(new_state));
> +
> +       if (num_keys_pressed == 0) {
> +               handle_constant_keypress(keypad, num_keys_pressed, 0, 0,
> +                                        keypad->matrix_key_state);
> +
> +               goto scan;
> +       }
> +
> +       if (num_keys_pressed == 1) {
> +               col = KPAS_CP(kpas);
> +               row = KPAS_RP(kpas);
> +
> +               /* if invalid row/col, treat as no key pressed */
> +               if (col >= keypad->matrix_key_cols ||
> +                   row >= keypad->matrix_key_rows)
> +                       goto scan;
> +
> +               /* if NumLk pressed */
> +               if (col == 0 && row == 1)
> +                       keypad->numlck = !keypad->numlck;
> +
> +               handle_constant_keypress(keypad, num_keys_pressed, col, row,
> +                                        keypad->matrix_key_state);
> +
> +               new_state[col] = (1 << row);
> +
> +               goto scan;
> +       }
> +
> +       if (num_keys_pressed > 1) {
> +               uint32_t kpasmkp0 = keypad_readl(KPASMKP0);
> +               uint32_t kpasmkp1 = keypad_readl(KPASMKP1);
> +               uint32_t kpasmkp2 = keypad_readl(KPASMKP2);
> +               uint32_t kpasmkp3 = keypad_readl(KPASMKP3);
> +
> +               new_state[0] = kpasmkp0 & KPASMKP_MKC_MASK;
> +               new_state[1] = (kpasmkp0 >> 16) & KPASMKP_MKC_MASK;
> +               new_state[2] = kpasmkp1 & KPASMKP_MKC_MASK;
> +               new_state[3] = (kpasmkp1 >> 16) & KPASMKP_MKC_MASK;
> +               new_state[4] = kpasmkp2 & KPASMKP_MKC_MASK;
> +               new_state[5] = (kpasmkp2 >> 16) & KPASMKP_MKC_MASK;
> +               new_state[6] = kpasmkp3 & KPASMKP_MKC_MASK;
> +               new_state[7] = (kpasmkp3 >> 16) & KPASMKP_MKC_MASK;
> +
> +               /* if Fn is pressed, all SHIFT is ignored, except when {
> +                * or } is pressed */
> +               if (new_state[6] & 0x40) {
> +                       keypad->fn = 1;
> +                       new_state[3] &= ~0x40;
> +                       new_state[1] &= ~0x80;
> +               }
> +
> +               if (keypad->fn == 1) {
> +                       /* if { or } pressed */
> +                       if ((new_state[4] & 0x20) || (new_state[7] & 0x20)) {
> +                               /* as if LEFTSHIFT is pressed */
> +                               new_state[3] |= 0x40;
> +                               /* as if Fn not pressed */
> +                               new_state[6] &= ~0x40;
> +                       }
> +                       /* if [ or ] pressed */
> +                       if ((new_state[0] & 0x04) || (new_state[3] & 0x20))
> +                               /* as if Fn not pressed */
> +                               new_state[6] &= ~0x40;
> +               }
> +       }
> +
> +
> +scan:
> +       /* re-build keycode */
> +       mrst_keypad_build_keycode(keypad);

No, let's not do it. Like I said, have single keymap and when you look
up the code selec the proper "page" there.

> +
> +       for (col = 0; col < keypad->matrix_key_cols; col++) {
> +               uint32_t bits_changed;
> +
> +               bits_changed = keypad->matrix_key_state[col] ^ new_state[col];
> +               if (bits_changed == 0)
> +                       continue;
> +
> +               for (row = 0; row < keypad->matrix_key_rows; row++) {
> +                       if ((bits_changed & (1 << row)) == 0)
> +                               continue;
> +
> +                       input_report_key(keypad->input_dev,
> +                               lookup_matrix_keycode(keypad, row, col),
> +                               new_state[col] & (1 << row));
> +               }
> +       }
> +       input_sync(keypad->input_dev);
> +       memcpy(keypad->matrix_key_state, new_state, sizeof(new_state));
> +}
> +
> +#define DEFAULT_KPREC  (0x007f007f)
> +
> +static inline int rotary_delta(uint32_t kprec)
> +{
> +       if (kprec & KPREC_OF0)
> +               return (kprec & 0xff) + 0x7f;
> +       else if (kprec & KPREC_UF0)
> +               return (kprec & 0xff) - 0x7f - 0xff;
> +       else
> +               return (kprec & 0xff) - 0x7f;
> +}
> +
> +static void report_rotary_event(struct mrst_keypad *keypad, int r, int delta)
> +{
> +       struct input_dev *dev = keypad->input_dev;
> +
> +       if (delta == 0)
> +               return;
> +
> +       if (keypad->rotary_up_key[r] && keypad->rotary_down_key[r]) {
> +               int keycode = (delta > 0) ? keypad->rotary_up_key[r] :
> +                                           keypad->rotary_down_key[r];
> +
> +               /* simulate a press-n-release */
> +               input_report_key(dev, keycode, 1);
> +               input_sync(dev);
> +               input_report_key(dev, keycode, 0);
> +               input_sync(dev);
> +       } else {
> +               input_report_rel(dev, keypad->rotary_rel_code[r], delta);
> +               input_sync(dev);
> +       }
> +}
> +
> +static void mrst_keypad_scan_rotary(struct mrst_keypad *keypad)
> +{
> +       unsigned int kprec;
> +
> +       /* read and reset to default count value */
> +       kprec = keypad_readl(KPREC);
> +       keypad_writel(KPREC, DEFAULT_KPREC);
> +
> +       if (keypad->enable_rotary0)
> +               report_rotary_event(keypad, 0, rotary_delta(kprec));
> +
> +       if (keypad->enable_rotary1)
> +               report_rotary_event(keypad, 1, rotary_delta(kprec >> 16));
> +}
> +
> +static void mrst_keypad_scan_direct(struct mrst_keypad *keypad)
> +{
> +       unsigned int new_state;
> +       uint32_t kpdk, bits_changed;
> +       int i;
> +
> +       kpdk = keypad_readl(KPDK);
> +
> +       if (keypad->enable_rotary0 || keypad->enable_rotary1)
> +               mrst_keypad_scan_rotary(keypad);
> +
> +       if ((keypad->direct_key_map == NULL) || (++keypad->count == 1)) {
> +               keypad->direct_key_state = 0;
> +               return;
> +       }
> +
> +       new_state = KPDK_DK(kpdk) & keypad->direct_key_mask;
> +       new_state = ~new_state;
> +       bits_changed = keypad->direct_key_state ^ new_state;
> +
> +       if (bits_changed == 0)
> +               return;
> +
> +       for (i = 0; i < keypad->direct_key_num; i++) {
> +               if (bits_changed & (1 << i)) {
> +                       input_report_key(keypad->input_dev,
> +                                        keypad->direct_key_map[i],
> +                                        (new_state & (1 << i)));
> +               }
> +       }
> +       input_sync(keypad->input_dev);
> +       keypad->direct_key_state = new_state;
> +
> +}
> +
> +static irqreturn_t mrst_keypad_irq_handler(int irq, void *dev_id)
> +{
> +       struct mrst_keypad *keypad = dev_id;
> +       unsigned long kpc = keypad_readl(KPC);
> +
> +       if (kpc & KPC_DI)
> +               mrst_keypad_scan_direct(keypad);
> +
> +       if (kpc & KPC_MI)
> +               mrst_keypad_scan_matrix(keypad);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/* temporily remove GPIO dependencies here... */
> +#if 0
> +#define        KEYPAD_MATRIX_GPIO_IN_PIN       24
> +#define        KEYPAD_MATRIX_GPIO_OUT_PIN      32
> +#define KEYPAD_DIRECT_GPIO_IN_PIN      40
> +static void mrst_keypad_gpio_init(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < MAX_MATRIX_KEY_ROWS; i++) {
> +               gpio_direction_input(KEYPAD_MATRIX_GPIO_IN_PIN + i);
> +               gpio_alt_func(KEYPAD_MATRIX_GPIO_IN_PIN + i, 1);
> +       }
> +
> +       for (i = 0; i < MAX_MATRIX_KEY_COLS; i++) {
> +               /* __gpio_set_value(KEYPAD_GPIO_OUT_PIN + i, 1); */
> +               /* set action is executed in gpio_direction_output() */
> +               gpio_direction_output(KEYPAD_MATRIX_GPIO_OUT_PIN + i, 1);
> +               gpio_alt_func(KEYPAD_MATRIX_GPIO_OUT_PIN + i, 1);
> +       }
> +
> +       for (i = 0; i < MAX_DIRECT_KEY_NUM; i++) {
> +               gpio_direction_input(KEYPAD_DIRECT_GPIO_IN_PIN + i);
> +               gpio_alt_func(KEYPAD_DIRECT_GPIO_IN_PIN + i, 1);
> +       }
> +}

If it is not needed/ready for mainline lets drop it.

> +#endif
> +
> +static void mrst_keypad_config(struct mrst_keypad *keypad)
> +{
> +       unsigned int mask = 0, direct_key_num = 0;
> +       unsigned long kpc = 0;
> +
> +       /* enable matrix keys with automatic scan */
> +       if (keypad->matrix_key_rows && keypad->matrix_key_cols) {
> +               kpc |= KPC_ASACT | KPC_MIE | KPC_ME | KPC_MS_ALL;
> +               kpc |= KPC_MKRN(keypad->matrix_key_rows) |
> +                      KPC_MKCN(keypad->matrix_key_cols);
> +       }
> +
> +       /* enable rotary key, debounce interval same as direct keys */
> +       if (keypad->enable_rotary0) {
> +               mask |= 0x03;
> +               direct_key_num = 2;
> +               kpc |= KPC_REE0;
> +       }
> +
> +       if (keypad->enable_rotary1) {
> +               mask |= 0x0c;
> +               direct_key_num = 4;
> +               kpc |= KPC_REE1;
> +       }
> +
> +       if (keypad->direct_key_num > direct_key_num)
> +               direct_key_num = keypad->direct_key_num;
> +
> +       keypad->direct_key_mask = ((2 << direct_key_num) - 1) & ~mask;
> +
> +       /* enable direct key */
> +       if (direct_key_num)
> +               kpc |= KPC_DE | KPC_DIE | KPC_DKN(direct_key_num);
> +
> +       keypad_writel(KPC, kpc);
> +       keypad_writel(KPREC, DEFAULT_KPREC);
> +       keypad_writel(KPKDI, keypad->debounce_interval);
> +}
> +
> +static int mrst_keypad_open(struct input_dev *dev)
> +{
> +       struct mrst_keypad *keypad = input_get_drvdata(dev);
> +
> +       /* mrst_keypad_gpio_init(); */
> +       mrst_keypad_config(keypad);
> +
> +       return 0;
> +}
> +
> +static void mrst_keypad_close(struct input_dev *dev)
> +{
> +       struct mrst_keypad *keypad ;
> +       keypad = input_get_drvdata(dev);

And..?


> +}
> +
> +#ifdef CONFIG_PM
> +static int mrst_keypad_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +       /* struct mrst_keypad *keypad = pci_get_drvdata(pdev); */
> +
> +       /* clk_disable(keypad->clk); */

If stopping clock is not needed why do you have this fucntion at all?

> +       return 0;
> +}
> +
> +static int mrst_keypad_resume(struct pci_dev *pdev)
> +{
> +       struct mrst_keypad *keypad = pci_get_drvdata(pdev);
> +       struct input_dev *input_dev = keypad->input_dev;
> +
> +       mutex_lock(&input_dev->mutex);
> +
> +       if (input_dev->users) {
> +               /* Enable unit clock */
> +               /* clk_enable(keypad->clk); */
> +               mrst_keypad_config(keypad);
> +       }
> +
> +       mutex_unlock(&input_dev->mutex);
> +
> +       return 0;
> +}
> +#else
> +#define mrst_keypad_suspend    NULL
> +#define mrst_keypad_resume     NULL
> +#endif
> +
> +
> +static int __devinit mrst_keypad_probe(struct pci_dev *pdev,
> +                       const struct pci_device_id *ent)
> +{
> +       struct mrst_keypad *keypad;
> +       struct input_dev *input_dev;
> +       int error;
> +
> +#ifndef MODULE
> +       printk(KERN_INFO MRST_KEYPAD_DRIVER_NAME "\n");
> +#endif

Just drop it.

> +
> +       keypad = kzalloc(sizeof(struct mrst_keypad), GFP_KERNEL);
> +       if (keypad == NULL) {
> +               dev_err(&pdev->dev, "failed to allocate driver data\n");
> +               return -ENOMEM;
> +       }
> +
> +       error = pci_enable_device(pdev);
> +       if (error || (pdev->irq < 0)) {
> +               dev_err(&pdev->dev, "failed to enable device/get irq\n");
> +               error = -ENXIO;
> +               goto failed_free;
> +       }
> +
> +       error = pci_request_regions(pdev, DRV_NAME);
> +       if (error) {
> +               dev_err(&pdev->dev, "failed to request I/O memory\n");
> +               goto failed_free;
> +       }
> +
> +       keypad->mmio_base = ioremap(pci_resource_start(pdev, 0), \
> +               pci_resource_len(pdev, 0));
> +       if (keypad->mmio_base == NULL) {
> +               dev_err(&pdev->dev, "failed to remap I/O memory\n");
> +               error = -ENXIO;
> +               goto failed_free_mem;
> +       }
> +
> +       /* Create and register the input driver. */
> +       input_dev = input_allocate_device();
> +       if (!input_dev) {
> +               dev_err(&pdev->dev, "failed to allocate input device\n");
> +               error = -ENOMEM;
> +               goto failed_free_io;
> +       }
> +
> +       input_dev->name = pci_name(pdev);
> +       input_dev->id.bustype = BUS_PCI;
> +       input_dev->open = mrst_keypad_open;
> +       input_dev->close = mrst_keypad_close;
> +       input_dev->dev.parent = &pdev->dev;
> +
> +       input_dev->keycode = keypad->matrix_keycodes;
> +       input_dev->keycodesize = sizeof(unsigned int);

sizeof(keypad->matrix_keycodes[0]) is safer.

> +       input_dev->keycodemax = ARRAY_SIZE(mrst_keycode);

ARRAY_SIZE(keypad->matrix_keycodes);

> +
> +       keypad->input_dev = input_dev;
> +       keypad->fn = 0;
> +       keypad->numlck = 0;
> +       /*FIXME*/keypad->count = 0;
> +       input_set_drvdata(input_dev, keypad);
> +
> +       input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> +               BIT_MASK(EV_REL);
> +
> +       mrst_keypad_build_keycode(keypad);
> +       pci_set_drvdata(pdev, keypad);
> +
> +       error = request_irq(pdev->irq, mrst_keypad_irq_handler, IRQF_SHARED,
> +               pci_name(pdev), keypad);
> +       if (error) {
> +               dev_err(&pdev->dev, "failed to request IRQ\n");
> +               goto failed_free_dev;
> +       }
> +
> +       /* Register the input device */
> +       error = input_register_device(input_dev);
> +       if (error) {
> +               dev_err(&pdev->dev, "failed to register input device\n");
> +               goto failed_free_irq;
> +       }
> +
> +       printk(KERN_INFO "*** keypad driver load successfully ***\n");

Drop it as weel, input core prints a message when a new device is
registered.

> +       return 0;
> +
> +failed_free_irq:
> +       free_irq(pdev->irq, keypad);
> +       pci_set_drvdata(pdev, NULL);
> +failed_free_dev:
> +       input_free_device(input_dev);
> +failed_free_io:
> +       iounmap(keypad->mmio_base);
> +failed_free_mem:
> +       pci_release_regions(pdev);
> +failed_free:
> +       kfree(keypad);
> +       return error;
> +}
> +
> +static void __devexit mrst_keypad_remove(struct pci_dev *pdev)
> +{
> +       struct mrst_keypad *keypad = pci_get_drvdata(pdev);
> +
> +       free_irq(pdev->irq, keypad);
> +       input_unregister_device(keypad->input_dev);
> +       iounmap(keypad->mmio_base);
> +       pci_release_regions(pdev);
> +       pci_set_drvdata(pdev, NULL);
> +       kfree(keypad);
> +}
> +
> +
> +static struct pci_driver mrst_keypad_driver = {
> +       .name           = DRV_NAME,
> +       .id_table       = keypad_pci_tbl,
> +       .probe          = mrst_keypad_probe,
> +       .remove         = __devexit_p(mrst_keypad_remove),
> +#ifdef CONFIG_PM
> +       .suspend        = mrst_keypad_suspend,
> +       .resume         = mrst_keypad_resume,
> +#endif /* CONFIG_PM */
> +};
> +
> +static int __init mrst_keypad_init(void)
> +{
> +#ifdef MODULE
> +       printk(KERN_INFO MRST_KEYPAD_DRIVER_NAME "\n");
> +#endif

Please just drop the message, boot is already noisy enough.

> +
> +       return pci_register_driver(&mrst_keypad_driver);
> +}
> +
> +static void __exit mrst_keypad_exit(void)
> +{
> +       pci_unregister_driver(&mrst_keypad_driver);
> +}
> +
> +module_init(mrst_keypad_init);
> +module_exit(mrst_keypad_exit);
> +
> +MODULE_DESCRIPTION("MRST Keypad Controller Driver");
> +MODULE_LICENSE("GPL v2");

MODULE_AUTHOR()?

I have not looked at the driver in much detail as I really want to see
how it will look like after combining the keymaps together. Please do
that and I will review it again. Thanks!

-- 
Dmitry

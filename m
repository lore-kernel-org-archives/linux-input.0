From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH 1/2] Input: matrix-keymap - uninline and prepare for device
 tree support
Date: Thu, 26 Apr 2012 13:53:12 +0530
Message-ID: <4F9905F0.6030402@st.com>
References: <20120426081750.GA2684@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120426081750.GA2684@core.coreip.homeip.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rakesh Iyer <riyer@nvidia.com>, Trilok Soni <tsoni@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>, Michael Hennerich <michael.hennerich@analog.com>, Thomas Abraham <thomas.abraham@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Wanlong Gao <gaowanlong@cn.fujitsu.com>, Hui Wang <jason77.wang@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Yong Zhang <yong.zhang0@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kyle Manna <kyle.manna@fuel7.com>, Wolfram Sang <w.sang@pengutronix.de>, Felipe Balbi <balbi@ti.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, Anirudh Ghayal <aghayal>
List-Id: linux-input@vger.kernel.org

On 4/26/2012 1:47 PM, Dmitry Torokhov wrote:
> diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> index 3b6b528..7c8f2bc 100644
> --- a/drivers/input/keyboard/spear-keyboard.c
> +++ b/drivers/input/keyboard/spear-keyboard.c
> @@ -49,7 +49,9 @@
>  #define KEY_VALUE      0x00FFFFFF
>  #define ROW_MASK       0xF0
>  #define COLUMN_MASK    0x0F
> -#define ROW_SHIFT      4
> +#define NUM_ROWS       16
> +#define NUM_COLS       16
> +
>  #define KEY_MATRIX_SHIFT       6
> 
>  struct spear_kbd {
> @@ -60,7 +62,7 @@ struct spear_kbd {
>         unsigned int irq;
>         unsigned int mode;
>         unsigned short last_key;
> -       unsigned short keycodes[256];
> +       unsigned short keycodes[NUM_ROWS * NUM_COLS];
>  };
> 
>  static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
> @@ -212,18 +214,17 @@ static int __devinit spear_kbd_probe(struct platform_device *pdev)
>         input_dev->open = spear_kbd_open;
>         input_dev->close = spear_kbd_close;
> 
> -       __set_bit(EV_KEY, input_dev->evbit);
> +       error = matrix_keypad_build_keymap(keymap, NULL, NUM_ROWS, NUM_COLS,
> +                                          kbd->keycodes, input_dev);
> +       if (error) {
> +               dev_err(&pdev->dev, "Failed to build keymap\n");
> +               goto errr_put_clk;
> +       }
> +
>         if (pdata->rep)
>                 __set_bit(EV_REP, input_dev->evbit);
>         input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> 
> -       input_dev->keycode = kbd->keycodes;
> -       input_dev->keycodesize = sizeof(kbd->keycodes[0]);
> -       input_dev->keycodemax = ARRAY_SIZE(kbd->keycodes);
> -
> -       matrix_keypad_build_keymap(keymap, ROW_SHIFT,
> -                       input_dev->keycode, input_dev->keybit);
> -
>         input_set_drvdata(input_dev, kbd);
> 
>         error = request_irq(irq, spear_kbd_interrupt, 0, "keyboard", kbd);

Have you rebased these patches over my patchset for SPEAr and Tegra?

-- 
viresh

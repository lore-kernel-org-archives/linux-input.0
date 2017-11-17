From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 03/10] Input: twl4030_keypad: Fix platform_get_irq's
 error checking
Date: Fri, 17 Nov 2017 12:27:02 -0800
Message-ID: <20171117202702.nzfptx5qdcujh4al@dtor-ws>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1510946132-13554-4-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1510946132-13554-4-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: daniel.thompson@linaro.org, mcuos.com@gmail.com, wsa@the-dreams.de, linux-kernel@vger.kernel.org, wens@csie.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, maxime.ripard@free-electrons.com, linux@roeck-us.net
List-Id: linux-input@vger.kernel.org

On Sat, Nov 18, 2017 at 12:45:25AM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/input/keyboard/twl4030_keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
> index f9f98ef..f94090e 100644
> --- a/drivers/input/keyboard/twl4030_keypad.c
> +++ b/drivers/input/keyboard/twl4030_keypad.c
> @@ -389,7 +389,7 @@ static int twl4030_kp_probe(struct platform_device *pdev)
>  	}
>  
>  	kp->irq = platform_get_irq(pdev, 0);
> -	if (!kp->irq) {
> +	if (kp->irq < 0) {

kp->irq is unsigned

>  		dev_err(&pdev->dev, "no keyboard irq assigned\n");
>  		return -EINVAL;

Let's not clobber error.

>  	}
> -- 
> 2.7.4
> 

-- 
Dmitry

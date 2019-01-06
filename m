From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH] keyboard/mtk-pmic-keys.c: Remove duplicate header
Date: Sun, 6 Jan 2019 17:32:41 +0530
Message-ID: <CAFqt6zb9Wk63Mne+p9x5zfZJfADV-VOQQvGYwvky5a6nffRmhw@mail.gmail.com>
References: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, chen.zhong@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Sat, Jan 5, 2019 at 10:39 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove linux/kernel.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 02c67a1749fc..5027ebb7b4e8 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -19,7 +19,6 @@
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> -#include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> --
> 2.17.1
>

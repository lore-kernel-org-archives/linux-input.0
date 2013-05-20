From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 1/7] input: ep93xx_keypad: Pass correct pointer to
 free_irq()
Date: Mon, 20 May 2013 10:49:00 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DA656F56D@AUSP01VMBX24.collaborationhost.net>
References: <1369061486-28226-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369061486-28226-1-git-send-email-lars@metafoo.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Monday, May 20, 2013 7:51 AM, Lars-Peter Clausen wrote:
> free_irq() expects the same pointer that was passed to request_irq(), otherwise
> the IRQ is not freed.

<snip>

> Cc: H Hartley Sweeten <hartleys@visionengravers.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/input/keyboard/ep93xx_keypad.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks,

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

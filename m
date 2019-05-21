From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND] input: keyboard: imx: make sure keyboard can always
 wake up system
Date: Mon, 20 May 2019 22:30:47 -0700
Message-ID: <20190521053047.GG183429@dtor-ws>
References: <1554341727-16084-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554341727-16084-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

Hi Anson,
On Thu, Apr 04, 2019 at 01:40:16AM +0000, Anson Huang wrote:
> There are several scenarios that keyboard can NOT wake up system
> from suspend, e.g., if a keyboard is depressed between system
> device suspend phase and device noirq suspend phase, the keyboard
> ISR will be called and both keyboard depress and release interrupts
> will be disabled, then keyboard will no longer be able to wake up
> system. Another scenario would be, if a keyboard is kept depressed,
> and then system goes into suspend, the expected behavior would be
> when keyboard is released, system will be waked up, but current
> implementation can NOT achieve that, because both depress and release
> interrupts are disabled in ISR, and the event check is still in
> progress.
> 
> To fix these issues, need to make sure keyboard's depress or release
> interrupt is enabled after noirq device suspend phase, this patch
> moves the suspend/resume callback to noirq suspend/resume phase, and
> enable the corresponding interrupt according to current keyboard status.

I believe it is possible for IRQ to be disabled and still  being enabled
as wakeup source. What happens if you call disable_irq() before
disabling the clock?

Thanks.

-- 
Dmitry

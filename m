From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: rpckbd - fix a leak of the IRQ during init failure
Date: Sat, 2 Apr 2011 21:20:45 -0700
Message-ID: <20110403042044.GA24788@core.coreip.homeip.net>
References: <1301794866.3657.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1301794866.3657.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Apr 03, 2011 at 09:41:06AM +0800, Axel Lin wrote:
> In rpckbd_open prror path, free_irq() was using NULL rather than the
> driver data as the data pointer so free_irq() wouldn't have matched.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks Axel.

-- 
Dmitry

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: pxrc - fix leak of usb_device
Date: Sat, 14 Jul 2018 08:51:09 +0000
Message-ID: <20180714085109.mbhk6aybpjsbuq6l@penguin>
References: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
 <20180714080920.GA15123@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180714080920.GA15123@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-input@vger.kernel.org

On Sat, Jul 14, 2018 at 10:09:20AM +0200, Marcus Folkesson wrote:
> Hi Alexey,
> 
> Good catch!
> 
> On Fri, Jul 13, 2018 at 11:07:57PM +0300, Alexey Khoroshilov wrote:
> > pxrc_probe() calls usb_get_dev(), but there is no usb_put_dev()
> > anywhere in the driver.
> > 
> > The patch adds one to error handling code and to pxrc_disconnect().
> > 
> > Found by Linux Driver Verification project (linuxtesting.org).
> > 
> > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> 
> Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Hmm, the biggest question however if we need to "take" the device, as I
do not think interface can outlive the device, and whether we actually
need to store it in pxrc, as we only need it during set up, as far as I
can see.

Thanks.

-- 
Dmitry

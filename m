From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 14/15] Input: atmel_tsadcc: remove driver
Date: Sun, 16 Mar 2014 12:26:01 -0700
Message-ID: <5652100.Y5W0uRRy4s@dtor-d630.eng.vmware.com>
References: <1394040940-18246-1-git-send-email-alexandre.belloni@free-electrons.com> <20140305184611.GA5453@core.coreip.homeip.net> <5325ECE3.5090800@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5325ECE3.5090800-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sunday, March 16, 2014 06:26:43 PM Jonathan Cameron wrote:
> On 05/03/14 18:46, Dmitry Torokhov wrote:
> > On Wed, Mar 05, 2014 at 06:35:39PM +0100, Alexandre Belloni wrote:
> >> The atmel_tsadcc driver is not used anymore, it has been replaced by
> >> at91_adc so remove it.
> >> 
> >> Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > 
> > Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> All the rest of this series looks fine to me.
> 
> Dmitry, are you happy for me to take this whole series through IIO once
> the last few bits are pinned down?  If the atmel guys want to take the whole
> thing through their tree I'm also happy with that.
> 
> Not sure what the lowest pain route will be...

Jonathan,

I am fine with either one of these 2 options.

Thanks.

-- 
Dmitry

From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] input: Add Nintendo extension controller driver
Date: Fri, 27 May 2011 02:01:00 -0600
Message-ID: <20110527080100.GB907@ponder.secretlab.ca>
References: <20110516214608.17011.3075.stgit@ponder>
 <87fwo5ywdh.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87fwo5ywdh.fsf@macbook.be.48ers.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: simon@mungewell.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, OliverNeukumoliver@neukum.org
List-Id: linux-input@vger.kernel.org

On Mon, May 23, 2011 at 10:50:34PM +0200, Peter Korsgaard wrote:
> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
> 
>  Grant> This driver adds support for Nintendo Wiimote extension controllers
>  Grant> directly attached to an i2c bus, such as when using an adaptor like
>  Grant> the Wiichuck.
> 
> 
>  Grant> + * If the device is recognized, then the polling period is bumped up
>  Grant> + * to 50ms, and the state machine enters into a loop alternating
> 
> <snip>
> 
>  Grant> +#else
>  Grant> +#define WIICHUCK_CAPTURE_PERIOD (100)	/* 100 milliseconds */
> 
> 50 or 100ms?

Good catch.  It's 100ms.  Now fixed, thanks.

g.

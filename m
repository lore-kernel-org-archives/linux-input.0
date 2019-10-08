From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: mms114 - add support for mms345l
Date: Tue, 8 Oct 2019 15:00:14 -0700
Message-ID: <20191008220014.GI22365@dtor-ws>
References: <20191007203343.101466-1-stephan@gerhold.net>
 <20191007205021.104402-1-stephan@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191007205021.104402-1-stephan@gerhold.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Andi Shyti <andi@etezian.org>, Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 07, 2019 at 10:50:21PM +0200, Stephan Gerhold wrote:
> MMS345L is another first generation touch screen from Melfas,
> which uses the same registers as MMS152.
> 
> However, using I2C_M_NOSTART for it causes errors when reading:
> 
> 	i2c i2c-0: sendbytes: NAK bailout.
> 	mms114 0-0048: __mms114_read_reg: i2c transfer failed (-5)
> 
> The driver works fine as soon as I2C_M_NOSTART is removed.
> 
> Add a separate melfas,mms345l binding, and make use of I2C_M_NOSTART
> only for MMS114 and MMS152.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Note: I was not able to find a datasheet for any of the models,
> so this change is merely based on testing and comparison with
> the downstream driver [1].
> 
> There was a related patch [2] that removes I2C_M_NOSTART for all models,
> but it seems abandoned and I do not have any other model for testing.
> Therefore, this patch implements the least instrusive solution
> and only removes I2C_M_NOSTART for MMS345L.

Hmm,  at this point I am inclined to pick up Andi's patch since it seems
to work for you and him and it looks like Android drivers are not using
I2C_M_NOSTART. I wonder if this was some quirk/big on the platform where
it was originally developed.

Any objections?

Thanks.

-- 
Dmitry

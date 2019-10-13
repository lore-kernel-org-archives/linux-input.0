From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH 3/3] Input: mms114 - add support for mms345l
Date: Mon, 14 Oct 2019 00:04:55 +0300
Message-ID: <20191013210455.GA16344@jack.zhora.eu>
References: <20191007203343.101466-1-stephan@gerhold.net>
 <20191007205021.104402-1-stephan@gerhold.net>
 <20191008220014.GI22365@dtor-ws>
 <20191009104740.GA107000@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191009104740.GA107000@gerhold.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andi Shyti <andi@etezian.org>, Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Stephan,

> > > There was a related patch [2] that removes I2C_M_NOSTART for all models,
> > > but it seems abandoned and I do not have any other model for testing.
> > > Therefore, this patch implements the least instrusive solution
> > > and only removes I2C_M_NOSTART for MMS345L.
> > 
> > Hmm,  at this point I am inclined to pick up Andi's patch since it seems
> > to work for you and him and it looks like Android drivers are not using
> > I2C_M_NOSTART. I wonder if this was some quirk/big on the platform where
> > it was originally developed.
> > 
> > Any objections?
> 
> I cannot really speak for any of the other models, but no objections for
> removing I2C_M_NOSTART from my side. I'm actually rather confused by it
> since it is used on the first partial message.
> 
> The documentation [1] says:
>   If you set the I2C_M_NOSTART variable for the first partial message,
>   we do not generate Addr, but we do generate the startbit S.
>   ** This will probably confuse all other clients on your bus,
>   so don't try this. **
> 
> Yet, someone felt like trying this here. ;)

still it should be specified in the i2c protocol of the device,
if it's not, then most probably it's not needed, I guess.

Andi

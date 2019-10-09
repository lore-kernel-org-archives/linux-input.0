From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: mms114 - add support for mms345l
Date: Wed, 9 Oct 2019 13:40:17 -0700
Message-ID: <20191009204017.GK22365@dtor-ws>
References: <20191007203343.101466-1-stephan@gerhold.net>
 <20191007205021.104402-1-stephan@gerhold.net>
 <20191008220014.GI22365@dtor-ws>
 <20191009072612.GA2814@jack.zhora.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191009072612.GA2814@jack.zhora.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Oct 09, 2019 at 10:26:12AM +0300, Andi Shyti wrote:
> Hi Dmitry,
> 
> > > There was a related patch [2] that removes I2C_M_NOSTART for all models,
> > > but it seems abandoned and I do not have any other model for testing.
> > > Therefore, this patch implements the least instrusive solution
> > > and only removes I2C_M_NOSTART for MMS345L.
> > 
> > Hmm,  at this point I am inclined to pick up Andi's patch since it seems
> > to work for you and him and it looks like Android drivers are not using
> > I2C_M_NOSTART. I wonder if this was some quirk/big on the platform where
> > it was originally developed.
> 
> I completely forgot about that patch :)
> 
> I should refresh some old work on that device which was left
> undone.
> 
> > Any objections?
> 
> It's OK for me. If you can just update my e-mail, please, when
> applying the patch to "andi@etezian.org". Thanks!

Andi, any chance you could resend it with the new email? One thing that
I try to avoid modifying whenever I can is S-O-B strings...

Thanks.

-- 
Dmitry

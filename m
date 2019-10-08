From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: mms114 - use device_get_match_data
Date: Tue, 8 Oct 2019 14:54:33 -0700
Message-ID: <20191008215433.GH22365@dtor-ws>
References: <20191007203343.101466-1-stephan@gerhold.net>
 <20191007203343.101466-2-stephan@gerhold.net>
 <20191008114426.GC4015@jack.zhora.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191008114426.GC4015@jack.zhora.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, Andi Shyti <andi.shyti@samsung.com>, Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 08, 2019 at 02:44:26PM +0300, Andi Shyti wrote:
> Hi Stephan,
> 
> > device_get_match_data is available now, so we can replace the call
> > to of_device_get_match_data and remove the FIXME comment.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> 
> Reviewed-by: Andi Shyti <andi@etezian.org>

Applied, thank you.

-- 
Dmitry

From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 2/4] Input: mms114 - mark as direct input device
Date: Fri, 26 Jan 2018 13:55:18 +0900
Message-ID: <20180126045518.GQ7575@gangnam.samsung>
References: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
        <CGME20180124193814epcas1p22db64829cbf5476abe443b3ef404cd50@epcas1p2.samsung.com>
        <20180124193804.155654-3-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <20180124193804.155654-3-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Shields <simon@lineageos.org>, Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Wed, Jan 24, 2018 at 11:38:02AM -0800, Dmitry Torokhov wrote:
> mms14 is a touchscreen and thus a direct input device; let's mark it
> as such. This also allows us to drop some initialization code as
> input_init_mt_slots() will do that for us.
> 
> Also add error handling for input_mt_init_slots().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
Tested-by: Andi Shyti <andi.shyti@samsung.com>

Thanks,
Andi

From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH 1/3] Input: add STMicroelectronics FingerTip touchscreen
 driver
Date: Fri, 20 Jan 2017 09:19:14 +0900
Message-ID: <20170120001914.him3d6j2fota547l@jack.zhora.eu>
References: <20170117135441.31450-1-andi.shyti@samsung.com>
 <CGME20170117135456epcas5p2e303f0c5fa642b43fde543d5d6098dc2@epcas5p2.samsung.com>
 <20170117135441.31450-2-andi.shyti@samsung.com>
 <20170119181912.lzlcc5zbtue2ojp4@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170119181912.lzlcc5zbtue2ojp4@rob-hp-laptop>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Andi Shyti <andi.shyti@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hi Rob,

> > +- compatible		: must be "st,stmfts"
> 
> Seems too generic. Is this a single device?

the device is precisely called ST-Microelectronics FingerTip S
(stmfts). There are variants, but they all have the same name and
same datasheet.

Maybe I can be more specific in the description, sometimes I
omitted the 'S'.

Andi

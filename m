From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
Date: Thu, 13 Dec 2018 11:59:23 +0100
Message-ID: <20181213105923.GN19816@piout.net>
References: <20181211190953.13626-1-enric.balletbo@collabora.com>
 <20181212222937.GL19816@piout.net>
 <6f688bfe-2ebe-1934-0375-016ae859dcfb@collabora.com>
 <20181213095050.GM19816@piout.net>
 <d603fcb9-c1f1-a622-5774-10fac45fc7a5@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d603fcb9-c1f1-a622-5774-10fac45fc7a5@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, groeck@chromium.org, kernel@collabora.com, linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, Sebastian Reichel <sre@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Rob Herring <robh+dt@kernel.org>, Lars-Peter Clausen <lars@>
List-Id: linux-input@vger.kernel.org

On 13/12/2018 10:55:29+0100, Enric Balletbo i Serra wrote:
> 
> 
> On 13/12/18 10:50, Alexandre Belloni wrote:
> > On 13/12/2018 10:30:16+0100, Enric Balletbo i Serra wrote:
> >>> However, you should probably indicate which tree do you expect that to
> >>> go through ;)
> >>>
> >>
> >> Well, these are sub-drivers for different subsystems but are related to the main
> >> ChromeOS EC. I expect all go through their specific subsystem and their
> >> maintainer. I.e the rtc driver go through your tree, the mfd go through Lee's
> >> tree, iio drivers through Jonathan's tree, etc. This is the reason I did not add
> >> the tree. Main purpose here as that Benson and I are aware when someone sends a
> >> change on one of the sub-drivers and we can review these patches.
> >>
> > 
> > Sure, sorry I was not clear but I was asking about this particular
> > patch because as it is, you will get acks from all the maintainers but I
> > think they all think someone else will apply it ;)
> > 
> 
> Ah, ok, I didn't got it :)
> 
> If nobody complains and we have all the acks I think that this can go through
> the Benson's tree (chrome-platform). The reason is that he already has a couple
> of patches related to this (remove Olof as a chrome-platform maintainer and
> adding me)
> 

Ok, great.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 4/5] Input: add haptic drvier on max77843
Date: Sat, 7 Mar 2015 20:55:26 -0800
Message-ID: <20150308045526.GB4054@dtor-ws>
References: <1425291038-18269-1-git-send-email-jaewon02.kim@samsung.com>
 <1425291038-18269-5-git-send-email-jaewon02.kim@samsung.com>
 <20150302173223.GA17094@dtor-ws>
 <54F50FE5.3060605@samsung.com>
 <20150304224742.GA38298@dtor-ws>
 <20150307202102.GH5233@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150307202102.GH5233@earth>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Jaewon Kim <jaewon02.kim@samsung.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Beomho Seo <beomho.seo@samsung.com>
List-Id: linux-input@vger.kernel.org

On Sat, Mar 07, 2015 at 09:21:02PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Mar 04, 2015 at 02:47:42PM -0800, Dmitry Torokhov wrote:
> > [...]
> > > >Do you want it to go through my or MFD tree?
> > > Other drivers merged in each maintainers git.
> 
> Actually only Lee took PATCH 1 so far.
> 
> > > If you don`t hava a problem, please merge your input git tree.
> > 
> > Applied, thank you.
> 
> Patches 2-4 depend on linux/mfd/max77843-private.h from Patch 1,
> so taking them independently will introduce build problems.

Luckily at least the input driver depends no MFD core so while I agree
that the situation is not ideal it is pretty safe since make *config
will not allow selecting it.

Thanks.

-- 
Dmitry

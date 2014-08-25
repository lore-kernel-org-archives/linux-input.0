From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/7] Second batch of cleanups for cros_ec
Date: Mon, 25 Aug 2014 11:01:52 -0700
Message-ID: <20140825180152.GA31693@core.coreip.homeip.net>
References: <1408974008-17184-1-git-send-email-javier.martinez@collabora.co.uk>
 <20140825170533.GA29350@core.coreip.homeip.net>
 <53FB7221.8090804@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53FB7221.8090804@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 25, 2014 at 07:28:01PM +0200, Javier Martinez Canillas wrote:
> Hello Dmitry,
> 
> On 08/25/2014 07:05 PM, Dmitry Torokhov wrote:
> >> 
> >> Patches #1, #2, #6 and #7 do not depend of others so they can be
> >> merged independently but patches #3, #4 and #5 have to be merged
> >> in that specific order since they depend on the previous one. 
> > 
> > #7 does not apply to my tree (I guess it depends on the 1st batch which I
> > expect will go through MFD tree?). Maybe you could rebase it on top of my next
> > so it can be applied sooner? Or it really needs parts of patchset #1?
> > 
> 
> The first batch sent by Doug did indeed touch this driver and the patches
> were merged through the MFD tree for 3.17 as you said. I see that your
> next branch is based on 3.16-rc6 and that is why it does not apply cleanly.
> 
> I guess you will rebase your next branch for 3.18 on top of 3.17-rc1
> anyways which will fix this issue? If not please let me know and I can of
> course re-spin the patch so it applies cleanly on top of 3.16-rc6.

I normally merge with mainline around -rc3 so please ping me around that time
if you do not see the patch in my tree.

Thanks.

-- 
Dmitry

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2 5/5] Input: arizona-haptics - Use SoC component pin
 control functions
Date: Wed, 30 Nov 2016 10:30:06 -0800
Message-ID: <20161130183006.GC31934@dtor-ws>
References: <1480434282-26389-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1480434282-26389-6-git-send-email-rf@opensource.wolfsonmicro.com>
 <20161130014135.GE20680@dtor-ws>
 <20161130172823.ihmk6jaw2khtyzek@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34735 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754198AbcK3SaJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Nov 2016 13:30:09 -0500
Content-Disposition: inline
In-Reply-To: <20161130172823.ihmk6jaw2khtyzek@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, myungjoo.ham@samsung.com, linux-input@vger.kernel.org

On Wed, Nov 30, 2016 at 05:28:23PM +0000, Mark Brown wrote:
> On Tue, Nov 29, 2016 at 05:41:35PM -0800, Dmitry Torokhov wrote:
> > On Tue, Nov 29, 2016 at 03:44:42PM +0000, Richard Fitzgerald wrote:
> 
> > > Switch to using the snd_soc_component_x_pin equivalent functions that
> > > take a specified SoC component and automatically add the name prefix to
> > > the provided pin name.
> 
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Do you want me to apply this or do you want to apply it in your tree?

Please apply though your tree, I should not have anything conflicting in
mine, and grouped on the same branch the changes make more sense.

Thanks!

-- 
Dmitry

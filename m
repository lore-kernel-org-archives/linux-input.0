From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] Input: arizona-haptics - Use SoC component pin
 control functions
Date: Mon, 28 Nov 2016 10:53:57 -0800
Message-ID: <20161128185357.GA28810@dtor-glaptop>
References: <1480354350-24978-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1480354350-24978-6-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36201 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbcK1Sx7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 13:53:59 -0500
Content-Disposition: inline
In-Reply-To: <1480354350-24978-6-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: broonie@kernel.org, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, myungjoo.ham@samsung.com, linux-input@vger.kernel.org

Hi Richard,

On Mon, Nov 28, 2016 at 05:32:30PM +0000, Richard Fitzgerald wrote:
> The name of a codec pin can have an optional prefix string, which is
> defined by the SoC machine driver. The snd_soc_dapm_x_pin functions
> take the fully-specified name including the prefix and so the existing
> code would fail to find the pin if the audio machine driver had added
> a prefix.
> 
> Switch to using the snd_soc_component_x_pin equivalent functions that
> take a specified SoC component and automatically add the name prefix to
> the provided pin name.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

If ASOC folks are fine with this then I am otto. Please merge with the rest of
Arizona changes.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] Input: imx6ul_tsc - generalize the averaging property
Date: Tue, 13 Dec 2016 13:10:50 -0600
Message-ID: <20161213191050.3yrmxaubpgjh65bz@rob-hp-laptop>
References: <1481440003-27168-1-git-send-email-guy.shapiro@mobi-wize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33578 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932547AbcLMTKy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Dec 2016 14:10:54 -0500
Content-Disposition: inline
In-Reply-To: <1481440003-27168-1-git-send-email-guy.shapiro@mobi-wize.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guy Shapiro <guy.shapiro@mobi-wize.com>
Cc: dmitry.torokhov@gmail.com, fabio.estevam@freescale.com, mark.rutland@arm.com, devicetree@vger.kernel.org, haibo.chen@freescale.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Dec 11, 2016 at 09:06:43AM +0200, Guy Shapiro wrote:
> Make the avarage-samples property a general touchscreen property
> rather than imx6ul device specific.
> 
> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
> ---
>  .../bindings/input/touchscreen/imx6ul_tsc.txt      | 11 ++----
>  .../bindings/input/touchscreen/touchscreen.txt     |  3 ++
>  drivers/input/touchscreen/imx6ul_tsc.c             | 46 ++++++++++++++++------
>  3 files changed, 41 insertions(+), 19 deletions(-)

You can't just switch existing bindings as that breaks compatibility 
with old dtbs. The kernel driver would need to support both. Just 
introduce the new common property and use it for your device.

Rob

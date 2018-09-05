From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH 1/2] input: egalax_ts: add system wakeup support
Date: Wed, 5 Sep 2018 13:34:28 +0300
Message-ID: <20180905103428.GA29158@jack.zhora.eu>
References: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, marco.franchi@nxp.com, fabio.estevam@nxp.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org

Hi Anson,

On Wed, Sep 05, 2018 at 05:26:46PM +0800, Anson Huang wrote:
> This patch adds wakeup function support for egalax touch
> screen, if "wakeup-source" is added to device tree's egalax
> touch screen node, the wakeup function will be enabled, and
> egalax touch screen will be able to wakeup system from suspend.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

I think you messed up the order of the patches, this patch
whould come after the PATCH 2/2.

You first create the property and then use it. If someone checks
out right here, he would find an inconsistency between the dts
property and this code.

You can either send a version 2 with the correct order or check
if Dmitry and Rob are willing to sync for who takes first the
patch first.

Andi

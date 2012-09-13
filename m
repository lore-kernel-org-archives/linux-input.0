From: "Patil, Rachna" <rachna@ti.com>
Subject: RE: [PATCH 0/4] input: TSC: ti_tscadc: TI Touchscreen driver updates
Date: Thu, 13 Sep 2012 10:39:12 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B9323E953A6A@DBDE01.ent.ti.com>
References: <1345634265-29646-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47283 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757410Ab2IMKjw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 06:39:52 -0400
In-Reply-To: <1345634265-29646-1-git-send-email-rachna@ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Patil, Rachna" <rachna@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>

Hi Dmitry,

This is just a gentle reminder for the patch set I had submitted viz.
"[PATCH 0/4] input: TSC: ti_tscadc: TI Touchscreen driver updates"
Can you please accept this patch set?
A lot of other patches that I have submitted and going to submit
are dependent on these patches.
This patch set just improves the driver and does not break anything existing.

Regards,
Rachna

On Wed, Aug 22, 2012 at 16:47:45, Patil, Rachna wrote:
> This patch set is a cumulative work for
> 1. Correcting resister usage
> 2. Adding more platform data
> 3. Making way for converting touchscreen into Multifunctional device 4. Remove usage of End Of Interrupt(EOI) register
> 
> These patches are tested on AM335x EVM.
> 
> Patil, Rachna (4):
>   input: TSC: ti_tscadc: Correct register usage
>   input: TSC: ti_tscadc: Add Step configuration as platform data
>   input: TSC: ti_tscadc: set FIFO0 threshold Interrupt
>   input: TSC: ti_tscadc: Remove definition of End Of Interrupt register
> 
>  drivers/input/touchscreen/ti_tscadc.c |  164 ++++++++++++++++++++-------------
>  include/linux/input/ti_tscadc.h       |    6 +
>  2 files changed, 106 insertions(+), 64 deletions(-)
> 
> 


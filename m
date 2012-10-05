From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/6] Input: da9052_onkey.c: Convert to the new da9052
 interrupt functions.
Date: Fri, 5 Oct 2012 19:57:26 +0100
Message-ID: <20121005185726.GG4360@opensource.wolfsonmicro.com>
References: <1349320509-26930-1-git-send-email-festevam@gmail.com>
 <1349320509-26930-4-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53002 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750856Ab2JES5i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 5 Oct 2012 14:57:38 -0400
Content-Disposition: inline
In-Reply-To: <1349320509-26930-4-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: sameo@linux.intel.com, ashish.jangam@kpitcummins.com, dchen@diasemi.com, arnd@arndb.de, kernel@pengutronix.de, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thu, Oct 04, 2012 at 12:15:07AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Use the new da9052 irq functions and allow the driver to probe successfully.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

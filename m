From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] Add generic GPIO-tilt driver
Date: Tue, 29 Nov 2011 18:42:03 +0000
Message-ID: <20111129184203.GE12111@sirena.org.uk>
References: <201111291324.34045.heiko@sntech.de>
 <20111129182326.GF4241@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:34224 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086Ab1K2SmF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Nov 2011 13:42:05 -0500
Content-Disposition: inline
In-Reply-To: <20111129182326.GF4241@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Heiko St?bner <heiko@sntech.de>, linux-input@vger.kernel.org

On Tue, Nov 29, 2011 at 10:23:26AM -0800, Dmitry Torokhov wrote:

> Could you please separate this change? I applied previous version to my
> tree and I am not sure when module_driver changes will hit mainline...

module_platform_driver is in Linus' tree already.

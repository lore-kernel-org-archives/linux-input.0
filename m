From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Input: Enable WM97xx touchscreen sub-drivers by default
Date: Thu, 24 Jul 2008 06:57:56 -0700
Message-ID: <20080724065756.55954c35@infradead.org>
References: <1216905308-4723-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1216906867-5058-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:47314 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636AbYGXN6F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jul 2008 09:58:05 -0400
In-Reply-To: <1216906867-5058-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Thu, 24 Jul 2008 14:41:07 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> Currently the support for each WM97xx touchscreen model is compiled
> out by default, meaning that the default configuration when the
> driver is built is for it to support no hardware.  This is suboptimal
> and leads to problems like distribution kernels shipping a
> non-functional driver.


this isn't normally how things are done; Linux is on a "off unless
selected or unless it breaks booting" policy nowadays...

(and distributions don't follow "default" anyway, so don't worry about
that part)

-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org

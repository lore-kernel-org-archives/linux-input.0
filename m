From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] Synaptics TM1217 Touchscreen Controller driver
Date: Mon, 19 Jul 2010 09:06:59 +0100
Message-ID: <20100719090659.6525eade@linux.intel.com>
References: <20100716130926.12814.59708.stgit@localhost.localdomain>
	<20100716162939.GB9232@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:11439 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760208Ab0GSIiX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Jul 2010 04:38:23 -0400
In-Reply-To: <20100716162939.GB9232@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

> Is this RMI3 or RMI4 hardware? Synaptics has posted and generic-ish
> framework for RMI4 devices so if it is RMI4 we'd need to move over to
> it.

RIM4 - when will the Synaptics patches get merged ?

Moving over to use their framework providing its going to end up in
tree soonish looks sensible enough.

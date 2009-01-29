From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH RFC] sh: maple: Add support for SEGA Dreamcast VMU and clean up maple bus driver (3/3)
Date: Thu, 29 Jan 2009 11:57:54 +0900
Message-ID: <20090129025754.GC31096@linux-sh.org>
References: <1233186456.6734.16.camel@localhost.localdomain> <1233187069.6734.21.camel@localhost.localdomain> <1233187750.6734.27.camel@localhost.localdomain> <1233188287.6734.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249]:42310 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751364AbZA2DBF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 22:01:05 -0500
Content-Disposition: inline
In-Reply-To: <1233188287.6734.32.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>

On Thu, Jan 29, 2009 at 12:18:07AM +0000, Adrian McMenamin wrote:
> +	if (!(mdev->function & MAPLE_FUNC_KEYBOARD)) {
> +		error = EINVAL;
> +		goto fail;
> +	}
>  
What is this all about? If the function doesn't match, you should never
enter the probe routine in the first place. The bus code should already
get this right.

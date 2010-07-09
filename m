From: Alan Cox <alan@linux.intel.com>
Subject: Re: cy8ctmg110: capacitive touchscreen support
Date: Fri, 9 Jul 2010 14:51:08 +0100
Message-ID: <20100709145108.3d89f017@linux.intel.com>
References: <20100708161040.23957.36738.stgit@localhost.localdomain>
	<20100708174401.GJ10135@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11048 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029Ab0GIOUB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Jul 2010 10:20:01 -0400
In-Reply-To: <20100708174401.GJ10135@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?UTF-8?B?U3lyasOkbMOk?= <syrjala@sci.fi>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

> s/req/reg

???

req - request, but reg makes more sense perhaps

> > +	struct cy8ctmg110 *tsc = (struct cy8ctmg110 *) dev_id;
> > +	cy8ctmg110_touch_pos(tsc);
> 
> i2c from an interrupt handler? Is there some problem with using a
> threaded irq handler?

Threaded IRQ would certainly make sense here. Will investigate further.


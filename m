From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and trigger
 support
Date: Fri, 16 Aug 2013 12:46:31 +0200
Message-ID: <520E0307.70704@linutronix.de>
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com> <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com> <520CBEC6.8010400@kernel.org> <20130816100702.GD26895@linutronix.de> <520E0E22.4000403@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38705 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab3HPKqi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Aug 2013 06:46:38 -0400
In-Reply-To: <520E0E22.4000403@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Zubair Lutfullah <zubair.lutfullah@gmail.com>, jic23@cam.ac.uk, dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Russ.Dill@ti.com

On 08/16/2013 01:33 PM, Jonathan Cameron wrote:
> Ah, fixes-togreg is for this cycle, whereas new stuff like this needs
> to go on the togreg branch.  Hence please rebase on the togreg branch
> instead.

But he needs "iio: ti_am335x_adc: Fix wrong samples received on 1st
read" from that branch. How should the rebase be done?

> 
> That would explain it.

Sebastian

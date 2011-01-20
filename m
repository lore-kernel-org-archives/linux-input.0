From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC] Input: input-polldev - create workqueue upfront
Date: Thu, 20 Jan 2011 09:26:40 +0100
Message-ID: <20110120082640.GA10195@polaris.bitmath.org>
References: <20110120074215.GB30522@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:33660 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754662Ab1ATI0r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 03:26:47 -0500
Content-Disposition: inline
In-Reply-To: <20110120074215.GB30522@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Jan 19, 2011 at 11:42:15PM -0800, Dmitry Torokhov wrote:
> Input: input-polldev - create workqueue upfront
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> With introduction of concurrency-managed work queues there is no point
> in creating workqueues on demand; they can be created upfront as it does
> not cause creation of unused threads.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---

Looks like a nice cleanup to me.

Henrik

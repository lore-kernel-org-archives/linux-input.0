From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3 2.6.39] Input: wm831x-ts - Fix races with IRQ
	management
Date: Tue, 3 May 2011 15:46:18 +0100
Message-ID: <20110503144618.GD2893@sirena.org.uk>
References: <1303237074-12878-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:56815 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab1ECOqT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2011 10:46:19 -0400
Content-Disposition: inline
In-Reply-To: <1303237074-12878-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Tue, Apr 19, 2011 at 07:17:52PM +0100, Mark Brown wrote:
> If the WM831x pen down and data IRQs run in parallel it is possible for the
> data and pen down IRQs to deadlock themselves as one is part way through
> disabling its operation while the other is part way through enabling. Fix
> this by always disabling the pen down interrupt while data is active and
> vice versa.  When a changeover is required we disable the IRQ that is to
> be stopped then schedule work that will enable the new IRQ.

Any updates on this?

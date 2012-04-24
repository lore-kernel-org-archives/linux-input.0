From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Add semi-MT support for v4 protocol
Date: Mon, 23 Apr 2012 23:00:33 -0700
Message-ID: <20120424060033.GA28958@core.coreip.homeip.net>
References: <1753794.1syzYofK8B@vaio>
 <20120418133823.GA31655@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:38871 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab2DXGAk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Apr 2012 02:00:40 -0400
Content-Disposition: inline
In-Reply-To: <20120418133823.GA31655@thinkpad-t410>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: George Pantalos <gpantalos@gmail.com>, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 18, 2012 at 08:38:23AM -0500, Seth Forshee wrote:
> On Wed, Apr 18, 2012 at 02:02:14AM +0300, George Pantalos wrote:
> > This patch adds semi-MT support for ALPS v4 protocol touchpads.
> > It is based on the work by Seth Forshee for ALPS v3 and v4 protocol
> > support. Three packets are required to assemble and process the MT
> > data. ST events are reported at once to avoid latency. If there
> > were two contacts or more, report MT data instead of ST events.
> > 
> > Thanks to Seth Forshee for providing most of the code, guidance
> > and insight for producing this patch.
> > 
> > Signed-off-by: George Pantalos <gpantalos@gmail.com>
> 
> Acked-by: Seth Forshee <seth.forshee@canonical.com>

Applied, thank you George, Seth.

-- 
Dmitry

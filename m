From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 13/20] Input: bcm5974 - Drop pressure and width
 emulation
Date: Thu, 13 Sep 2012 20:41:44 +0200
Message-ID: <20120913184144.GB3178@polaris.bitmath.org>
References: <1346528835-363-1-git-send-email-rydberg@euromail.se>
 <1346528835-363-14-git-send-email-rydberg@euromail.se>
 <20120913065723.GH17105@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:42242 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab2IMSe3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 14:34:29 -0400
Content-Disposition: inline
In-Reply-To: <20120913065723.GH17105@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 12, 2012 at 11:57:24PM -0700, Dmitry Torokhov wrote:
> On Sat, Sep 01, 2012 at 09:47:08PM +0200, Henrik Rydberg wrote:
> > The ABS_PRESSURE and ABS_WIDTH have special scales, and were initially
> > added solely for thumb and palm recognition in the synaptics driver.
> > This never really get used, however, and userspace quickly moved to
> > MT solutions instead. This patch drops the unused events.
> 
> How can you know that? There could still be people using ST emulation
> with this device. I think we should keep it.

Alright, maybe we need to carry this still. Probability = macbook *
old_userland * new_kernel * working_synaptics * tuned_palm_parameters,
must be a pretty large number. ;-)

Henrik

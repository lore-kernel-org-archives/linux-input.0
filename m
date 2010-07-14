From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Fix wrong dimensions check for synaptics
Date: Wed, 14 Jul 2010 09:32:02 -0700
Message-ID: <20100714163202.GB9957@core.coreip.homeip.net>
References: <s5hwrsy2ie2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:55220 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab0GNQcR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jul 2010 12:32:17 -0400
Content-Disposition: inline
In-Reply-To: <s5hwrsy2ie2.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 14, 2010 at 05:27:33PM +0200, Takashi Iwai wrote:
> The commit 83ba9ea8a04b72dfee2515428c15e7414ba4fc61 ommitted the return
> line for the old synaptics model accidentally.  This resulted in a wrong
> check, namely, the dimensions are checked for the old devices that don't
> support the query properly.
> 
> This patch adds the return line back.

Oops. Thanks Takashi, applied.

-- 
Dmitry

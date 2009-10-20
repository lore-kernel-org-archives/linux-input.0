From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Patch adding NOGET quirk for CH Products industrial joystick
Date: Tue, 20 Oct 2009 02:33:40 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0910200233280.8582@wotan.suse.de>
References: <4ADCD25B.4060508@signatureresearchinc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34195 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbZJTAdg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2009 20:33:36 -0400
In-Reply-To: <4ADCD25B.4060508@signatureresearchinc.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Keith Rutkowski <rutkowski@signatureresearchinc.com>
Cc: linux-input@vger.kernel.org

On Mon, 19 Oct 2009, Keith Rutkowski wrote:

> This patch was applied to Fedora 11's 2.6.30.8-64 kernel and adds the 
> NOGET quirk for CH Products industrial class joystick(s).  It is like 
> the previous CH Products NOGET quirk patch for their consumer class 
> joysticks.  Without the quirk, the joystick would only be detected and 
> would not function at all in kernels >= 2.6.29.  It was tested with a CH 
> Products 3-axis 5-button industrial joystick, product 
> #HG-434IS000-U-217.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

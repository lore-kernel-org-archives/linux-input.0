From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/3] Input: penmount - add PenMount 6000 support
Date: Mon, 19 Sep 2011 16:32:25 +0100
Message-ID: <20110919153225.GA15609@srcf.ucam.org>
References: <1315290961-23570-1-git-send-email-penmount.touch@gmail.com>
 <20110907232947.GB32566@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38193 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250Ab1ISPc1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Sep 2011 11:32:27 -0400
Content-Disposition: inline
In-Reply-To: <20110907232947.GB32566@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: John Sung <penmount.touch@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 07, 2011 at 04:29:47PM -0700, Dmitry Torokhov wrote:
> 
> Initializing a device connected to a serport serio port is actually task
> of inputattach utility.

For devices that present a unique pnp ID, we probably ought to support 
doing this in-kernel rather than relying on inputattach. It makes it 
easier to handle things like suspend/resume.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

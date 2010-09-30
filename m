From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gameport: emu10k1-gp: call pci_disable_device in
 error path and in remove()
Date: Wed, 29 Sep 2010 18:18:14 -0700
Message-ID: <20100930011813.GB5260@core.coreip.homeip.net>
References: <1285503285-6219-1-git-send-email-rahul.ruikar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:39460 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab0I3BSU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Sep 2010 21:18:20 -0400
Content-Disposition: inline
In-Reply-To: <1285503285-6219-1-git-send-email-rahul.ruikar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rahul Ruikar <rahul.ruikar@gmail.com>
Cc: nm127@freemail.hu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 26, 2010 at 05:44:45PM +0530, Rahul Ruikar wrote:
> pci_disable_device() is called for following 2 cases
> - error path in emu_probe()
> - in emu_remove()
> 
> Signed-off-by: Rahul Ruikar <rahul.ruikar@gmail.com>

Applied, thanks Rahul.

-- 
Dmitry

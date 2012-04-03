From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: use module_pci_driver
Date: Tue, 3 Apr 2012 09:46:08 -0700
Message-ID: <20120403164608.GC24832@core.coreip.homeip.net>
References: <1333414253.18133.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:64826 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab2DCQqQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 12:46:16 -0400
Content-Disposition: inline
In-Reply-To: <1333414253.18133.1.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Apr 03, 2012 at 08:50:53AM +0800, Axel Lin wrote:
> This patch converts the drivers in drivers/input/* to use module_pci_driver()
> macro which makes the code smaller and a bit simpler.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks Axel.

Any chance you could add module_serio_driver() and
module_ganeport_driver() too?

Thanks.

-- 
Dmitry

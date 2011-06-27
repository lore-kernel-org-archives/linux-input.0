From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 09/37] Remove unneeded version.h includes from
 drivers/input/
Date: Mon, 27 Jun 2011 12:00:13 -0700
Message-ID: <20110627190001.GA13829@core.coreip.homeip.net>
References: <alpine.LNX.2.00.1106232344480.17688@swampdragon.chaosbits.net>
 <alpine.LNX.2.00.1106240009201.17688@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46941 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab1F0TBH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2011 15:01:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1106240009201.17688@swampdragon.chaosbits.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: LKML <linux-kernel@vger.kernel.org>, trivial@kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Alessandro Rubini <rubini@ipvvis.unipv.it>, Mike Frysinger <vapier@gentoo.org>, device-drivers-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

On Fri, Jun 24, 2011 at 12:10:37AM +0200, Jesper Juhl wrote:
> It was pointed out by 'make versioncheck' that some includes of
> linux/version.h are not needed in drivers/input/.
> This patch removes them.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>

Applied, thanks Jesper.

-- 
Dmitry

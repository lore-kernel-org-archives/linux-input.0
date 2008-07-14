From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] new driver for SGI Indy volume buttons
Date: Mon, 14 Jul 2008 10:32:10 -0400
Message-ID: <20080714143210.GB13938@anvil.corenet.prv>
References: <20080711183435.4C53AC2EBF@solo.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.243]:7026 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973AbYGNOcO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jul 2008 10:32:14 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1089463hsl.5
        for <linux-input@vger.kernel.org>; Mon, 14 Jul 2008 07:32:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080711183435.4C53AC2EBF@solo.franken.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-input@vger.kernel.org

Hi Thomas,

On Fri, Jul 11, 2008 at 08:34:35PM +0200, Thomas Bogendoerfer wrote:
> This driver adds support for the volume buttons on the front of every
> SGI Indy workstation.
> 

This driver looks like a twin brother to sgio2_btns. Is is possible to
merge these 2?

Thanks.

-- 
Dmitry

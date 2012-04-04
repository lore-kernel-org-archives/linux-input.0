From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: use module_gameport_driver
Date: Wed, 4 Apr 2012 00:05:29 -0700
Message-ID: <20120404070529.GB26093@core.coreip.homeip.net>
References: <1333510350.15318.10.camel@phoenix>
 <1333510434.15318.12.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:38685 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab2DDHFf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Apr 2012 03:05:35 -0400
Content-Disposition: inline
In-Reply-To: <1333510434.15318.12.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, linux-input@vger.kernel.org

On Wed, Apr 04, 2012 at 11:33:54AM +0800, Axel Lin wrote:
> This patch converts the drivers in drivers/input/* to use
> module_gameport_driver() macro which makes the code smaller and a bit simpler.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied all 4, thank you Axel.

-- 
Dmitry

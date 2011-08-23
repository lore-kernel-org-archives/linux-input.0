From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] Input: ad714x - fix endianness issues
Date: Tue, 23 Aug 2011 17:22:57 +0100
Message-ID: <20110823162257.GC26317@sirena.org.uk>
References: <1313957345-22608-1-git-send-email-dmitry.torokhov@gmail.com>
 <1313957345-22608-2-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:53504 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857Ab1HWQXB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Aug 2011 12:23:01 -0400
Content-Disposition: inline
In-Reply-To: <1313957345-22608-2-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org

On Sun, Aug 21, 2011 at 01:09:03PM -0700, Dmitry Torokhov wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Allow driver to be used on Big Endian boxes.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Might the regmap API be helpful here?

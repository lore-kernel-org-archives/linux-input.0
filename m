From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: adp5588-keys: use obvious i2c_device_id name
 string
Date: Fri, 22 Oct 2010 09:35:31 -0700
Message-ID: <20101022163530.GB20816@core.coreip.homeip.net>
References: <1287440580-1497-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52402 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756378Ab0JVQfj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Oct 2010 12:35:39 -0400
Received: by gxk23 with SMTP id 23so564449gxk.19
        for <linux-input@vger.kernel.org>; Fri, 22 Oct 2010 09:35:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287440580-1497-1-git-send-email-vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

On Mon, Oct 18, 2010 at 06:23:00PM -0400, Mike Frysinger wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> KBUILD_MODNAME normalizes "-" to "_".  This is non-obvious and results in
> the id name for ADP5588 being "adp5588_keys" while the other supported id
> is "adp5587-keys".  So avoid this define and use an explicit string as the
> id name.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Applied, thank you.

-- 
Dmitry

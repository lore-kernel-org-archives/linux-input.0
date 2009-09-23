From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input/keyboard: new driver for ADP5520 MFD PMICs
Date: Tue, 22 Sep 2009 23:28:09 -0700
Message-ID: <20090923062808.GD1458@core.coreip.homeip.net>
References: <1253211850-29309-1-git-send-email-vapier@gentoo.org> <1253682916-27387-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:49876 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbZIWG2J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2009 02:28:09 -0400
Content-Disposition: inline
In-Reply-To: <1253682916-27387-1-git-send-email-vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <cooloney@kernel.org>

On Wed, Sep 23, 2009 at 01:15:16AM -0400, Mike Frysinger wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
> this patch requires:
> 	[PATCH] mfd: ADP5520 Multifunction LCD Backlight and Keypad Input Device Driver
> 
> v2
> 	- address feedback from Dmitry
> 

Looks good. I assume you want it to be merged with the rest of ADP5520
patches, so:

Acked-by: Dmitry Torokhov <dtor@mail.ru>

-- 
Dmitry

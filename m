From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] arch/tile: finish enabling support for TILE-Gx 64-bit
 chip
Date: Thu, 5 May 2011 09:11:43 -0700
Message-ID: <20110505161143.GE27251@core.coreip.homeip.net>
References: <201105042004.p44K4rPS011723@farm-0032.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:38076 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab1EEQLt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 May 2011 12:11:49 -0400
Content-Disposition: inline
In-Reply-To: <201105042004.p44K4rPS011723@farm-0032.internal.tilera.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, May 04, 2011 at 02:38:26PM -0400, Chris Metcalf wrote:
> 
> Finally, I had to hack the existing hacky drivers/input/input-compat.h
> to add yet another "#ifdef" for INPUT_COMPAT_TEST (same as x86_64).

That change looks fine, please feel free to merge with the rest.

-- 
Dmitry

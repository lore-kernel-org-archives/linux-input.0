From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: remove BKL from uinput open function
Date: Fri, 29 Jan 2010 23:57:02 -0800
Message-ID: <20100130075702.GC30378@core.coreip.homeip.net>
References: <1264800197-29523-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:42349 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab0A3H5H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jan 2010 02:57:07 -0500
Content-Disposition: inline
In-Reply-To: <1264800197-29523-1-git-send-email-cascardo@holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 29, 2010 at 07:23:16PM -0200, Thadeu Lima de Souza Cascardo wrote:
> Commit 8702965848ed4bee27486a3e3d2ae34ebba6dd83 has push down the BKL
> into uinput open function. However, there's nothing that needs locking
> in there.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

Applied to next, thank you.

-- 
Dmitry

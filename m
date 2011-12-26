From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: wm831x-on - Convert to devm_kzalloc()
Date: Mon, 26 Dec 2011 19:26:31 +0000
Message-ID: <20111226192631.GO8722@opensource.wolfsonmicro.com>
References: <1324925128-9161-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112262008.46507.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60273 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752261Ab1LZT0e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Dec 2011 14:26:34 -0500
Content-Disposition: inline
In-Reply-To: <201112262008.46507.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, Dec 26, 2011 at 08:08:46PM +0100, Marek Vasut wrote:
> > Saves a small amount of code and reduces the potential for leaks.

> Shouldn't you still be kind and free the memory anyway?

There doesn't seem to be much point if it's going to be freed
immediately anyway and half the point of the helpers is to avoid having
to write the cleanup code.

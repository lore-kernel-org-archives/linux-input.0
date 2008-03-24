From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] Fix sh_keysc double free
Date: Mon, 24 Mar 2008 15:13:18 +0900
Message-ID: <20080324061318.GB17734@linux-sh.org>
References: <20080321111446.13134.8863.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249]:48887 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755512AbYCXGNl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Mar 2008 02:13:41 -0400
Content-Disposition: inline
In-Reply-To: <20080321111446.13134.8863.sendpatchset@rx1.opensource.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, akpm@linux-foundation.org, linux-sh@vger.kernel.org

On Fri, Mar 21, 2008 at 08:14:46PM +0900, Magnus Damm wrote:
> Avoid double free situation from happening by removing input_free_device() 
> after input_unregister_device(). Suggested by Dmitry Torokhov.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied, thanks.

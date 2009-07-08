From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] drivers/input: Use resource_size
Date: Tue, 7 Jul 2009 23:51:05 -0700
Message-ID: <20090708065105.GB3309@dtor-d630.eng.vmware.com>
References: <Pine.LNX.4.64.0907050835530.27464@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:2012 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759222AbZGHG5t (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2009 02:57:49 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0907050835530.27464@ask.diku.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sun, Jul 05, 2009 at 08:36:22AM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Use the function resource_size, which reduces the chance of introducing
> off-by-one errors in calculating the resource size.
> 

Applied, thank you Julia.

-- 
Dmitry

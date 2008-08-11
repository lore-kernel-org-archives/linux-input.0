From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] input: migor_ts compile and detection fix
Date: Mon, 11 Aug 2008 20:28:59 +0900
Message-ID: <20080811112858.GA5340@linux-sh.org>
References: <20080811055349.19913.70612.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249]:15266 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751221AbYHKL37 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Aug 2008 07:29:59 -0400
Content-Disposition: inline
In-Reply-To: <20080811055349.19913.70612.sendpatchset@rx1.opensource.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org

On Mon, Aug 11, 2008 at 02:53:49PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> The i2c layer got changed while the migor_ts driver was in the input
> tree waiting to get merged upstream. Fix current compile issue by using
> struct i2c_client member "name" instead of "driver_name". Also, add
> id_table to make sure the device gets properly detected.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Paul, can you pick up this one together with other SuperH fixes?
> 
Yes, I rolled it in to my queue, thanks.

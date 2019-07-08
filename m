From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Input: iforce - Remove empty multiline comments
Date: Mon, 8 Jul 2019 08:01:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1907080800160.3648@nanos.tec.linutronix.de>
References: <20190708025010.9318-1-timschumi@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190708025010.9318-1-timschumi@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Schumacher <timschumi@gmx.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 8 Jul 2019, Tim Schumacher wrote:

> Those are remnants of the SPDX identifier migration, which haven't been
> removed properly.
> 
> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
> ---
> This is probably the highest level of cosmetic-only that a patch
> can achieve, sorry for the noise.
> 
> CCing Thomas Gleixner, since the tool (is it a tool?) that makes
> those SPDX changes would have room for improvement in that regard.
> It seems to expect that all of the license information is contained
> within the same comment block, which wasn't the case for the iforce
> driver.

Right. I noticed too late, that these empty comments were left. Tool was
fixed for later patches.

Thanks for cleaning that up.

       tglx

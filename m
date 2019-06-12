From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers: input: serio: Add a module desription to the
 hyperv_keyboard driver
Date: Wed, 12 Jun 2019 14:53:37 -0700
Message-ID: <20190612215337.GB40779@dtor-ws>
References: <20190530174645.18147-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190530174645.18147-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Sasha,

On Thu, May 30, 2019 at 01:46:45PM -0400, Sasha Levin wrote:
> From: Joseph Salisbury <Joseph.Salisbury@microsoft.com>
> 
> This patch only adds a MODULE_DESCRIPTION statement to the driver.
> This change is only cosmetic, so there should be no runtime impact.
> 
> Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is already in Linus' tree as commit
9d1c2f067e50bebb521ed6ced49ddf53bb1deba8

-- 
Dmitry

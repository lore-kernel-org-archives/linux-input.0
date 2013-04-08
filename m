From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: MT - handle semi-mt devices in core
Date: Sun, 7 Apr 2013 21:07:56 -0700
Message-ID: <20130408040756.GA6479@core.coreip.homeip.net>
References: <1365363692-986-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1365363692-986-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Apr 07, 2013 at 09:41:32PM +0200, Henrik Rydberg wrote:
> Most semi-mt drivers use the slots in a manual way, but really only
> need to treat the finger count manually. With this patch, a semi-mt
> driver may use the input-mt core for everything else.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Applied, thank you Henrik.

-- 
Dmitry

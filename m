From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.26-rc2-mm1: oops on ARM while registering GPIO Keys
Date: Wed, 14 May 2008 11:52:18 -0400
Message-ID: <20080514115114.ZZRA012@mailhub.coreip.homeip.net>
References: <alpine.DEB.1.00.0805141620080.3865@gamma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761744AbYENPwc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805141620080.3865@gamma>
Sender: linux-kernel-owner@vger.kernel.org
To: Byron Bradley <byron.bbradley@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, akpm@linux-foundation.org, nico@cam.org, buytenh@wantstofly.org
List-Id: linux-input@vger.kernel.org

On Wed, May 14, 2008 at 04:34:41PM +0100, Byron Bradley wrote:
> Testing on a QNAP TS-209 (ARM, Marvell Orion 88F5182 SoC). GPIO Keys works 
> correctly on 2.6.26-rc2 but panics on 2.6.26-rc2-mm1. If nobody knows the 
> cause of this I can look into it/bisect later.
> 

Yeah, it seems I applied the wrong version of the debouncing patch.
Just revert git-input from -mm for now.

-- 
Dmitry

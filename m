From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Make keyboard.c match braille-only keyboards
Date: Sat, 31 Jul 2010 02:43:04 -0700
Message-ID: <20100731094304.GA3533@core.coreip.homeip.net>
References: <20100730204117.GI4824@const.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100730204117.GI4824@const.famille.thibault.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jul 30, 2010 at 10:41:18PM +0200, Samuel Thibault wrote:
> drivers/char/keyboard.c also handles braille keys, so it should also match
> braille-only keyboards.
> 

Applied to 'next', thanks Samuel.

-- 
Dmitry

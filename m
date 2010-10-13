From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH/RFC] input: hil_mlc - Fix hil_mlc_serio_id file2alias
 failure
Date: Tue, 12 Oct 2010 23:56:02 -0700
Message-ID: <20101013065602.GA7014@core.coreip.homeip.net>
References: <alpine.DEB.2.00.1010122111270.6491@ayla.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1010122111270.6491@ayla.of.borg>
Sender: linux-next-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dzianis Kahanovich <mahatma@eu.by>, Helge Deller <deller@gmx.de>, linux-next@vger.kernel.org, linux-input@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, linux-parisc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 12, 2010 at 09:17:49PM +0200, Geert Uytterhoeven wrote:
> Commit e288bf7c346360ac9dafbc1b6d7b6b1a82b51616 ("Input: HIL keyboard and
> serio - add missing MODULE_DEVICE_TABLE()") caused the following build
> failure on m68k/allmodconfig:
> 
> FATAL: drivers/input/serio/hil_mlc: struct serio_device_id is not terminated with a NULL entry!
> 
> hil_mlc_serio_id is not an array, but a single struct serio_device_id entry.
> Fix the build by converting it into an array, and adding a NULL entry.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Build failure in linux-next:
> http://kisskb.ellerman.id.au/kisskb/buildresult/3385851/
> 
> I'm not sure this is the right fix, as hil_mlc_serio_id is a catch-all ID.
> Perhaps the MODULE_DEVICE_TABLE() should just be removed again instead?
> 

Gah, that original patch was incorrect, I should not have applied it at
all... The serio_device_id in question is for serio port that is being
created by the driver and thus of course should not be used in
MODULE_DEVICE_TABLE().

I'll drop it from my 'next' queue.

-- 
Dmitry

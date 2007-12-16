From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Tosa keyboard support
Date: Sun, 16 Dec 2007 10:29:12 +0000
Message-ID: <20071216102911.GA2307@flint.arm.linux.org.uk>
References: <20071211152318.GA8344@doriath.ww600.siemens.net> <20071211153851.GA14156@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765216AbXLPK3s@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071211153851.GA14156@doriath.ww600.siemens.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Marcin Juszkiewicz <openembedded@hrw.one.pl>, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-input@vger.kernel.org

On Tue, Dec 11, 2007 at 06:38:51PM +0300, Dmitry Baryshkov wrote:
> Sorry, posted wrong version of patch. Here is correct version:
> 
> Support keyboard on tosa (Sharp Zaurus SL-6000x).
> Largely based on patches by Dirk Opfer.

Looks fine to me, but Dmitry Torokhov needs to look at it; he maintains
the input subsystem.  Note that the current input subsystem mailing list
is not the one you have in the CC line - please always check MAINTAINERS
for the correct addresses.


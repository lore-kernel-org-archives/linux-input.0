From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] psmouse: disable the synaptics extension on OLPC
 machines.
Date: Fri, 17 Dec 2010 21:49:28 -0800
Message-ID: <20101218054927.GA14718@core.coreip.homeip.net>
References: <20101217210939.19b6111a@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101217210939.19b6111a@queued.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dsd@laptop.org, pgf@laptop.org, James Cameron <quozl@laptop.org>
List-Id: linux-input@vger.kernel.org

On Fri, Dec 17, 2010 at 09:09:39PM -0800, Andres Salomon wrote:
> 
> OLPC has switched to a Synaptics touchpad.  It turns out that it's
> pretty useless in absolute mode.  This patch looks for an OLPC
> system (via DMI tables), and refuses to init Synaptics mode in
> that scenario (falling back to relative mode).
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Andres,

Can we do what hgpk does and add "depend on !OLPC" to the Kconfig
instead?

Thanks.

-- 
Dmitry

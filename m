From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: use IS_ENABLED() instead of checking for built-in
 or module
Date: Tue, 2 Aug 2016 16:42:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1608021641570.22028@cbobk.fhfr.pm>
References: <1469114754-2650-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469114754-2650-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 21 Jul 2016, Javier Martinez Canillas wrote:

> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
> built-in or as a module, use that macro instead of open coding the same.
> 
> Using the macro makes the code more readable by helping abstract away some
> of the Kconfig built-in and module enable details.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

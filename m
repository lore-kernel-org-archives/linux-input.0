From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/29] ARM: OMAP1: Move keypad.h from plat to mach
Date: Thu, 20 Sep 2012 11:14:37 -0700
Message-ID: <20120920181436.GE28835@atomide.com>
References: <20120919205732.28074.43697.stgit@muffinssi>
 <20120919210549.28074.7146.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120919210549.28074.7146.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120919 14:07]:
> This is only used by omap1.

Turns out this one is already taken care of by Arnd's
platform data patches, so I'll drop this one.

Regards,

Tony

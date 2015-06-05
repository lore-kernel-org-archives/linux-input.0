From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] CHROMIUM: elants_i2c: Solved previous issue on 3.10 and
 3.14.
Date: Thu, 4 Jun 2015 22:38:28 -0700
Message-ID: <20150605053828.GC29704@dtor-ws>
References: <1433315176-12805-1-git-send-email-james.chen@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433315176-12805-1-git-send-email-james.chen@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: "james.chen" <james.chen@emc.com.tw>
Cc: Herman Lin <herman.lin@emc.com.tw>, Scott Liu <scott.liu@emc.com.tw>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jeff Chuang <jeff.chuang@emc.com.tw>, Agnes Cheng <agnescheng@google.com>
List-Id: linux-input@vger.kernel.org

Hi James,

On Wed, Jun 03, 2015 at 03:06:16PM +0800, james.chen wrote:
> From: "james.chen" <james.chen@emc.com.tw>
> 
> This patch refer 3.10 driver code to solve firmware upgrade
> issue(Change 266813) and enable noise-immunity(Change 243875).
> 
> BUG=chrome-os-partner:39373
> TEST=Test Elan Touch Screen on cyan project without problems.

As I mentioned elsewhere this does not simply address firmware upgrade
and noise immunity issues but rather overlays version that can be found
in 3.10 ChromeOS kernel on top of mainline driver, removing a lot of
cleanups and fixes that went into preparing the driver for mainline
inclusion.

Thanks.

-- 
Dmitry

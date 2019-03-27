From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 4/4] Input: add Apple SPI keyboard and trackpad
 driver.
Date: Wed, 27 Mar 2019 15:15:38 -0400
Message-ID: <20190327151538.2ca6ac83@gandalf.local.home>
References: <20190327014807.7472-1-ronald@innovation.ch>
        <20190327014807.7472-5-ronald@innovation.ch>
        <20190327093530.GH9224@smile.fi.intel.com>
        <20190327184526.GA11095@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327184526.GA11095@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ronald =?UTF-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 27 Mar 2019 19:45:26 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > > +// SPDX-License-Identifier: GPL-2.0  
> > 
> > According to last changes this should be GPL-2.0-only  
> 
> What "last changes"?  "GPL-2.0" is a totally valid SPDX identifier for
> the kernel.  Don't buy into the "-only" prefix crud that the newer SPDX
> version adopted for crazy reasons.  The in-kernel documentation lists
> the valid identifiers and the version of SPDX we are currently using.

According to: LICENSES/preferred/GPL-2.0

> SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
> Usage-Guide:
>   To use this license in source code, put one of the following SPDX
>   tag/value pairs into a comment according to the placement
>   guidelines in the licensing rules documentation.
>   For 'GNU General Public License (GPL) version 2 only' use:
>     SPDX-License-Identifier: GPL-2.0
>   or
>     SPDX-License-Identifier: GPL-2.0-only
>   For 'GNU General Public License (GPL) version 2 or any later version' use:
>     SPDX-License-Identifier: GPL-2.0+
>   or
>     SPDX-License-Identifier: GPL-2.0-or-later

So, GPL-2.0 is the same as GPL-2.0-only. Changing it from one to the
other doesn't make any difference.

-- Steve

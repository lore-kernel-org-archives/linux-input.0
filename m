From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 4/4] Input: goodix - Support interchanging x and y
 coordinates in hardware
Date: Thu, 27 Oct 2016 12:34:31 +0200
Message-ID: <1477564471.2458.11.camel@hadess.net>
References: <20161020195917.20051-1-fcooper@ti.com>
         <20161020195917.20051-5-fcooper@ti.com>
         <20161026231816.a35orxe3mpsvcx3m@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161026231816.a35orxe3mpsvcx3m@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Franklin S Cooper Jr <fcooper@ti.com>
Cc: dmitry.torokhov@gmail.com, octavian.purdila@intel.com, irina.tirdea@intel.com, merker@debian.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, nm@ti.com
List-Id: linux-input@vger.kernel.org

On Wed, 2016-10-26 at 18:18 -0500, Rob Herring wrote:
> On Thu, Oct 20, 2016 at 02:59:17PM -0500, Franklin S Cooper Jr wrote:
> > 
<snip>
> I'm not sure I follow why existing properties don't cover this.

Me neither. I certainly don't understand why the driver can't mangle
the data from the touchscreen all it wants. It's not like user-space is
talking to the touchscreen directly.

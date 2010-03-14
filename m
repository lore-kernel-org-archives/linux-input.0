From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Added locks for sysfs attributes and internal data.
Date: Sun, 14 Mar 2010 00:42:15 -0800
Message-ID: <20100314084215.GA8226@core.coreip.homeip.net>
References: <201002200911.53900.stefan_achatz@web.de>
 <201003081704.30119.stefan_achatz@web.de>
 <20100309074155.GA17288@core.coreip.homeip.net>
 <201003131219.27482.erazor_de@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201003131219.27482.erazor_de@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Jiri Kosina <jkosina@suse.cz>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, wylda@volny.cz, Pavel Machek <pavel@suse.cz>, Alessandro Guido <ag@alessandroguido.name>, Tomas Hanak <tomas.hanak@gmail.com>, Jason Noble <nobleja@polezero.com>, simon.windows@gmail.com, Sean Hildebrand <silverwraithii@gmail.com>, Sid Boyce <sboyce@blueyonder.co.uk>, Henning Glawe <glaweh@debian.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Stefan,

On Sat, Mar 13, 2010 at 12:19:27PM +0100, Stefan Achatz wrote:
> Hello,
> I have some more questions regarding the work on my driver:
> 
> 1. binary vs text sysfs attributes
> As I found little information about binary sysfs attributes I used the normal 
> sysfs attributes to transfer binary data because they are also easier to use. 
> The transfered data is far less than the 4096 bytes minimum page size.
> So, is there a significant difference in these two variants that should force 
> me to use the binary variant?
> 

I'd say in this case it just sets expectations for the interface -
normal sysfs attributes are supposed to pass data in human-readable
form, one value per attribute.

> 2. memory footprint
> I'm thinking about a redesign of my sysfs attributes to reduce io and simplify 
> the use of binary sysfs attributes (if needed, see above). This would 
> increase the memory footprint of hid_drvdata to around 5kbytes.
> Is it allowed for a driver to constantly alloc such an amount of data or 
> should I stick with more complicated code and more io?

5K is not that much but why do you think binary attributes will require
such increase?

> 
> 3. grow up of driver
> I see my work is not quite ready for kernel inclusion. Maybe I'm wrong in this 
> list and should bug other people. Would the linuxdriverproject.org be a 
> better place to raise my work to adulthood?
> 

Rarely a driver is ready for inclusion right away ;) Normally that
happens after someone submitted a few of them to the same subsystem so
he knows maintainers perferences, etc. I'd say you are doing well as is
here, there is no sense to move away somewhere else at this point.

Thanks.

-- 
Dmitry

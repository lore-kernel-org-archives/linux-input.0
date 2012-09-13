From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: input_to_handler: unable to handle kernel NULL pointer
 dereference
Date: Thu, 13 Sep 2012 19:41:08 +0200
Message-ID: <20120913174108.GA3099@polaris.bitmath.org>
References: <5051F648.8030003@suse.cz>
 <20120913155738.GA3519@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120913155738.GA3519@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-input@vger.kernel.org

On Thu, Sep 13, 2012 at 08:57:38AM -0700, Dmitry Torokhov wrote:
> On Thu, Sep 13, 2012 at 05:05:44PM +0200, Jiri Slaby wrote:
> > Hi,
> > 
> > -next commit "Input: Send events one packet at a time" seems like broke
> > the input layer:
> 
> Right, Henrik has a patch for this.

Yep, it just missed the cut for today, but will appear in tomorrow's
-next.

Thanks,
Henrik

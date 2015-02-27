From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] [PATCH 1/7] thinkpad_acpi: Remember adaptive kbd
 presence
Date: Fri, 27 Feb 2015 08:16:19 -0300
Message-ID: <1425035779.2000837.233193809.65561A3E@webmail.messagingengine.com>
References: <1424443450.22910.13.camel@hadess.net>
 <20150226061814.GC7331@fury.dvhart.com>
 <1425035130.1995042.233191101.57145444@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1425035130.1995042.233191101.57145444@webmail.messagingengine.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Feb 27, 2015, at 08:05, Henrique de Moraes Holschuh wrote:
> On Thu, Feb 26, 2015, at 03:18, Darren Hart wrote:
> > On Fri, Feb 20, 2015 at 03:44:10PM +0100, Bastien Nocera wrote:
> > > Rather than checking on each suspend and resume whether the laptop
> > > has an adaptive keyboard, check when the driver is initialised.
> > 
> > Bastien, am I awaiting another version of this from you to address
> > comments from
> > Henrique?
> > 
> > Henrique, when you're satisfied, please provide a Reviewed-by for the
> > series.
> 
> I usually provide a signed-off-by, as I am the thinkpad-acpi driver
> maintainer... reviewed-by is implied in that case.

Or an Acked-by, for that matter.  Which is what I'd use for this series,
since there is no reason to gatekeep it and it is being sent to you
directly.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

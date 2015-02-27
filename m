From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/7] thinkpad_acpi: Remember adaptive kbd presence
Date: Fri, 27 Feb 2015 08:15:01 -0300
Message-ID: <1425035701.2000092.233191529.45B58E4B@webmail.messagingengine.com>
References: <1424443450.22910.13.camel@hadess.net>
 <20150226061814.GC7331@fury.dvhart.com>
 <1424949752.2459.14.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1424949752.2459.14.camel@hadess.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Darren Hart <dvhart@infradead.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Thu, Feb 26, 2015, at 08:22, Bastien Nocera wrote:
> On Wed, 2015-02-25 at 22:18 -0800, Darren Hart wrote:
> > On Fri, Feb 20, 2015 at 03:44:10PM +0100, Bastien Nocera wrote:
> > > Rather than checking on each suspend and resume whether the laptop
> > > has an adaptive keyboard, check when the driver is initialised.
> > 
> > Bastien, am I awaiting another version of this from you to address comments from
> > Henrique?
> 
> I was waiting for more comments on the additional keycodes from Dmitry
> and Jiri.
> 
> > Henrique, when you're satisfied, please provide a Reviewed-by for the series.
> 
> I can send the first 5 patches of that series if you want to land it
> soon.

Please write the missing patch with the documentation update, and add it
to the next version of the series...

We could then merge this series without any new keycodes ASAP through
the platform-x86 tree, and add new keycodes later through either the
input tree or the platform-x86 tree, whichever Dmitry and Darren feel
best.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

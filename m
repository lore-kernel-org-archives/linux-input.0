From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [PATCH 1/7] thinkpad_acpi: Remember adaptive
 kbd presence
Date: Tue, 03 Mar 2015 15:39:54 -0300
Message-ID: <1425407994.1004750.235001957.08166EE5@webmail.messagingengine.com>
References: <1424443450.22910.13.camel@hadess.net>
	<20150226061814.GC7331@fury.dvhart.com>
	<1425035130.1995042.233191101.57145444@webmail.messagingengine.com>
	<1425035779.2000837.233193809.65561A3E@webmail.messagingengine.com>
	<20150303165225.GD83894@vmdeb7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20150303165225.GD83894@vmdeb7>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 3, 2015, at 13:52, Darren Hart wrote:
> Henrique, I believe I may have overstepped with thinkpad-acpi and dealt
> with it like the other drivers in platform/drivers/x86, when instead I should
> have been leaving it to you. My apologies, it was not intentional.

No harm done!  And I did appreciate the extra help :-)

> Do you typically send pull-requests for the thinkpad-acpi driver directly to Linus?

thinkpad-acpi is part of the platform-x86 subsystem, so IMHO it should
continue to be merged through your tree if you are okay with that.

I'd really appreciate if the typical patch approval flux would go
through me first.  However, I certainly don't mind if you merge patches
directly should I be unresponsible for some reason, or when they are
part of the usual tree-wide spot fixes for some pattern/anti-pattern,
etc.

> I would be more than happy to basically ignore anything to thinkpad-acpi until
> after you have provided a review. I can also roll up pull requests from
> you if you prefer to integrate into the platform-drivers-x86 tree as the path to
> Linus.

Well, if it is fine with you, I'd suggest we continue with the process
used in this patchset, where I will reply to patches in this ML with a
reviewed-by or acked-by before you merge them.

If you want to change that at some point, just drop me a note and I will
start pushing patches to you either through this ML or through signed
pull requests, whichever you prefer.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/

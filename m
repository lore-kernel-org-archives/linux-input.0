From: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/8 V5] Many fixes for in-kernel decoding and for the
	ENE driver
Date: Thu, 14 Oct 2010 04:36:30 +0200
Message-ID: <1287023790.11191.4.camel@maxim-laptop>
References: <1283808373-27876-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lirc-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1283808373-27876-1-git-send-email-maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/lirc-list>,
	<mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=lirc-list>
List-Post: <mailto:lirc-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/lirc-list>,
	<mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: lirc-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lirc-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 2010-09-07 at 00:26 +0300, Maxim Levitsky wrote:
> Hi,
> 
> Here is full overview of my patches:
> 
> Patch #1 fixes races in ir thread.
> It fixes the case when ktherad_stop waits forever for the thread.
> This happens on module unload and therefore it never finishes.
> Sorry for introducing this bug.
> 
> Patch #2, fixes a crash on my module load.
> It happens because ir core initializes the input device a bit early,
> therefore it could be accessed while still not set up.
> 
> Patch #3 fixes a small typo in lirc code that makes it impossible to use tx duty cycle setting.
> 
> Patch #4 fixes a problem seen on my system that results in stuck down forever key.
> 
> Patch #5 adds few keys to MCE keymap that were found on laptop of an user I tested this driver with
> 
> Patch #6, is a combined update ti my driver. It contains lot of refactoring thanks to docs I have now,
> and lot of fixes, and supports latest version of firmware (and I have 4 users asking for that)
> It is quite huge, but it would be a tedios job to break it up. This can't introduce regressions
> because the ene_ir was never released. In addition to that it was tested by me and another two users.
> 
> Patch #7 the really only patch that touches drivers I don't have does touch the ir-core.
> It is quite small, and it adds a proper solution to dilema about what to do with huge space between keypresses.
> Now this space is just truncated by the driver with timeout flag.
> The lirc codec then ensures that right sample is send to the lircd.
> Please review and test it.
> 
> Patch #8 is very simple. It just builds on top of patch #7 and adds carrier reports to ene driver.
> 

Any update?
Should I resent these (didn't change anything I think).
What about other work that conflicts with this?
What are the plans for (very close) merge window?

Best regards,
	Maxim Levitsky



------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb

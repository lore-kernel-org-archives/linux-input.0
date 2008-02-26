From: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/3] fbdev: Make deferred I/O work
	as advertized
Date: Tue, 26 Feb 2008 15:45:43 +0100
Message-ID: <871w6z6ajs.fsf@pike.pond.sub.org>
References: <87tzjx6vj3.fsf@pike.pond.sub.org>
	<87k5kt6vd3.fsf@pike.pond.sub.org>
	<45a44e480802260611l5a8d0bc9k9cc967bc73b88fac@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45a44e480802260611l5a8d0bc9k9cc967bc73b88fac@mail.gmail.com>
	(Jaya Kumar's message of "Tue\, 26 Feb 2008 09\:11\:45 -0500")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, linux-input@vger.kernel.org, adaplas@pol.net, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

"Jaya Kumar" <jayakumar.lkml@gmail.com> writes:

> On Mon, Feb 25, 2008 at 8:03 AM, Markus Armbruster <armbru@redhat.com> wrote:
>>
>>     Subject: [PATCH 1/1 2.6.24] fbdev: defio and Metronomefb
>>     From: Jaya Kumar <jayakumar.lkml@gmail.com>
>>     Date: 2008-02-18 13:41:26
>
> Hi Markus,
>
> Andrew pointed out that there may be race conditions associated with
> this patch. [ http://marc.info/?l=linux-fbdev-devel&m=120376473020396&w=2
> ] So I would not encourage anyone to merge it. I'll try to figure
> things out this weekend.
>
> Thanks,
> jaya

Thanks for the timely info.  I'm not in an undue hurry to get this
merged.  As long as we're moving forward, I'm happy.

What about pushing the fb_defio fixes independently of any new
fb_defio users?  If fb_defio was worth merging into Linus's tree, it
should be worth fixing there, whether new users are in shape already
or not.

If we must have a new user, well, I could easily whip up something
like FB_VIRTUAL on top of fb_defio.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

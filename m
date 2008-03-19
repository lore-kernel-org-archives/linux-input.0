From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] fbdev: Make deferred I/O work
	as advertized
Date: Wed, 19 Mar 2008 15:39:46 -0700
Message-ID: <20080319153946.a5a8060e.akpm@linux-foundation.org>
References: <87tzjx6vj3.fsf@pike.pond.sub.org>
	<87k5kt6vd3.fsf@pike.pond.sub.org>
	<45a44e480802260611l5a8d0bc9k9cc967bc73b88fac@mail.gmail.com>
	<871w6z6ajs.fsf@pike.pond.sub.org>
	<45a44e480802260701o7c616e3bjd5f86f4143be791b@mail.gmail.com>
	<87iqzjat6e.fsf@pike.pond.sub.org>
	<45a44e480803190424s51b85efbk39ab3bfce4cb924a@mail.gmail.com>
	<20080319113745.d3873de0.akpm@linux-foundation.org>
	<45a44e480803191530p27ec9575l260d6de063a8d6bf@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45a44e480803191530p27ec9575l260d6de063a8d6bf@mail.gmail.com>
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
Cc: xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, armbru@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, linux-input@vger.kernel.org, adaplas@pol.net
List-Id: linux-input@vger.kernel.org

On Thu, 20 Mar 2008 06:30:37 +0800
"Jaya Kumar" <jayakumar.lkml@gmail.com> wrote:

> On Thu, Mar 20, 2008 at 2:37 AM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> >  Do we need some of all of that patch in 2.6.25?  I wasn't aware of such a
> >  need.
> >
> >  If the drivers/video/fb_defio.c hunk of that patch fixes something then I'd
> >  be inclined to merge the whole thing - adding a new driver won't hurt
> >  anyone.
> >
> 
> Yes, the defio hunk is a bugfix. I agree with pushing the whole thing
> to 2.6.25 if there are people who need it in 2.6.25. I believe there
> is no risk of impact on anyone else.
> 

Well all we have in the changelog is

  Implement support for the E-Ink Metronome controller.  It provides an
  mmapable interface to the controller using defio support.  It was tested
  with a gumstix pxa255 with Vizplex media using Xfbdev and various X
  clients such as xeyes, xpdf, xloadimage.

grump.  This say nothing at all about the change to drivers/video/fb_defio.c.

a) the changelog _should_ document this change.  Please send a paragraph and
   I'll add it.

b) If this discussion hadn't happened, that bug (whatever it is) would
   have remained unfixed in 2.6.25.  As a direct consequence of poor
   changelogging.

c) This bugfix (whatever it is) should have been in a separate patch.

Thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

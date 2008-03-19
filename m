From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 2/3] fbdev: Make deferred I/O work
	as advertized
Date: Thu, 20 Mar 2008 06:55:11 +0800
Message-ID: <45a44e480803191555vfcfe493r4f2fd267097d9a38@mail.gmail.com>
References: <87tzjx6vj3.fsf@pike.pond.sub.org>
	<87k5kt6vd3.fsf@pike.pond.sub.org>
	<45a44e480802260611l5a8d0bc9k9cc967bc73b88fac@mail.gmail.com>
	<871w6z6ajs.fsf@pike.pond.sub.org>
	<45a44e480802260701o7c616e3bjd5f86f4143be791b@mail.gmail.com>
	<87iqzjat6e.fsf@pike.pond.sub.org>
	<45a44e480803190424s51b85efbk39ab3bfce4cb924a@mail.gmail.com>
	<20080319113745.d3873de0.akpm@linux-foundation.org>
	<45a44e480803191530p27ec9575l260d6de063a8d6bf@mail.gmail.com>
	<20080319153946.a5a8060e.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20080319153946.a5a8060e.akpm@linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, armbru@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, linux-input@vger.kernel.org, adaplas@pol.net
List-Id: linux-input@vger.kernel.org

On Thu, Mar 20, 2008 at 6:39 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
>
>  Well all we have in the changelog is
>
>   Implement support for the E-Ink Metronome controller.  It provides an
>   mmapable interface to the controller using defio support.  It was tested
>   with a gumstix pxa255 with Vizplex media using Xfbdev and various X
>   clients such as xeyes, xpdf, xloadimage.
>
>  grump.  This say nothing at all about the change to drivers/video/fb_defio.c.

I apologize. I should have done better.

>
>  a) the changelog _should_ document this change.  Please send a paragraph and
>    I'll add it.

This patch fixes the following bug. Defio would cause a hang on write
access to the framebuffer as the page fault would be called
ad-infinitum. It fixes fb_defio by setting the mapping to be used by
page_mkclean.

>
>  b) If this discussion hadn't happened, that bug (whatever it is) would
>    have remained unfixed in 2.6.25.  As a direct consequence of poor
>    changelogging.

Understood. The root cause of my flaw was my assumption that other
than me, there weren't any users of defio so I was in no hurry to get
it fixed.

>
>  c) This bugfix (whatever it is) should have been in a separate patch.

Understood. It won't happen again.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

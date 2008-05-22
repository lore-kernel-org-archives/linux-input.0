From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] xen: Enable console tty by
 default in domU if it's not a dummy
Date: Wed, 21 May 2008 17:26:13 -0700
Message-ID: <20080521172613.18eb24c4.akpm@linux-foundation.org>
References: <87d4ngm4s4.fsf@pike.pond.sub.org>
	<878wy4m4px.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <878wy4m4px.fsf@pike.pond.sub.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Markus Armbruster <armbru@redhat.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, plc@novell.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 21 May 2008 10:38:50 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Without console= arguments on the kernel command line, the first
> console to register becomes enabled and the preferred console (the one
> behind /dev/console).  This is normally tty (assuming
> CONFIG_VT_CONSOLE is enabled, which it commonly is).
> 
> This is okay as long tty is a useful console.  But unless we have the
> PV framebuffer, and it is enabled for this domain, tty0 in domU is
> merely a dummy.  In that case, we want the preferred console to be the
> Xen console hvc0, and we want it without having to fiddle with the
> kernel command line.  Commit b8c2d3dfbc117dff26058fbac316b8acfc2cb5f7
> did that for us.
> 
> Since we now have the PV framebuffer, we want to enable and prefer tty
> again, but only when PVFB is enabled.  But even then we still want to
> enable the Xen console as well.
> 
> Problem: when tty registers, we can't yet know whether the PVFB is
> enabled.  By the time we can know (xenstore is up), the console setup
> game is over.
> 
> Solution: enable console tty by default, but keep hvc as the preferred
> console.  Change the preferred console to tty when PVFB probes
> successfully, unless we've been given console kernel parameters.

What a stunningly good changelog - I'd buy the tee-shirt.

Ack on the non-xen bits.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

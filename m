From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 2/3] fbdev: Make deferred I/O work
	as advertized
Date: Wed, 19 Mar 2008 19:24:25 +0800
Message-ID: <45a44e480803190424s51b85efbk39ab3bfce4cb924a@mail.gmail.com>
References: <87tzjx6vj3.fsf@pike.pond.sub.org>
	<87k5kt6vd3.fsf@pike.pond.sub.org>
	<45a44e480802260611l5a8d0bc9k9cc967bc73b88fac@mail.gmail.com>
	<871w6z6ajs.fsf@pike.pond.sub.org>
	<45a44e480802260701o7c616e3bjd5f86f4143be791b@mail.gmail.com>
	<87iqzjat6e.fsf@pike.pond.sub.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <87iqzjat6e.fsf@pike.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, linux-input@vger.kernel.org, adaplas@pol.net, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 19, 2008 at 6:45 PM, Markus Armbruster <armbru@redhat.com> wrote:
>
>  Any progress on this?
>
>  Considering that fb_defio is utterly broken without the fix (writing
>  the frame buffer makes the VM endlessly invoke vm_ops.page_mkwrite()),
>  wouldn't it make sense to merge the fix even if it still has issues?
>

Yes, Andrew has merged the fix into -mm. I see it in mmotm

http://userweb.kernel.org/~akpm/mmotm/broken-out/fbdev-defio-and-metronomefb-v4.patch

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

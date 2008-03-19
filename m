From: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/3] fbdev: Make deferred I/O work
	as advertized
Date: Wed, 19 Mar 2008 11:45:29 +0100
Message-ID: <87iqzjat6e.fsf@pike.pond.sub.org>
References: <87tzjx6vj3.fsf@pike.pond.sub.org>
	<87k5kt6vd3.fsf@pike.pond.sub.org>
	<45a44e480802260611l5a8d0bc9k9cc967bc73b88fac@mail.gmail.com>
	<871w6z6ajs.fsf@pike.pond.sub.org>
	<45a44e480802260701o7c616e3bjd5f86f4143be791b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45a44e480802260701o7c616e3bjd5f86f4143be791b@mail.gmail.com>
	(Jaya Kumar's message of "Tue\, 26 Feb 2008 10\:01\:16 -0500")
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

> On Tue, Feb 26, 2008 at 9:45 AM, Markus Armbruster <armbru@redhat.com> wrote:
>>
>>  What about pushing the fb_defio fixes independently of any new
>>  fb_defio users?  If fb_defio was worth merging into Linus's tree, it
>>  should be worth fixing there, whether new users are in shape already
>>  or not.
>
> I think that Andrew's message is saying that there may be a race
> condition in the defio patch itself as opposed to the defio user
> patch.
>
> If there is no race condition or other problems, then I think it would
> make sense to merge the defio patch independent of metronomefb or
> other new patches that use defio.
>
> Thanks,
> jaya

Any progress on this?

Considering that fb_defio is utterly broken without the fix (writing
the frame buffer makes the VM endlessly invoke vm_ops.page_mkwrite()),
wouldn't it make sense to merge the fix even if it still has issues?

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

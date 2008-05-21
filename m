From: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/5] xen pvfb: Para-virtual
	framebuffer, keyboard and pointer driver updates
Date: Wed, 21 May 2008 11:54:29 +0200
Message-ID: <87lk24j82y.fsf@pike.pond.sub.org>
References: <87d4ngm4s4.fsf@pike.pond.sub.org> <4833E6BA.3060408@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4833E6BA.3060408@goop.org> (Jeremy Fitzhardinge's message of
	"Wed\, 21 May 2008 10\:09\:14 +0100")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, Pat Campbell <plc@novell.com>, linux-input@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Markus Armbruster wrote:
>> This is an update to the Linux part of the Xen PVFB.  Linux Xen PVFB
>> is a pair of Xen para-virtual frontend device drivers:
>> drivers/video/xen-fbfront.c provides a framebuffer, and
>> drivers/input/xen-kbdfront provides keyboard and mouse.  Their
>> backends run in dom0 user space.
>>
>> Parts in this patch series:
>>
>> 1. Enable Xen console by default in domU
>> 2. Pointer z-axis (mouse wheel) support
>> 3. Module aliases to support module autoloading
>> 4. Zero unused bytes in events sent to backend
>> 5. Dynamic mode support (screen resizing)
>>
>> To the best of my knowledge, these patches are independent.  The last
>> one needs a bit of trivial merging to apply without the first one.  I
>> tested only 1, 1+2, 1+2+3, 1+2+3+4, and the complete series.  I'm
>> happy to split this into different parts if that helps.
>>   
>
> Thanks Markus,
>
> This looks good.  I'll stick it into my queue and feed it via Ingo
> when I've given it a bit of a test.

Thanks!

> Are we happy that the preferred console stuff is now the best
> solution?  Does it solve your installer issues?
>
>    J

Yes, the console stuff works nicely for me, and the installer is
happy.

Note that I went with the stupidest solution that could possibly work
there: have a global flag that gets set when the command line sets
consoles, and don't mess with the console then.  Mark McLoughlin
suggested a somewhat less stupid way, namely to mark consoles selected
on the command line with a flag.  Critical review invited!

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

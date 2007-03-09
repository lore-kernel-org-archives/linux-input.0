From: Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [2/6] 2.6.21-rc2: known regressions
Date: Fri, 9 Mar 2007 18:48:21 +0100
Message-ID: <20070309174821.GA31754@linuxtv.org>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org>
	<20070305015034.GG3441@stusta.de>
	<20070308123143.GF5149@mellanox.co.il>
	<Pine.LNX.4.64.0703080954220.10832@woody.linux-foundation.org>
	<20070308192554.GA2999@elte.hu> <20070308230705.GA4611@elte.hu>
	<Pine.LNX.4.64.0703081545110.10832@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703081545110.10832@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ash Milsted <thatistosayiseenem@gawab.com>, dmitry.torokhov@gmail.com, Arkadiusz Miskiewicz <arekm@maven.pl>, linux-pm@lists.osdl.org, Jens Axboe <jens.axboe@oracle.com>, linux-input@atrey.karlin.mff.cuni.cz, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-usb-devel@lists.sourceforge.net, Jeff Chua <jeff.chua.linux@gmail.com>, Meelis Roos <mroos@linux.ee>, Janosch Machowinski <jmachowinski@gmx.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Thomas Meyer <thomas.mey@web.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 08, 2007, Linus Torvalds wrote:
> On Fri, 9 Mar 2007, Ingo Molnar wrote:
> > =

> > disabling the following radeonfb options in the .config made resume wor=
k =

> > again:
> =

> In general, don't even *try* to use radeonfb for suspend/resume.
> =

> I don't think it has ever worked, except on some very rare laptops =

> (largely PPC Macs) where people had enough information to set up the =

> PLL's.
> =

> I don't think the other framebuffer drivers are much better.
> =

> You're better off using the VGA console, and lettign X re-initialize the =

> graphics device. That generally at least has a reasonably good chance of =

> working.
> =

> Re-initializing graphics modes really is very hard. You can try with the =

> BIOS video hack (I forget the kernel command line to turn it on), but we =

> really do end up depending on X doing it better.

acpi_sleep=3Ds3_bios has always worked for me on my ThinkPad T42p.

Even if one doesn't use the fb console at all, radeonfb apparently
is still required on some ThinkPad models to work around BIOS bugs:

http://www.thinkwiki.org/wiki/Problem_with_high_power_drain_in_ACPI_sleep#R=
adeon_GPU_not_powered_off


Johannes

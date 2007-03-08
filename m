From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [2/6] 2.6.21-rc2: known regressions
Date: Thu, 8 Mar 2007 21:47:23 +0200
Message-ID: <20070308194723.GF17114@mellanox.co.il>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org>
	<20070305015034.GG3441@stusta.de>
	<20070308123143.GF5149@mellanox.co.il>
	<Pine.LNX.4.64.0703080954220.10832@woody.linux-foundation.org>
	<20070308190642.GA30517@elte.hu>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070308190642.GA30517@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Ash Milsted <thatistosayiseenem@gawab.com>, dmitry.torokhov@gmail.com, Arkadiusz Miskiewicz <arekm@maven.pl>, Jens Axboe <jens.axboe@oracle.com>, linux-input@atrey.karlin.mff.cuni.cz, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, linux-usb-devel@lists.sourceforge.net, Jeff Chua <jeff.chua.linux@gmail.com>, Meelis Roos <mroos@linux.ee>, Janosch Machowinski <jmachowinski@gmx.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Thomas Meyer <thomas.mey@web.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

> Quoting Ingo Molnar <mingo@elte.hu>:
> Subject: Re: [2/6] 2.6.21-rc2: known regressions
> =

> =

> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> =

> > > 3. When I switch to X (CTRL-ALT-F7), X hangs after drawing a couple o=
f windows
> > >    after waiting for some 10 min, I rebooted. no new messages showed =

> > >    up in /var/log/messages
> > =

> > I think this is likely just more of the disk being buggered, but it =

> > could again be related to NO_HZ (people report time not advancing, and =

> > that would make any X timeout taking forever, and you'd see exactly =

> > your behaviour).
> =

> Michael - does your 'date' output advance after resume? If not then i'd =

> say it's a NO_HZ related problem. If yes then i'd guess it's the SATA =

> problem.

I'll test, but I have NO_HZ off for now.

-- =

MST

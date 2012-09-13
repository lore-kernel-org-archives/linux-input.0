From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: linux-next: Tree for Sept 13 (input causes kernel-panic)
Date: Thu, 13 Sep 2012 11:12:26 +0200
Message-ID: <CA+icZUUi3DgkyZe57=zB2tqS95F-uwt_qGtRLjoPxd6baE6APQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Minchan Kim <minchan.kim@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Sep 13, 2012 at 10:22 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Changes since 201209012:
>
> The staging tree gained a conflict against the tty tree.
>
> The arm-soc tree gained a conflict against the i2c-embedded tree.
>
> The tegra tree lost 2 conflicts.
>
> The akpm tree gained 3 build failures for which I applied a merge fix
> patch and reverted 3 commits.
>
> ----------------------------------------------------------------------------
>

Unfortunately, for me an important fix did not make it into today's Linux-Next.
So, this is a warning for people (like Minchan) seeing the same kernel-panic.
( Please. follow also the discussion thread in [2] for more details. )

Thanks to all involved people!

- Sedat -

[1] https://github.com/rydberg/linux/commit/ccc6557bfd02efdca4d9dfda6cfdfe5a08d0193b
[2] http://marc.info/?t=134751435100001&r=1&w=2

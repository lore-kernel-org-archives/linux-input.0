From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: atakbd.c - fix Atari CapsLock behaviour
Date: Mon, 17 Sep 2018 15:36:27 -0700
Message-ID: <20180917223627.GC203020@dtor-ws>
References: <1536277243-3821-1-git-send-email-schmitzmic@gmail.com>
 <1536277243-3821-3-git-send-email-schmitzmic@gmail.com>
 <20180917194310.GA171258@dtor-ws>
 <87in33hnqj.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-68k=debian-68k=m.gmane.org@lists.debian.org>
Content-Disposition: inline
In-Reply-To: <87in33hnqj.fsf@igel.home>
Resent-Message-ID: <6cOU0PE0yHG.A.-aE.RCDobB@bendel>
List-URL: <https://lists.debian.org/debian-68k/>
List-Post: <mailto:debian-68k@lists.debian.org>
List-Help: <mailto:debian-68k-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-68k-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-68k-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/20180917223627.GC203020@dtor-ws
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, linux-input@vger.kernel.org, debian-68k@lists.debian.org, linux-m68k@lists.linux-m68k.org
List-Id: linux-input@vger.kernel.org

On Mon, Sep 17, 2018 at 10:29:08PM +0200, Andreas Schwab wrote:
> On Sep 17 2018, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Fri, Sep 07, 2018 at 11:40:43AM +1200, Michael Schmitz wrote:
> >> The CapsLock key on Atari keyboards is not a toggle, it does send the
> >> normal make and break scancodes.
> >> 
> >> Drop the CapsLock toggle handling code, which did cause the CapsLock
> >> key to merely act as a Shift key.
> >> 
> >> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
> >> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> >
> > Andreas, I have no idea how Atari keyboards work, can you add your
> > signed-off-by (or NAK) to this one as well please?
> 
> The old atakbd driver never had that special handling.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Applied, thank you.

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: atakbd.c - fix Atari CapsLock behaviour
Date: Tue, 18 Sep 2018 10:08:56 -0700
Message-ID: <20180918170856.GE177805@dtor-ws>
References: <1536277243-3821-1-git-send-email-schmitzmic@gmail.com>
 <1536277243-3821-3-git-send-email-schmitzmic@gmail.com>
 <20180917194310.GA171258@dtor-ws>
 <87in33hnqj.fsf@igel.home>
 <20180917223627.GC203020@dtor-ws>
 <136f4a00-ba74-a705-ef31-29c60eb51aa1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-68k=debian-68k=m.gmane.org@lists.debian.org>
Content-Disposition: inline
In-Reply-To: <136f4a00-ba74-a705-ef31-29c60eb51aa1@gmail.com>
Resent-Message-ID: <OKrAm8ynaAB.A.2ND.tVTobB@bendel>
List-URL: <https://lists.debian.org/debian-68k/>
List-Post: <mailto:debian-68k@lists.debian.org>
List-Help: <mailto:debian-68k-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-68k-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-68k-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/20180918170856.GE177805@dtor-ws
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>, linux-input@vger.kernel.org, debian-68k@lists.debian.org, linux-m68k@lists.linux-m68k.org
List-Id: linux-input@vger.kernel.org

Hi Michael,

On Tue, Sep 18, 2018 at 02:03:29PM +1200, Michael Schmitz wrote:
> Thanks Dmitry!
> 
> I had asked Andreas' signoff for his keymap fixes only - the rewrite of the
> Atari keyboard driver to the current input framework (and hence the CapsLock
> toggle bug) was entirely mine, no blame attaches to Andreas there.

It was not about blame, it was about helping me to check the sanity of
the patch given I have no idea about the hardware ;)

Thanks.

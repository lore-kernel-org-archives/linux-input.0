From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/2] input: atakbd.c - fix Atari CapsLock behaviour
Date: Mon, 17 Sep 2018 22:29:08 +0200
Message-ID: <87in33hnqj.fsf@igel.home>
References: <1536277243-3821-1-git-send-email-schmitzmic@gmail.com>
	<1536277243-3821-3-git-send-email-schmitzmic@gmail.com>
	<20180917194310.GA171258@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <bounce-debian-68k=debian-68k=m.gmane.org@lists.debian.org>
In-Reply-To: <20180917194310.GA171258@dtor-ws> (Dmitry Torokhov's message of
	"Mon, 17 Sep 2018 12:43:10 -0700")
Resent-Message-ID: <R74nxT4rubK.A.jlB.aJBobB@bendel>
List-URL: <https://lists.debian.org/debian-68k/>
List-Post: <mailto:debian-68k@lists.debian.org>
List-Help: <mailto:debian-68k-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-68k-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-68k-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/87in33hnqj.fsf@igel.home
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Schmitz <schmitzmic@gmail.com>, linux-input@vger.kernel.org, debian-68k@lists.debian.org, linux-m68k@lists.linux-m68k.org
List-Id: linux-input@vger.kernel.org

On Sep 17 2018, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Fri, Sep 07, 2018 at 11:40:43AM +1200, Michael Schmitz wrote:
>> The CapsLock key on Atari keyboards is not a toggle, it does send the
>> normal make and break scancodes.
>> 
>> Drop the CapsLock toggle handling code, which did cause the CapsLock
>> key to merely act as a Shift key.
>> 
>> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
> Andreas, I have no idea how Atari keyboards work, can you add your
> signed-off-by (or NAK) to this one as well please?

The old atakbd driver never had that special handling.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Andreas.

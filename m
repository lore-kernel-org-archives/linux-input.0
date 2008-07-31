From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for July 30
Date: Wed, 30 Jul 2008 23:10:29 -0700
Message-ID: <20080730231029.9818953c.akpm@linux-foundation.org>
References: <20080730170635.f737ffe9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080730170635.f737ffe9.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 30 Jul 2008 17:06:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git

The X server broke on my FC8 t61p thinkpad.  Mainline is OK.

Various information is at http://userweb.kernel.org/~akpm/mo/

I'm suspecting the input layer - my synaptics device seems to have
disappeared?  See http://userweb.kernel.org/~akpm/mo/Xorg-log-diff.txt

From: Michal Marek <mmarek@suse.cz>
Subject: Re: any value in running my kernel scanning scripts before release?
Date: Thu, 15 Jul 2010 15:28:59 +0200
Message-ID: <4C3F0D1B.9060403@suse.cz>
References: <alpine.DEB.2.00.1007150728520.13042@lynx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1007150728520.13042@lynx>
Sender: linux-kernel-owner@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 07/15/2010 01:32 PM, Robert P. J. Day wrote:
> 
>   normally i wait for the merge window, then run my kernel scanning
> scripts and post results.  any interest in me doing that earlier?  i
> just did a quick test and found a number of incongruities like, for
> example:
> 
> $ grep -r "config QT2160" *
> drivers/input/keyboard/Kconfig:config QT2160
> $
> 
> $ grep -r KEYBOARD_QT2160 *
> drivers/input/keyboard/Makefile:obj-$(CONFIG_KEYBOARD_QT2160) += qt2160.o
> $

These are plain bugs, so it's IMO OK to send fixes for these at any time
before the final release. In the worst case, it will be merged after the
final release.

just my two cents,
Michal

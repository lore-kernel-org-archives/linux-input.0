From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/03] sh: SuperH KEYSC keypad support
Date: Fri, 29 Feb 2008 14:01:47 -0800
Message-ID: <20080229140147.0d01afad.akpm@linux-foundation.org>
References: <20080229104847.22537.66432.sendpatchset@clockwork.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:55083 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932157AbYB2WCm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Feb 2008 17:02:42 -0500
In-Reply-To: <20080229104847.22537.66432.sendpatchset@clockwork.opensource.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, magnus.damm@gmail.com, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Fri, 29 Feb 2008 19:48:47 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> These patches add support for keypads attached to the SuperH KEYSC block.
> 
> [PATCH 01/03] sh: SuperH KEYSC platform driver
> [PATCH 02/03] sh: SuperH KEYSC support for MigoR
> [PATCH 03/03] sh: SuperH KEYSC support for Solution Engine 7722
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Please note that the board patches need the header file provided by
>  the first patch to compile. So maybe this is suitable for -mm?

The diffstat looks pretty tame to me - this could be merged via either
git-input or git-sh.  Probably the latter.

>  If it is better to merge the driver in some subsystem tree then I'll
>  just resend the board code to the linux-sh list during late -rc1 merge.

That would be a bad time to send it.  We should get patches into the
subsystem trees (and linux-next and -mm!) prior to the 2.6.x release.  A
subsystem maintainer who receives feature work during the 2.6.x merge
window could/shouidl/would schedule it for 2.6.x+1.

>  arch/sh/boards/renesas/migor/setup.c |   56 ++++++
>  arch/sh/boards/se/7722/setup.c       |   41 ++++
>  drivers/input/keyboard/Kconfig       |    9 +
>  drivers/input/keyboard/Makefile      |    1 
>  drivers/input/keyboard/sh_keysc.c    |  281 ++++++++++++++++++++++++++++++++++
>  include/asm-sh/se7722.h              |    2 
>  include/asm-sh/sh_keysc.h            |   13 +
>  7 files changed, 402 insertions(+), 1 deletion(-)

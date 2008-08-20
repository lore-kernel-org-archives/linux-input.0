From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: evdev.c(EVIOCGBIT): Suspicious buffer size 511,
Date: Wed, 20 Aug 2008 00:00:40 -0700
Message-ID: <20080820000040.55015b48.akpm@linux-foundation.org>
References: <dd18b0c30808172310u7cf7836ai15e19485908ae0ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58946 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751288AbYHTHBR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Aug 2008 03:01:17 -0400
In-Reply-To: <dd18b0c30808172310u7cf7836ai15e19485908ae0ce@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>

On Sun, 17 Aug 2008 23:10:54 -0700 "Justin Mattock" <justinmattock@gmail.com> wrote:

> I'm noticing:
> evdev.c(EVIOCGBIT): Suspicious buffer size 511, limiting output to 64
> bytes. See http://userweb.kernel.org/~dtor/eviocgbit-bug.html
> with rc-3 not with rc2.
> Did the patch to synaptics, seems
> my xorg is not reading /usr/X11R6/lib/modules/input/synaptics_drv.o
> only /usr/lib/xorg/modules/input/synaptics_drv.so
> is there any easy fix, or do I have to recompile xorg?
> regards;
> 

(cc's added)

From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] input: remove BKL from uinput open function
Date: Sun, 31 Jan 2010 05:20:55 +0100
Message-ID: <201001310520.55813.arnd@arndb.de>
References: <1264800197-29523-1-git-send-email-cascardo@holoscopio.com> <201001302257.09354.arnd@arndb.de> <520f0cf11001301507k20e3cf8dqa73026e12f3a1767@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51530 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab0AaEau (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jan 2010 23:30:50 -0500
In-Reply-To: <520f0cf11001301507k20e3cf8dqa73026e12f3a1767@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Kacur <jkacur@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 31 January 2010, John Kacur wrote:
> > Sorry, I should have been clearer, but not implementing llseek
> > is the problem I was referring to: When a driver has no explicit
> > .llseek operation in its file operations and does not call
> > nonseekable_open from its open operation, the VFS layer will
> > implicitly use default_llseek, which takes the BKL. We're
> > in the process of changing drivers not to do this, one by one
> > so we can kill the BKL in the end.
> >
> 
> I know we've discussed this before, but why wouldn't the following
> make more sense?
>  .llseek         = no_llseek,

That's one of the possible solutions. Assigning it to generic_file_llseek
also gets rid of the BKL but keeps the current behaviour (calling seek
returns success without having an effect, no_llseek returns -ESPIPE),
while calling nonseekable_open has the other side-effect of making
pread/pwrite fail with -ESPIPE, which is more consistent than
only failing seek.

	Arnd


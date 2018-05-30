From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Input updates for v4.17-rc7
Date: Tue, 29 May 2018 22:21:53 -0500
Message-ID: <CA+55aFzc_gZ15Qg3BAoSgALbgTepnQmAnzNb+1w9U8OUxjjVvQ@mail.gmail.com>
References: <20180529233834.GA50727@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529233834.GA50727@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, May 29, 2018 at 6:38 PM Dmitry Torokhov <dmitry.torokhov@gmail.com>
wrote:

>     We are switching a bunch of
> Lenovo devices with Synaptics touchpads from PS/2 emulation over to
> native RMI/SMbus.

> Given that all commits are marked for stable there is no point delaying
> them till next release.

Hmm. The elan driver stack overrun isn't mentioned, but seems more
fundamental fix than the other changes that just add a few new PnP ID's...

            Linus

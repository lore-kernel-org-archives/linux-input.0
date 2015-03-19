From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Input updates for 4.0-rc4
Date: Thu, 19 Mar 2015 16:45:24 -0700
Message-ID: <CA+55aFxg4-6vSVPX9vuc2BMujZE9wCe4a3fo8oNg1YHMH-V_uw@mail.gmail.com>
References: <20150319192056.GL30732@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150319192056.GL30732@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 19, 2015 at 12:20 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Linus,
>
> Please pull from:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> or
>         master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

Btw, can you change your script to not use that old ssh-to-master
line? It hasn't worked in a long time, and even back when it worked it
was the wrong way to pull things.

So just have that "git://git.kernel.org.." line.

                        Linus

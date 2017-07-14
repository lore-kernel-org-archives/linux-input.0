From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 08/14] Input: adxl34x - fix gcc-7 -Wint-in-bool-context warning
Date: Fri, 14 Jul 2017 12:24:45 -0700
Message-ID: <CA+55aFw076kkn_NS1K+nSHDLoajhviHUsnCOmJOpz5YajpEtFw@mail.gmail.com>
References: <20170714092540.1217397-1-arnd@arndb.de> <20170714092540.1217397-9-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20170714092540.1217397-9-arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Guenter Roeck <linux@roeck-us.net>, IDE-ML <linux-ide@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, DRI <dri-devel@lists.freedesktop.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jul 14, 2017 at 2:25 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> FIFO_MODE is an macro expression with a '<<' operator, which
> gcc points out could be misread as a '<':

Yeah, no, NAK again.

We don't make the code look worse just because gcc is being a f*cking
moron about things.

This warning is clearly pure garbage.

                 Linus

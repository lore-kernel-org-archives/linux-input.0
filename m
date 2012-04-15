From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] PCI: Fix regression in pci_restore_state()
Date: Sun, 15 Apr 2012 11:59:19 -0700
Message-ID: <CA+55aFyShMvUjkyGv4DgSGByuoU18o8=MnGJqbz5aSwDVyOyOA@mail.gmail.com>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com>
 <201204152032.36770.rjw@sisk.pl> <CA+55aFww66BY+WuTQHycGqShEtuqix9gzrjmQTsHhyuvmv9mPQ@mail.gmail.com>
 <201204152047.51019.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201204152047.51019.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mikko Vinni <mmvinni@yahoo.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Apr 15, 2012 at 11:47 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> mdelay(10) doesn't really look good either to me in this case, though.

Oh, I agree. What kind of ass-backwards device actually needs that
kind of crazy delays? It is almost certainly buggy.

With retries, 10ms delays are totally unacceptable. There's something wrong.

A single ms *may* be ok.

Anyway, can you also split the actual "write _one_ register with
retry" into a function of its own? The code looks like crap with those
multiple levels of looping, with conditionals inside them etc. With a
simple helper function, you could change the break into return, and it
would look much better, I bet.

                    Linus

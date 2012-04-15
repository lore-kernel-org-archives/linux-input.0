From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] PCI: Fix regression in pci_restore_state()
Date: Sun, 15 Apr 2012 11:36:21 -0700
Message-ID: <CA+55aFww66BY+WuTQHycGqShEtuqix9gzrjmQTsHhyuvmv9mPQ@mail.gmail.com>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com>
 <201204150011.53556.rjw@sisk.pl> <1334486385.82898.YahooMailNeo@web161803.mail.bf1.yahoo.com>
 <201204152032.36770.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201204152032.36770.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mikko Vinni <mmvinni@yahoo.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Apr 15, 2012 at 11:32 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote=
:
>
> To fix the regression, make pci_restore_state() only retry the
> writes for BAR registers and only wait if the first read from
> the register doesn't return the written value. =A0Additionally, make
> it use msleep() instead of mdelay() for waiting.

WHAT?

msleep() is the one that can sleep. So that part of the change is just
crazy. There's no way you can sleep during PCI register restore.

                       Linus

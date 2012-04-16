From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] "i8042: Can't reactivate AUX port" after s2ram on 3.4-rc2
Date: Mon, 16 Apr 2012 18:14:12 +0200
Message-ID: <201204161814.12441.rjw@sisk.pl>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com> <201204152030.23148.rjw@sisk.pl> <1334553341.70819.YahooMailNeo@web161806.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1334553341.70819.YahooMailNeo@web161806.mail.bf1.yahoo.com>
Sender: linux-pci-owner@vger.kernel.org
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Monday, April 16, 2012, Mikko Vinni wrote:
> From: Rafael J. Wysocki
> 
> >
> > Do you still have the kernel where all PCI devices worked correctly after system
> > resume?
> 
> If you are talking about https://bugzilla.kernel.org/show_bug.cgi?id=35452,
> I am not aware of such a kernel. That bug has existed for as long as I have
> cared to test.

OK, let's try to debug it a bit more in the Bugzilla entry.

> Testing the patch v4 soon.

Thanks!

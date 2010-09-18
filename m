From: Andreas Bombe <aeb@debian.org>
Subject: Re: OOPS in hiddev_open on connecting "Logitech MX620 Laser
 Cordless Mouse"
Date: Sat, 18 Sep 2010 21:41:17 +0200
Message-ID: <20100918194117.GA4465@amos.infernal>
References: <AANLkTikOowB=8=3cnJ0QgJNfBsVeMUrkNT0E0uH2LDXL@mail.gmail.com>
 <alpine.LNX.2.00.1009181954010.26813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1009181954010.26813@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Alex Riesen <raa.lkml@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guillaume Chazarain <guichaz@gmail.com>, Mat <jackdachef@gmail.com>
List-Id: linux-input@vger.kernel.org

On Sat, Sep 18, 2010 at 07:56:40PM +0200, Jiri Kosina wrote:
> Does reverting of commit 8fe294caf8c868edd9046251824a0af91991bf43 fix the 
> problem please?

It does here.

From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: [PATCH] Add touchscreen platform data for the Onda oBook 20 Plus tablet.
Date: Tue, 12 Dec 2017 03:11:23 +0200
Message-ID: <Mahogany-0.68.0-8070-20171212-031123.01@nerijus.sat.lt>
References: <20171210220213.19290-1-nerijus@users.sourceforge.net> <17392159-0968-89f6-d716-137d006a0d80@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bluegene.sat.lt ([88.119.145.12]:42836 "HELO bluegene.sat.lt"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752501AbdLLBMQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Dec 2017 20:12:16 -0500
Content-Disposition: INLINE
In-Reply-To: <17392159-0968-89f6-d716-137d006a0d80@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Mon, 11 Dec 2017 19:25:40 +0100 Gregor Riepl <onitake@gmail.com> wrote:

> > +	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-onda-obook-20-plus.fw"),
> 
> Firmware for this is available here:
> https://github.com/onitake/gsl-firmware/blob/master/firmware/linux/silead/gsl3676-onda-obook-20-plus.fw

BTW, what could be done with these firmware files? Is it possible to include them in linux-firmware?

Regards,
Nerijus

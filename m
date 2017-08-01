From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: add USB_HID dependency
Date: Tue, 1 Aug 2017 11:21:42 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1708011119410.30597@cbobk.fhfr.pm>
References: <20170728131826.180483-1-arnd@arndb.de> <6C9C978F-447D-42A5-9245-894577F2944D@gmail.com> <CAK8P3a3S_1LMXrQ_m5N3Cu4XQvcDAyQFGMEwcRCtYBwBaajdYg@mail.gmail.com> <CANRwn3TcLOgW9E=Sauj8-14d834FKegUXO7cw_ekJNhyLVR7=g@mail.gmail.com>
 <CAK8P3a2NP=mTO9z8_wtbjExAfGsPaGhaa=srEuR4hA9HbPNUFg@mail.gmail.com> <CANRwn3QGovTdAhbVtc1MYzogEir+P3niiRCUPDG80XQH6eHxKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751571AbdHAJVq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 1 Aug 2017 05:21:46 -0400
In-Reply-To: <CANRwn3QGovTdAhbVtc1MYzogEir+P3niiRCUPDG80XQH6eHxKg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Gerecke <jason.gerecke@wacom.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 28 Jul 2017, Jason Gerecke wrote:

> I could accept either the strict dependency you originally suggested
> or a modified header, but don't see much reason for the former.

Well, until any better solution is proposed (in the form of patch), I'm 
applying Arnd's patch introducing the hard dependency. We can always 
revisit this later.

The dependency is currently simply there, because we do rely on the actual 
existence of usb_hid_driver structure for the purpose of testing against 
it.

Thanks,

-- 
Jiri Kosina
SUSE Labs


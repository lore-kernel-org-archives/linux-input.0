From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [v3.11][Regression] HID: hyperv: convert alloc+memcpy to
 memdup
Date: Thu, 19 Dec 2013 13:59:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1312191358410.11852@pobox.suse.cz>
References: <5237430B.5040009@canonical.com> <20130916203824.GP25896@mwanda> <52376ED9.5080208@canonical.com> <20130916210503.GQ25896@mwanda> <5237A5D5.8010006@canonical.com> <alpine.LNX.2.00.1309241129370.18703@pobox.suse.cz> <52432152.3030100@canonical.com>
 <alpine.LNX.2.00.1309271250130.18703@pobox.suse.cz> <52459942.3020600@canonical.com> <alpine.LNX.2.00.1312161401100.12882@pobox.suse.cz> <CANq1E4QriATWbfruwj7oVnEBHvtLe_s2yhSSU5COXFjomt5R_A@mail.gmail.com> <alpine.LNX.2.00.1312191058100.28730@pobox.suse.cz>
 <CANq1E4RuteNfo23DQ5SvGXpsrpTmotLoJ6Wv1L8hAbE1ict6aA@mail.gmail.com> <CANq1E4R3LSx7pYncZ1dWf-BYY5gvC15=AjhFvurFqp0jaTUqYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANq1E4R3LSx7pYncZ1dWf-BYY5gvC15=AjhFvurFqp0jaTUqYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Joseph Salisbury <joseph.salisbury@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, thomas@m3y3r.de, Haiyang Zhang <haiyangz@microsoft.com>, LKML <linux-kernel@vger.kernel.org>, open@osuosl.org, HID CORE LAYER <linux-input@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: linux-input@vger.kernel.org

On Thu, 19 Dec 2013, David Herrmann wrote:

> As this thread doesn't really contain any oops message nor the exact
> driver name (except mentioning hyperv and magicmouse), 

FWIW I recall the oopses being present somewhere in the ubuntu bug 
tracker, referenced in this thread.

Thanks,

-- 
Jiri Kosina
SUSE Labs

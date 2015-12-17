From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [patch] HID: wacom: bitwise vs logical ORs
Date: Fri, 18 Dec 2015 00:02:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512180001380.9922@cbobk.fhfr.pm>
References: <20151209102205.GB3173@mwanda> <alpine.LNX.2.00.1512161557060.9922@cbobk.fhfr.pm> <CANRwn3TvwFr85A=dbVTY2gXVdL0y=uw10f1eJBLYWzd3BfNg1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <CANRwn3TvwFr85A=dbVTY2gXVdL0y=uw10f1eJBLYWzd3BfNg1Q@mail.gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, Linux Input <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 16 Dec 2015, Jason Gerecke wrote:

> This patch looks fine to me (the 'prox' calculation /should/ be
> logical, but I suppose bitwise works too :D). Found two other bugs
> from c7f0522 while reviewing though -- I'll have patches for you
> shortly.
> 
> Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Queued in for-4.5/wacom, thanks.

-- 
Jiri Kosina
SUSE Labs


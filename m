From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Add quirk for HP X1200 PIXART OEM mouse
Date: Mon, 5 Aug 2019 14:25:43 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1908051425350.5899@cbobk.fhfr.pm>
References: <20190724184003.12402-1-s.parschauer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190724184003.12402-1-s.parschauer@gmx.de>
Sender: stable-owner@vger.kernel.org
To: Sebastian Parschauer <s.parschauer@gmx.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 24 Jul 2019, Sebastian Parschauer wrote:

> The PixArt OEM mice are known for disconnecting every minute in
> runlevel 1 or 3 if they are not always polled. So add quirk
> ALWAYS_POLL for this one as well.
> 
> Jonathan Teh (@jonathan-teh) reported and tested the quirk.
> Reference: https://github.com/sriemer/fix-linux-mouse/issues/15
> 
> Signed-off-by: Sebastian Parschauer <s.parschauer@gmx.de>
> CC: stable@vger.kernel.org

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Add another Primax PIXART OEM mouse quirk
Date: Tue, 2 Jul 2019 10:32:51 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1907021032360.20818@cbobk.fhfr.pm>
References: <20190701054817.13991-1-s.parschauer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190701054817.13991-1-s.parschauer@gmx.de>
Sender: stable-owner@vger.kernel.org
To: Sebastian Parschauer <s.parschauer@gmx.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 1 Jul 2019, Sebastian Parschauer wrote:

> The PixArt OEM mice are known for disconnecting every minute in
> runlevel 1 or 3 if they are not always polled. So add quirk
> ALWAYS_POLL for this Alienware branded Primax mouse as well.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

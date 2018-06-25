From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: redragon: fix num lock and caps lock LEDs
Date: Mon, 25 Jun 2018 15:23:59 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1806251523050.6203@cbobk.fhfr.pm>
References: <20180619082040.30825-1-rombert@apache.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619082040.30825-1-rombert@apache.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Munteanu <rombert@apache.org>
List-Id: linux-input@vger.kernel.org

On Tue, 19 Jun 2018, Robert@suse.de wrote:

> From: Robert Munteanu <rombert@apache.org>
> 
> The redragon asura keyboard registers two input devices. The initial
> commit d44e2fadf940 ("HID: redragon: Fix modifier keys for Redragon Asura Keyboard")

This should actually have been 85455dd906d.

I have fixed that, added Fixes: tag, and applied.

-- 
Jiri Kosina
SUSE Labs

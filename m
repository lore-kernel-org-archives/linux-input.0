From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid-elo: kill not flush the work
Date: Wed, 1 Jun 2016 14:10:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606011410080.11844@cbobk.fhfr.pm>
References: <1464698895-6788-1-git-send-email-oneukum@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1464698895-6788-1-git-send-email-oneukum@suse.com>
Sender: stable-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: jslaby@suse.com, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 31 May 2016, Oliver Neukum wrote:

> Flushing a work that reschedules itself is not a sensible
> operation. It needs to be killed. Failure to do so leads
> to a kernel panic in the timer code.

Applied to for-4.7/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

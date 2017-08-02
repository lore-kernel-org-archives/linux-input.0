From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 1/2] HID: input: map digitizer battery usage
Date: Wed, 2 Aug 2017 10:54:31 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1708021054150.30597@cbobk.fhfr.pm>
References: <20170801223802.30521-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801223802.30521-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 1 Aug 2017, Dmitry Torokhov wrote:

> We already mapped battery strength reports from the generic device
> control page, but we did not update capacity from input reports, nor we
> mapped the battery strength report from the digitizer page, so let's
> implement this now.
> 
> Batteries driven by the input reports will now start in "unknown" state,
> and will get updated once we receive first report containing battery
> strength from the device.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied both patches to for-4.14/battery. Thanks!

-- 
Jiri Kosina
SUSE Labs

From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Correct logical maximum Y for 2nd-gen Intuos
 Pro large
Date: Wed, 13 Jun 2018 15:44:15 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1806131544050.6203@cbobk.fhfr.pm>
References: <20180612204246.6623-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180612204246.6623-1-killertofu@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

On Tue, 12 Jun 2018, Jason Gerecke wrote:

> The HID descriptor for the 2nd-gen Intuos Pro large (PTH-860) contains
> a typo which defines an incorrect logical maximum Y value. This causes
> a small portion of the bottom of the tablet to become unusable (both
> because the area is below the "bottom" of the tablet and because
> 'wacom_wac_event' ignores out-of-range values). It also results in a
> skewed aspect ratio.
> 
> To fix this, we add a quirk to 'wacom_usage_mapping' which overwrites
> the data with the correct value.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> CC: stable@vger.kernel.org # v4.10+

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

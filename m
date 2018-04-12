From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: bluetooth: send exit report for recent
 Bluetooth devices
Date: Thu, 12 Apr 2018 14:05:21 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1804121405130.28129@cbobk.fhfr.pm>
References: <1522877051-3943-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1522877051-3943-1-git-send-email-skomra@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, killertofu@gmail.com, "# 4 . 11" <stable@vger.kernel.org>, Aaron Armstrong Skomra <aaron.skomra@wacom.com>
List-Id: linux-input@vger.kernel.org

On Wed, 4 Apr 2018, Aaron Armstrong Skomra wrote:

> The code path for recent Bluetooth devices omits an exit report which
> resets all the values of the device.
> 
> Fixes: 4922cd26f0 ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface")
> Cc: <stable@vger.kernel.org> # 4.11
> Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
> Reviewed-by: Ping Cheng <ping.cheng@wacom.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

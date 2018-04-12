From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: Fix resume issue on Raydium touchscreen
 device
Date: Thu, 12 Apr 2018 15:06:44 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1804121506360.28129@cbobk.fhfr.pm>
References: <1523259691-7672-1-git-send-email-aaron.ma@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523259691-7672-1-git-send-email-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 9 Apr 2018, Aaron Ma wrote:

> When Rayd touchscreen resumed from S3, it issues too many errors like:
> i2c_hid i2c-RAYD0001:00: i2c_hid_get_input: incomplete report (58/5442)
> 
> And all the report data are corrupted, touchscreen is unresponsive.
> 
> Fix this by re-sending report description command after resume.
> Add device ID as a quirk.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

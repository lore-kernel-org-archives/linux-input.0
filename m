From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: fix bit shift for Cintiq Companion 2
Date: Mon, 5 Aug 2019 14:15:46 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1908051415290.5899@cbobk.fhfr.pm>
References: <1563905355-20921-1-git-send-email-aaron.skomra@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1563905355-20921-1-git-send-email-aaron.skomra@wacom.com>
Sender: stable-owner@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, pinglinux@gmail.com, jason.gerecke@wacom.com, Aaron Armstrong Skomra <aaron.skomra@wacom.com>, "# v4 . 5+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, 23 Jul 2019, Aaron Armstrong Skomra wrote:

> The bit indicating BTN_6 on this device is overshifted
> by 2 bits, resulting in the incorrect button being
> reported.
> 
> Also fix copy-paste mistake in comments.
> 
> Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
> Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
> Link: https://github.com/linuxwacom/xf86-input-wacom/issues/71
> Fixes: c7f0522a1ad1 ("HID: wacom: Slim down wacom_intuos_pad processing")
> Cc: <stable@vger.kernel.org> # v4.5+

Applied to for-5.3/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

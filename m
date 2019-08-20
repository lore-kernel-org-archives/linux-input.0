From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: correct misreported EKR ring values
Date: Tue, 20 Aug 2019 10:43:17 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1908201043020.27147@cbobk.fhfr.pm>
References: <1565982054-29236-1-git-send-email-aaron.skomra@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1565982054-29236-1-git-send-email-aaron.skomra@wacom.com>
Sender: stable-owner@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, ping.cheng@wacom.com, jason.gerecke@wacom.com, Aaron Armstrong Skomra <aaron.skomra@wacom.com>, "# v4 . 3+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, 16 Aug 2019, Aaron Armstrong Skomra wrote:

> The EKR ring claims a range of 0 to 71 but actually reports
> values 1 to 72. The ring is used in relative mode so this
> change should not affect users.
> 
> Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
> Fixes: 72b236d60218f ("HID: wacom: Add support for Express Key Remote.")
> Cc: <stable@vger.kernel.org> # v4.3+
> Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
> Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Queued for 5.3, thanks Aaron.

-- 
Jiri Kosina
SUSE Labs

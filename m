From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: Add checks to fix of_led_classdev_register
Date: Thu, 3 Jan 2019 11:30:49 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1901031130430.14047@cbobk.fhfr.pm>
References: <20181224213914.26453-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181224213914.26453-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: kjlu@umn.edu, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 24 Dec 2018, Aditya Pakki wrote:

> In lenovo_probe_tpkbd(), the function of_led_classdev_register() could
> return an error value that is unchecked. The fix adds these checks.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

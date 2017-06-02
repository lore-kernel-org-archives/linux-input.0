From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: asus: Stop underlying hardware on remove
Date: Fri, 2 Jun 2017 14:14:18 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1706021414080.30709@cbobk.fhfr.pm>
References: <20170530203946.9346-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170530203946.9346-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com, Carlo Caione <carlo@endlessm.com>
List-Id: linux-input@vger.kernel.org

On Tue, 30 May 2017, Carlo Caione wrote:

> From: Carlo Caione <carlo@endlessm.com>
> 
> We are missing a call to hid_hw_stop() on the remove hook.
> Among other things this is causing an Oops when (re-)starting GNOME /
> upowerd / ... after the module has been already rmmod-ed.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Applied to for-4.12/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

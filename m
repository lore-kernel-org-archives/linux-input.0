From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: logitech-hidpp: add a module parameter to keep
 firmware gestures
Date: Thu, 2 Apr 2015 14:32:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504021432310.843@pobox.suse.cz>
References: <1427388117-20101-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427388117-20101-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, abyss.7@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 26 Mar 2015, Benjamin Tissoires wrote:

> The Logitech T650 used to report 3 fingers swipes to the up as a press on
> the Super key. When we switched the touchpad to the raw mode, we also
> disable such firmware gesture and some users may rely on it.
> 
> Unfortunately, 3 finger swipes are still not supported in most of the
> Linux environments, which means that we disabled a feature of the touchpad.
> 
> Allow users to revert the raw reporting mode and keep going with the
> firmware gestures by providing a new module parameter.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-4.1/logitech.

-- 
Jiri Kosina
SUSE Labs

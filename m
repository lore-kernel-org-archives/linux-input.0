From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v2] HID: wacom: remove the extra Pen interface for Wacom
 Bamboo PAD
Date: Mon, 13 Jul 2015 13:18:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507131317580.7522@pobox.suse.cz>
References: <1436465511-5680-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436465511-5680-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 9 Jul 2015, Benjamin Tissoires wrote:

> As mentioned in the comment in the code, both the pen and touch data
> come from the interface tagged as BAMBOO_PAD. The driver re-routes the
> events for the Pen to the generic HID interface and keeps the ones for
> the touch through this current interface.
> 
> Clearing the WACOM_DEVICETYPE_PEN bit removes the extra unused interface
> added in 2a6cdbd ("HID: wacom: Introduce new 'touch_input' device") and
> makes the Bamboo PAD to behave like in 4.1.
> 
> Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-4.3/wacom.

-- 
Jiri Kosina
SUSE Labs

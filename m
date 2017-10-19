From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: generic: Recognize WACOM_HID_WD_PEN as a
 type of pen collection
Date: Thu, 19 Oct 2017 10:22:27 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710191021420.9294@jbgna.fhfr.qr>
References: <20171018152713.22633-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171018152713.22633-1-killertofu@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

On Wed, 18 Oct 2017, Jason Gerecke wrote:

> The WACOM_PEN_FIELD macro is used to determine if a given HID field should be
> associated with pen input. This field includes several known collection types
> that Wacom pen data is contained in, but the WACOM_HID_WD_PEN application
> collection type is notably missing. This can result in fields within this
> kind of collection being completely ignored by the `wacom_usage_mapping`
> function, preventing the later '*_event' functions from being notified about
> changes to their value.
> 
> Fixes: c9c095874a ("HID: wacom: generic: Support and use 'Custom HID' mode and usages")
> Fixes: ac2423c975 ("HID: wacom: generic: add vendor defined touch")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.14/upstream-fixes

-- 
Jiri Kosina
SUSE Labs

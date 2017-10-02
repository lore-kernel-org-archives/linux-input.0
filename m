From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Always increment hdev refcount within
 wacom_get_hdev_data
Date: Mon, 2 Oct 2017 11:45:44 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710021145340.17517@jbgna.fhfr.qr>
References: <20170918162742.10717-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170918162742.10717-1-killertofu@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

On Mon, 18 Sep 2017, Jason Gerecke wrote:

> The wacom_get_hdev_data function is used to find and return a reference to
> the "other half" of a Wacom device (i.e., the touch device associated with
> a pen, or vice-versa). To ensure these references are properly accounted
> for, the function is supposed to automatically increment the refcount before
> returning. This was not done, however, for devices which have pen & touch
> on different interfaces of the same USB device. This can lead to a WARNING
> ("refcount_t: underflow; use-after-free") when removing the module or device
> as we call kref_put() more times than kref_get(). Triggering an "actual" use-
> after-free would be difficult since both devices will disappear nearly-
> simultaneously. To silence this warning and prevent the potential error, we
> need to increment the refcount for all cases within wacom_get_hdev_data.
> 
> Fixes: 41372d5d40 ("HID: wacom: Augment 'oVid' and 'oPid' with heuristics for HID_GENERIC")
> Cc: <stable@vger.kernel.org> # v4.9+
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.14/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

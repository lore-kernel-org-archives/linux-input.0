From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Do not completely map WACOM_HID_WD_TOUCHRINGSTATUS
 usage
Date: Tue, 8 Aug 2017 10:11:31 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1708081011160.30597@cbobk.fhfr.pm>
References: <20170804223514.3080-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170804223514.3080-1-killertofu@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

On Fri, 4 Aug 2017, Jason Gerecke wrote:

> The WACOM_HID_WD_TOUCHRINGSTATUS usage is a single bit which tells us
> whether the touchring is currently in use or not. Because we need to
> reset the axis value to 0 when the finger is removed, we call
> 'wacom_map_usage' to ensure that the required type/code values are
> associated with the usage. The 'wacom_map_usage' also sets up the axis
> range and resolution, however, which is not desired in this particular
> case.
> 
> Although xf86-input-wacom doesn't do really do anything with the ring's
> range or resolution, the libinput driver (for Wayland environments)
> uses these values to provide proper angle indications to userspace.
> 
> Fixes: 60a2218698 ("HID: wacom: generic: add support for touchring")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.13/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

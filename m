From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: steam: remove input device when a hid client is
 running.
Date: Mon, 19 Nov 2018 16:20:51 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1811191620120.21108@cbobk.fhfr.pm>
References: <20181014173643.9643-1-rodrigorivascosta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181014173643.9643-1-rodrigorivascosta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, lkml <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, 14 Oct 2018, Rodrigo Rivas Costa wrote:

> Previously, when a HID client such as the Steam Client was running, this
> driver disabled its input device to avoid doubling the input events.
> 
> While it worked mostly fine, some games got confused by the idle gamepad,
> and switched to two player mode, or asked the user to choose which gamepad
> to use. Other games just crashed, probably a bug in Unity [1].
> 
> With this commit, when a HID client starts, the input device is removed;
> when the HID client ends the input device is recreated.
> 
> [1]: https://github.com/ValveSoftware/steam-for-linux/issues/5645

Applied to for-4.20/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

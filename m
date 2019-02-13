From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: steam: fix boot loop with bluetooth firmware.
Date: Thu, 14 Feb 2019 00:05:12 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1902140005030.11598@cbobk.fhfr.pm>
References: <20190206212754.17929-1-rodrigorivascosta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206212754.17929-1-rodrigorivascosta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, lkml <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, 6 Feb 2019, Rodrigo Rivas Costa wrote:

> There is a new firmware for the Steam Controller with support for BLE
> connections. When using such a device with a wired connection, it
> reboots itself every 10 seconds unless an application has opened it.
> 
> Doing hid_hw_open() unconditionally on probe fixes the issue, and the
> code becomes simpler.
> 
> Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

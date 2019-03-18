From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: steam: fix deadlock with input devices.
Date: Mon, 18 Mar 2019 14:44:54 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1903181444420.19912@cbobk.fhfr.pm>
References: <20190315190910.4602-1-rodrigorivascosta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315190910.4602-1-rodrigorivascosta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, lkml <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Simon Gene Gottlieb <simon@gottliebtfreitag.de>
List-Id: linux-input@vger.kernel.org

On Fri, 15 Mar 2019, Rodrigo Rivas Costa wrote:

> When using this driver with the wireless dongle and some usermode
> program that monitors every input device (acpid, for example), while
> another usermode client opens and closes the low-level device
> repeadedly, the system eventually deadlocks.
> 
> The reason is that steam_input_register_device() must not be called with
> the mutex held, because the input subsystem has its own synchronization
> that clashes with this one: it is possible that steam_input_open() is
> called before input_register_device() returns, and since
> steam_input_open() needs to lock the mutex, it deadlocks.
> 
> However we must hold the mutex when calling any function that sends
> commands to the controller. If not, random commands end up falling fail.
> 
> Reported-by: Simon Gene Gottlieb <simon@gottliebtfreitag.de>
> Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
> Tested-by: Simon Gene Gottlieb <simon@gottliebtfreitag.de>

Applied to for-5.1/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: check if device is there before really
 probing
Date: Tue, 15 May 2018 11:16:03 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1805151115540.27054@cbobk.fhfr.pm>
References: <20180509191215.77406-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509191215.77406-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@google.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-input@vger.kernel.org

On Wed, 9 May 2018, Dmitry Torokhov wrote:

> From: Dmitry Torokhov <dtor@chromium.org>
> 
> On many Chromebooks touch devices are multi-sourced; the components are
> electrically compatible and one can be freely swapped for another without
> changing the OS image or firmware.
> 
> To avoid bunch of scary messages when device is not actually present in the
> system let's try testing basic communication with it and if there is no
> response terminate probe early with -ENXIO.
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

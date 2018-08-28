From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: Fix flooded incomplete report after S3 on
 Rayd touchscreen
Date: Tue, 28 Aug 2018 13:46:23 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1808281346150.25787@cbobk.fhfr.pm>
References: <20180821085513.13739-1-acelan.kao@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821085513.13739-1-acelan.kao@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dtor@chromium.org>, Aaron Ma <aaron.ma@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 21 Aug 2018, AceLan Kao wrote:

> The incomplete report flooded after S3 and touchscreen becomes
> malfunctioned.
> [ 1367.646244] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/18785)
> [ 1367.649471] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/28743)
> [ 1367.651092] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/26757)
> [ 1367.652658] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/52280)
> [ 1367.654287] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/56059)
> 
> Adding device ID, 04F3:30CC, to the quirk to re-send report description
> after resume.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

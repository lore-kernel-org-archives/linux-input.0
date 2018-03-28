From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: google: Enable PM Full On mode when adjusting
 backlight
Date: Wed, 28 Mar 2018 16:13:38 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1803281613260.15778@cbobk.fhfr.pm>
References: <20180328061610.206090-1-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180328061610.206090-1-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, groeck@chromium.org, dtor@chromium.org, Haridhar Kalvala <haridhar.kalvala@intel.com>
List-Id: linux-input@vger.kernel.org

On Wed, 28 Mar 2018, Nicolas Boichat wrote:

> From: Haridhar Kalvala <haridhar.kalvala@intel.com>
> 
> hammer LED backlight brightness is not getting set when USB
> device is in suspend state.
> 
> This patch fixes the issue by requesting USB HID device to be
> in FULLON mode, so that sending hardware output report and
> hardware raw request won't fail to set brightness, and set
> device back to NORMAL mode once this call returns.
> 
> Signed-off-by: Haridhar Kalvala <haridhar.kalvala@intel.com>
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Applied to for-4.17/google-hammer. Thanks,

-- 
Jiri Kosina
SUSE Labs

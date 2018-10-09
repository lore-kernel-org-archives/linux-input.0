From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/2] mfd: cros: add "base attached" MKBP switch
 definition
Date: Mon, 8 Oct 2018 23:28:55 -0700
Message-ID: <20181009062855.GA32033@dell>
References: <20181005184114.207503-1-dtor@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005184114.207503-1-dtor@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>
List-Id: linux-input@vger.kernel.org

On Fri, 05 Oct 2018, Dmitry Torokhov wrote:

> This adds a "base attached" switch definition to the MKBP protocol that
> is used by Whiskers driver to properly determine device state (clamshell
> vs tablet mode).
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---
> 
> v2 changes: None
> 
> Lee, I was wondering if it would be OK for cros_ec_commands.h to be
> merged through HID tree.

Yes, so long as it goes through in this merge-window.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

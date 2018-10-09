From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 1/2] mfd: cros: add "base attached" MKBP switch
 definition
Date: Tue, 9 Oct 2018 10:41:45 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810091041030.14430@cbobk.fhfr.pm>
References: <20181005184114.207503-1-dtor@chromium.org> <20181009062855.GA32033@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009062855.GA32033@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Dmitry Torokhov <dtor@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>
List-Id: linux-input@vger.kernel.org

On Mon, 8 Oct 2018, Lee Jones wrote:

> > This adds a "base attached" switch definition to the MKBP protocol that
> > is used by Whiskers driver to properly determine device state (clamshell
> > vs tablet mode).
> > 
> > Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> > ---
> > 
> > v2 changes: None
> > 
> > Lee, I was wondering if it would be OK for cros_ec_commands.h to be
> > merged through HID tree.
> 
> Yes, so long as it goes through in this merge-window.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks; both patches now queued in hid.git#for-4.20/google

-- 
Jiri Kosina
SUSE Labs
